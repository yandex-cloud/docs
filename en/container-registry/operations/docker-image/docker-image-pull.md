# Pulling a Docker image from a registry

To download a [Docker image](../../concepts/docker-image.md), you need to know the [repository](../../concepts/repository.md) it is stored in as well as its [tag or digest](../../concepts/docker-image.md#version).

{% list tabs %}

- CLI

  1. Select the Docker image you need. To do this, [get a list of the Docker images in the registry](docker-image-list.md#docker-image-list).
  1. Pull the Docker image from the [registry](../../concepts/registry.md):
     * Using the **tag**:

       ```bash
       docker pull {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
       ```

       Result:

       ```text
       hello: Pulling from crpd50616s9a2t7gr8mi/ubuntu
       84ed7d2f608f: Already exists
       be2bf1c4a48d: Already exists
       a5bdc6303093: Already exists
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       Status: Downloaded newer image for {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu:hello
       ```

     * Using the **digest**:

       ```bash
       docker pull {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu@sha256:035ac8e1bd9c49871a2fd76
       ```

       Result:

       ```text
       ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d: Pulling from crpd50616s9a2t7gr8mi/ubuntu
       84ed7d2f608f: Already exists
       ...
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       Status: Downloaded newer image for {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu@sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       ```

       Note that in this case the Docker image will be pulled with no tag. The `TAG` field value will be `<none>`.
  1. Make sure the Docker image has been pulled:

     ```bash
     docker image list
     ```

     Result:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ registry }}/crpd50616s9a2t7gr8mi/ubuntu  <none>  50ff4b0e5783  24 hours ago  86.7MB
     ubuntu                                      latest  1d9c17228a9e  2 weeks ago   86.7MB
     ```

{% endlist %}

#### See also {#see-also}

* [Troubleshooting in {{ container-registry-name }}](../../error/index.md).