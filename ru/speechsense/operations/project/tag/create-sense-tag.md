---
title: Создать смысловой тег
description: Следуя данной инструкции, вы сможете создать смысловой тег проекта.
---

# Создать смысловой тег

[Смысловой тег](../../../concepts/tags.md#sense-tags) можно создать только в [проекте](../../../concepts/resources-hierarchy.md#project). Для этого нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

При создании смыслового тега доступны следующие варианты:

* [создать новый тег](#new-tag);
* [добавить зависимый тег](create-dependent-tag.md) для существующего тега.

## Создать тег {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Выберите тип тега **Смысловой**.
1. Задайте параметры тега:

    * Введите название тега.
    * (Опционально) Введите описание тега.

    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys](../../../../_includes/speechsense/tag/data-analysis.md) %}

    * (Опционально) Включите [тестирование тега](test.md).

    {% note info %}

    Смысловому тегу по умолчанию присваиваются каналы `Оператор` и `Клиент` одновременно, изменить это нельзя.

    {% endnote %}

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

После создания тег активируется автоматически.
