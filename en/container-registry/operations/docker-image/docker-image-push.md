---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
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
      REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
      cr.yandex/crpd50616s9a2t7gr8mi/ubuntu   hello               50ff4b0e5783        23 hours ago        86.7MB
      ubuntu                                  latest              1d9c17228a9e        2 weeks ago         86.7MB
      ```

  1. (option) Assign a tag like `cr.yandex/<registry ID>/<Docker image name>:<tag>` to the Docker image:

      ```
      docker tag ubuntu \
      cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:example
      ```

      {% note info %}

      You can only push to {{ container-registry-name }} Docker images tagged with `cr.yandex/<registry ID>/<Docker image name>:<tag>`.

      {% endnote %}

  1. Push the required Docker image to the registry:

      ```
      docker push cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:hello
      ```

  1. Make sure the image has been added to the registry. To do this, [get a list of Docker images in the registry](docker-image-list.md).

{% endlist %}
