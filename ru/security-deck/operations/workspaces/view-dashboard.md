---
title: Просмотр операций и обзор окружения {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как посмотреть дашборд окружения и операции с ним в {{ sd-full-name }}.
---

# Посмотреть дашборд и операции с окружением {{ sd-name }}

{% include [note-preview](../../../_includes/note-preview.md) %}

## Посмотреть дашборд {#view-dashboard}

Чтобы посмотреть [дашборд окружения](../../concepts/workspace.md#dashboard) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. В верхней части окна выберите нужное [окружение](../../concepts/workspace.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.overview_tab }}**.

      На открывшемся дашборде будет отображена основная информация о результатах проверок безопасности в выбранном окружении. В зависимости от настроенных в окружении модулей {{ sd-name }} дашборд содержит карточки с общими сведениями:

      {% include [dashboard-contents](../../../_includes/security-deck/dashboard-contents.md) %}

{% endlist %}

## Посмотреть операции {#view-operations}

Чтобы посмотреть список операций с [окружением](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. В верхней части окна выберите нужное окружение.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.security.workspaces.WorkspacePageLayout.operations_tab }}**.

      На открывшейся странице отобразится список с операциями, выполненными и выполняемыми с выбранным окружением. Список операций содержит следующую информацию об операциях:

      * статус;
      * идентификатор;
      * логин пользователя, инициировавшего операцию;
      * описание операции;
      * дату и время начала выполнения операции;
      * дату и время изменения статуса операции;
      * сообщение об ошибке, если операция завершилась ошибкой.

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)