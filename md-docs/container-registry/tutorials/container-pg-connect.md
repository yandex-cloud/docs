# Настройка подключения к Yandex Managed Service for PostgreSQL из контейнера Serverless Containers

Чтобы подключиться к кластеру Managed Service for PostgreSQL из контейнера Serverless Containers:

1. [Подготовьте файлы для Docker-образа](#prepare-docker).
1. [Создайте Docker-образ в реестре](#create-image).
1. [Создайте и настройте контейнер Serverless Containers](#create-container).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.


## Необходимые платные ресурсы {#paid-resources}

* Кластер Managed Service for PostgreSQL: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы Managed Service for PostgreSQL](../../managed-postgresql/pricing.md)).
* Публичные IP-адреса, если для хостов кластера включен публичный доступ (см. [тарифы Virtual Private Cloud](../../vpc/pricing.md)).
* Реестр Container Registry: хранение созданных Docker-образов и использование сканера уязвимостей (см. [тарифы Container Registry](../pricing.md)).
* Контейнер Serverless Containers: количество вызовов контейнера, время простоя подготовленных экземпляров и выделенные для выполнения приложения вычислительные ресурсы (см. [тарифы Container Registry](../../serverless-containers/pricing.md)).


## Перед началом работы {#before-begin}

1. Если у вас не установлен [Docker](https://yandex.cloud/ru/blog/posts/2022/03/docker-containers), [установите его](https://docs.docker.com/get-docker/). Убедитесь, что Docker Engine запущен.
1. Если у вас нет кластера Managed Service for PostgreSQL, [создайте его](../../managed-postgresql/operations/cluster-create.md). Настройки публичного доступа к хостам кластера не влияют на возможность подключения из контейнера Serverless Containers.

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

1. В ту же рабочую директорию поместите скрипт `pg-version.sh`. Скрипт подключается к базе данных и запрашивает версию PostgreSQL. Строка подключения в скрипте зависит от наличия публичного доступа к хостам кластера:

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

    * [FQDN](../../managed-postgresql/operations/connect/fqdn.md) хоста вашего кластера.
    * Имя пользователя, от имени которого выполняется подключение.
    * Пароль пользователя.
    * Имя базы данных для подключения.

## Создайте Docker-образ в реестре {#create-image}

1. [Создайте реестр](../operations/registry/registry-create.md) в сервисе Yandex Container Registry.

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

    Другие способы см. в разделе [Аутентифицироваться в Container Registry](../operations/authentication.md).

1. Загрузите Docker-образ в реестр:

    ```bash
    docker push cr.yandex/<идентификатор_реестра>/ubuntu:pgconnect
    ```

## Создайте и настройте контейнер Serverless Containers {#create-container}

1. [Создайте сервисный аккаунт](../../iam/operations/sa/create.md) с именем `docker-puller` и ролью `container-registry.images.puller`.
1. [Создайте контейнер Serverless Containers](../../serverless-containers/operations/create.md) с именем `demo-pg-connect`.
1. В настройках ревизии контейнера укажите:

    * Ссылку на созданный ранее образ в реестре в поле **URL образа**.
    * Сервисный аккаунт `docker-puller` в поле **Сервисный аккаунт**.
    * Сеть, в которой расположен кластер Managed Service for PostgreSQL, в поле **Сеть**. Если к кластеру настроен публичный доступ, сеть указывать не обязательно.

1. Нажмите **Создать ревизию**.
1. Скопируйте ссылку для вызова контейнера из раздела **Общая информация** в консоли управления.
1. Вызовите контейнер командой:

    ```bash
    curl --header "Authorization: Bearer $(yc iam create-token)" <ссылка_для_вызова>
    ```

1. Перейдите в раздел **Логи** и убедитесь, что в логи контейнера попадает информация о версии PostgreSQL.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите контейнер Serverless Containers](../../serverless-containers/operations/delete.md).
1. [Удалите Docker-образы из реестра](../operations/docker-image/docker-image-delete.md).
1. [Удалите реестр](../operations/registry/registry-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md).
1. [Удалите кластер Managed Service for PostgreSQL](../../managed-postgresql/operations/cluster-delete.md).

Чтобы удалить созданный Docker-образ из локального репозитория, выполните команду:

```bash
docker rmi cr.yandex/<идентификатор_реестра>/ubuntu:pgconnect
```