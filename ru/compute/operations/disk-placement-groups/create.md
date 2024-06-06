---
title: "Как создать группу размещения дисков в {{ compute-full-name }}"
description: "Следуя данной инструкции, вы сможете создать группу размещения дисков."
---

# Создать группу размещения дисков


Чтобы создать [группу размещения](../../concepts/disk-placement-group.md) для [нереплицируемых дисков](../../concepts/disk.md#nr-disks):

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать группу размещения дисков.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.compute.placement-groups.button_create }}** → **{{ ui-key.yacloud.compute.placement-groups.button_menu-create-disk-placement-group }}**.
  1. Введите имя группы размещения дисков. Требования к имени:

     {% include [name-format](../../../_includes/name-format.md) %}

  1. При необходимости добавьте произвольное описание группы размещения дисков.
  1. Укажите [зону доступности](../../../overview/concepts/geo-scope.md).
  1. Выберите стратегию: [распределенное размещение](../../concepts/disk-placement-group.md#spread) (spread) или [размещение разделами](../../concepts/disk-placement-group.md#partition) (partition).

     Для размещения разделами укажите количество разделов для нереплицируемых дисков.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды [CLI](../../../cli/) для создания группы размещения дисков:

     ```bash
     yc compute disk-placement-group create --help
     ```

  1. Создайте группу размещения дисков в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию с одной из стратегий размещения:
     * [Распределенное размещение](../../concepts/disk-placement-group.md#spread) (spread):

       ```bash
       yc compute disk-placement-group create \
         --name <имя_группы_размещения_дисков> \
         --zone <зона_доступности> \
         --strategy SPREAD
       ```

       Где:
       * `--name` — имя группы размещения дисков.
       * `--zone` — [зона доступности](../../../overview/concepts/geo-scope.md).
       * `--strategy` — стратегия размещения.
     * [Размещение разделами](../../concepts/disk-placement-group.md#partition) (partition):

       ```bash
       yc compute disk-placement-group create \
         --name <имя_группы_размещения_дисков> \
         --zone <зона_доступности> \
         --strategy PARTITION \
         --partition-count <количество_разделов>
       ```

       Где:
       * `--name` — имя группы размещения дисков.
       * `--zone` — зона доступности.
       * `--strategy` — стратегия размещения.
       * `--partition-count` — количество разделов от 2 до 5.
  1. Получите список групп размещения дисков в каталоге по умолчанию:

     ```bash
     yc compute disk-placement-group list
     ```

     Результат:

     ```text
     +----------------------+---------------------+-------------------+--------+---------------+
     |          ID          |        NAME         |       ZONE        | STATUS |   STRATEGY    |
     +----------------------+---------------------+-------------------+--------+---------------+
     | epd3oalmkmbp******** | drbasic-partition-1 | {{ region-id }}-b | READY  | PARTITION [3] |
     | epdn7r7co1v4******** | drbasic-spread-2    | {{ region-id }}-b | READY  | SPREAD        |
     +----------------------+---------------------+-------------------+--------+---------------+
     ```

  1. Получите информацию о созданной группе размещения дисков, указав ее имя:

     ```bash
     yc compute disk-placement-group get \
       --name <имя_группы_размещения>
     ```

     Результат:

     ```text
     id: epd4sug6kesk********
     folder_id: w3qrbj9swoty********
     created_at: "2021-03-23T12:49:59Z"
     name: first-group
     zone_id: {{ region-id }}-b
     status: READY
     spread_placement_strategy: {}
     ```


- API {#api}

  Воспользуйтесь методом REST API [create](../../api-ref/DiskPlacementGroup/create.md) для ресурса [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md) или вызовом gRPC API [DiskPlacementGroupService/Create](../../api-ref/grpc/disk_placement_group_service.md#Create).

{% endlist %}