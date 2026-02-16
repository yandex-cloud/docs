---
title: Как начать работать с {{ container-registry-name }}
description: В этой инструкции вы создадите свой первый реестр {{ container-registry-name }} и попробуете управлять Docker-образами.
---

# Как начать работать с {{ container-registry-name }}

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/docker-image.md).

## Подготовка к работе {#before-you-begin}

Для создания реестра вам понадобится каталог в {{ yandex-cloud }}. Если каталога еще нет, перед созданием реестра необходимо создать новый каталог:

{% include [create-folder](../../_includes/create-folder.md) %}

Чтобы работать с {{ container-registry-name }} и Docker-образами, [установите {{ yandex-cloud }} CLI](../../cli/operations/install-cli.md) и [настройте](../operations/configure-docker.md) Docker.

## Создание реестра и базовые операции с Docker-образом {#registry-create}

1. Создайте реестр в {{ container-registry-name }}:

   ```bash
   yc container registry create --name my-first-registry
   ```

   Результат:

   ```text
   ..done
   id: crpc9qeoft23********
   folder_id: b1g0itj57rbj********
   name: my-first-registry
   status: ACTIVE
   created_at: "2018-12-25T12:24:56.286Z"
   ```

   Полученный `ID` далее будет использоваться для обращения к созданному реестру.
1. Аутентифицируйтесь в {{ container-registry-name }} с помощью [Docker Credential helper](../operations/authentication.md#cred-helper):
   1. Сконфигурируйте [Docker](/blog/posts/2022/03/docker-containers) для использования `docker-credential-yc`:

      ```bash
      yc container registry configure-docker
      ```

      Результат:

      ```text
      Credential helper is configured in '/home/<user>/.docker/config.json'
      ```

      При конфигурации сохраняется информация о текущем профиле пользователя.
   1. Проверьте, что Docker сконфигурирован.

      В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:

      ```json
      "{{ registry }}": "yc"
      ```

1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Присвойте скачанному Docker-образу тег вида `{{ registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

   ```bash
   docker tag ubuntu \
   {{ registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

1. Загрузите Docker-образ в репозиторий {{ container-registry-name }}:

   ```bash
   docker push \
   {{ registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

1. Запустите Docker-образ:

   ```bash
   docker run \
   {{ registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

#### Смотрите также {#see-also}

* [Создание реестра](../operations/registry/registry-create.md).
* [Аутентификация в {{ container-registry-name }}](../operations/authentication.md).
* [Создание Docker-образа](../operations/docker-image/docker-image-create.md).
* [Загрузка Docker-образа](../operations/docker-image/docker-image-push.md).
* [Скачивание Docker-образа](../operations/docker-image/docker-image-pull.md).
* [Запуск Docker-образа на виртуальной машине](../tutorials/index.md).