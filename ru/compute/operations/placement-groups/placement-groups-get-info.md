---
title: Как получить информацию о группе размещения в {{ compute-full-name }}
---

# Получить информацию о группе размещения

{% list tabs %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится [группа размещения](../../concepts/placement-groups.md).
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.compute.placement-groups_3CwzD }}**.
  1. Выберите нужную группу.
  1. На странице **{{ ui-key.yacloud.compute.placement-group.overview.label_title }}** отобразится подробная информация о группе размещения ВМ.

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [группе размещения](../../concepts/placement-groups.md):

      ```bash
      yc compute placement-group get --help
      ```

  1. Получите информацию о группе размещения, указав ее имя или идентификатор:

      ```bash
      yc compute placement-group get <имя_группы_размещения>
      ```

      Результат:

      ```text
      id: fd8j3mm3229m********
      folder_id: b1g86q4m5vej********
      created_at: "2023-10-19T10:36:38Z"
      name: test-group
      spread_placement_strategy: {}
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Чтобы получить информацию о [группе размещения](../../concepts/placement-groups.md) с помощью {{ TF }}:

  1. Добавьте в конфигурационный файл {{ TF }} блоки `data` и `output`:

      ```hcl
      data "yandex_compute_placement_group" "my_group" {
        group_id = "<идентификатор_группы_размещения>"
      }

      output "placement_group" {
        value = data.yandex_compute_placement_group.my_group.created_at
      }
      ```

      Где:

      * `data "yandex_compute_placement_group"` — описание группы размещения в качестве источника данных:
        * `group_id` — идентификатор группы размещения.
      * `output "placement_group"` — выходная переменная, которая содержит информацию о времени создания группы размещения:
        * `value` — возвращаемое значение.

      Вместо `created_at` вы можете выбрать любой другой параметр для получения информации. Более подробно о параметрах источника данных `yandex_compute_placement_group` см. в [документации провайдера]({{ tf-provider-datasources-link }}/compute_placement_group).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} создаст все требуемые ресурсы и отобразит значения выходных переменных в терминале. Чтобы проверить результат, выполните команду:

      ```bash
      terraform output
      ```

      Результат:

      ```text
      placement_group = "2024-03-18T17:27:14Z"
      ```

- API {#api}

  Чтобы получить подробную информацию о [группе размещения](../../concepts/placement-groups.md), воспользуйтесь методом REST API [get](../../api-ref/PlacementGroup/get.md) для ресурса [PlacementGroup](../../api-ref/PlacementGroup/index.md), или вызовом gRPC API [PlacementGroupService/Get](../../api-ref/grpc/PlacementGroup/get.md).

{% endlist %}
