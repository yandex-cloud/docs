# Создание функции на Python

Создайте и выполните [функцию](../../concepts/function.md) на Python, которая приветствует пользователя.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Создайте функцию {#create-func}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Откройте сервис **{{ sf-name }}**
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `python-function`.
    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```
    yc serverless function create --name=python-function
    ```

    Результат:

    ```
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: python-function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    status: ACTIVE
    ```

- API

    Создать версию функции можно с помощью метода API [create](../../functions/api-ref/Function/create.md).

{% endlist %}

## Создайте первую версию функции {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `hello.py`:
    ```python
    def handler(event, context):
        name = event['queryStringParameters']['name']

        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': False,
            'body': 'Hello, {}!'.format(name)
        }
    ```
        
1. Добавьте файл `hello.py` в ZIP-архив `hello-py.zip`.

### Создайте версию функции {#create-version}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию `python-function`.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Задайте параметры версии:
        - **Среда выполнения:** `python37`.
        - **Способ:** ZIP-архив.
        - **Файл:** `hello-py.zip`.
        - **Точка входа:** `hello.handler`.
        - **Таймаут, секунды:** 3.
        - **Память:** 128 МБ.
        - **Сервисный аккаунт:** Не выбрано.
    1. Нажмите кнопку **Создать версию**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

    ```
    yc serverless function version create \
    --function-name=python-function \
    --runtime python37 \
    --entrypoint hello.handler \
    --memory 128m \
    --execution-timeout 3s \
    --source-path ./hello-py.zip
    ```

    где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполенения.
    * `--entrypoint` — точка входа, указывается в формате <имя файла с функцией>.<имя обработчика>.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

    Результат:

    ```
    done (1s)
    id: d4evvn8obisajd51plaq
    function_id: d4elpv8pft639ku7k0u6
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: python37
    entrypoint: hello.handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p40gmr9gn
    ```

- API

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).

{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}