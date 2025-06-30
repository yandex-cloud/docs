---
title: Создание каталога метаданных
description: Следуя данной инструкции, вы сможете создать каталог метаданных в {{ data-catalog-full-name }}.
---

# Создание каталога

{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог ресурсов](../../../resource-manager/concepts/resources-hierarchy.md#folder), в котором нужно создать каталог метаданных.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-catalog }}**.
    1. Задайте параметры каталога:

       * В поле **{{ ui-key.yacloud.common.name }}** задайте уникальное имя каталога.
       * (Опционально) Добавьте описание каталога.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
