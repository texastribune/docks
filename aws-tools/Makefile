APP=aws-tools
NS=texastribune

build:
	docker build --tag=${NS}/${APP} .

interactive: build
	docker run \
		--env=AWS_ACCESS_KEY_ID \
		--env=AWS_SECRET_ACCESS_KEY \
		--env=SOURCE_DB=tt-prod-db \
		--env=TARGET_DB=tt-test-db \
		--env=DB_SUBNET_GROUP=texastribune-subnet-group \
		--env=SECURITY_GROUP=sg-5620f932 \
		--rm --interactive --tty --name=${APP} ${NS}/${APP} bash

run: build
	docker run \
		--env=AWS_ACCESS_KEY_ID \
		--env=AWS_SECRET_ACCESS_KEY \
		--env=SOURCE_DB=tt-prod-db \
		--env=TARGET_DB=tt-test-db \
		--env=SECURITY_GROUP=tt-test-dbsg \
		--env=TARGET_PASS=foobarbaz \
		--rm --entrypoint=python -it --name=${APP} ${NS}/${APP} /app/refresh-db.py

#		--env=DB_SUBNET_GROUP=texastribune-subnet-group \
		--env=SECURITY_GROUP=sg-5620f932 \
