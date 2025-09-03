---
title: Создание источника метаданных
description: Следуя данной инструкции, вы сможете создать источник метаданных в {{ data-catalog-full-name }}.
---

# Создание источника


{% note info %}

{% include [preview-tp](../../../_includes/preview-tp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) ресурсов, в котором создан каталог метаданных.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/folder-magnifier.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать источник.
    1. На панели слева выберите ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **{{ ui-key.yacloud.data-catalog.label_sources }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Задайте уникальное имя источника. После создания источника нельзя будет изменить его имя.
    1. (Опционально) Добавьте описание источника.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные. После создания источника нельзя будет изменить тип базы данных.

       Доступные бэкенды: {{ PG }}, {{ MY }}, {{ MG }}, {{ CH }}, {{ OS }}, {{ GP }}, {{ data-transfer-name }}.
       
    1. Укажите параметры источника для выбранного типа базы данных:

        {% include [source-parameters](../../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
