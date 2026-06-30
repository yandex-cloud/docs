# Получить информацию о сервисном подключении



{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.
  
  1. Посмотрите описание команды CLI для получения информации о [сервисном подключении](../concepts/private-endpoint.md) (Private Endpoint):

      ```bash
      yc vpc private-endpoint get --help
      ```

  1. Получите информацию о сервисном подключении, указав его имя или идентификатор:

     ```bash
     yc vpc private-endpoint get <идентификатор_сервисного_подключения>
     ```

     Результат:
     ```text
     id: enpd7***************
     folder_id: b1g23***************
     created_at: "2024-08-31T16:23:33.859574Z"
     name: s3-vpc-link
     description: Private Endpoint to the Object Storage
     network_id: enpgi***************
     status: AVAILABLE
     address:
       subnet_id: e2l8b***************
       address: 10.128.0.10
       address_id: e2ldn***************
     dns_options: {}
     object_storage: {}
     ```

- Terraform

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [сервисном подключении](../concepts/private-endpoint.md) с помощью Terraform:

  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

      ```hcl
      data "yandex_vpc_private_endpoint" "my-vpc-data" {
        private_endpoint_id = "<идентификатор_сервисного_подключения>"
      }

      output "endpoint-info-network" {
        value = data.yandex_vpc_private_endpoint.my-vpc-info.network_id
      }
      ```

      Где:

      * `data "yandex_vpc_private_endpoint"` — описание сервисного подключения в качестве источника данных:
         * `resource_id` — идентификатор сервисного подключения.
      * `output "ref_description"` — выходная переменная, которая содержит идентификатор сети (`network_id`) с сервисным подключением:
         * `value` — возвращаемое значение.

     Вместо `network_id` вы можете выбрать любой другой параметр для получения информации. Подробнее о параметрах источника данных `yandex_vpc_private_endpoint` в [документации провайдера](../../terraform/data-sources/vpc_private_endpoint.md).

  1. Создайте ресурсы:

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

      Terraform создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      endpoint-info-network = "enpt232s2lp6********"
      ```

- API {#api}

  Чтобы получить информацию о [сервисном подключении](../concepts/private-endpoint.md), воспользуйтесь методом REST API [get](../privatelink/api-ref/PrivateEndpoint/get.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Get](../privatelink/api-ref/grpc/PrivateEndpoint/get.md).

{% endlist %}