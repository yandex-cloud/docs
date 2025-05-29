---
title: Создать Docker-образ
description: В инструкции описано, как создать Docker-образ на основе Dockerfile в {{ container-registry-name }} и собрать его.
---

# Создать Docker-образ

В инструкции описано, как создать [Docker-образ](../../concepts/docker-image.md) на основе Dockerfile и собрать его.

Чтобы работать с Docker-образами, [установите и настройте](../configure-docker.md) Docker.

{% list tabs group=instructions %}

- CLI {#cli}

  1. Создайте файл Dockerfile на вашем устройстве и добавьте туда следующие строки:

     ```dockerfile
     FROM ubuntu:latest
     CMD echo "Hi, I'm inside"
     ```

     Описанный Docker-образ основан на Ubuntu и будет выполнять одну простую команду.

  1. Соберите Docker-образ. В качестве `<идентификатора_реестра>` используется `ID`, полученный при [создании реестра](../registry/registry-create.md).

     ```bash
     docker build . \
       -t {{ registry }}/<идентификатор_реестра>/ubuntu:hello
     ```

     Флаг `-t` присваивает Docker-образу URL вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`. Можно собрать Docker-образ без указания тега. В таком случае Docker CLI присвоит метку по умолчанию: `latest`.

     Имя и тег Docker-образа являются частью имени [репозитория](../../concepts/repository.md), представляющего собой [URI](https://ru.wikipedia.org/wiki/URI), и должны соответствовать определенному формату. Подробнее см. в спецификации [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#pull).

{% endlist %}

После выполнения данных команд будет создан Docker-образ с тегом `hello` в вашем репозитории и полным адресом репозитория, включающим:
* Адрес сервиса {{ container-registry-name }} `{{ registry }}`.
* Идентификатор вашего реестра `<идентификатор_реестра>`.
* Имя вашего репозитория `ubuntu`.