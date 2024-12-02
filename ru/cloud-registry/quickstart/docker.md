# Как начать работать с {{ cloud-registry-name }}

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/docker-image.md).

## Подготовка к работе {#before-you-begin}

Для создания реестра вам понадобится каталог в {{ yandex-cloud }}. Если каталога еще нет, перед созданием реестра необходимо создать новый каталог:

{% include [create-folder](../../_includes/create-folder.md) %}

## Создание реестра и загрузка Docker-образа {#create-and-push}

Чтобы работать с {{ cloud-registry-name }} и Docker-образами:

1. [Установите {{ yandex-cloud }} CLI](../../cli/operations/install-cli.md) и [настройте](../operations/docker/installation.md) Docker.
1. [Создайте реестр](../operations/registry/create.md) в {{ cloud-registry-name }}.
1. [Аутентифицируйтесь](../operations/docker/authentication.md) в {{ cloud-registry-name }}.
1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

   ```bash
   docker pull ubuntu
   ```

1. Присвойте скачанному Docker-образу тег вида `{{ cloud-registry }}/<идентификатор_реестра>/<имя_Docker-образа>:<тег>`:

   ```bash
   docker tag ubuntu \
   {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

1. Загрузите Docker-образ в репозиторий {{ cloud-registry-name }}:

   ```bash
   docker push \
   {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

1. Запустите Docker-образ:

   ```bash
   docker run \
   {{ cloud-registry }}/<идентификатор_реестра>/ubuntu:hello
   ```

#### Смотрите также {#see-also}

* [Java-артефакт](../concepts/art-java.md)
* [Node.js-артефакт](../concepts/art-nodejs.md)
