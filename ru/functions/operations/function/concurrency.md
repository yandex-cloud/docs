---
title: Как задать количество вызовов, одновременно обрабатываемых одним экземпляром функции в {{ sf-full-name }}
description: Следуя данной инструкции, вы сможете задать количество вызовов, одновременно обрабатываемых одним экземпляром функции.
---

# Задать количество одновременных вызовов экземпляра функции

Количество вызовов, одновременно обрабатываемых одним экземпляром функции (`concurrency`), не может превышать [квоты](../../concepts/limits.md#functions-quotas). Параметр доступен не для всех сред выполнения. Подробнее в разделе [{#T}](../../concepts/function.md#concurrency).

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}** в разделе **{{ ui-key.yacloud.serverless-functions.item.editor.label_concurrency }}** активируйте переключатель **{{ ui-key.yacloud.serverless-functions.item.editor.field_concurrency-enable }}** и укажите количество одновременных вызовов экземпляра функции.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    Чтобы задать количество вызовов, одновременно обрабатываемых одним экземпляром функции, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=<имя_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --concurrency 2 \
      --execution-timeout 3s \
      --source-path <путь_к_ZIP-архиву>
    ```

    Где:

    * `--function-name` — имя функции, версию которой вы хотите создать.
    * `--runtime` — [среда выполнения](../../concepts/index.md) функции.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
    * `--concurrency` — максимальное количество вызовов, одновременно обрабатываемых одним экземпляром функции.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-path` — ZIP-архив с кодом функции и необходимыми зависимостями.

    Результат:

    ```bash
    done (1s)
    id: d4evvn8obisa********
    function_id: d4elpv8pft63********
    created_at: "2020-08-01T19:09:19.531Z"
    runtime: nodejs18
    entrypoint: index.handler
    resources:
    memory: "134217728"
    execution_timeout: 3s
    image_size: "4096"
    status: ACTIVE
    tags:
    - $latest
    log_options:
    folder_id: b1g681qpemb4********
    concurrency: "2"
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}  

    Чтобы задать количество вызовов, одновременно обрабатываемых одним экземпляром функции, укажите параметр `concurrency`:

    1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

       * `yandex_function` — описание создаваемой функции и ее исходный код.
         * `name` — имя функции.
         * `user_hash` — произвольная строка, определяющая версию функции. При изменениях функции необходимо менять и эту строку. Функция обновится при изменении этой строки.
         * `runtime` — [среда выполнения](../../concepts/runtime/index.md) функции.
         * `entrypoint` — точка входа, указывается в формате `<имя_файла_без_расширения>.<имя_обработчика>`.
         * `memory` — объем памяти в мегабайтах, отведенный для выполнения функции.
         * `concurrency` — [максимальное количество вызовов, одновременно обрабатываемых одним экземпляром функции](../../concepts/function.md#concurrency).
         * `execution_timeout` — максимальное время выполнения функции до таймаута.
         * `service_account_id` — идентификатор сервисного аккаунта, от имени которого будет запускаться функция.
         * `content` — исходный код функции.
           * `content.0.zip_filename` — имя ZIP-архива, содержащего исходный код функции.

        Пример структуры конфигурационного файла:

        ```hcl
        resource "yandex_function" "test-function" {
          name               = "<имя_функции>"
          user_hash          = "<хеш>"
          runtime            = "<среда_выполнения>"
          entrypoint         = "<точка_входа>"
          memory             = "128"
          concurrency        = "2"
          execution_timeout  = "10"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }
        }
        ```

        Подробнее о параметрах ресурса `yandex_function` в [документации провайдера]({{ tf-provider-resources-link }}/function).

    1. Проверьте конфигурацию командой:
        
       ```bash
       terraform validate
       ```

       Если конфигурация является корректной, появится сообщение:
        
       ```text
       Success! The configuration is valid.
       ```

    1. Выполните команду:

       ```bash
       terraform plan
       ```

       В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 

    1. Примените изменения конфигурации:

       ```bash
       terraform apply
       ```
    1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

    Проверить добавление параметра `concurrency` можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):
    
    ```bash
    yc serverless function version get <идентификатор_версии>
    ```

- API {#api}

    Чтобы задать количество вызовов, одновременно обрабатываемых одним экземпляром функции, создайте версию функции с помощью метода REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызова gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md). В тело запроса добавьте поле `concurrency`.


{% endlist %}

{% include [see-also-scaling](../../../_includes/functions/see-also-scaling.md) %}
