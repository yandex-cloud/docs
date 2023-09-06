{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора или владельца организации.
    1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
    1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.users }}]({{ link-org-users }}) ![icon-users](../../_assets/organization/icon-users.svg).
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
    1. Введите почтовые адреса пользователей Яндекса, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).
    1. Нажмите **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

    Чтобы присоединиться к организации, приглашенным пользователям необходимо:
    
    1. Перейти по ссылке в письме с приглашением и принять приглашение.
    1. Войти в организацию.

	Для доступа к [сервисам](../../organization/concepts/manage-services.md#collaboration), которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

{% endlist %}