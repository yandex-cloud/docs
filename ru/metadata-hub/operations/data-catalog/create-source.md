---
title: Создание источника метаданных
description: Следуя данной инструкции, вы сможете создать источник метаданных в {{ data-catalog-full-name }}.
---

# Создание источника


{% note info %}

{% include [preview-pp](../../../_includes/preview-pp.md) %}

{% endnote %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../../resource-manager/concepts/resources-hierarchy.md#folder) ресурсов, в котором создан каталог метаданных.
    1. [Перейдите]({{ link-console-main }}/link/metadata-hub) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. В блоке **{{ ui-key.yacloud.metadata-hub.label_manage-metadata }}** выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_data-catalog }}**.
    1. В открывшемся списке выберите каталог метаданных, в котором вы хотите создать [источник](../../concepts/data-catalog-sources.md).
    1. Перейдите на вкладку **{{ ui-key.yacloud.data-catalog.layout.label.sources-new-layout_N6vT1 }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.data-catalog.label_create-source-button }}**.
    1. Задайте уникальное имя источника. После создания источника нельзя будет изменить его имя.
    1. (Опционально) Добавьте описание источника.
    1. Выберите тип бэкенда, из которого будут поставляться метаданные. После создания источника его тип нельзя будет изменить. Доступные бэкенды:

       {% include notitle [sources](../../../_includes/metadata-hub/data-catalog-sources.md) %}

    1. Укажите параметры источника для выбранного типа бэкенда:

        {% include [source-parameters](../../../_includes/metadata-hub/data-catalog-source-parameters.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
