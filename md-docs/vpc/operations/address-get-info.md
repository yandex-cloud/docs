# Получить информацию об IP-адресе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [адрес](../concepts/address.md).
  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
  1. На открывшейся странице отобразится подробная информация о всех доступных адресах.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды [CLI](../../cli/index.md) для получения информации об [адресе](../concepts/address.md):

     ```bash
     yc vpc address get --help
     ```

  1. Получите информацию об адресе, указав его имя или идентификатор:

     ```bash
     yc vpc address get <имя_адреса>
     ```

     Результат:

     ```text
     id: e2lot532vpte********
     folder_id: b1go3el0d8fs********
     created_at: "2024-03-05T09:53:21Z"
     external_ipv4_address:
       address: 84.201.***.***
       zone_id: ru-central1-b
       requirements: {}
     used: true
     type: EXTERNAL
     ip_version: IPV4
     ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы получить информацию об [адресе](../concepts/address.md) с помощью {{ TF }}:
  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

     ```hcl
     data "yandex_vpc_address" "my_addr" {
       address_id = "<имя_адреса>"
     }

     output "addr" {
       value = data.yandex_vpc_address.my_addr.external_ipv4_address
     }
     ```

     Где:
     * `data "yandex_vpc_address"` — описание адреса в качестве источника данных:
       * `address_id` — имя или идентификатор адреса.
     * `output "addr"` — выходная переменная, которая содержит информацию об IP-адресе:
       * `value` — возвращаемое значение.

     Вместо `external_ipv4_address` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_vpc_address` см. в [документации провайдера]({{ tf-provider-datasources-link }}/vpc_address).
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
     
        В терминале будет выведен список ресурсов с параметрами. На этом этапе изменения не будут внесены. Если в конфигурации есть ошибки, {{ TF }} на них укажет.
     1. Примените изменения конфигурации:
     
        ```bash
        terraform apply
        ```
     
     1. Подтвердите изменения: введите в терминале слово `yes` и нажмите **Enter**.

     {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

     ```bash
     terraform output
     ```

     Результат:

     ```text
     addr = tolist([
     {
         "address" = "84.201.***.***"
         "ddos_protection_provider" = ""
         "outgoing_smtp_capability" = ""
         "zone_id" = "ru-central1-b"
     },
     ])
     ```

- API {#api}

  Чтобы получить подробную информацию о [адресе](../concepts/address.md), воспользуйтесь методом REST API [get](../api-ref/Address/get.md) для ресурса [Address](../api-ref/Address/index.md), или вызовом gRPC API [AddressService/Get](../api-ref/grpc/Address/get.md).

{% endlist %}