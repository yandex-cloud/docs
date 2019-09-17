# Как начать работать c {{ container-registry-short-name }}

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/docker-image.md).

## Подготовка к работе
Для создания реестра вам понадобится каталог в Яндекс.Облаке. Если каталога еще нет, перед созданием реестра необходимо
создать новый каталог:


{% include [create-folder](../../_includes/create-folder.md) %}

Также вам понадобятся [Yandex CLI](../../cli/quickstart.md) и [Docker](https://docs.docker.com/install/).


## Создание реестра и базовые операции с Docker-образом

1. Создайте реестр в {{ container-registry-short-name }}:

    ```
    $ yc container registry create --name my-first-registry
    ..done
    id: crpc9qeoft236r8tfalm
    folder_id: b1g0itj57rbjk9thrinv
    name: my-first-registry
    status: ACTIVE
    created_at: "2018-12-25T12:24:56.286Z"
    ```

    Полученный `id` далее будет использоваться для обращения к созданному реестру.

1. Пройдите аутентификацию в {{ container-registry-short-name }} командой `docker login` с помощью OAuth-токена,
получить его можно по [ссылке]({{ link-cloud-oauth }}).

    ```
    $ docker login \
    --username oauth \ # тип используемого токена
    --password <OAuth-токен> \
    cr.yandex
    ```

1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

    ```
    $ docker pull ubuntu
    ```

1. Присвойте Docker-образу тег:

    ```
    $ docker tag <ID образа> \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Загрузите Docker-образ в репозиторий:

    ```
    $ docker push \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Запустите Docker-образ:

    ```
    $ docker run \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

#### Смотрите также

- [Создание реестра](../operations/registry/registry-create.md)
- [Аутентификация в {{ container-registry-short-name }}](../operations/authentication.md)
- [Создание Docker-образа](../operations/docker-image/docker-image-create.md)
- [Загрузка Docker-образа](../operations/docker-image/docker-image-push.md)
- [Скачивание Docker-образа](../operations/docker-image/docker-image-pull.md)
- [Запуск Docker-образа на виртуальной машине](../solutions/index.md)
