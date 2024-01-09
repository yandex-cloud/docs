---
title: "Инструкция по изменению организации для облака в {{ resmgr-full-name }}"
description: "Из статьи вы узнаете, как изменить организацию для облака в {{ resmgr-full-name }}."
---

# Изменение организации для облака

Если в вашем аккаунте зарегистрировано несколько организаций, вы можете переносить облака из одной организации в другую.

{% note info %}

В новую организацию необходимо вручную [добавить](../../../organization/operations/add-account.md) всех пользователей, для которых в исходной организации назначены роли на переносимое облако, каталоги или ресурсы. При этом сами роли будут перенесены в новую организацию автоматически.

{% endnote %}


Чтобы перенести облако в другую организацию, у вас должна быть роль `{{ roles-organization-owner }}` на организацию и `{{ roles-cloud-owner }}` на облако. О том, как назначить пользователю роль, читайте в разделах [Роли на облако](set-access-bindings.md#access-to-user) и [Роли на организацию](../../../organization/security/index.md#add-role).

{% list tabs group=instructions %}

- Консоль управления {#console}



  1. В [консоли управления]({{ link-console-main }}) выберите нужное облако.
  1. В правом верхнем углу нажмите кнопку ![***](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.component.console-dashboard.button_action-change-org }}**.
  1. Выберите новую организацию из списка и нажмите **{{ ui-key.yacloud.iam.cloud.change-org.button_change }}**.

- API {#api}

  Сейчас нет возможности изменить назначенную облаку организацию с помощью API.

{% endlist %}

## См. также {#see-also}

* [{#T}](../../../organization/operations/leave-organization.md)
* [{#T}](../../../organization/concepts/manage-services.md)
