---
title: Удаление тега
description: Следуя данной инструкции, вы сможете удалить тег для метаданных в {{ data-catalog-full-name }}.
---

# Удаление тега


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите удалить тег.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** и выберите классификацию, в которой вы хотите удалить тег.
  1. В списке тегов нажмите на значок ![image](../../../_assets/console-icons/ellipsis.svg) в строке с нужным тегом и выберите **{{ ui-key.yacloud.common.delete }}**.
  1. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}
