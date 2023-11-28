## Пользователи с аккаунтом на Яндексе{#useraccount}

Если у сотрудников компании есть аккаунты на Яндексе (например, `{{ login-example }}`), они могут использовать эти аккаунты для доступа к сервисам {{yandex-cloud}}, подключенным к вашей организации.

Пользователя можно пригласить в организацию через консоль управления или сервис {{ org-full-name }}. Приглашение присоединиться к организации направляется пользователю на электронную почту.

### Отправьте приглашение {#send-invitation}

{% list tabs %}

- {{ org-name }}

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg).
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{login-example}}`).

        Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.

    1. Нажмите **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

- Консоль управления

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора облака.
    1. Войдите в [консоль управления]({{ link-console-main }}).
    1. В списке слева выберите нужное облако. Пример:

        ![image](../../_assets/resource-manager/switch-cloud-n-n.png)

    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. В правом верхнем углу нажмите на значок ![icon-users](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{login-example}}`).

        Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.

    1. Нажмите **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

{% endlist %}

Пользователь сможет войти в организацию, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. Для доступа к [сервисам](../../organization/concepts/manage-services.md#collaboration), которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

Удалить приглашение или отправить приглашение повторно можно только через {{ org-name }}.

### Удалите приглашение {#delete-invitation}

1. В разделе [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg) перейдите на вкладку **{{ ui-key.yacloud_org.page.users.label_tab-invitations }}** → **{{ ui-key.yacloud_org.entity.invitation.label_option-actual }}**.
1. В строке приглашения нажмите на значок ![icon-users](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-delete }}**.

### Отправьте приглашение повторно {#resend-invitation}

1. В разделе [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/console-icons/person.svg) перейдите на вкладку **{{ ui-key.yacloud_org.page.users.label_tab-invitations }}** → **{{ ui-key.yacloud_org.entity.invitation.label_option-actual }}**.
1. В строке приглашения нажмите на значок ![icon-users](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-resend }}**.

{% note info %}

{% include [yandex-account-2fa-warning.md](../iam/yandex-account-2fa-warning.md) %}

{% endnote %}