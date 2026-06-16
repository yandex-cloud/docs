# Получить информацию о зоне DNS

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [зона DNS](../concepts/dns-zone.md).
  1. Перейдите в сервис **Cloud DNS**.
  1. На панели слева выберите ![image](../../_assets/console-icons/compass.svg) **Зоны**.
  1. Выберите нужную зону DNS.
  1. Перейдите на вкладку **Обзор**
  1. На странице **Обзор** отобразится подробная информация о зоне DNS.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы узнать имя или уникальный идентификатор [зоны DNS](../concepts/dns-zone.md), [получите](zone-list.md) список зон в каталоге.

  1. Посмотрите описание команды CLI для получения информации о зоне DNS:

      ```bash
      yc dns zone get --help
      ```

  1. Получите информацию о зоне DNS, указав ее имя или идентификатор:

      ```bash
      yc dns zone get <имя_зоны_DNS>
      ```

      Результат:

      ```text
      id: dns6oh57qm9n********
      folder_id: f01derqpemb4********
      created_at: "2023-11-02T08:34:58.493Z"
      name: example.com.
      zone: example-zone-name
      public_visibility: {}
      ```

- Terraform {#tf}

  [Terraform](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в Yandex Cloud и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций Terraform автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  Terraform распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер Yandex Cloud для Terraform](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [Terraform](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале](../../terraform/index.md).

  Если у вас еще нет Terraform, [установите его и настройте провайдер Yandex Cloud](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью Terraform от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию о [зоне DNS](../concepts/dns-zone.md) с помощью Terraform:
  1. Добавьте в конфигурационный файл Terraform блоки `data` и `output`:

     ```hcl
     data "yandex_dns_zone" "my_zone" {
       dns_zone_id = "<идентификатор_зоны_DNS>"
     }

     output "public" {
       value = data.yandex_dns_zone.my_zone.public
     }
     ```

     Где:
     * `data "yandex_dns_zone"` — описание зоны DNS в качестве источника данных:
       * `dns_zone_id` — идентификатор зоны DNS.
     * `output "zone"` — выходная переменная, которая содержит информацию о типе зоне DNS:
       * `value` — возвращаемое значение.

     Вместо `public` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_dns_zone` в [документации провайдера](../../terraform/data-sources/dns_zone.md).
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
     public = false
     ```

- API {#api}

  Чтобы получить подробную информацию о [зоне DNS](../concepts/dns-zone.md), воспользуйтесь методом REST API [get](../api-ref/DnsZone/get.md) для ресурса [DnsZone](../api-ref/DnsZone/index.md), или вызовом gRPC API [DnsZoneService/Get](../api-ref/grpc/DnsZone/get.md).

{% endlist %}