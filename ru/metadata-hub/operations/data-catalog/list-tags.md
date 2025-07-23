---
title: Получение списка тегов в классификации
description: Следуя данной инструкции, вы сможете получить список тегов для метаданных в классификации, созданной в {{ data-catalog-full-name }}.
---

# Получение списка тегов в классификации

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. Hа панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором созданы теги.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}** и выберите классификацию, в которой созданы теги.

{% endlist %}

## Настройка списка тегов {#setting-list-tags}

С помощью консоли управления можно найти теги по их идентификатору или имени, отсортировать теги по имени, а также настроить отображение колонок в списке.

Чтобы найти теги, введите идентификатор или имя тега в поисковой строке над списком тегов.

Чтобы отсортировать теги по имени, нажмите на заголовок колонки **{{ ui-key.yacloud.common.name }}**. Теги будут отсортированы в алфавитном порядке. Второе нажатие на тот же заголовок сменит направление сортировки. Третье нажатие отменит сортировку.

{% include [display-columns](../../../_includes/metadata-hub/display-columns.md) %}
