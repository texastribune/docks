build:
	docker build -t texastribune/sputnik .

run: clean_sputnik
	docker run --detach -p 5111:5111 -p 1957:1957 -p 554:554 --name sputnik \
	  texastribune/sputnik

# run in the foreground
test: clean_sputnik
	docker run --rm -p 5111:5111 -p 1957:1957 -p 554:554 --name sputnik \
	  --sig-proxy=false texastribune/sputnik

# open a shell into the `sputnik` container
shell:
	docker run --rm -i -t --name sputnik-shell texastribune/sputnik /bin/bash

# open a shell into a utility container to examine `sputnik` logs
debug:
	docker run --rm -i -t --name sputnik-debug --volumes-from sputnik crccheck/zz

# copy the default
conf: run
	docker cp sputnik:/data/conf .
	docker stop sputnik
	docker rm sputnik

clean_sputnik:
	-docker rm sputnik 2> /dev/null
