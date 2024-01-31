# Pushing a Docker image to a registry

These instructions describe how to push a local [Docker image](../../concepts/docker-image.md) to a registry.

{% note info %}

To push an image, you need to [authenticate](../authentication.md) in the registry.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

   1. View the list of available [Docker images](../../concepts/docker-image.md):

      ```
      docker image list
      ```

      Result:

      ```
      REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
      {{ registry }}/crpd50616s9a********/ubuntu  hello   50ff********  23 hours ago  86.7MB
      ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
      ```

   1. (Optional) Assign to the Docker image a URL in `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>` format:

      ```
      docker tag ubuntu \
      {{ registry }}/crpd50616s9a********/ubuntu:hello
      ```

      {% note info %}

      You can only push Docker images to {{ container-registry-name }} if they have a URL in `{{ registry }}/<registry_ID>/<Docker_image_name>:<tag>` format.

      {% endnote %}

   1. Push the required Docker image to the registry:

      ```
      docker push {{ registry }}/crpd50616s9a********/ubuntu:hello
      ```

   1. Make sure the image has been pushed to the registry by [getting a list of docker images in the registry](docker-image-list.md#docker-image-list).

{% endlist %}