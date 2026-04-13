# Создание функции на .NET Core

Создайте и выполните [функцию](../../concepts/function.md) на .NET Core, которая приветствует пользователя.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции — `dotnet-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=dotnet-function
    ```

    Результат:

    ```text
    id: b09bhaokchn9********
    folder_id: aoek49ghmknn********
    created_at: "2019-06-14T10:03:37.475Z"
    name: dotnet-function
    log_group_id: eolm8aoq9vcp********
    http_invoke_url: https://{{ sf-url }}/b09bhaokchn9********
    status: ACTIVE
    ```

- API {#api}

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Создайте первую версию функции {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `Handler.cs`:

    ```csharp
    using System;
    using System.Collections.Generic;

    namespace Function;

    public class Request
    {
        public Dictionary<string, string> queryStringParameters { get; set; }
    }

    public class Response
    {
        public Response(int statusCode, Dictionary<string, string> headers, bool isBase64Encoded, string body)
        {
            StatusCode = statusCode;
            Headers = headers;
            IsBase64Encoded = isBase64Encoded;
            Body = body;
        }

        public int StatusCode { get; set; }
        public Dictionary<string, string> Headers { get; set; }
        public bool IsBase64Encoded { get; set; }
        public string Body { get; set; }
    }

    public class Handler
    {
        public Response FunctionHandler(Request request)
        {
            var headers = new Dictionary<string, string>();
            headers.Add("Content-Type", "text/plain");

            string name = request.queryStringParameters["name"];
            return new Response(200, headers, false, string.Format("Hello, {0}!", name));
        }
    }
    ```

1. Добавьте файл `Handler.cs` в ZIP-архив `hello-dotnet.zip`.

    {% include [macos-zip-error](../../../_includes/functions/macos-zip-error.md) %}

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. [Перейдите](../../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию `dotnet-function`.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения `.NET 8.0`.
    1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Задайте параметры версии:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** — `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** — прикрепите файл `hello-dotnet.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `Function.Handler`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}** — `3`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}** — `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
        * **{{ ui-key.yacloud.forms.label_service-account-select }}** — `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=dotnet-function \
      --runtime dotnet8.0 \
      --entrypoint Function.Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-dotnet.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.

    Результат:

    ```text
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: dotnet8.0
    entrypoint: Function.Handler
    resources:
        memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```

- API {#api}

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

{% include [function-invoke](../../../_includes/functions/function-invoke-with-param.md) %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}
