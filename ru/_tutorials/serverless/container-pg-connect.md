Чтобы подключиться к кластеру {{ mpg-name }} из контейнера {{ serverless-containers-name }}:

1. [Подготовьте файлы для Docker-образа](#prepare-docker).
1. [Создайте Docker-образ в реестре](#create-image).
1. [Создайте и настройте контейнер {{ serverless-containers-name }}](#create-container).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Перед началом работы {#before-begin}

1. Если у вас не установлен [Docker](/blog/posts/2022/03/docker-containers), [установите его](https://docs.docker.com/get-docker/). Убедитесь, что Docker Engine запущен.
1. Если у вас нет кластера {{ mpg-name }}, [создайте его](../../managed-postgresql/operations/cluster-create.md). Настройки публичного доступа к хостам кластера не влияют на возможность подключения из контейнера {{ serverless-containers-name }}.

## Подготовьте файлы для Docker-образа {#prepare-docker}

1. В локальной директории создайте Dockerfile на основе Ubuntu. Настройка окружения в контейнере зависит от наличия публичного доступа к хостам кластера:

    {% list tabs %}

    - Без публичного доступа

        ```docker
        FROM ubuntu:latest

        RUN apt-get update && \
            apt-get install postgresql-client --yes

        COPY pg-version.sh pg-version.sh

        RUN chmod +x pg-version.sh

        ENTRYPOINT ["/pg-version.sh"]
        ```

    - С публичным доступом

        ```docker
        FROM ubuntu:latest

        RUN apt-get update && \
            apt-get install wget postgresql-client --yes && \
            mkdir --parents ~/.postgresql && \
            wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
            --output-document ~/.postgresql/root.crt && \
            chmod 0600 ~/.postgresql/root.crt

        COPY pg-version.sh pg-version.sh

        RUN chmod +x pg-version.sh

        ENTRYPOINT ["/pg-version.sh"]
        ```

    {% endlist %}

1. В ту же рабочую директорию поместите скрипт `pg-version.sh`. Скрипт подключается к базе данных и запрашивает версию {{ PG }}. Строка подключения в скрипте зависит от наличия публичного доступа к хостам кластера:

    {% list tabs %}

    - Без публичного доступа

        ```bash
        #!/bin/bash

        echo "$0: Start: $(date)"

        echo "Viewing the PostgreSQL Server Version"

        export PGPASSWORD='<пароль>'
        psql -h <FQDN_хоста> -p 6432 -U <имя_пользователя> -d <имя_БД> -c 'select version();'

        echo "$0: End: $(date)"
        ```

    - С публичным доступом

        ```bash
        #!/bin/bash

        echo "$0: Start: $(date)"

        echo "Viewing the PostgreSQL Server Version"

        export PGPASSWORD='<пароль>'
        psql -h <FQDN_хоста> -p 6432 --set=sslmode=require -U <имя_пользователя> -d <имя_БД> -c 'select version();'

        echo "$0: End: $(date)"
        ```

    {% endlist %}

    Укажите в скрипте:

    * [FQDN](../../managed-postgresql/operations/connect.md#fqdn) хоста вашего кластера.
    * Имя пользователя, от имени которого выполняется подключение.
    * Пароль пользователя.
    * Имя базы данных для подключения.

## Создайте Docker-образ в реестре {#create-image}

1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) в сервисе {{ container-registry-full-name }}.

1. Соберите Docker-образ, выполнив в рабочей директории с Docker-файлом команду:

    ```bash
    docker build . \
        -t cr.yandex/<идентификатор_реестра>/ubuntu:pgconnect
    ```

    Проверьте, что в локальном репозитории появился образ с указанным именем:

    ```bash
    docker images
    ```

1. Аутентифицируйтесь в реестре:

    1. [Получите IAM-токен](../../iam/operations/iam-token/create.md).
    1. Выполните команду:

        ```bash
        docker login \
        --username iam \
        --password <IAM-токен> \
        cr.yandex
        ```

    Другие способы см. в разделе [{#T}](../../container-registry/operations/authentication.md).

1. Загрузите Docker-образ в реестр:

    ```bash
    docker push cr.yandex/<идентификатор_реестра>/ubuntu:pgconnect
    ```

## Создайте и настройте контейнер {{ serverless-containers-name }} {#create-container}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `docker-puller` и ролью `container-registry.images.puller`.
1. [Создайте контейнер {{ serverless-containers-name }}](../../serverless-containers/operations/create.md) с именем `demo-pg-connect`.
1. В настройках ревизии контейнера укажите:

    * Ссылку на созданный ранее образ в реестре в поле **{{ ui-key.yacloud.serverless-containers.label_image-url }}**.
    * Сервисный аккаунт `docker-puller` в поле **{{ ui-key.yacloud.forms.label_service-account-select }}**.
    * Сеть, в которой расположен кластер {{ mpg-name }}, в поле **{{ ui-key.yacloud.vpc.label_network }}**. Если к кластеру настроен публичный доступ, сеть указывать не обязательно.

1. Нажмите **{{ ui-key.yacloud.serverless-containers.button_deploy-revision }}**.
1. Скопируйте ссылку для вызова контейнера из раздела **{{ ui-key.yacloud.common.section-base }}** в консоли управления.
1. Вызовите контейнер командой:

    ```bash
    curl -H "Authorization: Bearer $(yc iam create-token)" <ссылка_для_вызова>
    ```

1. Перейдите в раздел **{{ ui-key.yacloud.common.logs}}** и убедитесь, что в логи контейнера попадает информация о версии {{ PG }}.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите контейнер {{ serverless-containers-name }}](../../serverless-containers/operations/delete.md).
1. [Удалите Docker-образы из реестра](../../container-registry/operations/docker-image/docker-image-delete.md).
1. [Удалите реестр](../../container-registry/operations/registry/registry-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md).

Чтобы удалить созданный Docker-образ из локального репозитория, выполните команду:

```bash
docker rmi cr.yandex/<идентификатор_реестра>/ubuntu:pgconnect
```
