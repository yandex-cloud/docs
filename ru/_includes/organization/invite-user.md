{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Введите почтовые адреса пользователей Яндекса, которых вы хотите добавить в организацию (например, `{{ login-example }}`).
    1. Нажмите **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

    После получения письма с приглашением пользователь должен:
    
    1. Перейти по ссылке и принять приглашение.
    1. Войти в организацию.

    Для доступа к [сервисам](../../organization/concepts/manage-services.md#collaboration), которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

    #### Удалить приглашение {#deletу-invitation}

    Чтобы удалить приглашение:

    1. В разделе [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg) перейдите на вкладку **{{ ui-key.yacloud_org.page.users.label_tab-invitations }}** → **{{ ui-key.yacloud_org.entity.invitation.label_option-actual }}**.
    1. В строке приглашения нажмите значок ![icon-users](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-delete }}**.

    #### Отправить приглашение повторно {#resend -invitation}

    Если необходимо отправить приглашение повторно:

    1. В разделе [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg) перейдите на вкладку **{{ ui-key.yacloud_org.page.users.label_tab-invitations }}** → **{{ ui-key.yacloud_org.entity.invitation.label_option-actual }}**.
    1. В строке приглашения нажмите значок ![icon-users](../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-resend }}**.

{% endlist %}