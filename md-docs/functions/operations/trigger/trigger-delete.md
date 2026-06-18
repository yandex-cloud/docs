# Удалить триггер в Cloud Functions

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/gear-play.svg) **Триггеры**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.

- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор триггера, [получите](trigger-list.md) список триггеров в каталоге.
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
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
    status: PAUSED
    ```

- Terraform {#tf}

  Информацию о Terraform [читайте в документации](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../../terraform/index.md).

  Чтобы удалить триггер, созданный с помощью Terraform:

  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием триггера.
     
     Пример описания триггера в конфигурации Terraform:

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

  1. В командной строке перейдите в папку, где расположен файл конфигурации Terraform.

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.

  1. Примените изменения конфигурации:

     ```
     terraform apply
     ```

  1. Подтвердите изменения: введите в терминал слово `yes` и нажмите **Enter**.

     Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../../cli/quickstart.md):

     ```
     yc serverless trigger list
     ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../../triggers/api-ref/grpc/Trigger/delete.md).

{% endlist %}