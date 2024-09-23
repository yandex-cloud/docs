# API-ключ


_API-ключ_ — секретный ключ, используемый для упрощенной авторизации в API {{ yandex-cloud }}. API-ключи используются только для авторизации [сервисного аккаунта](../users/service-accounts.md).

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/api-key/delete.md) и [создайте новый](../../operations/api-key/create.md).

{% endnote %}

Пользователь самостоятельно хранит API-ключ. {{ yandex-cloud }} предоставляет доступ к API-ключу только в процессе его создания. Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API-ключи с ограничениями области и срока действия {#scoped-api-keys}

Вы можете создавать API-ключи с ограниченной областью и сроком действия. Это позволит снизить риск несанкционированного использования ключей.

Создание таких ключей доступно для управления таблицами и топиками {{ ydb-full-name }} (`yc.ydb.tables.manage` и `yc.ydb.topics.manage`).

## Использование API-ключа {#use}

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передавайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

API-ключи в качестве способа аутентификации поддерживают несколько сервисов:

* [{{ sf-full-name }}](../../../functions/operations/function/auth.md)
* [{{ ml-platform-full-name }}](../../../datasphere/api-ref/authentication.md)
* [{{ search-api-full-name }}](../../../search-api/operations/auth.md)
* [{{ speechkit-full-name }}](../../../{{ speechkit-slug }}/concepts/auth.md)
* [{{ speechsense-full-name }}](../../../speechsense/api-ref/authentication.md)
* [{{ translate-full-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-full-name }}](../../../vision/api-ref/authentication.md)


#### См. также {#see-also}

* [{#T}](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)