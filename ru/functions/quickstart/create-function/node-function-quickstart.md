# Создание функции на Node.js

Создайте и выполните [функцию](../../concepts/function.md) на Node.js, которая приветствует пользователя.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Создайте функцию {#create-func}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции — `nodejs-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```
    yc serverless function create --name=nodejs-function
    ```

    Результат:

    ```
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2023-08-16T19:01:37.475Z"
    name: nodejs-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).


- {{ yandex-cloud }} Toolkit

    Создать функцию можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


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
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию `nodejs-function`.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения `nodejs16` и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Задайте параметры версии:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** — `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** — прикрепите файл `hello-js.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `hello.handler`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

      
    ```
    yc serverless function version create \
      --function-name=nodejs-function \
      --runtime nodejs16 \
      --entrypoint hello.handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-js.zip
    ```
  

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя файла с функцией>.<имя обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.

    Результат:

    
    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2023-08-16T19:09:19.531Z"
    runtime: nodejs16
    entrypoint: hello.handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```
  

- API

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).


- {{ yandex-cloud }} Toolkit

    Создать версию функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}