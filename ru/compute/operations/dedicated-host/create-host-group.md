---
title: Создание группы выделенных хостов
description: Следуя данной инструкции, вы сможете создать группу выделенных хостов.
---

# Создание группы выделенных хостов


Вы можете создать группу [выделенных хостов](../../concepts/dedicated-host.md), предназначенных для размещения исключительно ваших виртуальных машин в {{ yandex-cloud }}.

{% include [dedicated](../../../_includes/compute/dedicated-quota.md) %}

Чтобы создать группу выделенных хостов:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создана группа выделенных хостов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../../_assets/console-icons/cubes-3-overlap.svg) **{{ ui-key.yacloud.compute.host-groups_eKsBm }}**.
  1. Справа сверху нажмите **{{ ui-key.yacloud.compute.host-groups.button_create-host-group }}**.
  1. Введите имя и описание группы выделенных хостов. Требования к имени:

      {% include [name-format](../../../_includes/name-format.md) %}
  
  1. (Опционально) Добавьте [метку](../../../resource-manager/concepts/labels.md) группе выделенных хостов.
  1. Выберите [зону доступности](../../../overview/concepts/geo-scope.md), в которой будет находиться группа выделенных хостов.
  1. Выберите [тип хоста](../../concepts/dedicated-host.md#host-types).
  1. Укажите количество выделенных хостов в группе.
  1. Нажмите **{{ ui-key.yacloud.common.create }}**.

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

      ```text
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

  1. Выберите тип хоста с помощью метода REST API [list](../../api-ref/HostType/list.md) для ресурса [HostType](../../api-ref/HostType/index.md) или вызова gRPC API [HostTypeService/List](../../api-ref/grpc/HostType/list.md).
  1. Создайте группу выделенных хостов с помощью метода REST API [create](../../api-ref/HostGroup/create.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызова gRPC API [HostGroupService/Create](../../api-ref/grpc/HostGroup/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](running-host-group-vms.md)
* [{#T}](running-host-vms.md)