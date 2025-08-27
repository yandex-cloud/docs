# Создание функции на Kotlin

Создайте и выполните [функцию](../../concepts/function.md) на Kotlin, которая приветствует пользователя.

{% include [function-before-begin](../../../_includes/functions/function-before-begin.md) %}

## Создайте функцию {#create-func}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать функцию.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
    1. Введите имя функции — `kotlin-function`.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать функцию, выполните команду:

    ```bash
    yc serverless function create --name=kotlin-function
    ```

    Результат:

    ```text
    id: d4eek526ai42********
    folder_id: b1gt6g8ht345********
    created_at: "2024-12-19T20:02:56.039Z"
    name: kotlin-function
    http_invoke_url: https://{{ sf-url }}/d4eek526ai42********
    status: ACTIVE
    ```

- API {#api}

    Создать функцию можно с помощью метода API [create](../../functions/api-ref/Function/create.md).


{% endlist %}

## Создайте первую версию функции {#create-first-version}

{% include [create-version](../../../_includes/functions/create-version.md) %}

### Подготовьте ZIP-архив с кодом функции {#create-zip}

1. Сохраните следующий код в файл с названием `Handler.kt`:

    ```kotlin
    data class Request(
        val httpMethod: String?,
        val headers: Map<String, String> = mapOf(),
        val body: String = ""
    )

    data class Response(
        val statusCode: Int,
        val body: String
    )

    fun handle(request: Request): Response {
        return Response(200, "Hello World!")
    }
    ```

1. Добавьте файл `Handler.kt` в ZIP-архив `hello-kotlin.zip`.

### Создайте версию функции {#create-version}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию `kotlin-function`.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите среду выполнения `{{ kotlin-full-ver }}`.
    1. Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}** и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Задайте параметры версии:
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** — `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}** — прикрепите файл `hello-kotlin.zip`.
        * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** — `Handler`.
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
      --function-name=kotlin-function \
      --runtime {{ kotlin-cli-ver }} \
      --entrypoint Handler \
      --memory 128m \
      --execution-timeout 3s \
      --source-path ./hello-kotlin.zip
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

    Результат:

    ```text
    done (10s)
    id: d4ektme8jo2d********
    function_id: d4e9arrf01oh********
    created_at: "2024-12-19T20:22:15.942Z"
    runtime: {{ kotlin-cli-ver }}
    entrypoint: Handler
    resources:
      memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
      - $latest
    log_options:
      folder_id: b1gt6g8ht345********
    concurrency: "1"
    ```

- API {#api}

    Создать версию функции можно с помощью метода API [createVersion](../../functions/api-ref/Function/createVersion.md).


{% endlist %}

## Вызовите функцию {#invoke}

{% note info %}

Чтобы любой пользователь мог вызывать функцию, необходимо [сделать ее публичной](../../operations/function/function-public.md). Подробнее о правах читайте в разделе [{#T}](../../security/index.md).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку ![CirclePlay](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_tag }}** выберите `$latest`, чтобы вызвать последнюю версию функции.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload-template }}** выберите `{{ ui-key.yacloud.serverless-functions.item.testing.value_empty }}`.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** введите:

       ```
       {}
       ```
    1. Нажмите кнопку ![PlayFill](../../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.testing.label_title-test-result }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_execution-result }}**, будет показан статус тестирования. **Важно**: максимальное время выполнения функции до [таймаута](../../operations/function/version-manage.md) (включая начальную инициализацию при первом запуске) — 10 минут.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.testing.field_function-output }}** появится результат выполнения функции:

       ```
       {
           "statusCode": 200,
           "body": "Hello World!"
       }
       ```

- CLI {#cli}

    Чтобы вызвать функцию, выполните команду:

    ```
    yc serverless function invoke <идентификатор_функции> -d '{}'
    ```

    Результат:

    ```
    {"statusCode":200,"body":"Hello World!"}
    ```

    По умолчанию вызывается версия функции с тегом `$latest`.

- HTTPS {#https}

    Ссылку для вызова функции можно найти на вкладке **{{ ui-key.yacloud.common.overview }}**, в поле **{{ ui-key.yacloud.serverless-functions.item.overview.label_invoke-link }}**.

    Для обеспечения безопасности функцию можно вызвать только по протоколу HTTPS. Вызовите ее как обычный HTTPS-запрос, вставив ссылку в адресную строку браузера и добавив в URL параметр `name`:

    ```
    https://{{ sf-url }}/<идентификатор_функции>
    ```

    На странице появится ответ:

    ```
    Hello World!
    ```


{% endlist %}

{% include [function-what-is-next](../../../_includes/functions/function-what-is-next.md) %}