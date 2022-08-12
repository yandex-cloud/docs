# Добавить пользователя


## Добавить пользователя {% if product == "yandex-cloud" %}Яндекса{% endif %}{% if product == "cloud-il" %}Google{% endif %}{#add-user-account}

Если у сотрудников компании есть аккаунты {% if product == "yandex-cloud" %}на Яндексе (например, `{{login-example}}`){% endif %}{% if product == "cloud-il" %} в Google{% endif %}, они могут использовать эти аккаунты для доступа к сервисам {{yandex-cloud}}, подключенным к вашей организации.

{% note info %}

Добавить пользователя может администратор (роль `organization-manager.admin`) или владелец (роль `organization-manager.organizations.owner`) организации. Как назначить роль пользователю, читайте в разделе [Роли](roles.md#admin).

{% endnote %}

Чтобы добавить аккаунты сотрудников в организацию:

{% include [add-useraccount](../_includes/organization/add-useraccount.md) %}

{% note info %}

{% include [yandex-account-2fa-warning.md](../_includes/iam/yandex-account-2fa-warning.md) %}

{% endnote %}


## Добавить федеративных пользователей {#add-user-sso}

Если при [настройке федерации](add-federation.md#federation-usage) вы не включили опцию **Автоматически создавать пользователей**, федеративных пользователей нужно добавить в организацию вручную.

Для этого вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Чтобы добавить пользователей федерации в организацию:

{% include [add-federateduser](../_includes/organization/add-federateduser.md) %}


#### Что дальше {#what-is-next}

* [Назначьте роли добавленным пользователям](../iam/operations/roles/grant.md).
