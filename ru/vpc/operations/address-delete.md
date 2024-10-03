---
title: Как удалить статический публичный IP-адрес
description: Следуя данной инструкции, вы сможете удалить статический публичный IP-адрес.
---

# Удалить статический публичный IP-адрес

{% note alert %}

Перед удалением [статический адрес](../concepts/address.md) необходимо освободить, удалив ресурс, к которому он привязан.
Если у адреса включена защита от удаления, то сначала выключите ее.
После удаления адрес невозможно восстановить.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, где требуется удалить статический адрес.
   1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
   1. Нажмите ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного адреса:
      * Выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
      * (Опционально) Выберите ![image](../../_assets/console-icons/lock-open.svg) **{{ ui-key.yacloud.vpc.addresses.button_action-disable-protection }}**, если включена защита, затем нажмите **{{ ui-key.yacloud.vpc.addresses.popup-confirm_button_disable-protection }}**.
   1. В открывшемся окне подтвердите, нажатием **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

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

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

  Чтобы удалить [статический адрес](../concepts/address.md), воспользуйтесь методом REST API [delete](../api-ref/Address/delete.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Delete](../api-ref/grpc/address_service.md#Delete) и передайте в запросе идентификатор удаляемого адреса в параметре `addressId`.

  {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}
