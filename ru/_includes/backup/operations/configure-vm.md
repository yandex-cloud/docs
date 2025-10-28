{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [attach-sg-to-vm-console](./attach-sg-to-vm-console.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../cli-install.md) %}

  {% include [default-catalogue](../../default-catalogue.md) %}

  1. Посмотрите описание команды для изменения [сетевого интерфейса](../../../compute/concepts/network.md) ВМ:

      ```bash
      yc compute instance update-network-interface --help
      ```

  1. Добавьте созданную ранее группу безопасности в сетевой интерфейс ВМ:

      ```bash
      yc compute instance update-network-interface \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса> \
        --security-group-id <идентификатор_группы_безопасности>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.
      * `--security-group-id` — идентификатор группы безопасности.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

  1. Посмотрите описание команды для привязки публичного IP-адреса к ВМ:

      ```bash
      yc compute instance add-one-to-one-nat --help
      ```

  1. Если у ВМ нет [публичного IP-адреса](../../../vpc/concepts/address.md#public-addresses), то привяжите его:

      ```bash
      yc compute instance add-one-to-one-nat \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса>
      ```

      Где:

      * `--id` — идентификатор ВМ.
      * `--network-interface-index` — номер сетевого интерфейса, например `0`.

      Результат:

      ```text
      id: epddj31hkik0********
      folder_id: b1g681qpemb4********
      updateNetworkInterfaced_at: "2025-04-21T11:07:34Z"
      name: my-vm
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:d9:8c:31:a4
          subnet_id: e2lb1da2dd9v********
          primary_v4_address:
            address: 10.129.**.**
            one_to_one_nat:
              address: 158.160.**.**
              ip_version: IPV4
          security_group_ids:
            - enpqtbh6ulo3********
      ...
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../terraform-install.md) %}

  1. Откройте конфигурационный файл и в блоке с описанием ресурса `yandex_compute_instance` измените параметры [сетевого интерфейса](../../../compute/concepts/network.md) ВМ:

      ```hcl
      resource "yandex_compute_instance" "my-vm" {
      ...
        network_interface {
          ...
          security_group_ids = "<идентификатор_группы_безопасности>"
          nat                = true
          ...
        }
      ...
      }
      ```

      Где:

      * `yandex_compute_instance` — описание ВМ.
      * `network_interface` — настройки сетевого интерфейса ВМ.
      * `security_group_ids` — список идентификаторов групп безопасности.
      * `nat` — параметр, задающий привязку публичного IP-адреса к ВМ.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} изменит все требуемые ресурсы. Проверить изменение ресурсов можно в [консоли управления]({{ link-console-main }}).

  Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_instance).

- API {#api}

  Чтобы добавить группу безопасности в [сетевой интерфейс](../../../compute/concepts/network.md) ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../../compute/api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/UpdateNetworkInterface](../../../compute/api-ref/grpc/Instance/updateNetworkInterface.md).

  Чтобы привязать [публичный IP-адрес](../../../vpc/concepts/address.md#public-addresses) к ВМ, воспользуйтесь методом REST API [addOneToOneNat](../../../compute/api-ref/Instance/addOneToOneNat.md) для ресурса [Instance](../../../compute/api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/AddOneToOneNat](../../../compute/api-ref/grpc/Instance/addOneToOneNat.md).

{% endlist %}

Подробности см. в разделах [{#T}](../../../compute/operations/vm-control/vm-change-security-groups-set.md) и [{#T}](../../../compute/operations/vm-control/vm-attach-public-ip.md).