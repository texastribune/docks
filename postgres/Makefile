APP=postgres
NAMESPACE=texastribune

build:
	docker build --tag=${NAMESPACE}/${APP} .
#
#  You could use a completely different image to debug; maybe one with your
#  favorite tools already present:
#
debug:
		docker run --volumes-from=${APP} --interactive=true --tty=true ${NAMESPACE}/${APP} bash
#
#  The publish here will depend on your environment
#
run:
		docker run --name=${APP} --detach=true --publish=80:8000 ${NAMESPACE}/${APP}
clean:
		docker stop ${APP} && docker rm ${APP}
