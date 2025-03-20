---
title: Изменить словарный тег
description: Следуя данной инструкции, вы сможете изменить словарный тег проекта.
---

# Изменить словарный тег

При работе со [словарным тегом](../../../concepts/tags.md#dictionary-tags) проекта можно:

* [изменить его настройки](#edit);
* [активировать или деактивировать тег](#activate-tag);
* [изменить канал тега](#tag-channel).

Для изменения тега проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

{% include [after-changing-tags](../../../../_includes/speechsense/tag/after-changing-tags.md) %}

## Изменить настройки тега {#edit}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.dialogs.classifiers }}** откройте нужный тег и нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. В открывшемся окне измените нужные настройки:

    * Введите название и описание тега.

    * {% include [select-channel](../../../../_includes/speechsense/tag/select-channel.md) %}
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}

    {% include [select-conditions](../../../../_includes/speechsense/tag/select-conditions.md) %}

    * Включите [тестирование тега](test.md).

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Активировать или деактивировать тег {#activate-tag}

{% include notitle [activation](../../../../_includes/speechsense/tag/activation.md) %}

## Изменить канал тега {#tag-channel}

### Изменить канал одного тега {#single-tag}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.tags.tags }}**.
1. В строке нужного тега нажмите ![icon](../../../../_assets/console-icons/ellipsis.svg), затем ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yc-ui-talkanalytics.tags.change-channel }}**.
1. Укажите канал в зависимости от того, где {{ speechsense-name }} должен искать ключевые слова тега:

    * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator-and-client }}** — во всем диалоге;
    * **{{ ui-key.yc-ui-talkanalytics.tags.channel.operator }}** — только в речи или сообщениях оператора;
    * **{{ ui-key.yc-ui-talkanalytics.tags.channel.client }}** — только в речи или сообщениях клиента.

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

### Изменить канал нескольких тегов {#multiple-tags}

Вы можете изменить канал нескольких тегов одновременно:

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. Перейдите на вкладку **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** и выберите нужные теги.
1. Во всплывающем окне нажмите кнопку ![icon](../../../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yc-ui-talkanalytics.tags.change-channel }}**.
1. Укажите канал для каждого тега. Если для всех тегов нужен один канал, выберите его в поле **{{ ui-key.yc-ui-talkanalytics.tags.new-channel }}** над списком тегов.
1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.
