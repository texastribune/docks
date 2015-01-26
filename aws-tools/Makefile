APP=aws-tools
NS=texastribune

build:
	docker build --tag=${NS}/${APP} .

interactive:
	docker run --rm --interactive --tty --name=${APP} ${NS}/${APP} bash
