---
title: Удаление схемы
description: Следуя данной инструкции, вы сможете удалить схему.
---

# Удаление схемы



{% include notitle [preview](../../_includes/note-preview.md) %}



{% note warning %}

Если в субъекте только одна схема, ее удаление приведет к удалению субъекта.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../_assets/console-icons/layout-cells.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_schema-registry }}**.
  1. Выберите пространство имен, в котором вы хотите удалить схему.
  1. На панели слева выберите ![image](../../_assets/console-icons/branches-down.svg) **{{ ui-key.yacloud.schema-registry.label_schemas }}**.
  1. Справа от имени схемы, которую вы хотите удалить, нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
