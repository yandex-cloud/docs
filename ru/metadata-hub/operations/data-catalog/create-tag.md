---
title: Создание тега
description: Следуя данной инструкции, вы сможете создать тег для метаданных в {{ data-catalog-full-name }}.
---

# Создание тега

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором создан каталог метаданных.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
  1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать тег.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/tag.svg) **{{ ui-key.yacloud.data-catalog.label_tags-and-classification }}**.
  1. Выберите классификацию, в которой вы хотите создать тег, или создайте новую классификацию.
  1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-tag-action }}**.
  1. Задайте параметры тега:

     * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя тега.
     * (Опционально) Добавьте описание тега.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
