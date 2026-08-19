---
title: Удалить зарезервированный внутренний IP-адрес
description: Следуя данной инструкции, вы сможете освободить зарезервированный внутренний IP-адрес.
---

# Удалить внутренний IP-адрес

Перед удалением зарезервированный адрес необходимо освободить, удалив ресурс, к которому он привязан.

Если для адреса включена защита от удаления, то перед удалением адреса ее нужно [отключить](./deletion-protection.md#disable).

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужный адрес.
   1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Выберите подсеть, в которой находится зарезервированный адрес.
   1. Перейдите на вкладку **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.
   1. В строке с IP-адресом, который нужно удалить, нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
   1. Подтвердите удаление.

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

  1. Примените изменения:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  1. Проверить изменения можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc address list
     ```

- API {#api}

  Чтобы удалить внутренний IP-адрес, воспользуйтесь методом REST API [delete](../api-ref/Address/delete.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Delete](../api-ref/grpc/Address/delete.md) и передайте в запросе идентификатор удаляемого адреса в параметре `addressId` для REST API или `address_id` для gRPC API.

  {% include [get-address-id](../../_includes/vpc/get-adress-id.md) %}

  {% include [get-catalog-id](../../_includes/get-catalog-id.md) %}

{% endlist %}

