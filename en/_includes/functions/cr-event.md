## Events for setting up a trigger {#event}

Events with Docker images that can be tracked using a trigger:
* [Creating a Docker image](../../container-registry/operations/docker-image/docker-image-push.md).
* [Delete Docker images](../../container-registry/operations/docker-image/docker-image-delete.md).
* Creating a Docker image tag.
* Deleting a Docker image tag.

A Docker image is always pushed with a tag (if no tag is specified, Docker automatically inserts the `latest` tag). Therefore the `CreateImage` event is always paired with `CreateImageTag`. You can add an arbitrary number of tags to a Docker image by pushing the same image with other tags. In this case, only the `CreateImageTag` event will occur, without `CreateImage`.

A tag can go from one Docker image to another. This happens when pushing a new Docker image with a tag that is already used in another Docker image. In this case, the `CreateImage` event will occur for the new Docker image, while changing the tag will trigger two events: `DeleteImageTag` (removing the tag from the old Docker image) and `CreateImageTag` (assigning the tag to the new Docker image).

When you delete a Docker image, all its tags are deleted. This is why deleting a Docker image always triggers the `DeleteImage` event and as many `DeleteImageTag` events as the Docker image had tags at the time of deletion.

### Filtering events {#filter}

Events are filtered using tags and names of Docker images that you push. When using a name and tag at the same time, filtering is done based on the logical `AND`: for the trigger to work, the image must match both the name and tag.
