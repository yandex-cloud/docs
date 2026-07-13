---
title: Зарезервировать внутренний IP-адрес
description: Следуя данной инструкции, вы сможете зарезервировать внутренний IP-адрес.
---

# Зарезервировать внутренний IP-адрес

Вы можете зарезервировать [внутренний IP-адрес](../concepts/address.md#internal-addresses), чтобы использовать его для передачи информации между ресурсами внутри облака.

{% list tabs group=instructions %}

- Консоль управления {#console}

   1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога, в котором нужно зарезервировать адрес.
   1. [Перейдите]({{ link-console-main }}/link/vpc) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. На панели слева выберите ![subnets](../../_assets/console-icons/nodes-right.svg) **{{ ui-key.yacloud.vpc.switch_networks }}**.
   1. Выберите подсеть, в которой нужно зарезервировать адрес.
   1. Перейдите на вкладку ![addresses](../../_assets/console-icons/map-pin.svg) **{{ ui-key.yacloud.vpc.subnetworks.switch_ip-addresses }}**.
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.Subnetwork.SubnetUsedAddressesList.button_create_sPV4s }}**.  
   1. В открывшемся окне:
       * Введите имя и описание внутреннего адреса.
       * В поле **{{ ui-key.yacloud.component.internal-v4-address-field.field_internal-ipv4-address }}** введите адрес, который необходимо зарезервировать.
       * (Опционально) Включите опцию **{{ ui-key.yacloud.vpc.addresses.popup-create_field_deletion-protection }}**.
       * (Опционально) Укажите [метки](../../resource-manager/concepts/labels.md).
   1. Нажмите кнопку **{{ ui-key.yacloud.vpc.addresses.popup-create_button_create }}**.

- CLI {#cli}

   {% include [include](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Просмотрите описание команды CLI для резервирования адреса:

      ```bash
      yc vpc address create --help
      ```

   1. Зарезервируйте внутренний IP-адрес, указав идентификатор подсети:

      ```bash
      yc vpc address create \
        --name <имя_адреса> \
        --internal-ipv4 subnet=<идентификатор_подсети>,address=<IP-адрес>
      ```

      Где:

      * `--name` — имя внутреннего IP-адреса.
      * `--internal-ipv4` — описание внутреннего IPv4-адреса:
        * `subnet` — идентификатор подсети, в которой резервируется адрес.
        * `address` — конкретный IP-адрес для резервирования. Если не указан, адрес назначается автоматически.

      Чтобы защитить адрес от удаления, добавьте флаг `--deletion-protection`.

      Результат:

      ```text
      id: e9b6un9gkso6********
      folder_id: b1g7gvsi89m3********
      created_at: "2024-05-08T07:55:49Z"
      name: my-internal-address
      internal_ipv4_address:
        address: 192.168.0.10
        subnet_id: e2lghukd9iqo********
      reserved: true
      type: INTERNAL
      ip_version: IPV4
      ```

      Внутренний IP-адрес зарезервирован.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры ресурсов, которые необходимо создать:

     * `name` — имя внутреннего IP-адреса. Формат имени:

          {% include [name-format](../../_includes/name-format.md) %}

     * `folder_id` — идентификатор каталога.
     * `internal_ipv4_address` — описание внутреннего IPv4-адреса:
        * `subnet_id` — идентификатор подсети, в которой резервируется адрес.
        * `address` — (опционально) конкретный IP-адрес для резервирования. Если не указан, адрес назначается автоматически.

     Пример структуры конфигурационного файла:

     ```hcl
     resource "yandex_vpc_address" "internal_addr" {
       name = "<имя_адреса>"
       folder_id = "<идентификатор_каталога>"
       internal_ipv4_address {
         subnet_id = "<идентификатор_подсети>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_vpc_address` в {{ TF }} см. в [документации провайдера]({{ tf-provider-resources-link }}/vpc_address).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого в указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

     ```bash
     yc vpc address list
     ```

- API {#api}

  Чтобы зарезервировать внутренний IP-адрес, воспользуйтесь методом REST API [create](../api-ref/Address/create.md) для ресурса [Address](../api-ref/Address/index.md) или вызовом gRPC API [AddressService/Create](../api-ref/grpc/Address/create.md) и передайте в запросе параметр `internalIpv4AddressSpec` для REST API или `internal_ipv4_address_spec` для gRPC API с полями:

    * Идентификатор каталога, в котором будет размещен адрес, в поле `folderId` для REST API или `folder_id` для gRPC API.
    * Имя внутреннего IP-адреса в поле `name`. Формат имени:

      {% include [name-format](../../_includes/name-format.md) %}

    * Идентификатор подсети в поле `subnetId` для REST API или `subnet_id` для gRPC API.
    * (Опционально) Конкретный IP-адрес для резервирования в поле `address`. Если не указан, адрес назначается автоматически.

  Чтобы защитить адрес от удаления, передайте в запросе параметр `deletionProtection` для REST API или `deletion_protection` для gRPC API со значением `true`.

{% endlist %}

