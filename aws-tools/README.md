This is intended to be a collection of tools for use with AWS all packaged together in one tidy container.

So far it just has one script that refreshes and RDS database (removes and restores from a snapshot).  

*This will remove whatever database you specify with `TARGET_DB`. Use caution!*

Use it like this:

	docker run \
		--env=AWS_ACCESS_KEY_ID \
		--env=AWS_SECRET_ACCESS_KEY \
		--env=SOURCE_DB=my-prod-db \
		--env=TARGET_DB=my-test-db \
		--env=DB_SUBNET_GROUP=my-subnet-group \
		--env=SECURITY_GROUP=sg-123456 \
		--env=TARGET_PASS=mynewpassword \
		--rm --entrypoint=python texastribune/aws-tools /app/refresh-db.py

It assumes an AWS region of 'us-east-1' but you can override that by setting `AWS_REGION`

The `DB_SUBNET_GROUP` is optional and only applies to instances residing in a VPC. If not provided 
the new database will not be in a VPC.

The security group designation for VPC instances is an ID (e.g 'sg-123456'), for non-VPC it's a name (e.g. 'test-db-sg')
