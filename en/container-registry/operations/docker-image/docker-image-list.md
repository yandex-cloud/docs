# Getting information about available Docker images

Find out how to get:
* [A list of Docker images in a registry](#docker-image-list).
* [Detailed information about a Docker image](#docker-image-get).

## Getting a list of Docker images in a registry {#docker-image-list}

{% list tabs %}

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   Get a list of [Docker images](../../concepts/docker-image.md) in the current registry:

   ```bash
   yc container image list
   ```

   Result:

   ```bash
   +----------------------+---------------------+----------------------------+------+-----------------+
   |          ID          |       CREATED       |            NAME            | TAGS | COMPRESSED SIZE |
   +----------------------+---------------------+----------------------------+------+-----------------+
   | crp9vik7sgeco7emq743 | 2019-01-17 17:00:48 | crph8pf7irvcu3p7gjpb/myimg |  111 | 30.7 MB         |
   +----------------------+---------------------+----------------------------+------+-----------------+
   ```

- API

   To get a list of the Docker images in a registry, use the [list](../../api-ref/Image/list.md) method for the [Image](../../api-ref/Image/) resource.

{% endlist %}

## Getting information about a Docker image {#docker-image-get}

{% list tabs %}

- CLI

   Get detailed information about a Docker image using the `id` from the [previous](#docker-image-list) item:

   ```bash
   yc container image get crphc7nnrvhlg73oeiv5
   ```

   Result:

   ```bash
   id:crphc7nnrvhlg73oeiv5
   name: crpd50616s9a2t7gr8mi/ubuntu
   digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
   ...
     size: "163"
   tags:
   - hello
   ```

- API

   To get detailed information about a Docker image, use the [get](../../api-ref/Image/get.md) method for the [Image](../../api-ref/Image/) resource.

{% endlist %}