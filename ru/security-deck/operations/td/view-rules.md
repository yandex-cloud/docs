---
title: Просмотр правил контроля безопасности модуля {{ td-name }} в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в модуле {{ td-full-name }} ({{ td-name }}) {{ sd-full-name }} можно посмотреть действующие правила безопасности.
---

# Посмотреть правила контроля безопасности модуля {{ td-full-name }} ({{ td-name }})

{% include [td-use-in-workspaces](../../../_includes/security-deck/td-use-in-workspaces.md) %}

## Посмотреть общую информацию о правилах контроля безопасности {#general-info}

Чтобы посмотреть общую информацию о действующих правилах контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ td-full-name }}**. Открывшийся раздел содержит список правил контроля модуля {{ td-full-name }} для текущего окружения.

      {% include [td-view-general-info](../../../_includes/security-deck/td-view-general-info.md) %}

{% endlist %}

## Посмотреть подробную информацию о правилах контроля безопасности {#detailed-info}

Чтобы посмотреть подробную информацию о конкретном правиле контроля безопасности модуля {{ td-full-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ td-full-name }}**. Открывшийся раздел содержит список правил контроля модуля {{ td-full-name }} для текущего окружения.
  1. {% include [td-view-detailed-info](../../../_includes/security-deck/td-view-detailed-info.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./manage-exceptions.md)
* [{#T}](../../concepts/threat-detector.md)
* [{#T}](../../concepts/workspace.md)