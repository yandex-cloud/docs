# Скачать Docker-образ из реестра {{ cloud-registry-name }}

Для скачивания [Docker-образа](../../concepts/docker-image.md) необходима [роль](../../security/index.md#cloud-registry-artifacts-puller) `cloud-registry.artifacts.puller` или выше.

Чтобы работать с Docker-образами, [установите и настройте](installation.md) Docker.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Выберите необходимый вам Docker-образ.
  1. Скачайте Docker-образ из [реестра](../../concepts/registry.md):
     * Используя **тег**:

       ```bash
       docker pull {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
       ```

       Результат:

       ```text
       hello: Pulling from crpd50616s9a********/ubuntu
       84ed7d2f608f: Already exists
       be2bf1c4a48d: Already exists
       a5bdc6303093: Already exists
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       Status: Downloaded newer image for {{ cloud-registry }}/crpd50616s9a********/ubuntu:hello
       ```

     * Используя **хеш**:

       ```bash
       docker pull {{ cloud-registry }}/<идентификатор_реестра>/ubuntu@sha256:035ac8e1bd9c49871a2fd76
       ```

       Результат:

       ```text
       ccb3c4b0f84e7eee775919ccd345337ec7b49f80d
       sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********: Pulling from crpd50616s9a********/ubuntu
       84ed7d2f608f: Already exists
       ...
       e9055237d68d: Already exists
       Digest: sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       Status: Downloaded newer image for {{ cloud-registry }}/crpd50616s9a********/ubuntu@sha256:035ac8e1bd9c49871a2fd76ccb3c4b0f84e7eee775919ccd345337ec********
       ```

       Обратите внимание, что в данном случае Docker-образ будет скачан без тега. В поле `TAG` будет указано `<none>`.
  1. Проверьте, что Docker-образ действительно скачан:

     ```bash
     docker image list
     ```

     Результат:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ cloud-registry }}/crpd50616s9a********/ubuntu       <none>  50ff********  24 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

{% endlist %}
