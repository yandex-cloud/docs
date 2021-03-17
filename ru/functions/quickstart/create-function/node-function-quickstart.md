# Создание функции на Node.js

Создайте и выполните [функцию](../../concepts/function.md) на Node.js, которая приветствует пользователя.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Создайте функцию {#create-func}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Откройте сервис **{{ sf-name }}**
    1. Нажмите кнопку **Создать функцию**.
    1. Введите имя функции — `nodejs-function`.
    1. Нажмите кнопку **Создать**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```
    yc serverless function create --name=nodejs-function
    ```

    Результат:

    ```
    id: b09bhaokchn9pnbrlseb
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-06-14T10:03:37.475Z"
    name: nodejs-function
    log_group_id: eolm8aoq9vcppsieej6h
    http_invoke_url: https://functions.yandexcloud.net/b09bhaokchn9pnbrlseb
    status: ACTIVE
    ```

- API

    Создать версию функции можно с помощью метода API [create](../../functions/api-ref/Function/create.md).

{% endlist %}

## Создайте первую версию функции {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Подготовьте ZIP-архив с кодом функции {#create-js-zip}

1. Сохраните следующий код в файл с названием `hello.js`:
    ```js
    exports.handler = async function (event, context) {
        name = event.queryStringParameters.name
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/plain'
            },
            'isBase64Encoded': false,
            'body': `Hello, ${name}!`
        }
    };
    ```

1. Добавьте файл `hello.js` в ZIP-архив `hello-js.zip`.

### Создайте версию функции {#create-version}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ sf-name }}**.
    1. Выберите функцию `nodejs-function`.
    1. В разделе **Последняя версия** нажмите кнопку **Создать в редакторе**.
    1. Задайте параметры версии:
        - **Среда выполнения:** `nodejs12`.
        - **Способ:** ZIP-архив.
        - **Файл:** `hello-js.zip`.
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
    --function-name=nodejs-function \
    --runtime nodejs12 \
    --entrypoint hello.handler \
    --memory 128m \
    --execution-timeout 3s \
    --source-path ./hello-js.zip
    ```

    где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
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
    runtime: nodejs12
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