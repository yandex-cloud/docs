## Events for setting up a trigger {#event}

Events with Docker images that can be tracked using a trigger:
* [Creating a Docker image](../../container-registry/operations/docker-image/docker-image-push.md).
* [Deleting a Docker image](../../container-registry/operations/docker-image/docker-image-delete.md).
* Creating a Docker image tag.
* Deleting a Docker image tag.

A Docker image is always pushed with a tag (if no tag is specified, Docker automatically assigns the `latest` tag), meaning the `CreateImage` event always comes with `CreateImageTag`. You can add any number of tags to a Docker image by pushing the same image with different tags. In this case, only the `CreateImageTag` event occurs, without `CreateImage`.

A tag can be reassigned from one Docker image to another. This happens when pushing a new Docker image with a tag that is already used in another Docker image. In this case, the `CreateImage` event will occur for the new Docker image. In this case, changing the tag will trigger two events: `DeleteImageTag` (removing the tag from the old Docker image) and `CreateImageTag` (assigning the tag to the new Docker image).

Deleting a Docker image also deletes all its tags. This is why deleting a Docker image always triggers the `DeleteImage` event and as many `DeleteImageTag` events as the Docker image had tags at the time of deletion.

### Filtering events {#filter}

Events are filtered using tags and names of Docker images you push. When using a name and a tag at the same time, filtering is based on the logical `AND`: for the trigger to fire, the image must match both the name and the tag.