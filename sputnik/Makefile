build:
	docker build -t texastribune/sputnik .

run: clean
	docker run --detach -p 5111:5111 -p 1957:1957 -p 554:554 --name sputnik \
	  texastribune/sputnik

test: clean
	docker run --rm -p 5111:5111 -p 1957:1957 -p 554:554 --name sputnik \
	  texastribune/sputnik

shell:
	docker run --rm -i -t --name debug texastribune/sputnik /bin/bash

debug:
	docker run --rm -i -t --name debug --volumes-from sputnik ubuntu

conf: run
	docker cp sputnik:/data/conf .
	docker stop sputnik
	docker rm sputnik

clean:
	-docker rm sputnik 2> /dev/null
