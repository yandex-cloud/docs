# Создание группы выделенных хостов


Вы можете создать группу [выделенных хостов](../../concepts/dedicated-host.md), предназначенных для размещения исключительно ваших виртуальных машин в {{ yandex-cloud }}.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

Чтобы создать группу выделенных хостов:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите список возможных [типов](../../concepts/dedicated-host.md#host-types) выделенных хостов:

      ```bash
      yc compute host-type list
      ```

      Результат:

      {% include [dedicated-types-cli-output](../../../_includes/compute/dedicated-types-cli-output.md) %}

  1. Создайте группу выделенных хостов выбранного типа. В группе может быть один или несколько хостов.

      ```bash
      yc compute host-group create \
        --fixed-size <количество_выделенных_хостов_в_группе> \
        --type <тип_выделенных_хостов> \
        --zone <зона_доступности>
      ```

      Где:

      * `--fixed-size` — количество выделенных хостов в группе.
      * `--type` — тип выделенных хостов.
      * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md), в которой будет размещена группа.

      Результат:

      ```bash
      done (6s)
      id: abcdefg1hi23********
      folder_id: m4n56op78mev********
      created_at: "2020-10-13T07:36:49Z"
      zone_id: {{ region-id }}-a
      status: READY
      type_id: intel-6230-c66-m454
      maintenance_policy: RESTART
      scale_policy:
        fixed_scale:
          size: "2"
      ```

- API {#api}

  1. Выберите тип хоста с помощью метода REST API [list](../../api-ref/HostType/list.md) для ресурса [HostType](../../api-ref/HostType/index.md) или вызова gRPC API [HostTypeService/List](../../api-ref/grpc/host_type_service.md#List).
  1. Создайте группу выделенных хостов с помощью метода REST API [create](../../api-ref/HostGroup/create.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызова gRPC API [HostGroupService/Create](../../api-ref/grpc/host_group_service.md#Create).

{% endlist %}

#### См. также {#see-also}

* [{#T}](running-host-group-vms.md)
* [{#T}](running-host-vms.md)