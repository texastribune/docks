This is the master repository for The Texas Tribune's Docker images.

The full history for each image is stores in this repo. If the container has
its own repository, the full history will be there as well.


### Contributing

All commits and pull requests should be done in the master repository: docks.
This is so we don't have to have _n_ projects set up for _n_ docker images.
After contributions are merged, they can be pushed back out to their individual
repositories.


Subtrees
--------

Git subtrees let us store all our Docker images in one place while giving each
image its own Git remote and history at the same time.

### Usage

To help with the verbose arguments to `git subtree`, there's a helper included.

#### Adding all the Git remotes

Each Docker image has its own special remote. To make it easier for developers
to work on all of them, you can run this command to set up all the remotes at
once:

    ./subtree remotes

#### Pushing updates

After you're satisfied with your docker image, you can push changes back to
their dedicated repository with:

    ./subtree push <name>


### Tagged Images

_TODO_
