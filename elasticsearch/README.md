#### Build:

```
docker build --tag="elasticsearch" .   
```

or

```
make build
```

#### Run:

```
docker run --detach=true --publish=49200:9200 --publish=49300:9300 elasticsearch
```

or

```
make run
```

or 

```
docker run --detach=true --publish=9200:9200 --publish=9300:9300 x110dc/docker-elasticsearch
```

(I like to use the long version of the parameters because it's easier for me remember what they mean.)
