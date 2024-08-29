# Pulling a Docker image from a registry

To download a [Docker image](../../concepts/docker-image.md), you need the `container-registry.images.puller` [role](../../security/index.md#container-registry-images-puller) or higher. In addition, you need to know which [repository](../../concepts/repository.md) houses the Docker image, as well as its [tag or hash](../../concepts/docker-image.md#version).

To work with Docker images, [install and configure](../configure-docker.md) Docker.

{% list tabs group=instructions %}

- CLI {#cli}

   1. Select the Docker image you need. To do this, [get a list of Docker images in the registry](docker-image-list.md#docker-image-list).
   1. Pull the Docker image from the [registry](../../concepts/registry.md):
      * Using the **tag**:

         ```bash
         docker pull {{ registry }}/<registry_ID>/ubuntu:hello
         ```

         Result:

         ```text
         hello: Pulling from crpd50616s9a********/ubuntu
         84ed7d2f608f: Already exists
         be2bf1c4a48d: Already exists
         a5bdc6303093: Already exists
         e9055237d68d: Already exists
         Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
         Status: Downloaded newer image for {{ registry }}/crpd50616s9a********/ubuntu:hello
         ```

      * Using the **digest**:

         ```bash
         docker pull {{ registry }}/<registry_ID>/ubuntu@sha256:035ac8e1bd9c49871a2fd76
         ```

         Result:

         ```text
         ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
         sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********: Pulling from crpd50616s9a********/ubuntu
         84ed7d2f608f: Already exists
         ...
         e9055237d68d: Already exists
         Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
         Status: Downloaded newer image for {{ registry }}/crpd50616s9a********/ubuntu@sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
         ```

         Note that in this case the Docker image will be pulled with no tag. The `TAG` field value will be `<none>`.
   1. Make sure the Docker image has been pulled:

      ```bash
      docker image list
      ```

      Result:

      ```text
      REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
      {{ registry }}/crpd50616s9a********/ubuntu       <none>  50ff********  24 hours ago  86.7MB
      ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
      ```

{% endlist %}

#### See also {#see-also}

* [Troubleshooting in {{ container-registry-name }}](../../error/index.md).