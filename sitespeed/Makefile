APP=sitespeed
NAMESPACE=texastribune

build:
	docker build --tag=${NAMESPACE}/${APP} .
#
debug:
	docker run --volumes-from=${APP} --interactive=true --tty=true ${NAMESPACE}/${APP} bash
#
run:
	docker run --name=${APP} --detach=true --publish=80:8000 ${NAMESPACE}/${APP}
clean:
	docker stop ${APP} && docker rm ${APP}
interactive:
	docker run --rm --interactive --tty --name=${APP} ${NAMESPACE}/${APP} bash
push:
	docker push ${NAMESPACE}/${APP}
