---
title: "Как создать версию функции"
description: "Следуя данной инструкции, вы сможете создать версию функции."
---

# Создать версию функции

{% include [create-version](../../../_includes/functions/create-version.md) %}

## Подготовить ZIP-архив с кодом функции {#zip-archive}

{% include [create-js-zip](../../../_includes/functions/create-js-zip.md) %}

## Создать версию функции {#version-create}

При создании версии необходимо задать следующие параметры:

* _{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}_ — предоставляет дополнительные библиотеки и переменные окружения, к которым можно получить доступ из кода функции. Соответствует языку программирования, на котором написана ваша функция. Подробнее см. в разделе [Среда выполнения](../../concepts/runtime/index.md).
* _{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}_ — функция, которая будет вызываться в качестве обработчика. Подробнее об обработчике читайте в разделе [Модель программирования](../../concepts/function.md#programming-model).
* _{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}_ — максимальное время выполнения функции, после которого сервис прервет выполнение, не дожидаясь ответа. Включает в себя время начальной инициализации при первом запуске.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию, версию которой хотите создать.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-latest-version }}** нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.overview.button_editor-create }}**.
    1. Выберите [среду выполнения](../../concepts/runtime/index.md). Отключите опцию **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
    1. Подготовьте код функции:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_runtime }}**: `nodejs18`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}**: `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_file }}**: `hello-js.zip`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}**: `index.handler`.
    1. Задайте параметры версии:
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5`.
       * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`.
       * [**{{ ui-key.yacloud.forms.label_service-account-select }}**](../../../iam/concepts/users/service-accounts.md): `{{ ui-key.yacloud.component.service-account-select.label_no-service-account }}`.
       * [**{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**](../../concepts/runtime/environment-variables.md): `{{ ui-key.yacloud.common.not-selected }}`.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы создать версию функции, выполните команду:

    
    ```
    yc serverless function version create \
      --function-name=my-nodejs-function \
      --runtime nodejs18 \
      --entrypoint index.handler \
      --memory 128m \
      --execution-timeout 5s \
      --source-path ./hello-js.zip
    ```
  

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив c кодом функции и необходимыми зависимостями.

    Результат:

    
    ```
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs18
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 5s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_group_id: ckg3qh8h363p********
    ```
  

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    Чтобы создать новую версию функции:

    1. Откройте файл конфигурации {{ TF }} и измените параметры функции:
      
       * `yandex_function` — описание создаваемой функции и ее исходный код.
         * `name` — имя функции.
         * `description` — текстовое описание функции.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
         * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
         * `entrypoint` — имя функции в исходном коде, которая будет служить точкой входа в приложения.
         * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
         * `execution_timeout` — таймаут выполнения функции.
         * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
         * `content` — исходный код функции.
           * `content.0.zip_filename` — имя ZIP-архива, содержащего исходный код функции.

        Пример структуры конфигурационного файла:

        ```
        resource "yandex_function" "test-function" {
            name               = "test-function"
            description        = "Test function"
            user_hash          = "first-function"
            runtime            = "python311"
            entrypoint         = "main"
            memory             = "128"
            execution_timeout  = "10"
            service_account_id = "<идентификатор_сервисного_аккаунта>"
            content {
                zip_filename = "<путь_к_ZIP-архиву>"
            }
        }
        ```

       {% note info %}
    
       При изменении имени или описания функции версия создана не будет.

       {% endnote %}

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

    1. Проверьте конфигурацию командой:
        
       ```
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```
       terraform plan
       ```
        
       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
         
    1. Примените изменения конфигурации:

       ```
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.
      
    Проверить появление версии можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

    ```
    yc serverless function version list --function-name <имя_функции>
    ```

- API {#api}

    Чтобы создать версию функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

    **Пример запроса**

    Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se) и [аутентифицируйтесь](../../api-ref/functions/authentication.md) в API.

    1. [Загрузите](../../../storage/operations/objects/upload.md) в бакет {{ objstorage-name }} ZIP-архив с кодом версии функции `hello-js.zip`.
    1. Подготовьте файл `body.json` с телом запроса:

        ```json
        {
          "functionId": "<идентификатор_функции>",
          "runtime": "nodejs18",
          "entrypoint": "index.handler",
          "resources": {
            "memory": "134217728"
          },
          "executionTimeout": "5s",
          "serviceAccountId": "<идентификатор_сервисного_аккаунта>",
          "package": {
            "bucketName": "<имя_бакета>",
            "objectName": "hello-js.zip"
          },
        }
        ```

        Где:
        * `functionId` — идентификатор функции, версию которой вы хотите создать.
        * `runtime` — [среда выполнения](../../concepts/runtime/index.md#runtimes).
        * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
        * `memory` — объем RAM.
        * `executionTimeout` — максимальное время выполнения функции до таймаута.
        * `serviceAccountId` — идентификатор сервисного аккаунта, которому назначена [роль](../../../storage/security/index.md#service-roles), разрешающая чтение данных в бакете.
        * `bucketName` — имя бакета, в который вы загрузили ZIP-архив c кодом функции и необходимыми зависимостями.
        * `objectName` — [ключ объекта](../../../storage/concepts/object.md#key) с кодом функции в бакете.

    1. Выполните запрос:

        ```bash
        export IAM_TOKEN=<IAM-токен>
        curl -X POST \
            -H "Authorization: Bearer ${IAM_TOKEN}" \
            -d "@<путь_к_файлу_body.json>" \
            https://serverless-functions.{{ api-host }}/functions/v1/versions
        ```
        
        Результат:
        
        ```json
        {
         "done": false,
         "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.serverless.functions.v1.CreateFunctionVersionMetadata",
          "functionVersionId": "d4e25m0gila4********"
         },
         "id": "d4edk0oobcc9********",
         "description": "Create function version",
         "createdAt": "2023-10-11T11:22:21.286786431Z",
         "createdBy": "ajeol2afu1js********",
         "modifiedAt": "2023-10-11T11:22:21.286786431Z"
        }
        ```


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    Создать версию функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}

{% note info %}

Для сохранения целостности связей изменение и удаление версий функции не предусмотрено. Подробнее о взаимосвязи ресурсов читайте в разделе [{#T}](../../concepts/function.md).

{% endnote %}
