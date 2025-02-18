# Настроить параметры сервиса метаданных функции

Настроить параметры сервиса метаданных вы можете при [создании версии функции](version-manage.md).

{% include [metadata-options](../../../_includes/functions/metadata-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [функция](../../concepts/function.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Выберите функцию.
  1. Перейдите на вкладку **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}**.
  1. Разверните блок **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-additional-parameters }}**.
  1. В блоке **Параметры сервиса метаданных** настройте параметры сервиса метаданных функции — `{{ ui-key.yacloud.serverless-functions.item.editor.label_gce_http_endpoint }}` и `{{ ui-key.yacloud.serverless-functions.item.editor.label_aws_v1_http_endpoint }}`.
  1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  Чтобы настроить параметры сервиса метаданных функции, выполните команду:

  ```bash
  yc serverless function version create \
    --function-id=<идентификатор_функции> \
    --runtime <среда_выполнения> \
    --entrypoint <точка_входа> \
    --source-version-id <идентификатор_версии> \
    --metadata-options <опция>=<enable_или_disabled>
  ```

  Где:

  * `--function-id` — идентификатор функции, новую версию которой вы хотите создать. Чтобы узнать идентификатор, [получите список функций](function-list.md) в каталоге.
  * `--runtime` — среда выполнения.
  * `--entrypoint` — точка входа, указывается в формате `<имя_файла_с_функцией>.<имя_обработчика>`.
  * `--source-version-id` — идентификатор версии функции, код которой вы хотите скопировать. Чтобы узнать идентификатор, [получите список версий функции](version-list.md).
  * `--metadata-options` — настройки параметров сервиса метаданных, например `aws-v1-http-endpoint=disabled`.

- {{ TF }} {#tf}

    {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../../_includes/terraform-install.md) %}

    Чтобы настроить параметры сервиса метаданных функции:

    1. Откройте файл конфигурации Terraform и добавьте к описанию функции блок `metadata_options`:
      
        ```hcl
        resource "yandex_function" "metadata_function" {
          name               = "<имя_функции>"
          user_hash          = "<хеш_функции>"
          runtime            = "<среда_выполнения>"
          entrypoint         = "<точка_входа>"
          memory             = "<объем_RAM>"
          execution_timeout  = "<максимальное_время_выполнения>"
          service_account_id = "<идентификатор_сервисного_аккаунта>"
          content {
            zip_filename = "<путь_к_ZIP-архиву>"
          }

          metadata_options {
            metadata_options.0.gce_http_endpoint = "0_или_1_или_2"
            metadata_options.0.aws_v1_http_endpoint = "0_или_1_или_2"
          }
        }
        ```

        Где:

        * `metadata_options` — настройки параметров сервиса метаданных, например `metadata_options.0.gce_http_endpoint = "1"`. Укажите:
            * `0` — если хотите оставить значение по молчанию.
            * `1` — чтобы включить параметр.
            * `2` — чтобы выключить параметр.

        Более подробную информацию о параметрах ресурса `yandex_function` см. в [документации провайдера]({{ tf-provider-resources-link }}/function).

   1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

   Проверить, что функция и ее настройки изменились, можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

   ```bash
   yc serverless function version get <идентификатор_версии_функции>
   ```

- API {#api}

  Чтобы настроить параметры сервиса метаданных функции, воспользуйтесь методом REST API [createVersion](../../functions/api-ref/Function/createVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/CreateVersion](../../functions/api-ref/grpc/Function/createVersion.md).

{% endlist %}
