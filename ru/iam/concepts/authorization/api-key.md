# API-ключ

_API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API Яндекс.Облака. API-ключи используются только для [сервисного аккаунта](../users/service-accounts.md).

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/api-key/delete.md) и [создайте новый](../../operations/api-key/create.md).

{% endnote %}

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

О том, как использовать API-ключ для аутентификации, читайте в документации сервисов, поддерживающих этот способ авторизации:

* [{{ speechkit-name }}](../../../speechkit/concepts/auth.md)
* [{{ translate-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-name }}](../../../vision/api-ref/authentication.md)

#### См. также

* [Как создать API-ключ](../../operations/api-key/create.md)
* [#T](iam-token.md)
* [#T](index.md)