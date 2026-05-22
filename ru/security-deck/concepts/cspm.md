---
title: Контроль конфигурации ({{ cspm-name }}) в {{ sd-full-name }}
description: Контроль конфигурации ({{ cspm-name }}) контролирует соответствие облачной инфраструктуры и приложений, развернутых на платформе {{ yandex-cloud }}, комплексным требованиям и лучшим практикам в сфере безопасности.
---

# Контроль конфигурации ({{ cspm-name }})

{% include [note-preview](../../_includes/note-preview.md) %}

{% include [cspm-basic-intro](../../_includes/security-deck/cspm-basic-intro.md) %}

Проверка возобновляется каждые 8 часов. По завершении обновляются данные о количестве нарушений, применяются созданные исключения и отправляются алерты.

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

{% include [manage-exceptions-instruction](../../_includes/security-deck/manage-exceptions-instruction.md) %}

Чтобы отменить заданные исключением ограничения для проверок на соответствие правилам, [удалите](../operations/cspm/manage-exceptions.md#delete-exception) это исключение.

#### См. также {#see-also}

* [{#T}](./workspace.md)
* [{#T}](../operations/cspm/view-rules.md)
* [{#T}](../operations/cspm/manage-exceptions.md)