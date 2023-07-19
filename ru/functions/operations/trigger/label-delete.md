# Удалить метку триггера в {{ sf-name }}

{% list tabs %}

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы удалить метку триггера, выполните команду:

    ```bash
    yc serverless trigger remove-labels <имя триггера> --labels <ключ>
    ```

    Результат:

    ```text
    id: dd0gj5tsj2**********
    folder_id: aoek49ghmk**********
    created_at: "2019-08-28T12:26:25.675Z"
    name: my-trigger
    description: My YMQ trigger.
    rule:
      message_queue:
        queue_id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:my-mq
        service_account_id: bfbqqeo6jk**********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: b09e5lu91t**********
          function_tag: $latest
          service_account_id: bfbqqeo6jk**********
    status: ACTIVE
    ```

- {{ TF }}

  Информацию о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

  Чтобы удалить метку триггера:

  1. Откройте файл конфигурации {{ TF }} и в блоке `labels` удалите ненужную метку:

     ```hcl
     ...
     resource "yandex_function_trigger" "my_trigger" {
       name   = "some_name"
	   labels = {
         tf-label    = "tf-label-value"
         empty-label = ""
       }
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

     Проверить изменение триггера можно с помощью команды [CLI](../../../cli/quickstart.md):

     ```
     yc serverless trigger get <идентификатор триггера>
     ```

- API

  Чтобы удалить метку триггера, воспользуйтесь методом REST API [update](../../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}
