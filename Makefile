all:
	docker build -t mandrill .
run:
	docker run --detach=true --env-file=env --name mandrill --publish=25:25 mandrill
clean:
	docker stop mandrill && docker rm mandrill
debug:
	docker run -i -t --volumes-from mandrill mandrill tail -f /var/log/mail.log
