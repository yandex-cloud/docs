---
title: "Удалить организацию в {{ org-full-name }}"
description: "Из этой статьи вы узнаете, как удалить организацию в {{ org-name }}." 
---

# Удалить организацию

{% note info %}

Удалить организацию может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. Как назначить роль пользователю, читайте в разделе [Роли](../security/index.md#admin).

Перед удалением организации [удалите](../../resource-manager/operations/cloud/delete.md) из нее все облака.

{% endnote %}

Чтобы удалить организацию:

1. Войдите в [{{org-full-name}}]({{link-org-main}}) под аккаунтом администратора или владельца организации.

1. В левом нижнем углу нажмите на фото профиля и выберите организацию, которую нужно удалить.

1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.settings }}]({{link-org-settings}}) ![icon-settings](../../_assets/console-icons/circle-info.svg).

1. В правом верхнем углу нажмите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.

1. Укажите, когда следует удалить организацию. Выберите один из возможных периодов или `Удалить сейчас`. Срок удаления организации по умолчанию — 7 дней.

1. Нажмите кнопку **{{ ui-key.yacloud.common.delete }}**.
