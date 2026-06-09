# Удалить статический публичный IP-адрес

{% note alert %}

После удаления адрес невозможно восстановить.

{% endnote %}

Перед удалением статический адрес необходимо освободить, удалив ресурс, к которому он привязан.

Если для статического адреса включена защита от удаления, то перед удалением адреса ее нужно [отключить](deletion-protection.md#disable).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, где требуется удалить статический адрес.
   1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного адреса:
      * Выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      * (Опционально) Выберите ![image](../../_assets/console-icons/lock-open.svg) **{{ ui-key.yacloud.vpc.addresses.button_action-disable-protection }}**, если включена защита, затем нажмите **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_disable-protection }}**.
   1. В открывшемся окне подтвердите, нажатием **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

   По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Просмотрите описание команды CLI для удаления адреса:

      ```bash
      yc vpc address delete --help
      ```

   1. Получите список адресов в каталоге по умолчанию:

      ```bash
      yc vpc address list
      ```

      Результат:

      ```text
      +----------------------+------+----------------+----------+-------+
      |          ID          | NAME |    ADDRESS     | RESERVED | USED  |
      +----------------------+------+----------------+----------+-------+
      | e9b6un9gkso6******** |      | 178.154.253.52 | true     | false |
      +----------------------+------+----------------+----------+-------+
      ```

   1. Удалите адрес, указав его идентификатор:

      ```bash
      yc vpc address delete e9b6un9gkso6********
      ```

- {{ TF }} {#tf}

  [{{ TF }}](https://www.terraform.io/) позволяет быстро создать облачную инфраструктуру в {{ yandex-cloud }} и управлять ею с помощью файлов конфигураций. В файлах конфигураций хранится описание инфраструктуры на языке HCL (HashiCorp Configuration Language). При изменении файлов конфигураций {{ TF }} автоматически определяет, какая часть вашей конфигурации уже развернута, что следует добавить или удалить.
  
  {{ TF }} распространяется под лицензией [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE), а [провайдер {{ yandex-cloud }} для {{ TF }}](https://github.com/yandex-cloud/terraform-provider-yandex) — под лицензией [MPL-2.0](https://www.mozilla.org/en-US/MPL/2.0/).
  
  Подробную информацию о ресурсах провайдера смотрите в документации на сайте [{{ TF }}](https://www.terraform.io/docs/providers/yandex/index.html) или в [зеркале]({{ tf-docs-link }}).

  Если у вас еще нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
  
  
  Чтобы управлять инфраструктурой с помощью {{ TF }} от имени сервисного аккаунта или пользовательских аккаунтов: аккаунта на Яндексе, федеративного аккаунта и локального пользователя, [аутентифицируйтесь](../../terraform/authentication.md) соответствующим способом.

  Чтобы удалить статический публичный IP-адрес, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием статического публичного IP-адреса.

     Пример описания статического публичного IP-адреса в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_vpc_address" "addr" {
       name = "exampleAddress"
       external_ipv4_address {
         zone_id = "{{ region-id }}-a"
       }
     }
     ...
     ```

  1. В командной строке перейдите в папку, где расположен файл конфигурации {{ TF }}.

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

     Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```
     yc vpc address list
     ```

- API {#api}

  Чтобы удалить [статический адрес](../concepts/address.md), воспользуйтесь методом REST API [delete](../api-ref/Address/delete.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Delete](../api-ref/grpc/Address/delete.md) и передайте в запросе идентификатор удаляемого адреса в параметре `addressId`.

  Чтобы узнать идентификатор адреса, воспользуйтесь методом REST API [list](../api-ref/Address/list.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/List](../api-ref/grpc/Address/list.md) и передайте в запросе идентификатор каталога в параметре `folderId`.

  О том, как узнать идентификатор каталога, читайте в разделе [Получение идентификатора каталога](../../resource-manager/operations/folder/get-id.md).

{% endlist %}