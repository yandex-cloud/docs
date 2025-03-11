## Пользователи с аккаунтом на Яндексе {#useraccount}

Если у сотрудников компании есть аккаунты на Яндексе (например, `{{ login-example }}`), они могут использовать эти аккаунты для доступа к сервисам {{yandex-cloud}}, подключенным к вашей организации.

Пользователя можно пригласить в организацию через консоль управления или интерфейс {{ cloud-center }}. Приглашение присоединиться к организации направляется пользователю на электронную почту.

### Отправьте приглашение {#send-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [add-yandex-user](./add-yandex-user.md) %}

- Консоль управления {#console}

    1. Войдите в [консоль управления]({{ link-console-main }}) с учетной записью администратора облака.

    1. В списке слева выберите нужное облако. Пример:

        ![image](../../_assets/resource-manager/switch-cloud-n-n.png)

    1. В правом верхнем углу нажмите на значок ![icon-users](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.

    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{login-example}}`).

        Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.

    1. Нажмите **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

Пользователь сможет войти в организацию, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. Для доступа к сервисам, которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

Удалить приглашение или отправить приглашение повторно можно только в сервисе {{ org-name }}.

### Удалите приглашение {#delete-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. В центральной части экрана выберите вкладку **{{ ui-key.yacloud_org.users.title_invitations }}**.

  1. В строке с нужным приглашением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-delete }}**.

  1. В открывшемся окне подтвердите удаление.

{% endlist %}

### Отправьте приглашение повторно {#resend-invitation}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![icon-users](../../_assets/console-icons/person.svg) **{{ ui-key.yacloud_org.pages.users }}**.

  1. В центральной части экрана выберите вкладку **{{ ui-key.yacloud_org.users.title_invitations }}**.

  1. В строке с нужным приглашением нажмите значок ![ellipsis](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.invitation.label_row-action-resend }}**.

  1. В открывшемся окне подтвердите повторную отправку приглашения.

{% endlist %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../iam/yandex-account-2fa-warning.md) %}

{% endnote %}
