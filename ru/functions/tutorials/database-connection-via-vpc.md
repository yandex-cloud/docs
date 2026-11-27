---
title: Подключение к управляемым БД из функции {{ sf-full-name }} через пользовательскую сеть {{ vpc-short-name }}
description: В этом руководстве вы создадите функцию на Python, которая подключается к приватному кластеру {{ mpg-name }} или {{ mch-name }} через пользовательскую сеть и возвращает результат запроса SELECT 1.
alternate:
  - href: ru/functions/tutorials/database-connection-via-vpc.md
    type: text/markdown
    title: Markdown version
---

# Подключение к управляемым БД из функции {{ sf-name }} через пользовательскую сеть {{ vpc-short-name }}

С помощью этого руководства вы создадите [функцию](../concepts/function.md) {{ sf-name }} на Python, которая подключается к приватной базе данных [{{ mpg-name }}](../../managed-postgresql/) или [{{ mch-name }}](../../managed-clickhouse/) через [пользовательскую сеть](../concepts/networking.md) и выполняет запрос `SELECT 1`.

Функция подключается к кластеру через хост в пользовательской сети. Для аутентификации в кластере можно использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта или пароль из [{{ lockbox-name }}](../../lockbox/).

Чтобы создать функцию и подключиться к управляемой БД:

