---
title: Изменить смысловой тег
description: Следуя данной инструкции, вы сможете изменить смысловой тег проекта.
---

# Изменить смысловой тег

При работе со [смысловым тегом](../../../concepts/tags.md#sense-tags) проекта можно:

* [изменить его настройки](#edit);
* [активировать или деактивировать тег](#activate-tag).

Для изменения тега проекта нужна роль `{{ roles-speechsense-admin }}` или `{{ roles-speechsense-editor }}` в проекте.

{% include [after-changing-tags](../../../../_includes/speechsense/tag/after-changing-tags.md) %}

## Изменить настройки тега {#edit}

1. Откройте [главную страницу]({{ link-speechsense-main }}) {{ speechsense-name }}.
1. Перейдите в нужное пространство, затем выберите проект.
1. На вкладке **{{ ui-key.yc-ui-talkanalytics.tags.tags }}** откройте нужный тег и нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.edit }}**.
1. В открывшемся окне измените нужные настройки:

    * Введите название и описание тега.
    * {% include [select-tag-color](../../../../_includes/speechsense/tag/select-tag-color.md) %}
    * {% include [select-critical-tag](../../../../_includes/speechsense/tag/select-critical-tag.md) %}
    * {% include [data-analisys](../../../../_includes/speechsense/tag/data-analysis.md) %}
    * Включите [тестирование тега](test.md).

1. Нажмите кнопку **{{ ui-key.yc-ui-talkanalytics.common.save }}**.

## Активировать или деактивировать тег {#activate-tag}

{% include notitle [activation](../../../../_includes/speechsense/tag/activation.md) %}
