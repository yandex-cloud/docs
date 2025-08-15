---
title: Создать смысловой Pro-тег
description: Следуя данной инструкции, вы сможете создать смысловой Pro-тег проекта.
---

# Создать смысловой Pro-тег

[Смысловой Pro-тег](../../../concepts/tags.md#sense-pro-tags) можно создать только в [проекте](../../../concepts/resources-hierarchy.md#project). Для этого нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

{% note info %}

Смысловые Pro-теги — сложный экспертный инструмент {{ speechsense-name }}. Качество его работы зависит от правильности составления промтов. Рекомендуем обязательно пройти курс [Техники работы с промтами](../../../training.md).

{% endnote %}

При создании смыслового Pro-тега доступны следующие варианты:

* [создать новый тег](#new-tag);
* [добавить зависимый тег](create-dependent-tag.md) для существующего тега.

## Создать тег {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Выберите тип тега **{{ ui-key.yc-ui-talkanalytics.tags.tags-type.neuro-pro-key-value }}**.
1. Задайте параметры тега:

    * Введите название тега.
    * (Опционально) Введите описание тега.

    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys-pro](../../../../_includes/speechsense/tag/data-analysis-pro.md) %}

    * (Опционально) Включите [тестирование тега](test.md).

    {% note info %}

    Смысловому Pro-тегу по умолчанию присваиваются каналы `Оператор` и `Клиент` одновременно, изменить это нельзя.

    {% endnote %}

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

Новые теги будут применяться только к диалогам, загруженным после создания тегов. Нужные теги назначатся автоматически.