---
title: Подключение к управляемым БД из контейнера {{ serverless-containers-name }} через пользовательскую сеть {{ vpc-short-name }}
description: Следуя данному руководству, вы сможете развернуть в {{ serverless-containers-name }} HTTP-приложение, которое подключается к приватному кластеру {{ mpg-name }} или {{ mch-name }} через пользовательскую сеть {{ vpc-short-name }}.
alternate:
  - href: ru/serverless-containers/tutorials/database-connection-via-vpc.md
    type: text/markdown
    title: Markdown version
---

# Подключение к управляемым БД из контейнера {{ serverless-containers-name }} через пользовательскую сеть {{ vpc-short-name }}

В этом руководстве вы развернете в {{ serverless-containers-name }} HTTP-приложение на Python, которое подключается к приватному кластеру {{ mpg-name }} или {{ mch-name }} и возвращает результат запроса `SELECT 1`. Чтобы повторить пример для обеих СУБД, выполните руководство отдельно для каждого кластера.

Чтобы подключиться к управляемой БД из контейнера {{ serverless-containers-name }}:

1. [Подготовьте кластер и сеть](#prepare-cluster).
1. [Настройте аутентификацию](#setup-auth).
1. [Подготовьте файлы для Docker-образа](#prepare-docker).
1. [Создайте Docker-образ в реестре](#create-image).
1. [Создайте контейнер и разверните ревизию](#create-container).
1. [Проверьте работу контейнера](#test-container).

Если созданные ресурсы вам больше не нужны, [удалите](#clear-out) их.

## Необходимые платные ресурсы {#paid-resources}

В стоимость ресурсов для этого сценария входят:

* Плата за вычислительные ресурсы, объем хранилища и резервных копий кластера управляемой БД ([тарифы {{ mpg-name }}](../../managed-postgresql/pricing.md), [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Плата за хранение Docker-образов в реестре ([тарифы {{ container-registry-name }}](../../container-registry/pricing.md)).
* Плата за количество вызовов контейнера, время простоя подготовленных экземпляров и выделенные вычислительные ресурсы ([тарифы {{ serverless-containers-name }}](../../serverless-containers/pricing.md)).
* Плата за хранение секретов в {{ lockbox-name }}, если вы используете парольную аутентификацию ([тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

## Перед началом работы {#before-begin}

1. Если у вас не установлен [Docker](https://docs.docker.com/get-docker/), установите его. Убедитесь, что Docker Engine запущен.
1. Если у вас не установлен [{{ yandex-cloud }} CLI](../../cli/quickstart.md), установите и настройте его.
1. Установите в рабочем окружении утилиты `curl` и [`jq`](https://stedolan.github.io/jq/download/).
1. Если у вас нет кластера {{ mpg-name }} или {{ mch-name }}, создайте его: [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) или [{{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md). В кластере должна быть хотя бы одна база данных.

## Подготовьте кластер и сеть {#prepare-cluster}

1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером управляемой БД. Откройте кластер и запомните идентификатор его сети и группы безопасности.
1. Убедитесь, что в сети {{ vpc-short-name }} кластера есть подсети во всех зонах доступности. При необходимости [создайте недостающие подсети](../../vpc/operations/subnet-create.md).
1. [Отредактируйте правила группы безопасности кластера](../../vpc/operations/security-group-update.md) и добавьте правило для **входящего** трафика:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-direction }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-direction-ingress }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `TCP`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `198.19.0.0/16`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432` для {{ mpg-name }} или `8443` для {{ mch-name }}.

    Адреса `198.19.0.0/16` используются служебными подсетями платформы, через которые контейнер обращается к кластеру.

1. На странице кластера откройте раздел **Хосты** и скопируйте [FQDN хоста](../../managed-postgresql/operations/connect/fqdn.md). Для {{ mpg-name }} выберите хост-мастер.
1. Откройте раздел **Базы данных** и скопируйте имя базы данных.
1. Сохраните параметры кластера в переменных текущей Bash-сессии:

    ```bash
    DB_ENGINE='postgresql' # Для {{ mch-name }} укажите clickhouse.
    CLUSTER_ID='<идентификатор_кластера>'
    DB_HOST='<FQDN_хоста>'
    DB_NAME='<имя_базы_данных>'

    MDB_SERVICE="managed-${DB_ENGINE}"
    NETWORK_ID=$(yc "$MDB_SERVICE" cluster get --id "$CLUSTER_ID" --format json | \
      jq -er .network_id)
    ```

    В `DB_HOST` укажите только FQDN, без схемы, порта и пути.

## Настройте аутентификацию {#setup-auth}

1. Создайте сервисный аккаунт, от имени которого будет работать контейнер:

    ```bash
    SA_NAME='private-db-example-sa'
    SA_ID=$(yc iam service-account create --name "$SA_NAME" --format json | \
      jq -er .id)
    ```

    Если сервисный аккаунт уже существует, получите его идентификатор:

    ```bash
    SA_NAME='<имя_существующего_сервисного_аккаунта>'
    SA_ID=$(yc iam service-account get --name "$SA_NAME" --format json | \
      jq -er .id)
    ```

1. Выберите способ аутентификации в БД и выполните соответствующие команды в той же Bash-сессии:

    {% list tabs %}

    - IAM-токен

      Пример запрашивает IAM-токен сервисного аккаунта у сервиса метаданных при каждом вызове и использует его как пароль к БД.

      1. Создайте в кластере пользователя с именем, равным идентификатору сервисного аккаунта:

          ```bash
          if [[ "$DB_ENGINE" == postgresql ]]; then
            yc managed-postgresql user create "$SA_ID" --cluster-id "$CLUSTER_ID" \
              --auth-method auth-method-iam --permissions "$DB_NAME" --login
          else
            yc managed-clickhouse user create "$SA_ID" --cluster-id "$CLUSTER_ID" \
              --auth-method iam --permissions "$DB_NAME"
          fi
          ```

      1. Выдайте сервисному аккаунту права на подключение к кластеру и на использование самого себя:

          ```bash
          yc "$MDB_SERVICE" cluster add-access-binding --id "$CLUSTER_ID" \
            --role "$MDB_SERVICE.clusters.connector" --service-account-id "$SA_ID"

          yc iam service-account add-access-binding --id "$SA_ID" \
            --role iam.serviceAccounts.user --service-account-id "$SA_ID"
          ```

      1. Сохраните параметры аутентификации в переменной:

          ```bash
          AUTH_ARGS=(--environment "DB_AUTH=iam,DB_USER=$SA_ID")
          ```

    - Пароль из {{ lockbox-name }}

      Пример получает имя пользователя и пароль из секрета {{ lockbox-name }} и использует их для подключения к БД.

      1. В кластере создайте пользователя с парольной аутентификацией и доступом к выбранной БД или используйте существующего.
      1. [Создайте секрет](../../lockbox/operations/secret-create.md) в {{ lockbox-name }} с двумя текстовыми ключами: `username` — имя пользователя БД, `password` — его пароль. Скопируйте идентификаторы секрета и его версии.
      1. Выдайте сервисному аккаунту доступ к секрету. Если секрет зашифрован пользовательским ключом {{ kms-short-name }}, дополнительно выдайте аккаунту роль `kms.keys.encrypterDecrypter` на ключ.

          ```bash
          SECRET_ID='<идентификатор_секрета>'
          SECRET_VERSION_ID='<идентификатор_версии_секрета>'

          yc lockbox secret add-access-binding --id "$SECRET_ID" \
            --role lockbox.payloadViewer --service-account-id "$SA_ID"
          ```

      1. Сохраните параметры аутентификации в переменной:

          ```bash
          AUTH_ARGS=(
            --environment DB_AUTH=password
            --secret "environment-variable=DB_USER,id=$SECRET_ID,version-id=$SECRET_VERSION_ID,key=username"
            --secret "environment-variable=DB_PASSWORD,id=$SECRET_ID,version-id=$SECRET_VERSION_ID,key=password"
          )
          ```

    {% endlist %}

## Подготовьте файлы для Docker-образа {#prepare-docker}

1. Создайте пустую рабочую директорию и перейдите в нее.
1. Загрузите корневой сертификат {{ yandex-cloud }}:

    ```bash
    curl --fail --silent --show-error --location \
      {{ crt-web-path }} -o RootCA.pem
    ```

1. Создайте файл `requirements.txt` со списком зависимостей:

    ```text
    psycopg2-binary==2.9.10
    ```

1. Создайте файл `db.py` с кодом подключения к БД. Код проверяет сертификат и имя сервера, выполняет запрос `SELECT 1` и закрывает соединение:

    ```python
    import json
    import os
    import ssl
    from contextlib import closing
    from http.client import HTTPConnection, HTTPSConnection
    from pathlib import Path
    from urllib.parse import urlencode

    CA = Path(__file__).with_name("RootCA.pem")


    def credentials():
        user = os.environ["DB_USER"]
        if os.environ["DB_AUTH"] == "password":
            return user, os.environ["DB_PASSWORD"]

        with closing(HTTPConnection("169.254.169.254", timeout=3)) as metadata:
            metadata.request(
                "GET",
                "/computeMetadata/v1/instance/service-accounts/default/token",
                headers={"Metadata-Flavor": "Google"},
            )
            with metadata.getresponse() as response:
                if response.status != 200:
                    raise RuntimeError(f"Metadata HTTP {response.status}")
                return user, json.load(response)["access_token"]


    def select_one():
        engine = os.environ["DB_ENGINE"]
        if engine not in {"postgresql", "clickhouse"}:
            raise ValueError("DB_ENGINE must be postgresql or clickhouse")

        host = os.environ["DB_HOST"]
        database = os.environ["DB_NAME"]
        user, password = credentials()

        if engine == "postgresql":
            import psycopg2

            with closing(psycopg2.connect(
                host=host, port=6432, dbname=database,
                user=user, password=password, connect_timeout=5,
                sslmode="verify-full", sslrootcert=str(CA),
                options="-c statement_timeout=5000",
            )) as connection, connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                return cursor.fetchone()[0]

        tls = ssl.create_default_context(cafile=str(CA))
        path = "/?" + urlencode({"database": database})
        with closing(HTTPSConnection(host, 8443, timeout=5, context=tls)) as connection:
            connection.request(
                "POST", path, body=b"SELECT 1",
                headers={"X-ClickHouse-User": user, "X-ClickHouse-Key": password},
            )
            with connection.getresponse() as response:
                if response.status != 200:
                    raise RuntimeError(f"ClickHouse HTTP {response.status}")
                return int(response.read())
    ```

1. Создайте файл `app.py` с кодом HTTP-сервера. Приложение слушает порт, который {{ serverless-containers-name }} передает через переменную `PORT`:

    ```python
    import json
    import os
    from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

    from db import select_one


    class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
            try:
                body = json.dumps({"result": select_one()}).encode()
            except Exception as error:
                print(f"Database query failed: {type(error).__name__}", flush=True)
                self.send_error(502, "Database query failed")
                return

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)


    if __name__ == "__main__":
        ThreadingHTTPServer(("0.0.0.0", int(os.environ["PORT"])), Handler).serve_forever()
    ```

1. Создайте `Dockerfile`:

    ```dockerfile
    FROM python:3.12-slim
    WORKDIR /app
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    COPY app.py db.py RootCA.pem ./
    CMD ["python", "app.py"]
    ```

## Создайте Docker-образ в реестре {#create-image}

1. [Создайте реестр](../../container-registry/operations/registry/registry-create.md) в сервисе {{ container-registry-full-name }} или используйте существующий.
1. Выдайте сервисному аккаунту контейнера право скачивать образы из реестра и сохраните URL образа в переменной:

    ```bash
    REGISTRY_ID='<идентификатор_реестра>'
    IMAGE="{{ registry }}/$REGISTRY_ID/private-db-example:v1"

    yc container registry add-access-binding --id "$REGISTRY_ID" \
      --role container-registry.images.puller --service-account-id "$SA_ID"
    ```

1. [Аутентифицируйтесь в реестре](../../container-registry/operations/authentication.md). Например, с помощью {{ yandex-cloud }} CLI:

    ```bash
    yc container registry configure-docker
    ```

1. Соберите Docker-образ и загрузите его в реестр:

    ```bash
    docker build --platform linux/amd64 -t "$IMAGE" .
    docker push "$IMAGE"
    ```

## Создайте контейнер и разверните ревизию {#create-container}

1. Создайте контейнер {{ serverless-containers-name }}:

    ```bash
    CONTAINER_NAME='private-db-example'

    yc serverless container create --name "$CONTAINER_NAME"
    ```

1. Разверните ревизию контейнера. Команда использует переменную `AUTH_ARGS`, которую вы заполнили на шаге [Настройте аутентификацию](#setup-auth):

    ```bash
    yc serverless container revision deploy --container-name "$CONTAINER_NAME" \
      --image "$IMAGE" --cores 1 --memory 256MB --concurrency 1 --execution-timeout 20s \
      --network-id "$NETWORK_ID" --service-account-id "$SA_ID" \
      --environment "DB_ENGINE=$DB_ENGINE,DB_HOST=$DB_HOST,DB_NAME=$DB_NAME" \
      "${AUTH_ARGS[@]}"
    ```

    При смене версии секрета {{ lockbox-name }} повторите команду `revision deploy` с новым значением `SECRET_VERSION_ID`.

## Проверьте работу контейнера {#test-container}

1. Получите URL контейнера:

    ```bash
    CONTAINER_URL=$(yc serverless container get --name "$CONTAINER_NAME" --format json | \
      jq -er .url)
    ```

1. Вызовите контейнер. У вызывающего пользователя должна быть роль `serverless.containers.invoker` или другая роль с правом вызова контейнера:

    ```bash
    curl --fail --silent --show-error \
      -H "Authorization: Bearer $(yc iam create-token)" "$CONTAINER_URL"
    ```

    Ожидаемый ответ — HTTP 200 и тело:

    ```json
    {"result": 1}
    ```

    Значение `"result": 1` означает, что контейнер подключился к БД, прошел аутентификацию и получил результат SQL-запроса.

1. Если приложение возвращает HTTP 502, проверьте [логи контейнера](../operations/logs.md), выбранную сеть, правило группы безопасности и настройки пользователя БД.

## Удалите созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите контейнер {{ serverless-containers-name }}](../operations/delete.md).
1. [Удалите Docker-образ из реестра](../../container-registry/operations/docker-image/docker-image-delete.md).
1. Если реестр больше не нужен, [удалите его](../../container-registry/operations/registry/registry-delete.md).
1. Если вы использовали парольную аутентификацию, [удалите секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md), если он больше не нужен.
1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md) или [кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).
