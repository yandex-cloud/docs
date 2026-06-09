# Удалить триггер в Serverless Containers

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
    1. Перейдите в сервис **Serverless Containers**.
    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
    1. Выберите триггер, который хотите удалить.
    1. В правом верхнем углу страницы нажмите **Удалить**.
    1. В открывшемся окне нажмите кнопку **Удалить**.
    
- CLI {#cli}
  
    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
    
    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор триггера, [получите](trigger-list.md) список триггеров в каталоге.
    
    Удалите триггер:
    
    ```bash
    yc serverless trigger delete <имя_триггера>
    ```

    Результат:
    
    ```text
    id: a1s5msktijh2********
    folder_id: b1gmit33hgh2********
    created_at: "2022-10-24T15:19:15.353909857Z"
    name: timer-test
    rule:
      timer:
        cron_expression: 5 10 ? * * *
        invoke_container_with_retry:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
    status: PAUSED
    ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить триггер, созданный с помощью Terraform:

  1. Откройте файл конфигураций Terraform и удалите фрагмент с описанием ресурса `function_trigger`.

      Пример описания ресурса `function_trigger` в конфигурации Terraform:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "sc-timer"
        timer {
          cron_expression = "*/5 * ? * * *"
        }
        container {
          id                 = "bbaomb25tl68********"
          service_account_id = "ajej9vu5f62d********"
          retry_attempts     = 1
          retry_interval     = 15
        }
        dlq {
          queue_id           = "yrn:yc:ymq:ru-central1:b1geoelk7fld********:formycontainer"
          service_account_id = "ajej9vu5f62d********"
        }
      }
      ```

  1. Удалите ресурсы:

      1. В терминале перейдите в директорию с конфигурационным файлом.
      1. Проверьте корректность конфигурации с помощью команды:
      
         ```bash
         terraform validate
         ```
      
         Если конфигурация является корректной, появится сообщение:
      
         ```bash
         Success! The configuration is valid.
         ```
      
      1. Выполните команду:
      
         ```bash
         terraform plan
         ```
      
         В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, Terraform на них укажет.
      1. Примените изменения конфигурации:
      
         ```bash
         terraform apply
         ```
      
      1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

      Проверить изменения можно в [консоли управления](https://console.yandex.cloud) или с помощью команд [CLI](../../cli/quickstart.md):

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  Чтобы удалить триггер, воспользуйтесь методом REST API [delete](../triggers/api-ref/Trigger/delete.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Delete](../triggers/api-ref/grpc/Trigger/delete.md).

{% endlist %}