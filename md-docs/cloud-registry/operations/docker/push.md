[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Registry](../../index.md) > [Пошаговые инструкции](../index.md) > Управление артефактами > Docker-образ > Загрузить Docker-образ в реестр

# Загрузить Docker-образ в реестр Cloud Registry

Инструкция описывает, как загрузить локальный [Docker-образ](../../concepts/artifacts/docker.md) в реестр.

{% note info %}

Чтобы загрузить образ, необходимо [настроить](installation.md) Docker и [аутентифицироваться](authentication.md) в реестре.

{% endnote %}

Для загрузки Docker-образа в реестр необходима [роль](../../security/index.md#cloud-registry-artifacts-pusher) `cloud-registry.artifacts.pusher` или выше.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите список доступных для загрузки [Docker-образов](../../concepts/artifacts/docker.md):

     ```bash
     docker image list
     ```

     Результат:

     ```text
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     registry.yandexcloud.net/crpd50616s9a********/ubuntu       hello   50ff********  23 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

  1. (Опционально) Присвойте Docker-образу URL вида `registry.yandexcloud.net/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

     ```bash
     docker tag ubuntu \
     registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
     ```

     {% note info %}

     Загрузить в Cloud Registry можно только Docker-образы с URL вида `registry.yandexcloud.net/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.

     {% endnote %}

  1. Загрузите необходимый Docker-образ в реестр:

     ```bash
     docker push registry.yandexcloud.net/<идентификатор_реестра>/ubuntu:hello
     ```

{% endlist %}