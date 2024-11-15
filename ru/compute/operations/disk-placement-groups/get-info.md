---
title: Как получить информацию о группе размещения дисков в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете получить информацию о группе размещения дисков.
---

# Получить информацию о группе размещения дисков


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [группа размещения дисков](../../concepts/disk-placement-group.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.switch_placement-groups }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud.compute.placement-groups.label_tab-disks }}**.
  1. Выберите нужную группу размещения дисков.
  1. На странице **{{ ui-key.yacloud.compute.placement-group.overview.label_title }}** отобразится подробная информация о группе размещения дисков.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [группе размещения дисков](../../concepts/disk-placement-group.md):

      ```bash
      yc compute disk-placement-group get --help
      ```

  1. Получите информацию о группе размещения дисков, указав ее идентификатор или имя:

      ```bash
      yc compute disk-placement-group get <идентификатор_группы_размещения_дисков>
      ```

      Результат:

      ```text
      id: d9h3qkknmtsl********
      folder_id: aoe3hggkil3t********
      created_at: "2023-10-27T13:01:20Z"
      name: test-placement-group
      zone_id: {{ region-id }}-d
      status: READY
      spread_placement_strategy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [группе размещения дисков](../../concepts/disk-placement-group.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_disk_placement_group" "my_group" {
        group_id = "<идентификатор_группы>"
      }

      output "placement_group" {
        value = data.yandex_compute_disk_placement_group.my_group.name
      }
      ```

      Где:

      * `data "yandex_compute_disk_placement_group"` — описание группы размещения дисков в качестве источника данных:
        * `group_id` — идентификатор группы размещения дисков.
      * `output "placement_group"` — выходная переменная, которая содержит информацию о группе размещения дисков:
        * `value` — возвращаемое значение.

      Вместо `name` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_disk_placement_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_disk_placement_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      placement_group = "test-placement-group"
      ```

- API {#api}

  Чтобы получить подробную информацию о [группе размещения дисков](../../concepts/disk-placement-group.md), воспользуйтесь методом REST API [get](../../api-ref/DiskPlacementGroup/get.md) для ресурса [DiskPlacementGroup](../../api-ref/DiskPlacementGroup/index.md), или вызовом gRPC API [DiskPlacementGroupService/Get](../../api-ref/grpc/DiskPlacementGroup/get.md).

{% endlist %}