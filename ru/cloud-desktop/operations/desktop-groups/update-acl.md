---
title: Инструкция по изменению прав доступа к группе рабочих столов в {{ cloud-desktop-full-name }}
description: Из статьи вы узнаете, как изменить права доступа к группе рабочих столов в {{ cloud-desktop-full-name }}.
---

# Изменить права доступа к группе рабочих столов

{% include [access-options](../../../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа рабочих столов.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Справа от группы рабочих столов, к которой вы хотите изменить права доступа, нажмите ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.vdi.button_acl }}**.
  1. В появившемся окне **{{ ui-key.yacloud.component.acl-dialog.label_title }}** выдайте или отзовите необходимые разрешения.

{% endlist %}
