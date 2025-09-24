---
title: Удаление окружения {{ sd-full-name }}
description: Из этой инструкции вы узнаете, как удалить окружение в {{ sd-full-name }}.
---

# Удалить окружение {{ sd-name }}

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

Чтобы удалить [окружение](../../concepts/workspace.md) {{ sd-name }}:

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. На панели слева выберите ![sliders](../../../_assets/console-icons/sliders.svg) **{{ ui-key.yacloud_org.security-center.label_settings }}** и перейдите на вкладку **{{ ui-key.yacloud_org.security.settings.SettingsPageLayout.workspacesLabel_kZyU1 }}**.

      {% note tip %}

      Чтобы быстрее найти нужное окружение, воспользуйтесь фильтром.

      {% endnote %}

  1. В строке с нужным окружением нажмите значок ![ellipsis](../../../_assets/console-icons/ellipsis.svg) и выберите ![trash-bin](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.security.workspaces.WorkspaceResourcesForm.actionDelete }}**.
  1. В открывшемся окне подтвердите удаление. Для этого в текстовом поле введите имя удаляемого окружения и нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.

{% endlist %}

В результате окружение будет удалено без возможности восстановления. Все проверки согласно правилам контроля прекратятся, компоненты модулей {{ sd-name }} будут удалены. [Коннектор](../../concepts/workspace.md#connectors) и [приемник алертов](../../concepts/workspace.md#alert-sinks), использовавшиеся в окружении, будут сохранены.

#### См. также {#see-also}

* [{#T}](../../concepts/workspace.md)
* [{#T}](./create.md)
* [{#T}](./view-dashboard.md)
* [{#T}](./update.md)
* [{#T}](./manage-access.md)