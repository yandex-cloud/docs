# Зарезервировать статический публичный IP-адрес


Вы можете зарезервировать публичный [статический IP-адрес](../concepts/address.md#public-addresses), чтобы потом использовать его для доступа к облачным ресурсам.

{% note info %}

Обратите внимание на [правила тарификации](../pricing.md#prices-public-ip) неактивных статических публичных адресов.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором нужно зарезервировать адрес.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.button_create }}**.
   1. В открывшемся окне:
       * В поле **{{ ui-key.yacloud.vpc.addresses.popup-create_field_zone }}** выберите зону доступности, в которой нужно зарезервировать адрес.
       * (Опционально) В блоке **{{ ui-key.yacloud.vpc.addresses.popup-create_field_advanced }}** включите опции **{{ ui-key.yacloud.common.field_ddos-protection-provider }}** и **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
       * (Опционально) Укажите метки.
       * (Опционально) Чтобы добавить DNS-запись, разверните список **{{ ui-key.yacloud.vpc.addresses.label_dns-spec-title }}** и нажмите кнопку **{{ ui-key.yacloud.dns.button_add-record }}**. В открывшемся блоке:
           * Выберите зону DNS.
           * Укажите FQDN. Вы можете создать новый домен или использовать домен, имя которого совпадает с именем зоны DNS.
           * В поле **{{ ui-key.yacloud.dns.label_ttl }}** укажите время жизни записи в секундах.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Просмотрите описание команды CLI для резервирования адреса:

      ```bash
      yc vpc address create --help
      ```

   1. Зарезервируйте адрес, указав зону доступности:

      ```bash
      yc vpc address create --external-ipv4 zone={{ region-id }}-a --deletion-protection
      ```

      Где:

      * `--external-ipv4` — описание ipv4-адреса:
        * `zone` — [зона доступности](../../overview/concepts/geo-scope.md).
      * `--deletion-protection` — включает защиту статического публичного IP-адреса от удаления. Пока опция включена, IP-адрес удалить невозможно.

      Результат:

      ```text
      id: e9b6un9gkso6********
      folder_id: b1g7gvsi89m3********
      created_at: "2021-01-19T17:52:42Z"
      external_ipv4_address:
        address: 178.154.253.52
        zone_id: {{ region-id }}-a
        requirements: {}
      reserved: true
      type: EXTERNAL
      ip_version: IPV4
      deletion_protection: true
      ```

      Статический публичный IP-адрес зарезервирован.

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя статического публичного IP-адреса. Формат имени:

          * длина — от 3 до 63 символов;
          * может содержать строчные буквы латинского алфавита, цифры и дефисы;
          * первый символ — буква, последний — не дефис.

     * `deletion_protection` — защита статического публичного IP-адреса от удаления. Пока опция включена, IP-адрес удалить невозможно. Значение по умолчанию `false`.
     * `external_ipv4_address` — описание ipv4-адреса:
        * `zone_id` — [зона доступности](../../overview/concepts/geo-scope.md).

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_address" "addr" {
       name = "<имя_IP-адреса>"
       deletion_protection = "<защитить_адрес_от_удаления>"
       external_ipv4_address {
         zone_id = "<зона_доступности>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_address` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_address).

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

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc address list
     ```

- API {#api}

  Чтобы зарезервировать статический публичный IP-адрес, воспользуйтесь методом REST API [create](../api-ref/Address/create.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../api-ref/grpc/Address/create.md) и передайте в запросе:

    * Идентификатор каталога, в котором будет размещен статический IP-адрес, в параметре `folderId`.
    * Имя статического публичного IP-адреса в параметре `name`. Формат имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

    * Идентификатор [зоны доступности](../../overview/concepts/geo-scope.md), в которой будет размещен адрес, в параметре `externalIpv4AddressSpec.zoneId`.

  Чтобы защитить статический публичный IP-адрес от удаления, передайте в запросе параметр `deletionProtection` со значением `true`.

{% endlist %}