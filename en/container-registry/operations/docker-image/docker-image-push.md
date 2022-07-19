# Pushing a Docker image to a registry

These instructions describe how to push a local [Docker image](../../concepts/docker-image.md) to a registry.

{% note info %}

To push an image, you need to [authenticate](../authentication.md) in the registry.

{% endnote %}

{% list tabs %}

- CLI

   1. View the list of available Docker images:

      ```
      docker image list
      ```

      Result:

      ```
      REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
      {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu  hello   50ff4b0e5783  23 hours ago  86.7MB
      ubuntu                                      latest  1d9c17228a9e  2 weeks ago   86.7MB
      ```

   1. (optional) Assign a URL in the format `{{ registry }}/<registry ID>/<Docker image name>:<tag>` to the Docker image:

      ```
      docker tag ubuntu \
      {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
      ```

      {% note info %}

      You can only push Docker images with a URL in the format `{{ registry }}/<registry ID>/<Docker image name>:<tag>` to {{ container-registry-name }}.

      {% endnote %}

   1. Push the required Docker image to the registry:

      ```
      docker push {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
      ```

   1. Make sure the image uploaded to the registry by [getting a list of docker images in the registry](docker-image-list.md#docker-image-list).

{% endlist %}