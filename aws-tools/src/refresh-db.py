import boto.rds
import time
from boto.exception import BotoServerError
from project_runpy import env
from delorean import parse

# Refresh a database from another one

# Does the following:
# - deletes the target database
# - restores the most recent snapshot of the source db as the target db
# - removes the snapshot

# Requires:
# - boto
# - AWS credentials
# - project_runpy
# - Delorean

target_db = env.require('TARGET_DB')
source_db = env.require('SOURCE_DB')
db_subnet_group = env.get('DB_SUBNET_GROUP')
security_group = env.require('SECURITY_GROUP')
target_pass = env.require('TARGET_PASS')


region = env.get('AWS_REGION', 'us-east-1')
instance_class = env.get('INSTANCE_CLASS', 'db.t1.micro')

if 'prod' in target_db:
    exit("that looks like production; do it yourself")

rds_connection = boto.rds.connect_to_region(region)

# print "deleting {} snapshot...".format(snapshot)
# try:
#    rds_connection.delete_dbsnapshot(snapshot)
# except BotoServerError as e:
#    if e.reason != 'Not Found':
#        print " ---> it's not there to delete"
#        raise e

print "deleting {} database...".format(target_db)
# this has been taking about 5m
try:
    deleted_db = rds_connection.delete_dbinstance(target_db,
            skip_final_snapshot=True)
except BotoServerError as e:
    if e.reason != 'Not Found':
        print " ---> it's not there to delete"
        raise e
else:
    # wait for instance deletion
    while deleted_db.status != 'deleted':
        print "waiting for db deletion..."
        time.sleep(120)
        try:
            deleted_db.update()
        except boto.exception.BotoServerError as e:
            if e.reason != 'Not Found':
                raise e
            break

snapshots = rds_connection.get_all_dbsnapshots(instance_id=source_db)
if not snapshots:
    exit('{} has no snapshots'.format(source_db))
snapshot = max(snapshots, key=lambda x: parse(x.snapshot_create_time)).id

# print "creating snapshot from {}...".format(source_db)
# rds_connection.create_dbsnapshot(snapshot, source_db)
#
# # wait for it to become available
# # about 2m
# while rds_connection.get_all_dbsnapshots(
#        snapshot_id=snapshot)[0].status != 'available':
#    print "waiting for snapshot availability..."
#    time.sleep(60)

# instead of creating a new snapshot use the latest extant one (and
# rely on something else to create snapshots)
snapshots = rds_connection.get_all_dbsnapshots(instance_id=source_db)
if not snapshots:
    exit('{} has no snapshots'.format(source_db))
snapshot = max(snapshots, key=lambda x: parse(x.snapshot_create_time)).id

print "restoring to {} db from snapshot {}".format(target_db, snapshot)

if db_subnet_group:
    # if a subnet group is defined the instance ends up in that VPC:
    rds_connection.restore_dbinstance_from_dbsnapshot(
            identifier=snapshot,
            instance_id=target_db,
            instance_class=instance_class,
            db_subnet_group_name=db_subnet_group,
            )
else:
    rds_connection.restore_dbinstance_from_dbsnapshot(
            identifier=snapshot,
            instance_id=target_db,
            instance_class=instance_class,
            )

# this takes a variable amount of time - about 10m
while rds_connection.get_all_dbinstances(
        instance_id=target_db)[0].status != 'available':
    print "waiting for {} db availability...".format(target_db)
    time.sleep(240)

# why won't it let me specify the security group on creation?
# instead I have to wait until it's created and then modify it

print "modifying new database..."
if db_subnet_group:  # VPC
    rds_connection.modify_dbinstance(id=target_db,
            apply_immediately=True,
            backup_retention_period=0,
            master_password=target_pass,
            vpc_security_groups=[security_group])
else:  # no VPC:
    rds_connection.modify_dbinstance(id=target_db,
            apply_immediately=True,
            backup_retention_period=0,
            master_password=target_pass,
            security_groups=[security_group])

# print "deleting {} snapshot...".format(snapshot)
# try:
#    rds_connection.delete_dbsnapshot(snapshot)
# except BotoServerError as e:
#    if e.reason != 'Not Found':
#        print " ---> it's not there to delete"
#        raise e

rds_connection.close()
