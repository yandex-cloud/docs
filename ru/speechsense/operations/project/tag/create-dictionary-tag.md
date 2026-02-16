---
title: Создать словарный тег
description: Следуя данной инструкции, вы сможете создать словарный тег проекта разными способами.
---

# Создать словарный тег

[Словарный тег](../../../concepts/tags.md#dictionary-tags) можно создать только в [проекте](../../../concepts/resources-hierarchy.md#project). Для этого нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

При создании словарного тега доступны следующие варианты:

* [создать новый тег](#new-tag);
* [продублировать существующий тег](#duplicate);
* [добавить зависимый тег](create-dependent-tag.md) для существующего тега.

## Создать тег {#new-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** нажмите кнопку ![icon](../../../../_assets/console-icons/tag.svg) **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
1. Выберите тип тега **{{ ui-key.yc-ui-talkanalytics.tags.tags-type.dictionary-key-value }}**.
1. Задайте параметры тега:

    * Укажите название тега.
    * (Опционально) Задайте описание тега.

    * {% include [select-channel](../../../../_includes/speechsense/tag/select-channel.md) %}
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}

    {% include [select-conditions](../../../../_includes/speechsense/tag/select-conditions.md) %}

    * (Опционально) Включите [тестирование тега](test.md).

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.

После создания тег активируется автоматически.

## Продублировать тег {#duplicate}

При дублировании настройки исходного тега присваиваются новому тегу, после чего можно изменить нужные настройки. Это удобно, если хотите создать тег с настройками, похожими на настройки созданного ранее тега.

Чтобы продублировать тег:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.tags.tags }}**.
1. В строке тега, который надо продублировать, нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/copy.svg) **{{ ui-key.yc-ui-talkanalytics.common.duplicate }}**.

    В открывшемся окне видно, что по умолчанию подставляются значения настроек, которые были заданы в исходном теге. Имя нового тега по умолчанию — `<имя_исходного_тега> копия`.

1. (Опционально) [Задайте настройки](#new-tag) тега. Их набор совпадает с настройками, которые задаются при создании тега с нуля.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.tags.create-tag-key-value }}**.
