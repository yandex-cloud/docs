# Загрузить Docker-образ в реестр {{ cloud-registry-name }}

Инструкция описывает, как загрузить локальный [Docker-образ](../../concepts/docker-image.md) в реестр.

{% note info %}

Чтобы загрузить образ, необходимо [настроить](installation.md) Docker и [аутентифицироваться](authentication.md) в реестре.

{% endnote %}

Для загрузки Docker-образа в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите список доступных для загрузки [Docker-образов](../../concepts/docker-image.md):

     ```bash
     docker image list
     ```

     Результат:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ cloud-registry }}/crpd50616s9a********/ubuntu       hello   50ff********  23 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

  1. (Опционально) Присвойте Docker-образу URL вида `{{ cloud-registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

     ```bash
     docker tag ubuntu \
     {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
     ```

     {% note info %}

     Загрузить в {{ cloud-registry-name }} можно только Docker-образы с URL вида `{{ cloud-registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.

     {% endnote %}

  1. Загрузите необходимый Docker-образ в реестр:

     ```bash
     docker push {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
     ```

{% endlist %}