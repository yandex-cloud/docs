---
title: Изменить группу рабочих столов
description: Следуя данной инструкции, вы сможете изменить группу рабочих столов.
---

# Изменить группу рабочих столов

{% include [updating-group-disclaimer](../../../_includes/cloud-desktop/updating-group-disclaimer.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Напротив группы, которую нужно изменить, нажмите ![options](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.edit }}**.
  1. Выберите [образ](../../concepts/images.md) операционной системы.
  1. В блоке **{{ ui-key.yacloud.vdi.section_disks }}** увеличьте размер рабочего диска.
  1. В блоке **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Укажите количество ядер vCPU.
      * Выберите [гарантированную долю](../../../compute/concepts/performance-levels.md) vCPU.
      * Укажите объем RAM.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

{% endlist %}
