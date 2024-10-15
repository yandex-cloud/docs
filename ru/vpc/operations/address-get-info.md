---
title: Как получить информацию об IP-адресе в {{ vpc-full-name }}
---

# Получить информацию об IP-адресе

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором находится [адрес](../concepts/address.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.switch_addresses }}**.
  1. На открывшейся странице отобразится подробная информация о всех доступных адресах.

- CLI {#cli}

  {% include [include](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../cli/) для получения информации об [адресе](../concepts/address.md):

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

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

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

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

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

  Чтобы получить подробную информацию о [адресе](../concepts/address.md), воспользуйтесь методом REST API [get](../api-ref/Address/get.md) для ресурса [Address](../api-ref/Address/index.md), или вызовом gRPC API [AddressService/Get](../api-ref/grpc/address_service.md#Get).

{% endlist %}
