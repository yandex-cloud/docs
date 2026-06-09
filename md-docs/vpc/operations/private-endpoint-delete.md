# Удалить сервисное подключение

{% note warning %}

Функциональность **Сервисные подключения** (VPC Private Endpoints) находится на стадии [Preview](../../overview/concepts/launch-stages.md).

{% endnote %}



{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды CLI для удаления [сервисного подключения](../concepts/private-endpoint.md) (Private Endpoint):

      ```bash
      yc vpc private-endpoint delete --help
      ```

  1. Получите список всех сервисных подключений:

     ```bash
     yc vpc private-endpoint list
     ```

     Результат:
     
     ```text
     +----------------------+-------------+--------------------------------+
     |          ID          |    NAME     |          DESCRIPTION           |
     +----------------------+-------------+--------------------------------+
     | enpd7rq************* | s3-vpc-link | Private Endpoint to the Object |
     |                      |             | Storage                        |
     +----------------------+-------------+--------------------------------+
     ``` 

  1. Выберите идентификатор (`ID`) или имя (`NAME`) нужного сервисного подключения.
  1. Удалите сервисное подключение:

     ```bash
     yc vpc private-endpoint delete <идентификатор_подключения>
     ```


- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить [сервисное подключение](../concepts/private-endpoint.md), созданное с помощью {{ TF }}:
  1. Откройте файл конфигураций {{ TF }} и удалите фрагмент с описанием ресурса `yandex_vpc_private_endpoint`:

     ```hcl
     resource "yandex_vpc_private_endpoint" "vpc-endpoint" {
       name        = "<имя_сервисного_подключения>"
       description = "<описание_сервисного_подключения>"
       network_id  = "<идентификатор_облачной_сети>"
       
       # Сервисное подключение к Object Storage
       object_storage {}

       # Создание дополнительных ресурсных DNS-записей 
       dns_options {
         private_dns_records_enabled = <true_или_false>
       }

       endpoint_address {
         subnet_id = "<идентификатор_подсети>"
       }
     }
     ```

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
  
     В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
  1. Примените изменения конфигурации:
  
     ```bash
     terraform apply
     ```
  
  1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

  Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

  ```bash
  yc vpc private-endpoint list
  ```

- API {#api}

  Чтобы удалить [сервисное подключение](../concepts/private-endpoint.md), воспользуйтесь методом REST API [delete](../privatelink/api-ref/PrivateEndpoint/delete.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Delete](../privatelink/api-ref/grpc/PrivateEndpoint/delete.md).



{% endlist %}