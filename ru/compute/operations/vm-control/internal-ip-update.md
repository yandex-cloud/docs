# Изменить внутренний IP-адрес виртуальной машины

После создания [ВМ](../../concepts/vm.md) вы можете изменить ее [внутренний IP-адрес](../../../vpc/concepts/address.md#internal-addresses).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. [Остановите](vm-stop-and-start.md#stop) ВМ.
  1. Посмотрите описание команды [CLI](../../../cli/) для обновления внутреннего IP-адреса ВМ:

     ```bash
     yc compute instance update-network-interface --help
     ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) нужной ВМ.
  1. Измените внутренний IP-адрес ВМ:

     ```bash
     yc compute instance update-network-interface \
       --id <идентификатор_ВМ> \
       --ipv4-address <внутренний_IP-адрес> \
       --network-interface-index 0
     ```

     Где:
     * `--ipv4-address` — внутренний IP-адрес. Задайте новый IP-адрес или введите `auto`, чтобы присвоить новый адрес автоматически.
     * `--network-interface-index` — номер сетевого интерфейса.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Чтобы изменить внутренний IP-адрес ВМ, добавьте в конфигурацию ресурса `yandex_compute_instance` параметр `ip_address`:

     ```hcl
     resource "yandex_compute_instance" "vm-1" {
       ...
       network_interface {
         ...
         ip_address = "<внутренний_IP-адрес>"
       }
     }
     ```

     Более подробную информацию о параметрах ресурса `yandex_compute_instance` см. в [документации провайдера]({{ tf-provider-resources-link }}/compute_instance).
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы изменить внутренний IP-адрес ВМ, воспользуйтесь методом REST API [updateNetworkInterfacet](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/PrimaryAddress](../../api-ref/grpc/instance_service.md#PrimaryAddress).

{% endlist %}