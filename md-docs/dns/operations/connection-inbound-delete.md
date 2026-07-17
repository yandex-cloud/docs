[Документация Yandex Cloud](../../index.md) > [Yandex Cloud DNS](../index.md) > [Пошаговые инструкции](index.md) > DNS-подключения > Удалить входящее DNS-подключение

# Удалить входящее DNS-подключение

Чтобы удалить [входящее DNS-подключение](../concepts/dns-connection.md#dns-inbound):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите на страницу каталога, в котором находится нужное входящее DNS-подключение.
  1. Перейдите в сервис **Cloud DNS**.
  1. На панели слева выберите ![nodes-down](../../_assets/console-icons/nodes-down.svg) **Входящие подключения**.
  1. В строке с нужным DNS-подключением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../_assets/console-icons/trash-bin.svg) **Удалить**.
  1. В открывшемся окне подтвердите удаление.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для удаления входящего DNS-подключения:

      ```bash
      yc dns inbound-endpoint delete --help
      ```   
  1. Получите список входящих DNS-подключений в каталоге по умолчанию:
     
     ```bash
     yc dns inbound-endpoint list
     ```
     
     Результат:
     
     ```text
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     |          ID          |         NAME         | DESCRIPTION |      NETWORK ID      |      ADDRESS ID      |           CREATED AT           | DELETION PROTECTION |
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     | dns2n8fakpev******** | new-inbound-endpoint |             | enpg0adn0uv6******** | e2l8n7uup1j3******** | seconds:1783270956             | true                |
     |                      |                      |             |                      |                      | nanos:37000000                 |                     |
     | dns6h5q0h2ic******** | inbound-endpoint     |             | enpcfncr6uld******** | fl8not0e596n******** | seconds:1783270908             | false               |
     |                      |                      |             |                      |                      | nanos:107000000                |                     |
     +----------------------+----------------------+-------------+----------------------+----------------------+--------------------------------+---------------------+
     ```
  1. Удалите входящее DNS-подключение, указав его имя или идентификатор:

      ```bash
      yc dns inbound-endpoint delete <имя_или_идентификатор_DNS-подключения>
      ```

      Подробнее о команде `yc dns inbound-endpoint delete` читайте в [справочнике CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/delete.md).

      {% note info %}

      Если для удаляемого входящего DNS-подключения активирована опция защиты от удаления, перед удалением отключите эту опцию. Подробнее читайте в инструкции [Изменить входящее DNS-подключение](connection-inbound-update.md).

      {% endnote %}

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробная информация о ресурсах провайдера в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Чтобы удалить входящее DNS-подключение, созданное с помощью Terraform, откройте файл конфигурации Terraform и удалите фрагмент с описанием нужного входящего DNS-подключения.

      {% cut "Пример описания входящего DNS-подключения в конфигурации Terraform" %}

      ```hcl
      ...
      resource "yandex_dns_inbound_endpoint" "dns_connection" {
        name        = "my-inbound-endpoint"
        description = "DNS Inbound Endpoint"

        network_id  = yandex_vpc_network.my_net.id
        address_id  = yandex_vpc_address.dns_address.id

        deletion_protection = false
      }
      ...
      ```

      {% endcut %}

  1. Примените изменения, чтобы удалить входящее DNS-подключение:

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

      Terraform удалит входящее DNS-подключение. Убедиться в удалении ресурса можно в [консоли управления](https://console.yandex.cloud) или с помощью команды [CLI](../../cli/cli-ref/dns/cli-ref/inbound-endpoint/list.md):

      ```bash
      yc dns inbound-endpoint list
      ```

- API {#api}

  Чтобы удалить входящее DNS-подключение, воспользуйтесь методом REST API [delete](../api-ref/DnsInboundEndpoint/delete.md) для ресурса [DnsInboundEndpoint](../api-ref/DnsInboundEndpoint/index.md) или вызовом gRPC API [DnsInboundEndpointService/Delete](../api-ref/grpc/DnsInboundEndpoint/delete.md).

{% endlist %}

#### Полезные ссылки {#see-also}

* [DNS-подключения](../concepts/dns-connection.md)
* [Разрешение облачных DNS-имен в корпоративной сети](../tutorials/dns-integration.md)