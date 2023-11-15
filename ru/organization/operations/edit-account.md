---
title: "Удалить аккаунт пользователя в {{ org-full-name }}"
description: "Из этой статьи вы узнаете, как удалить аккаунт пользователя в {{ org-name }}."
---

# Удалить аккаунт пользователя

{% note info %}

Удалить аккаунт может пользователь с ролью `organization-manager.admin` или `organization-manager.organizations.owner`. О том, как назначить пользователю роль, читайте в разделе [Роли](../security/index.md#admin).

{% endnote %}

1. [Войдите в аккаунт]({{link-passport-login}}) администратора или владельца организации.

1. Перейдите в сервис [{{org-full-name}}]({{link-org-main}}).

1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{link-org-users}}) ![icon-users](../../_assets/organization/icon-users.svg).

1. Выберите сотрудника из списка или воспользуйтесь строкой поиска вверху страницы.

1. В строке сотрудника нажмите значок ![icon-context-menu](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.remove }}**.
