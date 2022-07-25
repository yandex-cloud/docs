# Как начать работать c {{ iam-short-name }}

Сервис {{ iam-short-name }} позволяет вам управлять доступом к ресурсам.

Эта инструкция для [владельцев](../resource-manager/concepts/resources-hierarchy.md#owner) и [администраторов](concepts/access-control/roles.md#admin) облака. Вы научитесь:

* [добавлять пользователей в свое облако](#add-user);
* [назначать пользователям роли](#assign-role);
* [отнимать назначенные роли](#revoke-roles).

## Перед началом {#before-you-begin}

1. Войдите в [консоль управления]({{ link-console-main }}). Если вы еще не зарегистрированы, перейдите в консоль управления и следуйте инструкциям.
{% if product == "yandex-cloud" %}
1. [На странице биллинга]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../billing/concepts/billing-account.md) и он находится в статусе `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../billing/quickstart/index.md#create_billing_account).
1. Если вам некого добавить в облако, вы можете {% if product == "yandex-cloud" %}[создать новый аккаунт](https://passport.yandex.ru/registration) на Яндексе{% endif %}{% if product == "cloud-il" %}[создать новый аккаунт](https://support.google.com/accounts/answer/27441) Google{% endif %} предоставить доступ в облако для этого аккаунта.
{% endif %}

## Добавьте нового пользователя в облако {#add-user}
{% if product == "yandex-cloud" %}

Чтобы предоставить доступ к ресурсам облака пользователю с аккаунтом {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}:

1. [Войдите в аккаунт]({{ link-passport-login }}) администратора облака.
1. [Выберите](../resource-manager/operations/cloud/switch-cloud.md) облако.
1. Перейдите на вкладку [Права доступа]({{ link-console-cloud }}?section=resource-acl).
1. Нажмите значок ![image](../_assets/options.svg) в правом верхнем углу страницы.
1. Нажмите **Добавить пользователя**.
1. Введите электронную почту пользователя {% if product == "yandex-cloud" %}в Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}.
1. Нажмите кнопку **Добавить пользователя**.

После этого пользователь получит роль [роль участника облака](../iam/concepts/access-control/roles.md#member) — `{{ roles-cloud-member }}`. Эта роль необходима пользователю для доступа к ресурсам в облаке. Однако она не дает права выполнять какие-либо операции и используется только в сочетании с другими ролями, например с ролями `admin`, `editor` или `viewer`.

Вы также можете добавить пользователя, используя сервис [{{ org-full-name }}](./operations/users/create.md#passport-user).

{% endif %}
{% if product == "cloud-il" %}

Вы можете добавить пользователя в облако, используя сервис [{{ org-full-name }}](./operations/users/create.md#passport-user).

{% endif %}
## Назначьте пользователю роли {#assign-role}

Чтобы указать, какие операции можно выполнять пользователю, назначьте ему соответствующие роли. Например, разрешите ему просматривать ресурсы в облаке и управлять ресурсами в каталоге:

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
