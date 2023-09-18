# Изменить описание триггера в {{ sf-name }}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится триггер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../../_assets/functions/triggers.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
    1. Выберите триггер, описание которого хотите изменить.
    1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud.common.edit }}**.
    1. Измените описание и нажмите кнопку **{{ ui-key.yacloud.serverless-functions.triggers.form.button_update-trigger }}**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить описание триггера, выполните команду:

    ```bash
    yc serverless trigger update <имя триггера> --description "<описание триггера>"
    ```

    Результат:

    ```text
    id: a1s9q2li6t**********
    folder_id: b1g9hv2loa**********
    created_at: "2023-08-01T12:36:14.321Z"
    name: my-trigger
    description: Trigger for uploaded objects
    rule:
      object_storage:
        event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        bucket_id: **********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: d4e5muirrt**********
          function_tag: $latest
          service_account_id: ajek0fou8e**********
    status: ACTIVE
    ```

- {{ TF }}

  Информацию о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Чтобы изменить описание триггера:

  1. Откройте файл конфигурации {{ TF }} и измените поле `description` в описании триггера:

     ```hcl
     ...
     resource "yandex_function_trigger" "my_trigger" {
       name        = "some_name"
       description = "any description"
       timer {
         cron_expression = "* * * * ? *"
       }
       function {
         id = "tf-test"
       }
     }
     ...
     ```

     Более подробную информацию о параметрах ресурса `yandex_function_trigger` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/function_trigger).

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

     Проверить изменение триггера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc serverless trigger get <идентификатор триггера>
     ```

- API

  Чтобы изменить описание триггера, воспользуйтесь методом REST API [update](../../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}