---
title: '{{ td-full-name }} ({{ td-name }}) в {{ sd-full-name }}'
description: Модуль {{ td-full-name }} ({{ td-name }}) позволяет в автоматическом режиме обнаруживать подозрительную активность в облачной инфраструктуре.
---

# {{ td-full-name }} ({{ td-name }})

{% include [td-basic-intro](../../_includes/security-deck/td-basic-intro.md) %}

{% note info %}

Для корректной работы модуля {{ td-full-name }} [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), привязанному к [коннектору](./workspace.md#connectors) окружения, должна быть [назначена](../../iam/operations/sa/assign-role-for-sa.md) роль `threat-detector.worker` или выше на контролируемые в окружении ресурсы.

{% endnote %}

## Правила {#rules}

[Посмотреть](../operations/td/view-rules.md) сведения о правилах контроля безопасности модуля {{ td-full-name }} вы можете на странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** на вкладке **Обнаружение угроз**.

## Исключения из правил {#exceptions}

Исключения позволяют гибко настраивать, когда и для каких объектов нужно игнорировать результаты проверки на соответствие правилам контроля безопасности модуля {{ td-full-name }}. [Посмотреть список](../operations/td/manage-exceptions.md#view-exceptions-list) заданных для окружения исключений вы можете в [интерфейсе {{ sd-name }}]({{ link-sd-main }}) в разделе **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

#### См. также {#see-also}

* [{#T}](./workspace.md)
* [{#T}](./alerts.md)
* [{#T}](../operations/td/view-rules.md)
* [{#T}](../operations/td/manage-exceptions.md)