---
title: Получение списка глоссариев в каталоге метаданных
description: Следуя данной инструкции, вы сможете получить список глоссариев в каталоге метаданных.
---

# Получение списка глоссариев

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы глоссарии.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/book.svg) **{{ ui-key.yacloud.data-catalog.label_terms-and-glossaries }}**.

{% endlist %}

## Настройка списка глоссариев {#setting-list-tags}

С помощью консоли управления можно найти глоссарии по их идентификатору или имени, отсортировать глоссарии по имени, а также настроить отображение колонок в списке.

Чтобы найти глоссарий, введите идентификатор или имя глоссария в поисковой строке над списком глоссариев.

Чтобы отсортировать глоссарии по имени, нажмите на заголовок колонки **{{ ui-key.yacloud.common.name }}**. Глоссарии будут отсортированы в алфавитном порядке. Второе нажатие на тот же заголовок сменит направление сортировки. Третье нажатие отменит сортировку.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
