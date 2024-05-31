# Изменить внутренний IP-адрес виртуальной машины

После создания [ВМ](../../concepts/vm.md) вы можете изменить [внутренние IP-адреса](../../../vpc/concepts/address.md#internal-addresses) ее [сетевых интерфейсов](../../concepts/network.md).

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для обновления внутреннего IP-адреса сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface --help
     ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Выберите идентификатор (`ID`) нужной ВМ.

  1. [Остановите](vm-stop-and-start.md#stop) выбранную ВМ.

  1. Получите список сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

     ```bash
     yc compute instance get <идентификатор_ВМ>
     ```

     Результат:

     ```yml
     ...
     network_interfaces:
       - index: "0"
         mac_address: d0:0d:24:**:**:**
         subnet_id: e2lpp96bvvgp********
         primary_v4_address:
           address: 192.168.2.23
           one_to_one_nat:
             address: 158.160.**.***
             ip_version: IPV4
       - index: "1"
         mac_address: d0:1d:24:**:**:**
         subnet_id: e2lrucutusnd********
         primary_v4_address:
           address: 192.168.1.32
       - index: "2"
         mac_address: d0:2d:24:**:**:**
         subnet_id: e2lv9c6aek1d********
         primary_v4_address:
           address: 192.168.4.26
     ...
     ```

     Сохраните значение поля `index` — номер сетевого интерфейса, для которого требуется изменить внутренний IP-адрес.

  1. Измените внутренний IP-адрес выбранного сетевого интерфейса ВМ:

     ```bash
     yc compute instance update-network-interface \
       --id <идентификатор_ВМ> \
       --ipv4-address <внутренний_IP-адрес> \
       --network-interface-index <номер_сетевого_интерфейса>
     ```

     Где:
     * `--id` — идентификатор виртуальной машины.
     * `--ipv4-address` — внутренний IP-адрес. Задайте новый IP-адрес или введите `auto`, чтобы присвоить новый адрес автоматически.
     * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Чтобы изменить внутренний IP-адрес сетевого интерфейса ВМ, добавьте параметр `ip_address` в блок `network_interface` нужного сетевого интерфейса в конфигурации ресурса `yandex_compute_instance`:

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

  Чтобы изменить внутренний IP-адрес сетевого интерфейса ВМ, воспользуйтесь методом REST API [updateNetworkInterface](../../api-ref/Instance/updateNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/PrimaryAddress](../../api-ref/grpc/instance_service.md#PrimaryAddress).

{% endlist %}