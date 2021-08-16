# Загрузить Docker-образ в реестр

Инструкция описывает, как загрузить локальный [Docker-образ](../../concepts/docker-image.md) в реестр.

{% note info %}

Чтобы загрузить образ, необходимо [аутентифицироваться](../authentication.md) в реестре.

{% endnote %}

{% list tabs %}

- CLI
  
  1. Посмотрите список доступных для загрузки Docker-образов:
  
      ```
      $ docker image list
      REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
      cr.yandex/crpd50616s9a2t7gr8mi/ubuntu   hello               50ff4b0e5783        23 hours ago        86.7MB
      ubuntu                                  latest              1d9c17228a9e        2 weeks ago         86.7MB
      ```
  
  1. (опционально) Присвойте Docker-образу тег вида `cr.yandex/<ID реестра>/<имя Docker-образа>:<тег>`:

      ```
      $ docker tag ubuntu \
      cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:example
      ```

      {% note info %}

      Загрузить в {{ container-registry-name }} можно только Docker-образы с тегом вида `cr.yandex/<ID реестра>/<имя Docker-образа>:<тег>`.

      {% endnote %}

  1. Загрузите необходимый Docker-образ в реестр:
  
      ```
      $ docker push cr.yandex/crpd50616s9a2t7gr8mi/ubuntu:hello
      ```
  
  1. Проверьте, что образ загрузился в реестр, [получив список Docker-образов в реестре](docker-image-list.md#docker-image-list).
  
{% endlist %}
