This is the master repository for The Texas Tribune's Docker images.

The full history for each image is stores in this repo. If the container has
its own repository, the full history will be there as well.


### Contributing

All commits and pull requests should be done in the master repository: docks.
This is so we don't have to have _n_ projects set up for _n_ docker images.
After contributions are merged, they can be pushed back out to their individual
repositories.


### Subtrees

To help with the verbose arguments to `git subtree`, there's a helper included.
To add all the git remotes needed, run:

    ./subtree remotes

After you're satisfied with your docker image, you can push changes to its
dedicated git repository with:

    ./subtree push <name>


### Tagged Images

_TODO_
