---
title: API-ключ
description: Из статьи вы узнаете, что такое API-ключ, зачем он нужен, как использовать API-ключ и какие сервисы поддерживают этот способ аутентификации.
---

# API-ключ


_API-ключ_ — секретный ключ, используемый только для упрощенной авторизации [сервисных аккаунтов](../users/service-accounts.md) в API {{ yandex-cloud }}.

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/api-key/delete.md) и [создайте новый](../../operations/api-key/create.md).

{% endnote %}

Пользователь самостоятельно хранит API-ключ. {{ yandex-cloud }} предоставляет доступ к API-ключу только в процессе его создания. Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API-ключи с ограничениями области и срока действия {#scoped-api-keys}

Вы можете [создавать](../../operations/api-key/create.md) API-ключи с ограниченным сроком и областью действия.

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

Область действия ограничивает применение API-ключей в дополнение к собственным правам доступа пользователя. Настройка ограничений области и срока действия позволит снизить риск несанкционированного использования ключей.

{% include [scoped-api-keys-note](../../../_includes/iam/scoped-api-keys-note.md) %}

Доступные области действия:

* `yc.postbox.send` — для отправки писем через API [{{ postbox-name }}](../../../postbox/index.yaml).
* `yc.ydb.tables.manage` — для работы с {{ ydb-short-name }} в режиме совместимости с {{ PG }}.
* `yc.ydb.topics.manage` — для работы с [Kafka API](../../../data-streams/kafkaapi/auth.md) в {{ yds-full-name }}.

## Использование API-ключа {#use}

Полученный API-ключ указывайте при обращении к ресурсам {{ yandex-cloud }} через API. Передавайте API-ключ в заголовке `Authorization` в следующем формате:

```
Authorization: Api-Key <API-ключ>
```

## Сервисы, поддерживающие этот способ аутентификации {#supported-services}

API-ключи в качестве способа аутентификации поддерживаются в следующих сервисах:

* [{{ sf-full-name }}](../../../functions/operations/function/auth.md)
* [{{ ml-platform-full-name }}](../../../datasphere/api-ref/authentication.md)
* [{{ monitoring-full-name }}](../../../monitoring/api-ref/authentication.md)
* [{{ postbox-full-name }}](../../../postbox/api-ref/authentication.md)
* [{{ search-api-full-name }}](../../../search-api/operations/auth.md)
* {{ serverless-containers-full-name }} — [контейнеры](../../../serverless-containers/api-ref/containers/authentication.md) и [триггеры](../../../serverless-containers/api-ref/triggers/authentication.md)
* [{{ speechkit-full-name }}](../../../{{ speechkit-slug }}/concepts/auth.md)
* [{{ speechsense-full-name }}](../../../speechsense/api-ref/authentication.md)
* [{{ translate-full-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-full-name }}](../../../vision/api-ref/authentication.md)
* {{ yds-full-name }} — [Kafka API](../../../data-streams/kafkaapi/index.md)
* {{ ydb-full-name }} — только в режиме совместимости с {{ PG }}. Для других режимов работы используйте соответствующий [способ аутентификации](../../../ydb/operations/connection#auth).

#### См. также {#see-also}

* [{#T}](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)
