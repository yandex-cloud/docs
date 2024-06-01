# Удалить сетевой интерфейс на виртуальной машине


К виртуальной машине может быть привязано от одного до восьми [сетевых интерфейсов](../../concepts/network.md). Ненужные сетевые интерфейсы можно удалять как на остановленных, так и на работающих ВМ.

{% note info %}

Единственный сетевой интерфейс виртуальной машины удалить нельзя.

{% endnote %}

Чтобы удалить сетевой интерфейс на виртуальной машине:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления сетевого интерфейса на виртуальной машине:

      ```bash
      yc compute instance detach-network-interface --help
      ```

  1. Получите список ВМ в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

      Сохраните идентификатор ВМ, на которой вы хотите удалить сетевой интерфейс.

  1. При необходимости остановите выбранную ВМ, указав ее идентификатор:

      {% note info %}

      {% include [add-network-interface-hotplug-preview-note](../../../_includes/compute/add-network-interface-hotplug-preview-note.md) %}

      {% endnote %}

      ```bash
      yc compute instance stop <идентификатор_ВМ>
      ```

  1. Получите список сетевых интерфейсов выбранной ВМ, указав ее идентификатор:

      ```bash
      yc compute instance get <идентификатор_ВМ>
      ```

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
        - index: "2"
          mac_address: d0:2d:1a:**:**:**
          subnet_id: e2lv9c6aek1d********
          primary_v4_address:
            address: 192.168.4.17
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

      Сохраните номер (значение поля `index`) сетевого интерфейса, который требуется удалить.

  1. Удалите сетевой интерфейс:

      ```bash
      yc compute instance detach-network-interface \
        --id <идентификатор_ВМ> \
        --network-interface-index <номер_сетевого_интерфейса>
      ```

      Где:
      * `--id` — идентификатор выбранной виртуальной машины. Вместо идентификатора вы можете использовать параметр `--name`, чтобы указать имя ВМ.
      * `--network-interface-index` — сохраненный ранее номер сетевого интерфейса ВМ, который требуется удалить.

      Результат:

      ```yml
      ...
      network_interfaces:
        - index: "0"
          mac_address: d0:0d:1a:**:**:**
          subnet_id: e2lrucutusnd********
          primary_v4_address:
            address: 192.168.1.20
            one_to_one_nat:
              address: 158.***.**.***
              ip_version: IPV4
          security_group_ids:
            - enpuatgvejtn********
        - index: "1"
          mac_address: d0:1d:1a:**:**:**
          subnet_id: e2lpp96bvvgp********
          primary_v4_address:
            address: 192.168.2.3
          security_group_ids:
            - enpuatgvejtn********
            - enpg8d2hqh1o********
      ...
      ```

- API {#api}

  Воспользуйтесь методом REST API [detachNetworkInterface](../../api-ref/Instance/detachNetworkInterface.md) для ресурса [Instance](../../api-ref/Instance/index.md) или вызовом gRPC API [InstanceService/DetachNetworkInterface](../../api-ref/grpc/instance_service.md#DetachNetworkInterface).

{% endlist %}