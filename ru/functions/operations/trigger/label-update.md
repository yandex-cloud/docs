---
title: "Изменить метку триггера в {{ sf-name }}"
description: "Следуя данной инструкции, вы сможете изменить метку триггера в {{ sf-name }}."
---

# Изменить метку триггера в {{ sf-name }}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    Чтобы изменить метку триггера, выполните команду:

    {% note warning %}

    Существующий набор `labels` полностью перезаписывается набором, переданным в запросе.

    {% endnote %}

    ```bash
    yc serverless trigger update <имя_триггера> --labels <ключ>=<значение>
    ```

    Результат:

   ```text
   id: a1s9q2li6t**********
   folder_id: b1g9hv2loa**********
   created_at: "2023-08-01T12:36:14.321Z"
   name: my-trigger
   description: Trigger for uploaded objects
   labels
     new_label: my-beta-trigger
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

- {{ TF }} {#tf}

  Информацию о {{ TF }} [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  Чтобы изменить метку триггера:

  1. Откройте файл конфигурации {{ TF }} и измените блок `labels` в описании триггера:

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
     yc serverless trigger get <идентификатор_триггера>
     ```

- API {#api}

  Чтобы изменить метку триггера, воспользуйтесь методом REST API [update](../../triggers/api-ref/Trigger/update.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Update](../../triggers/api-ref/grpc/trigger_service.md#Update).

{% endlist %}