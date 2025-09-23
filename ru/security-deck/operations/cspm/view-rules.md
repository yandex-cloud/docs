---
title: Просмотр правил контроля безопасности модуля {{ cspm-name }} в {{ sd-full-name }}
description: В данном разделе вы узнаете, как в модуле Контроль конфигурации ({{ cspm-name }}) {{ sd-full-name }} можно посмотреть действующие правила безопасности и узнать о нарушениях этих правил.
---

# Посмотреть правила контроля безопасности модуля {{ cspm-name }} и их нарушения

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [sd-usage-security-disclaimer](../../../_includes/security-deck/sd-usage-security-disclaimer.md) %}

{% include [cspm-use-in-workspaces](../../../_includes/security-deck/cspm-use-in-workspaces.md) %}

## Посмотреть общую информацию о правилах контроля безопасности {#general-info}

Чтобы посмотреть [общую информацию](../../concepts/cspm.md#general-info) о действующих правилах контроля безопасности модуля {{ cspm-name }} и случаях их нарушения:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}**. Открывшийся раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](../../concepts/workspace.md#standards).

      {% include [cspm-view-general-info](../../../_includes/security-deck/cspm-view-general-info.md) %}

{% endlist %}

## Посмотреть подробную информацию о правилах контроля безопасности {#detailed-info}

Чтобы посмотреть [подробную информацию](../../concepts/cspm.md#detailed-info) о конкретном правиле контроля безопасности модуля {{ cspm-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![file-text](../../../_assets/console-icons/file-text.svg) **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.
  1. В верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и выберите [окружение](../../concepts/workspace.md), для которого хотите посмотреть информацию о правилах. При необходимости воспользуйтесь поиском.
  1. На открывшейся странице **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** перейдите на вкладку **{{ ui-key.yacloud_org.security.controls.ControlsPageLayout.configuration_w7Kw7 }}**. Открывшийся раздел содержит список правил контроля, которые входят в состав заданных для текущего окружения [стандартов безопасности](../../concepts/workspace.md#standards).
  1. {% include [cspm-view-detailed-info](../../../_includes/security-deck/cspm-view-detailed-info.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](./manage-exceptions.md)
* [{#T}](../../concepts/cspm.md)
* [{#T}](../../concepts/workspace.md)