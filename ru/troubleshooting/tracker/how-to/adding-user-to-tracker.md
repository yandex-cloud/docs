# Как добавить пользователя в {{ tracker-name }}


## Описание сценария {#case-description}

Необходимо добавить пользователя в {{ tracker-name }}.

## Решение {#case-resolution}

Чтобы добавить пользователей в {{ tracker-name }}, необходимо добавить их в организацию по этой [инструкции](../../../tracker/add-users.md), а про добавление в {{ org-name }} можно прочитать [здесь](../../../organization/operations/add-account.md).

Чтобы добавить пользователя в {{ tracker-name }}, выполните следующие действия:

1. Войдите в аккаунт администратора или владельца организации.
1. Перейдите в сервис [{{ org-name }}](https://org.yandex.cloud/users).
1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.users }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
1. Введите адреса электронной почты пользователей Яндекса, которых вы хотите добавить в организацию, например `login@yandex.ru`.
1. Нажмите **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% note info %}

Добавление пользователей в организацию {{ yandex-360 }} осуществляется от имени администратора на этой [странице](https://admin.yandex.ru/users).

{% endnote %}