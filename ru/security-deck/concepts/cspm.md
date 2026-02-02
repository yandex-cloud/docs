---
title: Контроль конфигурации ({{ cspm-name }}) в {{ sd-full-name }}
description: Контроль конфигурации ({{ cspm-name }}) контролирует соответствие облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}, комплексным требованиям и лучшим практикам в сфере безопасности.
---

# Контроль конфигурации ({{ cspm-name }})

{% include [note-preview](../../_includes/note-preview.md) %}

{% include [cspm-basic-intro](../../_includes/security-deck/cspm-basic-intro.md) %}

## Стандарты {#standards}

В настоящий момент модуль Контроль конфигурации ({{ cspm-name }}) поддерживает проверку инфраструктуры на соответствие следующим стандартам безопасности:

{% include [cspm-sec-standard-list](../../_includes/security-deck/cspm-sec-standard-list.md) %}

## Правила {#rules}

[Посмотреть](../operations/cspm/view-rules.md) сведения о действующих для [окружения](./workspace.md) правилах контроля безопасности модуля {{ cspm-name }} и об обнаруженных в инфраструктуре окружения нарушениях таких правил вы можете на странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** на вкладке **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}**. Этот раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](#standards).

### Общая информация о правилах {#general-info}

{% include [cspm-view-general-info](../../_includes/security-deck/cspm-view-general-info.md) %}

### Подробная информация о правиле {#detailed-info}

{% include [cspm-view-detailed-info](../../_includes/security-deck/cspm-view-detailed-info.md) %}

## Исключения из правил {#exceptions}

Исключения позволяют гибко настраивать, когда и для каких объектов нужно игнорировать результаты проверки на соответствие правилам контроля безопасности модуля {{ cspm-name }}. [Посмотреть список](../operations/cspm/manage-exceptions.md#view-exceptions-list) заданных для окружения исключений вы можете в [интерфейсе {{ sd-name }}]({{ link-sd-main }}) в разделе **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

При [создании исключения](../operations/cspm/manage-exceptions.md#create-exception) вы можете задать для него следующие настройки:

* **{{ ui-key.yacloud_org.security.controls.ExceptionOverview.info_type_1dxbZ }}** — вариант действия для создаваемого исключения:

    {% include [cspm-exception-types](../../_includes/security-deck/cspm-exception-types.md) %}

* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.scopeOfControl_aRkwB }}** — ресурсы, которые требуется исключить при проверке правил безопасности:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.allResources_2ax5E }}` — чтобы исключить из проверки все ресурсы, контролируемые в [окружении](./workspace.md).
    * `Выбранные ресурсы` — чтобы исключить из проверки только явно заданную часть ресурсов.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.section-title }}** — правила контроля безопасности модуля {{ cspm-name }}, для которых не должны проводиться проверки выбранных ресурсов:

    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_all }}` — чтобы исключить для выбранных ресурсов проверку на соответствие всем правилам безопасности.
    * `{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.ExceptionRulesSection.rules-select_option_selected }}` — чтобы исключить для выбранных ресурсов проверку на соответствие явно заданному набору правил.
* **{{ ui-key.yacloud_org.security.controls.ControlExceptionForm.section-title_3YcSF }}** — причина, по которой создается исключение. Указывается в свободной текстовой форме.

Чтобы отменить заданные исключением ограничения для проверок на соответствие правилам, [удалите](../operations/cspm/manage-exceptions.md#delete-exception) это исключение.

#### См. также {#see-also}

* [{#T}](./workspace.md)
* [{#T}](../operations/cspm/view-rules.md)
* [{#T}](../operations/cspm/manage-exceptions.md)