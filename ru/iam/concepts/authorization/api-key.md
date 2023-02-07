# API-ключ

_API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API {{ yandex-cloud }}. API-ключи используются только для [сервисного аккаунта](../users/service-accounts.md).

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/api-key/delete.md) и [создайте новый](../../operations/api-key/create.md).

{% endnote %}

Ключ пользователь хранит самостоятельно. {{ yandex-cloud }} дает доступ к ключу только в процессе создания API-ключа.
Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

## Использование токена {#use}

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```


## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

* [{{ speechkit-name }}](../../../speechkit/concepts/auth.md)
* [{{ translate-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-name }}](../../../vision/api-ref/authentication.md)


#### См. также {#see-also}

* [Как создать API-ключ](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)