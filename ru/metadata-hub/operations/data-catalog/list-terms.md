---
title: Получение списка терминов в {{ data-catalog-full-name }}
description: Следуя данной инструкции, вы получите список терминов глоссария в {{ data-catalog-name }}.
---

# Получение списка терминов


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы термины.
  1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}** и выберите глоссарий, в котором созданы термины.

{% endlist %}

## Настройка списка терминов {#setting-list-terms}

{% include [list-search](../../../_includes/metadata-hub/search-sort-list-terms.md) %}

{% include [list-display](../../../_includes/metadata-hub/display-columns.md) %}
