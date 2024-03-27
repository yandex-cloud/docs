# Как начать работать с {{ iam-short-name }}

Чтобы начать работу с сервисом {{ iam-short-name }}, добавьте пользователя в организацию и выдайте ему доступ к ресурсу в одном из ваших облаков. [Подробнее об организациях, ресурсах и пользователях](../overview/roles-and-resources.md).

## Перед началом работы {#before-you-begin}


1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. Убедитесь, что у вас есть нужные [роли](./concepts/access-control/roles.md):

    1. В консоли управления в списке слева выберите нужное облако. Пример:

        ![image](../_assets/resource-manager/switch-cloud-n-n.png)

    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. В строке поиска введите свою учетную запись.
    1. Проверьте, что для вашей учетной записи указаны роли:

        * владельца организации (`organization-manager.organizations.owner`) или администратора организации (`organization-manager.admin`);
        * владельца облака (`resource-manager.clouds.owner`) или администратора облака (`admin`).

1. На странице [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если пока нет пользователей, которых можно добавить в облако, [создайте новый аккаунт](https://passport.yandex.ru/registration) на Яндексе и предоставьте доступ в облако для этого аккаунта.



## Добавьте пользователя с аккаунтом на Яндексе в организацию {#add-organization-member}

{% list tabs group=instructions %}

- Консоль управления
  
    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора облака.
    1. Войдите в [консоль управления]({{ link-console-main }}).
    1. В списке слева выберите нужное облако.
    1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
    1. В правом верхнем углу нажмите на значок ![icon-users](../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_invite-users }}**.
    1. Введите почтовые адреса пользователей, которых вы хотите пригласить в организацию (например, `{{login-example}}`).

        {% include [send-invitation](../_includes/organization/send-invitation.md) %}

    1. Нажмите **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**.

{% endlist %}

Пользователь сможет войти в организацию, как только примет приглашение по ссылке из письма и выберет подходящий аккаунт для входа. Для доступа к [сервисам](../organization/concepts/manage-services.md#collaboration), которые подключены к организации, приглашенным пользователям достаточно войти в свой аккаунт на Яндексе.

## Назначьте пользователю роли {#assign-role}

Чтобы указать, какие операции можно выполнять пользователю, назначьте ему соответствующие роли. Например, разрешите ему просматривать ресурсы в облаке и управлять каталогом:

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Назначьте пользователю роль в облаке:
        
        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-viewer-cloud-console.md) %}

    1. Назначьте пользователю роль в каталоге:

        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-editor-folder-console.md) %}

{% endlist %}

## Отзовите назначенные роли {#revoke-roles}

Если назначенные роли больше не нужны, отзовите их:

{% list tabs group=instructions %}

- Консоль управления {#console}

    * Чтобы отозвать роль только в каталоге:

        {% include [update-access-binding-user-console-folder](../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * Чтобы отозвать роль в облаке:

        {% include [update-access-binding-user-console-cloud](../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

{% endlist %}

## Что дальше {#what-is-next}

* [Пошаговые инструкции](operations/index.md) помогут вам решить конкретные задачи, возникающие при использовании {{ iam-name }}.
* Прочитайте, [как устроено управление доступом в {{ yandex-cloud }}](concepts/access-control/index.md).
* Посмотрите [рекомендации по безопасному использованию {{ yandex-cloud }}](best-practices/using-iam-securely.md).
* Узнайте, [как начать работать с сервисом {{ org-name }}](../organization/quickstart.md).
* Узнайте, [как происходит аутентификация в {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Научитесь работать с сервисными аккаунтами](quickstart-sa.md).
* Посмотрите [ответы на часто задаваемые вопросы](qa/index.md).
