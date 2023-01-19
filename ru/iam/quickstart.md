# Как начать работать с {{ iam-short-name }}

Сервис {{ iam-short-name }} позволяет вам управлять доступом к ресурсам {{ yandex-cloud }}.

По этой инструкции вы добавите пользователя в [организацию](../organization/) и дадите ему доступ к ресурсу в одном из ваших [облаков](../resource-manager/concepts/resources-hierarchy.md#cloud).

Для выполнения инструкции потребуются [роли](./concepts/access-control/roles.md):

* владельца (`organization-manager.organizations.owner`) или администратора (`organization-manager.admin`) организации;
* владельца (`resource-manager.clouds.owner`) или администратора (`admin`) облака.


## Перед началом {#before-you-begin}


1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если вам некого добавить в облако, вы можете [создать новый аккаунт](https://passport.yandex.ru/registration) на Яндексе и предоставить доступ в облако для этого аккаунта.



## Добавьте пользователя в организацию {#add-organization-member}

Вы можете добавить в организацию пользователя с аккаунтом на Яндексе или [федеративного](../organization/add-federation.md) пользователя.

Чтобы добавить пользователя с аккаунтом на Яндексе:

{% include [add-useraccount](../_includes/organization/add-useraccount.md) %}

{% note info %}

Так же вы можете добавить пользователя в организацию прямо со страницы облака в консоли управления. Подробнее в [инструкции](./operations/users/create.md#add-useraccount).

{% endnote %}

Чтобы дать пользователю доступ к ресурсу в облаке, назначьте ему роль на сам ресурс или на его контейнер, например на каталог.


## Назначьте пользователю роли {#assign-role}

Чтобы указать, какие операции можно выполнять пользователю, назначьте ему соответствующие роли. Например, разрешите ему просматривать ресурсы в облаке и управлять каталогом:

{% list tabs %}

- Консоль управления

    1. Назначьте пользователю роль в облаке:
        
        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-viewer-cloud-console.md) %}

    1. Назначьте пользователю роль в каталоге:

        {% include [set-accessbinding-user-editor-folder-console](../_includes/resource-manager/set-accessbinding-user-editor-folder-console.md) %}

{% endlist %}


## Отнимите назначенные роли {#revoke-roles}

Если назначенные роли больше не нужны, отнимите их:

{% list tabs %}

- Консоль управления

    * Чтобы отозвать роль только в каталоге:

        {% include [update-access-binding-user-console-folder](../_includes/resource-manager/update-access-binding-user-console-folder.md) %}

    * Чтобы отозвать роль в облаке:

        {% include [update-access-binding-user-console-cloud](../_includes/resource-manager/update-access-binding-user-console-cloud.md) %}

{% endlist %}


## Что дальше {#what-is-next}

* [Пошаговые инструкции](operations/index.md) помогут вам решить конкретные задачи, возникающие при использовании {{ iam-name }}.
* Прочитайте, [как устроено управление доступом в {{ yandex-cloud }}](concepts/access-control/index.md).
* Посмотрите [рекомендации по безопасному использованию {{ yandex-cloud }}](best-practices/using-iam-securely.md).
* Узнайте, как [происходит аутентификация в {{ yandex-cloud }}](concepts/authorization/index.md#authentication).
* [Научитесь работать с сервисными аккаунтами](quickstart-sa.md).
* Посмотрите [ответы на часто задаваемые вопросы](qa/index.md).
