---
title: Создание окружения в {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как в {{ sd-full-name }} создать окружение для контроля соответствия облачной инфраструктуры отраслевым стандартам.
---

# Создать окружение {{ sd-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [sd-usage-security-disclaimer](../../../_includes/security-deck/sd-usage-security-disclaimer.md) %}

Чтобы создать [окружение](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. Если у вас еще нет окружений, нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceSelect.create_action }}**.

      Если у вас уже есть окружение и вы хотите создать еще одно окружение в дополнение к уже имеющемуся, в верхней части окна нажмите кнопку **{{ ui-key.yacloud_components.cloud-center.action_more }}** ![chevron-down](../../../_assets/console-icons/chevron-down.svg) и нажмите **{{ ui-key.yacloud_org.security.workspaces.WorkspaceSelect.create_action }}**.
  1. {% include [workspace-create-step1](../../../_includes/security-deck/workspace-create-step1.md) %}
  1. {% include [workspace-create-step2](../../../_includes/security-deck/workspace-create-step2.md) %}
  1. {% include [workspace-create-step3](../../../_includes/security-deck/workspace-create-step3.md) %}
  1. {% include [workspace-create-step4](../../../_includes/security-deck/workspace-create-step4.md) %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)