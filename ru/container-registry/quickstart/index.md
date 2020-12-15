# Как начать работать c {{ container-registry-short-name }}

В этой инструкции вы создадите свой первый [реестр](../concepts/registry.md) и попробуете управлять [Docker-образами](../concepts/docker-image.md).

## Подготовка к работе {#before-you-begin}

Для создания реестра вам понадобится каталог в {{ yandex-cloud }}. Если каталога еще нет, перед созданием реестра необходимо
создать новый каталог:

{% include [create-folder](../../_includes/create-folder.md) %}

Также вам понадобятся [Yandex CLI](../../cli/quickstart.md) и [Docker](https://docs.docker.com/install/).

## Создание реестра и базовые операции с Docker-образом {#registry-create}

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

    Полученный `ID` далее будет использоваться для обращения к созданному реестру.

1. Аутентифицируйтесь в {{ container-registry-short-name }} с помощью [Docker Credential helper](../operations/authentication.md#cred-helper):

    1. Сконфигурируйте Docker для использования `docker-credential-yc`:
    
        ```
        $ yc container registry configure-docker
        Credential helper is configured in '/home/<user>/.docker/config.json'
        ```
    
        При конфигурации сохраняется информация о текущем профиле пользователя.
    
    1. Проверьте, что Docker сконфигурирован.
    
        В конфигурационном файле `/home/<user>/.docker/config.json` должна появиться строка:
    
        ```
        "cr.yandex": "yc"
        ```
        
1. Скачайте Docker-образ из репозитория [Docker Hub](https://hub.docker.com):

    ```
    $ docker pull ubuntu
    ```

1. Присвойте скачанному Docker-образу тег вида `cr.yandex/<ID реестра>/<имя Docker-образа>:<тег>`:

    ```
    $ docker tag ubuntu \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Загрузите Docker-образ в репозиторий {{ container-registry-short-name }}:

    ```
    $ docker push \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

1. Запустите Docker-образ:

    ```
    $ docker run \
    cr.yandex/crpc9qeoft236r8tfalm/ubuntu:hello
    ```

#### Смотрите также {#see-also}

- [Создание реестра](../operations/registry/registry-create.md)
- [Аутентификация в {{ container-registry-short-name }}](../operations/authentication.md)
- [Создание Docker-образа](../operations/docker-image/docker-image-create.md)
- [Загрузка Docker-образа](../operations/docker-image/docker-image-push.md)
- [Скачивание Docker-образа](../operations/docker-image/docker-image-pull.md)
- [Запуск Docker-образа на виртуальной машине](../solutions/index.md)
