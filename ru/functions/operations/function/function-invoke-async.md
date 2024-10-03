---
title: Вызвать функцию асинхронно
description: Следуя данной инструкции, вы сможете настроить и выполнить асинхронный вызов функции.
---

# Вызвать функцию асинхронно

{% include [note-preview](../../../_includes/note-preview.md) %}

## Настройте асинхронный вызов {#async}

{% list tabs group=instructions %}

- Консоль управления {#console}
    
    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. Выберите функцию.
    1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
    1. В блоке **{{ ui-key.yacloud.serverless-functions.item.editor.label_async }}** активируйте переключатель **{{ ui-key.yacloud.serverless-functions.item.editor.label_turn-on-button }}**.
    1. В поле **{{ ui-key.yacloud.serverless-functions.item.editor.label_tries-count }}** укажите количество повторных вызовов функции, которые будут сделаны, прежде чем вызов будет считаться неуспешным.
    1. В поле **{{ ui-key.yacloud.forms.label_service-account-select }}** укажите сервисный аккаунт, у которого есть права на вызов функции.
    1. Укажите в полях **{{ ui-key.yacloud.serverless-functions.item.editor.label_success-sa }}** и **{{ ui-key.yacloud.serverless-functions.item.editor.label_failed-sa }}**, куда отправлять сообщения об успешном и неуспешном вызовах функции соответственно:
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-unset }}` — не отправлять сообщения.
        * `{{ ui-key.yacloud.serverless-functions.item.editor.option_queues-mq }}` — отправлять сообщения в очередь {{ message-queue-name }}:
            * **{{ ui-key.yacloud.serverless-functions.item.editor.label_mq }}** — очередь {{ message-queue-name }}, в которую нужно отправлять сообщения.
            * **{{ ui-key.yacloud.forms.label_service-account-select }}** — сервисный аккаунт, у которого есть права на запись в очередь.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы настроить асинхронный вызов, выполните команду:

    ```bash
    yc serverless function version create \
      --function-name=<имя_функции> \
      --runtime <среда_выполнения> \
      --entrypoint <точка_входа> \
      --memory <объем_RAM> \
      --execution-timeout <максимальное_время_выполнения> \
      --source-version-id <идентификатор_версии> \
      --async-max-retries <количество_повторных_вызовов> \
      --async-service-account-id <идентификатор_сервисного_аккаунта> \
      --async-success-ymq-arn <очередь_сообщений> \
      --async-success-sa-id <идентификатор_сервисного_аккаунта> \
      --async-failure-ymq-arn <очередь_сообщений> \
      --async-failure-sa-id <идентификатор_сервисного_аккаунта>
    ```

    Где:

    * `--function-name` — имя функции.
    * `--runtime` — среда выполнения.
    * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
    * `--memory` — объем RAM.
    * `--execution-timeout` — максимальное время выполнения функции до таймаута.
    * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать.
    * `--async-max-retries` — количество повторных вызовов функции, которые будут сделаны, прежде чем вызов будет считаться неуспешным.
    * `--async-service-account-id` — идентификатор сервисного аккаунта, у которого есть права на вызов функции.
    * `--async-success-ymq-arn` — ARN очереди {{ message-queue-name }}, в которую нужно отправлять сообщения об успешных вызовах функции. Если параметр не указан, сообщения не отправляются.
    * `--async-success-sa-id` — идентификатор сервисного аккаунта с правами на запись в очередь `async-success-ymq-arn`.
    * `--async-failure-ymq-arn` — ARN очереди {{ message-queue-name }}, в которую нужно отправлять сообщения о неуспешных вызовах функции. Если параметр не указан, сообщения не отправляются.
    * `--async-failure-sa-id` — идентификатор сервисного аккаунта с правами на запись в очередь `async-failure-ymq-arn`.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы настроить асинхронный вызов:

  1. Откройте файл конфигурации {{ TF }} и добавьте к описанию функции блок `async_invocation`:

     ```hcl
     resource "yandex_function" "test-function" {
       name               = "<имя_функции>"
       user_hash          = "<хеш_функции>"
       runtime            = "<среда_выполнения>"
       entrypoint         = "<точка_входа>"
       memory             = "<объем_RAM>"
       execution_timeout  = "<максимальное время выполнения>"
       service_account_id = "<идентификатор_сервисного_аккаунта>"

       async_invocation {
         retries_count       = "<количество_повторных_вызовов>"
         service_account_id  = "<идентификатор_сервисного_аккаунта>"
         ymq_failure_target {
           service_account_id = "<идентификатор_сервисного_аккаунта>"
           arn                = "<очередь_сообщений>"
         }
         ymq_success_target {
           service_account_id = "идентификатор_сервисного_аккаунта"
           arn                = "<очередь_сообщений>"
         }
       }
     }
     ```

     Где:
     
     * `async_invocation` — параметры асинхронного вызова:
       * `retries_count` — количество повторных вызовов функции, которые будут сделаны, прежде чем вызов будет считаться неуспешным.
       * `service_account_id` — сервисный аккаунт, у которого есть права на вызов функции.
       * `ymq_failure_target` — параметры очереди для неуспешного вызова:
         * `service_account_id` — сервисный аккаунт с правами на запись в очередь для неуспешного асинхронного вызова.
         * `arn` — ARN очереди {{ message-queue-name }}, в которую нужно отправлять сообщения о неуспешных вызовах функции. Если параметр не указан, сообщения не отправляются.
       * `ymq_success_target` — параметры очереди для успешного вызова:
         * `service_account_id` — сервисный аккаунт с правами на запись в очередь для успешного асинхронного вызова.
         * `arn` — ARN очереди {{ message-queue-name }}, в которую нужно отправлять сообщения об успешных вызовах функции. Если параметр не указан, сообщения не отправляются.

     Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  Проверить изменение функции и ее настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

  ```bash
  yc serverless function version get <идентификатор_версии_функции>
  ```

- API {#api}

    Чтобы настроить асинхронный вызов, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/function_service.md#CreateVersion).

{% endlist %}

## Вызовите функцию {#invoke}

[Вызовите функцию](function-invoke.md) по HTTPS, указав параметр строки запроса `?integration=async`.

## См. также {#see-also}

* [Асинхронный вызов функции](../../concepts/function-invoke-async.md)
