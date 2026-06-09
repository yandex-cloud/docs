# Как начать работать с {{ iam-short-name }}

Чтобы начать работу с сервисом {{ iam-short-name }}, добавьте пользователя в организацию и выдайте ему доступ к ресурсу в одном из ваших облаков. [Подробнее об организациях, ресурсах и пользователях](../overview/roles-and-resources.md).

## Перед началом работы {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. Убедитесь, что у вас есть нужные [роли](concepts/access-control/roles.md):

    1. В консоли управления на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. В строке поиска введите свою учетную запись.
    1. Проверьте, что для вашей учетной записи указаны роли:

        * владельца организации (`organization-manager.organizations.owner`) или администратора организации (`organization-manager.admin`);
        * владельца облака (`resource-manager.clouds.owner`) или администратора облака (`admin`).

1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если пока нет пользователей, которых можно добавить в облако, [создайте новый аккаунт](https://passport.yandex.ru/registration) на Яндексе и предоставьте доступ в облако для этого аккаунта.

## Добавьте пользователя с аккаунтом на Яндексе в организацию {#add-organization-member}

{% list tabs group=instructions %}

- Консоль управления {#console}
  
    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора облака.
    1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. В правом верхнем углу нажмите на значок ![icon-users](../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{ login-example }}`).

        Приглашения можно отправлять на любые адреса электронной почты. Приглашенный пользователь сможет выбрать нужный аккаунт на Яндексе, когда примет приглашение.

    1. Нажмите **{{ ui-key.yacloud_components.organization.action_send-invitation }}**.

{% endlist %}

Пользователь сможет войти в организацию, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. Для доступа к сервисам, которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

## Назначьте пользователю роли {#assign-role}

Чтобы указать, какие операции можно выполнять пользователю, назначьте ему соответствующие роли. Например, разрешите ему просматривать ресурсы в облаке и управлять каталогом:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Назначьте пользователю роль в облаке:
        
        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
        1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.user-accounts }}**.
        1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
        1. Нажмите кнопку ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
        1. Выберите роль `resource-manager.viewer`. Эта роль позволяет читать информацию об облаке, в том числе список прав доступа.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

    1. Назначьте пользователю роль в каталоге:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../resource-manager/concepts/resources-hierarchy.md#folder).
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
        1. В открывшемся окне выберите раздел **{{ ui-key.yacloud_components.acl.label.user-accounts }}**.
        1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
        1. Нажмите кнопку ![image](../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
        1. Выберите роль `resource-manager.editor`. Эта роль позволяет читать информацию о каталоге, в том числе список прав доступа, редактировать и удалить каталог.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

## Отзовите назначенные роли {#revoke-roles}

Если назначенные роли больше не нужны, отзовите их:

{% list tabs group=instructions %}

- Консоль управления {#console}

    * Чтобы отозвать роль только в каталоге:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../resource-manager/concepts/resources-hierarchy.md#folder).
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
        1. Нажмите значок ![image](../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

    * Чтобы отозвать роль в облаке:

        1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![image](../_assets/console-icons/layout-side-content-left.svg) или ![image](../_assets/console-icons/chevron-down.svg) и выберите нужное облако.
        1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
        1. Выберите пользователя в списке и нажмите значок ![image](../_assets/console-icons/ellipsis.svg) напротив имени пользователя.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.edit-roles }}**.
        1. Нажмите значок ![image](../_assets/console-icons/xmark.svg) напротив роли, которую хотите отозвать.
        1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.

{% endlist %}

## Что дальше {#what-is-next}

* [Пошаговые инструкции](operations/index.md) помогут вам решить конкретные задачи, возникающие при использовании {{ iam-name }}.
* Прочитайте, [как устроено управление доступом в {{ yandex-cloud }}](concepts/access-control/index.md).
* Посмотрите [рекомендации по безопасному использованию {{ yandex-cloud }}](best-practices/using-iam-securely.md).
* Узнайте, [как начать работать с сервисом {{ org-full-name }}](../organization/quickstart.md).
* Узнайте, [как происходит аутентификация в {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Научитесь работать с сервисными аккаунтами](quickstart-sa.md).
* Используйте [чеклист безопасности аутентификации и авторизации](../security/domains/iam-checklist.md).
* Посмотрите [ответы на часто задаваемые вопросы](qa/index.md).