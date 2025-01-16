---
title: Удаление пространства имен
description: Следуя данной инструкции, вы сможете удалить пространство имен.
---

# Удаление пространства имен

{% include notitle [preview](../../_includes/note-preview.md) %}

{% note warning %}

При удалении пространства имен удаляются все связанные с ним субъекты и схемы данных.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно удалить пространство имен.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Справа от имени пространства, которое вы хотите удалить, нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
