APP=elasticsearch
NAMESPACE=texastribune

build:
	docker build --tag=${NAMESPACE}/${APP} .

run:
	docker run --detach=true --publish=9200:9200 --publish=9300:9300 --name=${APP} ${NAMESPACE}/${APP}