1. [Подготовьте облако к работе](#before-begin).
1. [Подготовьте кластер и сеть](#prepare-cluster).
1. [Создайте сервисный аккаунт](#create-sa).
1. [Настройте аутентификацию](#configure-auth).
1. [Подготовьте код функции](#prepare-code).
1. [Создайте функцию](#create-function).
1. [Вызовите функцию](#invoke-function).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

Для выполнения команд из руководства установите и настройте следующие инструменты:

* [{{ yandex-cloud }} CLI](../../cli/quickstart.md).
* `bash`, `curl`, `jq`.
* `zip` — для упаковки кода функции в архив.

### Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки инфраструктуры для этого руководства входит:

* плата за вычислительные ресурсы кластера, объем хранилища и резервных копий (тарифы [{{ mpg-name }}](../../managed-postgresql/pricing.md) или [{{ mch-name }}](../../managed-clickhouse/pricing.md));
* плата за количество вызовов функции и вычислительные ресурсы, выделенные для ее выполнения ([тарифы {{ sf-full-name }}](../pricing.md));
* плата за хранение секретов, если для аутентификации используется пароль ([тарифы {{ lockbox-name }}](../../lockbox/pricing.md)).

## Подготовьте кластер и сеть {#prepare-cluster}

Для подключения из функции кластеру нужна сеть с подсетями во всех зонах доступности и хотя бы один ресурс с IP-адресом в этой сети. Хост приватного кластера подходит в качестве такого ресурса.

1. Если у вас еще нет подходящего кластера, создайте его: [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) или [{{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md). Публичный доступ к хостам кластера можно оставить выключенным.
1. В [консоли управления]({{ link-console-main }}) выберите каталог с кластером и откройте его страницу.
1. В разделе **Обзор** проверьте, что в сети кластера есть подсети во всех зонах доступности.
1. [Добавьте в группу безопасности кластера](../../vpc/operations/security-group-update.md) правило для входящего трафика со следующими параметрами:

    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `TCP`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `198.19.0.0/16`. Это диапазон служебных подсетей, из которых функция обращается к ресурсам в пользовательской сети.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `6432` для {{ PG }} или `8443` для {{ CH }}.

1. На странице кластера откройте раздел **Хосты** и скопируйте значение в столбце **FQDN хоста**. Для {{ PG }} выберите хост-мастер.
1. В разделе **Базы данных** скопируйте имя нужной базы данных.

Сохраните параметры кластера в переменных текущей Bash-сессии. В переменной `DB_HOST` укажите только FQDN, без схемы, порта и пути. Выберите одно значение для `DB_ENGINE`.

```bash
DB_ENGINE='postgresql' # Для {{ CH }} укажите clickhouse.
CLUSTER_ID='<идентификатор_кластера>'
DB_HOST='<FQDN_хоста>'
DB_NAME='<имя_БД>'

MDB_SERVICE="managed-${DB_ENGINE}"
NETWORK_ID=$(yc "$MDB_SERVICE" cluster get --id "$CLUSTER_ID" --format json |
  jq -er .network_id)
```

Чтобы сверить FQDN и имя базы через CLI, выполните команды. В выводе `host list` адрес находится в столбце `NAME`:

```bash
yc "$MDB_SERVICE" host list --cluster-id "$CLUSTER_ID"
yc "$MDB_SERVICE" database list --cluster-id "$CLUSTER_ID"
```

{% note info %}

Если приложение выполняет запись в многохостовый кластер {{ PG }}, используйте [FQDN текущего мастера или несколько FQDN с выбором доступного для записи хоста](../../managed-postgresql/operations/connect/fqdn.md).

{% endnote %}

## Создайте сервисный аккаунт {#create-sa}

Создайте [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), от имени которого будет работать функция, и сохраните его идентификатор в переменной `SA_ID`:

```bash
SA_NAME='private-db-example-sa'
SA_ID=$(yc iam service-account create --name "$SA_NAME" --format json |
  jq -er .id)
```

Если сервисный аккаунт уже существует в текущем каталоге, подставьте его имя и получите идентификатор командой `get`:

```bash
SA_NAME='<имя_сервисного_аккаунта>'
SA_ID=$(yc iam service-account get --name "$SA_NAME" --format json |
  jq -er .id)
```

{% note info %}

Для создания сервисного аккаунта и развертывания функции нужны соответствующие права в текущем каталоге. Если при развертывании не хватает права на использование сервисного аккаунта, нужно выдать роль `iam.serviceAccounts.user` на сам созданный сервисный аккаунт.

{% endnote %}

## Настройте аутентификацию {#configure-auth}

Выберите способ аутентификации в кластере и выполните команды в той же Bash-сессии.

{% list tabs group=auth %}

- IAM-токен {#iam-token}

  Функция запрашивает [IAM-токен](../../iam/concepts/authorization/iam-token.md) сервисного аккаунта из [сервиса метаданных](../concepts/runtime/environment-variables.md) и использует его как пароль к БД.

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

  1. Назначьте сервисному аккаунту роль для подключения к кластеру:

      ```bash
      yc "$MDB_SERVICE" cluster add-access-binding --id "$CLUSTER_ID" \
        --role "$MDB_SERVICE.clusters.connector" --service-account-id "$SA_ID"
      ```

  1. Разрешите сервисному аккаунту получать собственный IAM-токен:

      ```bash
      yc iam service-account add-access-binding --id "$SA_ID" \
        --role iam.serviceAccounts.user --service-account-id "$SA_ID"
      ```

  1. Сохраните параметры для команды создания версии функции:

      ```bash
      AUTH_ARGS=(--environment "DB_AUTH=iam,DB_USER=$SA_ID")
      ```

  {% note info %}

  Для рабочего приложения выдайте пользователю БД права на нужные SQL-операции.

  {% endnote %}

- Пароль из {{ lockbox-name }} {#lockbox-password}

  Функция получает имя и пароль пользователя БД из [секрета {{ lockbox-name }}](../../lockbox/concepts/secret.md) через переменные окружения.

  1. Создайте в кластере пользователя с парольной аутентификацией и доступом к выбранной БД или используйте существующего. В консоли откройте кластер и перейдите в раздел **Пользователи**.
  1. [Создайте секрет](../../lockbox/operations/secret-create.md) {{ lockbox-name }} с двумя текстовыми ключами:

      * `username` — имя пользователя БД;
      * `password` — его пароль.

      Скопируйте идентификатор секрета и идентификатор его версии.
  1. Сохраните идентификаторы в переменных:

      ```bash
      SECRET_ID='<идентификатор_секрета>'
      SECRET_VERSION_ID='<идентификатор_версии_секрета>'
      ```

  1. Выдайте сервисному аккаунту доступ к секрету:

      ```bash
      yc lockbox secret add-access-binding --id "$SECRET_ID" \
        --role {{ roles-lockbox-payloadviewer }} --service-account-id "$SA_ID"
      ```

      Если секрет зашифрован пользовательским ключом [{{ kms-name }}](../../kms/), дополнительно выдайте сервисному аккаунту роль `kms.keys.encrypterDecrypter` на ключ.
  1. Сохраните параметры для команды создания версии функции:

      ```bash
      AUTH_ARGS=(
        --environment DB_AUTH=password
        --secret "environment-variable=DB_USER,id=$SECRET_ID,version-id=$SECRET_VERSION_ID,key=username"
        --secret "environment-variable=DB_PASSWORD,id=$SECRET_ID,version-id=$SECRET_VERSION_ID,key=password"
      )
      ```

  {% note info %}

  Передача секретов в окружение функции находится на стадии Preview. При смене версии секрета повторно создайте версию функции с новым значением `SECRET_VERSION_ID`.

  {% endnote %}

{% endlist %}

## Подготовьте код функции {#prepare-code}

Среда выполнения Python 3.12 в {{ sf-name }} уже содержит CA-сертификат для управляемых БД по пути `/usr/local/share/ca-certificates/yandex-internal-ca.crt`. Функция использует его для проверки TLS-соединения.

1. Создайте пустой рабочий каталог и перейдите в него.
1. Создайте файл `requirements.txt` со списком зависимостей:

    ```text
    psycopg2-binary==2.9.10
    ```

1. Создайте файл `db.py`. Код подключается к выбранной СУБД, проверяет сертификат и имя сервера, выполняет запрос `SELECT 1` и закрывает соединение.

    ```python
    import json
    import os
    import ssl
    from contextlib import closing
    from http.client import HTTPConnection, HTTPSConnection
    from urllib.parse import urlencode

    CA = "/usr/local/share/ca-certificates/yandex-internal-ca.crt"


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
                sslmode="verify-full", sslrootcert=CA,
                options="-c statement_timeout=5000",
            )) as connection, connection.cursor() as cursor:
                cursor.execute("SELECT 1")
                return cursor.fetchone()[0]

        tls = ssl.create_default_context(cafile=CA)
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

1. Создайте файл `index.py` с [обработчиком](../concepts/function.md) функции:

    ```python
    import json

    from db import select_one


    def handler(event, context):
        return {
            "statusCode": 200,
            "headers": {"Content-Type": "application/json"},
            "body": json.dumps({"result": select_one()}),
        }
    ```

1. Упакуйте файлы в ZIP-архив. Они должны лежать в корне архива:

    ```bash
    zip function.zip index.py db.py requirements.txt
    ```

## Создайте функцию {#create-function}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно создать функцию.
  1. [Перейдите]({{ link-console-main }}/link/functions) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
  1. Введите имя функции и нажмите **{{ ui-key.yacloud.common.create }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** выберите среду выполнения `Python 3.12` и отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
  1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-source }}** выберите способ `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` и загрузите подготовленный ранее ZIP-архив.
  1. В качестве точки входа укажите `index.handler`.
  1. В блоке с параметрами задайте:

      * сервисный аккаунт, созданный ранее;
      * сеть кластера {{ mpg-name }} или {{ mch-name }};
      * переменные окружения `DB_ENGINE`, `DB_HOST`, `DB_NAME` и `DB_AUTH` со значениями из предыдущих шагов. Для аутентификации по IAM-токену добавьте также переменную `DB_USER` со значением идентификатора сервисного аккаунта.

  1. Для аутентификации по паролю в блоке с секретами {{ lockbox-name }} добавьте две привязки для переменных `DB_USER` и `DB_PASSWORD` с ключами `username` и `password` из подготовленного секрета.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- {{ yandex-cloud }} CLI {#cli}

  1. Укажите имя функции в текущем каталоге:

      ```bash
      FUNCTION_NAME='private-db-example'
      ```

  1. Создайте функцию:

      ```bash
      yc serverless function create --name "$FUNCTION_NAME"
      ```

  1. Создайте версию функции. Команда загрузит архив, подключит функцию к сети кластера и применит выбранный способ аутентификации:

      ```bash
      yc serverless function version create --function-name "$FUNCTION_NAME" \
        --runtime python312 --entrypoint index.handler \
        --memory 256MB --execution-timeout 20s --source-path function.zip \
        --network-id "$NETWORK_ID" --service-account-id "$SA_ID" \
        --environment "DB_ENGINE=$DB_ENGINE,DB_HOST=$DB_HOST,DB_NAME=$DB_NAME" \
        "${AUTH_ARGS[@]}"
      ```

{% endlist %}

## Вызовите функцию {#invoke-function}

Для вызова функции у вашего аккаунта должна быть роль `{{ roles-functions-invoker }}` или другая роль, дающая право вызывать функции.

Вызовите функцию:

```bash
yc serverless function invoke --name "$FUNCTION_NAME" --data '{}'
```

Ожидаемый результат:

```json
{"statusCode":200,"headers":{"Content-Type":"application/json"},"body":"{\"result\": 1}"}
```

Значение `result: 1` означает, что функция подключилась к БД, прошла аутентификацию и получила результат SQL-запроса.

При ошибке подключения проверьте:

* [логи функции](../operations/function/function-logs.md);
* выбранную сеть;
* правило группы безопасности;
* настройки пользователя БД.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать платить за созданные ресурсы:

1. [Удалите функцию](../operations/function/function-delete.md).
1. [Удалите кластер {{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md) или [кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md), если он больше не нужен.
1. Если для аутентификации использовался пароль, [удалите секрет {{ lockbox-name }}](../../lockbox/operations/secret-delete.md).
1. [Удалите сервисный аккаунт](../../iam/operations/sa/delete.md), если он больше не нужен.

#### Полезные ссылки {#see-also}

* [Сетевое взаимодействие в {{ sf-name }}](../concepts/networking.md).
* [Подключение функции к сети](../operations/function/network-add.md).
* [Секреты {{ lockbox-name }} в функции](../operations/function/lockbox-secret-transmit.md).
* [IAM-токен сервисного аккаунта в функции](../operations/function-sa.md).
