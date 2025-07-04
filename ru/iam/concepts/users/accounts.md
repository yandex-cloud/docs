# Аккаунты в {{ yandex-cloud }}

В {{ yandex-cloud }} используются [аккаунты на Яндексе](#passport), [сервисные аккаунты](#sa) и [федеративные аккаунты](#saml-federation).

{% note info %}

Платежный аккаунт не используется для управления ресурсами в {{ yandex-cloud }} и не относится к сервису {{ iam-short-name }}. Подробнее читайте в разделе [{#T}](../../../billing/concepts/billing-account.md) документации по сервису {{ billing-name }}.

{% endnote %}

## Аккаунт на Яндексе {#passport}

_Аккаунт на Яндексе_ — ваш аккаунт на [Яндексе](https://yandex.ru/support/passport/index.html) или в [Яндекс 360](https://360.yandex.ru/). Используйте этот тип аккаунта:

* Если для ваших программ не надо настраивать права доступа. Иначе используйте [сервисный аккаунт](#sa).
* Если  у вас небольшая команда и в вашей организации не настроена федерация удостоверений (например, Active Directory или Google Workspace). Иначе используйте [федеративные аккаунты](#saml-federation).

{% include [yandex-account-2fa-warning.md](../../../_includes/iam/yandex-account-2fa-warning.md) %}

### Примеры использования {#examples-passport}

* [{#T}](../../../tutorials/serverless/websocket-app.md)

## Федеративный аккаунт {#saml-federation}

_Федеративный аккаунт_ — это аккаунт пользователя из федерации удостоверений, например из Active Directory.

{% include [about-saml-federations](../../../_includes/iam/about-saml-federations.md) %}

Используйте федеративные аккаунты, если нужно предоставить доступ в {{ yandex-cloud }} множеству сотрудников.

Подробнее читайте в разделе [{#T}](../../../organization/concepts/add-federation.md).

### Примеры использования {#examples-saml-federation}

* [{#T}](../../../tutorials/security/vault-secret.md)

## Локальный пользователь {#local}

_Локальные пользователи_ привязаны только к [домену](../../../organization/concepts/domains.md), их учетные данные хранятся только в {{ yandex-cloud }} в рамках [пула пользователей](../../../organization/concepts/user-pools.md). Локальные пользователи создаются в пуле пользователей, существуют в рамках одной организации и не могут создать новую.

Локальные пользователи аутентифицируются в {{ yandex-cloud }} с помощью [Login Discovery](../../../organization/concepts/domains.md#login-discovery), не используя внешних провайдеров аутентификации.

## Сервисный аккаунт {#sa}

{% include [sa-def](../../_includes_service/sa-def.md) %}

Сервисные аккаунты позволяют гибко настроить права доступа к ресурсам и предотвратить операции, которые могут быть выполнены из-за слишком широкого набора прав. Используйте такой тип аккаунта для ваших приложений, CLI, {{ TF }} и API {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](service-accounts.md).

### Примеры использования {#examples-sa}

* [{#T}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
