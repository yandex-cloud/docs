# API-ключ

_API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API Яндекс.Облака. API-ключи используются только для [сервисного аккаунта](../users/service-accounts.md).

[!INCLUDE [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md)]

> [!WARNING]
>
> Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/api-key/delete.md) и [создайте новый](../../operations/api-key/create.md).

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

О том, как использовать API-ключ для аутентификации, читайте в документации сервисов, поддерживающих этот способ авторизации:

* [[!KEYREF speechkit-name]](../../../speechkit/concepts/auth.md)
* [[!KEYREF translate-name]](../../../translate/api-ref/authentication.md)
* [[!KEYREF vision-name]](../../../vision/api-ref/authentication.md)

#### См. также

* [Как создать API-ключ](../../operations/api-key/create.md)
* [[!TITLE]](iam-token.md)
* [[!TITLE]](index.md)