# Подключение к базе данных {{ ydb-name }}

Чтобы подключиться к базе данных [{{ ydb-full-name }}](../../../ydb/) из {{ ml-platform-name }}, понадобится сервисный аккаунт. {{ ydb-name }} поддерживает метод аутентификации `ServiceAccountCredentials`.

## Перед началом работы {#before-you-begin}

1. [Создайте](../../../ydb/security/) сервисный аккаунт с правами `ydb.viewer` для чтения или `ydb.editor` для чтения и записи.
1. [Укажите](../projects/update.md) сервисный аккаунт в настройках проекта {{ ml-platform-name }}.

### Создайте ключ {#create-key}

Для подключения к {{ ydb-name }} из проекта {{ ml-platform-name }} вам понадобится [IAM-токен](../../../iam/concepts/authorization/iam-token.md).

{% list tabs %}

- YC CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Выполните команду:

     ```bash
     yc iam key create --service-account-name <имя_сервисного_аккаунта> --output key.json
     ```

     Где `<имя_сервисного_аккаунта>` — имя сервисного аккаунта, который вы указали в настройках проекта.

{% endlist %}

Сохраните полученный токен в файл `key.json`.

## Подключитесь к базе данных {{ ydb-short-name }} {#connect-to-ydb}

1. {% include [before-begin](../../../_includes/datasphere/ui-before-begin.md) %}

1. В проекте на панели слева нажмите кнопку ![upload](../../../_assets/datasphere/jupyterlab/upload.svg) **Upload file**. В открывшемся окне выберите файл `key.json`.

1. Установите библиотеки для работы с {{ ydb-name }}. Для этого введите в ячейке ноутбука команду:

    ```python
    %pip install ydb
    %pip install ydb[yc]
    ```

1. Перезагрузите ядро: на верхней панели в окне проекта нажмите **Kernel** → **Restart kernel**.

1. Установите подключение с БД. Для этого введите в ячейке ноутбука команду:

    ```python
    import os
    import ydb
    import ydb.iam

    # Create driver in global space.
    driver = ydb.Driver(
        endpoint='<эндпоинт>',
        database='<размещение_базы_данных>',
        credentials=ydb.iam.ServiceAccountCredentials.from_file('key.json'),
    )

    # Wait for the driver to become active for requests.
    driver.wait(fail_fast=True, timeout=5)

    # Create the session pool instance to manage YDB sessions.
    pool = ydb.SessionPool(driver)
   
    def execute_query(session):
        # Create the transaction and execute query.
        return session.transaction().execute(
            'SELECT * FROM <имя_таблицы>;',
            commit_tx=True,
            settings=ydb.BaseRequestSettings().with_timeout(3).with_operation_timeout(2)
        )

    def handler():
        # Execute query with the retry_operation helper.
        result = pool.retry_operation_sync(execute_query)
        return {
            'statusCode': 200,
            'body': str(result[0].rows[0]),
        }

    handler()
    ```

1. Настройте переменные окружения:
    * `<эндпоинт>` — первая часть значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть до вхождения `/?database=`). Например, `{{ ydb.ep-serverless }}`.
    * `<размещение_базы_данных>` — вторая часть значения поля **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** (часть после вхождения `/?database=`). Например, `/{{ region-id }}/r1gra875baom********/g5n22e7ejfr1********`.
    * `<имя_таблицы>` — название таблицы.

1. Запустите ячейку.
