# Загрузить Docker-образ в реестр

Инструкция описывает, как загрузить локальный [Docker-образ](../../concepts/docker-image.md) в реестр.

{% note info %}

Чтобы загрузить образ, необходимо [аутентифицироваться](../authentication.md) в реестре.

{% endnote %}

{% list tabs %}

- CLI

  1. Посмотрите список доступных для загрузки [Docker-образов](../../concepts/docker-image.md):

     ```
     docker image list
     ```
     
     Результат:

     ```
     REPOSITORY                                  TAG     IMAGE ID      CREATED       SIZE
     {{ registry }}/crpd50616s9a********/ubuntu       hello   50ff********  23 hours ago  86.7MB
     ubuntu                                      latest  1d9c********  2 weeks ago   86.7MB
     ```

  1. (Опционально) Присвойте Docker-образу URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

     ```
     docker tag ubuntu \
     {{ registry }}/crpd50616s9a********/ubuntu:hello
     ```

     {% note info %}

     Загрузить в {{ container-registry-name }} можно только Docker-образы с URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`.

     {% endnote %}

  1. Загрузите необходимый Docker-образ в реестр:

     ```
     docker push {{ registry }}/crpd50616s9a********/ubuntu:hello
     ```

  1. Проверьте, что образ загрузился в реестр, [получив список Docker-образов в реестре](docker-image-list.md#docker-image-list).

{% endlist %}