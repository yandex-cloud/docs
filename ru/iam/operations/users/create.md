# Добавление пользователя в облако

Добавьте пользователя в вашу [организацию](../../../organization/), чтобы [дать](../../../iam/operations/roles/grant.md) ему доступ к ресурсам {{ yandex-cloud }}.

Добавить можно [пользователей с аккаунтом {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}](#passport-user) и [федеративных пользователей](#federated-user). Для этого нужно быть администратором (роль `organization-manager.admin`) или владельцем (роль `organization-manager.organizations.owner`) организации.

Пользователь станет участником организации, вы сможете дать ему доступ к ресурсам ваших облаков, [назначив](../roles/grant.md) ему [роль](../../concepts/access-control/roles.md). Новый участник организации не будет иметь доступа к ресурсам в облаках, пока вы не назначите ему роль.


## Добавьте пользователя с аккаунтом {% if product == "yandex-cloud" %}на Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %} {#add-useraccount}

Пользователя можно добавить в организацию через консоль управления или сервис {{ org-full-name }}. Эти способы равнозначны.


{% if product == "yandex-cloud" %}

### Добавьте пользователя из интерфейса {{ org-full-name }} {#organization-user}

{% endif %}

{% include [add-useraccount](../../../_includes/organization/add-useraccount.md) %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}


{% if product == "yandex-cloud" %}

### Добавьте пользователя через консоль управления {#console-user}

{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора облака.
    1. Войдите в [консоль управления]({{ link-console-main }}).
    1. [Выберите](../../../resource-manager/operations/cloud/switch-cloud.md) облако.
    1. Перейдите на вкладку **Права доступа**.
    1. Нажмите значок ![image](../../../_assets/options.svg) в правом верхнем углу страницы.
    1. Нажмите **Добавить пользователя**.
    1. Введите электронную почту пользователя {% if product == "yandex-cloud" %}в Яндексе{% endif %}{% if product == "cloud-il" %}Google{% endif %}.
    1. Нажмите кнопку **Добавить**.

{% endlist %}

{% endif %}


## Добавьте федеративных пользователей {#federated-user}

Для добавления федеративных пользователей вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основная электронная почта пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Чтобы добавить пользователей федерации в организацию:

{% include [add-federateduser](../../../_includes/organization/add-federateduser.md) %}


#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../roles/grant.md).
