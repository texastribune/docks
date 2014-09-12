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
image its own Git remote and history at the same time. Using git subtrees also
gives us:

* Ability to do webhooks from the Index for these Dockerfiles
* Ability to do tagged builds in the Index for these Dockerfiles
* Simpler developer overhead of maintaining *n* projects:
    * It's easier to get started because you only have to check out one git
      repository and set up one project in your editor
    * You can refer to other Dockerfiles easier
    * We can implement best practices across all of our Dockerfiles at once

### Usage

To help with the verbose arguments to `git subtree`, there's a helper included:
`subtree`.

#### Adding all the Git remotes

Each Docker image has its own special remote. To make it easier for developers
to work on all of them, you can run this command to set up all the remotes at
once:

    ./subtree remotes

#### Pushing updates

After you're satisfied with your updates to a Docker image, you can push
changes back to their dedicated repository with:

    ./subtree push <name>

#### Forking an existing repo

For a more complex scenario, let's say we're forking an existing project:

1. Fork the project in github. Let's say we're forking utensils/fork to
   texastribune/fork
2. Update ./subtree's `remote` command to add a remote named `fork` to
   texastribune/fork
3. Run `./subtree remotes` to add the remote
4. Run `./subtree init fork` to link the two
5. Run `./subtree pull fork --squash` to bring the project into this one
6. Make your updates and commit them as you normally would:
    1. Branch
    2. Commit
    3. Pull Request
    4. Merge
7. Run `./subtree push fork` to push changes up, triggering a new build in the
   Index

#### Maintaining multiple branches in a remote

While this is possible, there is not a simple way of doing this using git
subtrees. While there are several possible approaches, we're waiting until we
actually need to do this.
