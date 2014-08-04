APP=pgloader
NAMESPACE=texastribune
#NAMESPACE=docker.texastribune.org

build:
	docker build --tag=${NAMESPACE}/${APP} .
debug:
	docker run --volumes-from=${APP} --interactive=true --tty=true x110dc/dev-base bash
interactive:
	docker run --rm -i -t --name=${APP} ${NAMESPACE}/${APP} bash
run:
	docker run --volume=${PWD}:/app/etc --name=${APP} --interactive --tty ${NAMESPACE}/${APP} pgloader /app/etc/config.load
clean:
	docker stop ${APP} && docker rm ${APP}
push:
	docker push ${NAMESPACE}/${APP}
