---
title: Удалить зарезервированный внутренний IP-адрес
description: Следуя данной инструкции, вы сможете освободить зарезервированный внутренний IP-адрес.
---

# Удалить внутренний IP-адрес

Перед удалением зарезервированный адрес необходимо освободить, удалив ресурс, к которому он привязан.

Если для адреса включена защита от удаления, то перед удалением адреса ее нужно [отключить](./deletion-protection.md#disable).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором находится нужный адрес.
   1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Выберите подсеть, в которой находится зарезервированный адрес.
   1. Перейдите на вкладку ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.
   1. Рядом с IP-адресом, который нужно удалить, нажмите кнопку ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.

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
      +----------------------+---------------------+----------------+----------+-------+
      |          ID          |        NAME         |    ADDRESS     | RESERVED | USED  |
      +----------------------+---------------------+----------------+----------+-------+
      | e9b6un9gkso6******** | my-internal-address | 192.168.0.10   | true     | false |
      +----------------------+---------------------+----------------+----------+-------+
      ```

   1. Удалите адрес, указав его идентификатор или имя:

      ```bash
      yc vpc address delete <идентификатор_или_имя_адреса>
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  Чтобы удалить внутренний IP-адрес, созданный с помощью {{ TF }}:

  1. Откройте файл конфигурации {{ TF }} и удалите фрагмент с описанием внутреннего IP-адреса.

     Пример описания внутреннего IP-адреса в конфигурации {{ TF }}:

     ```hcl
     ...
     resource "yandex_vpc_address" "internal_addr" {
       name = "<имя_адреса>"
       folder_id = "<идентификатор_каталога>"
       internal_ipv4_address {
         subnet_id = "<идентификатор_подсети>"
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

  Чтобы удалить внутренний IP-адрес, воспользуйтесь методом REST API [delete](../api-ref/Address/delete.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Delete](../api-ref/grpc/Address/delete.md) и передайте в запросе идентификатор удаляемого адреса в параметре `addressId` для REST API или `adress_id` для gRPC API.

  {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

