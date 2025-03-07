# Авторизация и аутентификация в {{ yandex-cloud }}

Когда пользователь выполняет операцию с ресурсом {{ yandex-cloud }}, {{ iam-short-name }} проверяет, обладает ли пользователь необходимыми разрешениями для этой операции.

Разрешения пользователи получают вместе с ролями на ресурсы. Подробнее о том, как назначаются роли и проверяется список разрешений, читайте в разделе [{#T}](../access-control/index.md).

## Аутентификация в {{ yandex-cloud }} {#authentication}

Перед авторизацией пользователь должен аутентифицироваться — войти под своим аккаунтом. Аутентификация происходит по-разному в зависимости от типа аккаунта и используемого интерфейса:

* [Аутентификация с аккаунтом на Яндексе](#passport)
* [Аутентификация сервисного аккаунта](#sa)
* [Аутентификация федеративного пользователя](#saml-federation)

### Аутентификация с аккаунтом на Яндексе {#passport}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Аутентификация происходит автоматически, когда вы входите в аккаунт Яндекса или Яндекс 360.


- CLI {#cli}

  Чтобы выполнять операции в CLI, аутентифицируйтесь по [инструкции](../../../cli/operations/authentication/user.md). После этого аутентификация будет происходить автоматически.


- API {#api}

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  Чтобы выполнять операции в API:
  
  1. [Получите IAM-токен](../../operations/iam-token/create.md) в обмен на [OAuth-токен](oauth-token.md).
  1. {% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

     {% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endlist %}

### Аутентификация сервисного аккаунта {#sa}

{% list tabs group=instructions %}

- CLI {#cli}

  Чтобы выполнять операции в CLI, аутентифицируйтесь по [инструкции](../../../cli/operations/authentication/service-account.md). После этого аутентификация будет происходить автоматически.

- API {#api}

  Есть 3 способа выполнять операции от имени сервисного аккаунта:

  * С помощью [IAM-токена](iam-token.md).

      Это рекомендуемый способ аутентификации, но у IAM-токена короткое [время жизни](iam-token.md#lifetime). Поэтому такой способ подойдет для приложений, которые будут запрашивать IAM-токен автоматически.

    [Инструкция получения IAM-токена](../../operations/iam-token/create-for-sa.md).
  * С помощью [API-ключей](api-key).

      {% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

      [Инструкция получения API-ключа](../../operations/authentication/manage-api-keys.md#create-api-key).
  * С помощью [статических ключей доступа](access-key.md). Этот способ необходимо использовать в сервисах с AWS-совместимым API, например в {{ objstorage-name }} и {{ message-queue-name }}.

      [Инструкция получения статического ключа доступа](../../operations/authentication/manage-access-keys.md#create-access-key).

{% endlist %}

### Аутентификация федеративного пользователя {#saml-federation}

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [federated-user-auth](../../../_includes/iam/federated-user-auth.md) %}

  То, как выглядит процесс аутентификации для федеративного пользователя — зависит от настроек сервера IdP. Подробнее читайте в разделе [{#T}](../../../organization/concepts/add-federation.md).

- CLI {#cli}

  Чтобы выполнять операции в CLI, аутентифицируйтесь по [инструкции](../../../cli/operations/authentication/federated-user.md).

  {% include [include](../../../_includes/cli/success-auth-via-federation.md) %}

{% endlist %}

#### См. также {#see-also}

[{#T}](../users/accounts.md)