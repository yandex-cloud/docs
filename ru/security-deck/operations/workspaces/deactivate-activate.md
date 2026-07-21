---
title: Деактивировать и активировать окружение {{ sd-full-name }}
description: Следуя данной инструкции, вы сможете деактивировать и активировать окружение в {{ sd-full-name }}.
---

# Деактивировать и активировать окружение

## Деактивируйте окружение {#deactivate}

Чтобы приостановить проверки безопасности, деактивируйте окружение:

{% include [workspace-after-deactivation](../../../_includes/security-deck/workspace-after-deactivation.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. В верхней части окна выберите нужное [окружение](../../concepts/workspace.md).
  1. Справа от имени окружения нажмите ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![alt text](../../../_assets/console-icons/ban.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceActionsMenu.stop_wvkkb }}**.
  1. В открывшемся окне подтвердите деактивацию.

{% endlist %}

## Активируйте окружение {#activate}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![vector-circle](../../../_assets/console-icons/vector-circle.svg) **{{ ui-key.yacloud_org.app.security.label_workspace_12Kax }}**.
  1. В верхней части окна выберите нужное окружение.
  1. Нажмите кнопку **{{ ui-key.yacloud_org.security.workspaces.WorkspaceInactiveAlert.activate_Y5mCr }}**.
  1. В открывшемся окне подтвердите активацию.

{% endlist %}

#### Полезные ссылки {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./update.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./manage-access.md)
* [{#T}](./delete.md)