---
title: API-ключ
description: Из статьи вы узнаете, что такое API-ключ, зачем он нужен, как использовать API-ключ и какие сервисы поддерживают этот способ аутентификации.
---

# API-ключ


_API-ключ_ — секретный ключ, используемый только для упрощенной аутентификации [сервисных аккаунтов](../users/service-accounts.md) в API {{ yandex-cloud }}.

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

Если кто-то мог узнать ваш секретный ключ, [удалите его](../../operations/authentication/manage-api-keys.md#delete-api-key) и [создайте новый](../../operations/authentication/manage-api-keys.md#create-api-key).

{% endnote %}

Пользователь самостоятельно хранит API-ключ. {{ yandex-cloud }} предоставляет доступ к API-ключу только в процессе его создания. Если ключ утрачен или поврежден, восстановить его нельзя. В этом случае вы можете [перевыпустить](../../operations/compromised-credentials.md#api-key-reissue) ключ или создать новый.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API-ключи с ограничениями области и срока действия {#scoped-api-keys}

При [создании](../../operations/authentication/manage-api-keys.md#create-api-key) API-ключа вы можете задать одну или несколько _областей действия_.

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

Область действия ограничивает применение API-ключей в дополнение к собственным правам доступа сервисного аккаунта. 

Дополнительно при создании API-ключа вы можете ограничить срок его действия. Настройка ограничений области и срока действия позволяет снизить риск несанкционированного использования ключей.

Доступные области действия:


* `yc.ai.foundationModels.execute` — для отправки запросов к [{{ assistant-api }}](../../../foundation-models/assistants/api-ref/index.md), [Image Generation API](../../../foundation-models/image-generation/api-ref/index.md), [Text Generation API](../../../foundation-models/text-generation/api-ref/index.md), [API {{ speechkit-name }}](../../../speechkit/concepts/api.md), [API {{ translate-full-name }}](../../../translate/concepts/api.md) и [{{ vision-name }} API](../../../vision/ocr/api-ref/index.md).
* `yc.ai.imageGeneration.execute` — для отправки запросов к моделям генерации изображений в сервисе {{ foundation-models-full-name }} через [Image Generation API](../../../foundation-models/image-generation/api-ref/index.md).
* `yc.ai.languageModels.execute` — для отправки запросов к моделям генерации текста в сервисе {{ foundation-models-full-name }} через [Text Generation API](../../../foundation-models/text-generation/api-ref/index.md).
* `yc.ai.speechkitStt.execute` — для [распознавания речи](../../../speechkit/stt/index.md) через [API {{ speechkit-name }}](../../../speechkit/concepts/api.md).
* `yc.ai.speechkitTts.execute` — для [синтеза речи](../../../speechkit/tts/index.md) через [API {{ speechkit-name }}](../../../speechkit/concepts/api.md).
* `yc.ai.translate.execute` — для перевода текста через [API {{ translate-full-name }}](../../../translate/concepts/api.md).
* `yc.ai.vision.execute` — для оптического распознавания текста с помощью [{{ vision-name }} API](../../../vision/ocr/api-ref/index.md).
* `yc.monitoring.manage` — для просмотра и записи данных в {{ monitoring-full-name }} через [API {{ monitoring-name }}](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read` — для просмотра данных в {{ monitoring-full-name }} через [API {{ monitoring-name }}](../../../monitoring/api-ref/index.md).
* `yc.postbox.send` — для отправки писем через API [{{ postbox-name }}](../../../postbox/index.yaml).
* `yc.search-api.execute` — для отправки поисковых запросов к [{{ search-api-name }}](../../../search-api/api-ref/index.md).
* `yc.serverless.containers.invoke` — для вызова контейнеров через [API {{ serverless-containers-short-name }}](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke` — для вызова функций через [API {{ sf-short-name }}](../../../functions/functions/api-ref/index.md).
* `yc.ydb.tables.manage` — для работы с {{ ydb-short-name }} в режиме совместимости с {{ PG }}.
* `yc.ydb.topics.manage` — для работы с [Kafka API](../../../data-streams/kafkaapi/auth.md) в {{ yds-full-name }}.

При создании API-ключа в [консоли управления]({{ link-console-main }}) область действия является обязательным параметром. При создании API-ключа с помощью [{{ yandex-cloud }} CLI](../../../cli/cli-ref/iam/cli-ref/api-key/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_api_key) или [API](../../api-ref/ApiKey/create.md) задавать область действия необязательно. Если область действия создаваемого API ключа не задана, ему будут по умолчанию назначены следующие области действия:

{% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

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
* [{{ serverless-containers-full-name }}](../../../serverless-containers/)
* [{{ speechkit-full-name }}](../../../{{ speechkit-slug }}/concepts/auth.md)
* [{{ speechsense-full-name }}](../../../speechsense/api-ref/authentication.md)
* [{{ translate-full-name }}](../../../translate/api-ref/authentication.md)
* [{{ vision-full-name }}](../../../vision/api-ref/authentication.md)
* {{ yds-full-name }} — [Kafka API](../../../data-streams/kafkaapi/index.md)
* {{ ydb-full-name }} — только в режиме совместимости с {{ PG }}. Для других режимов работы используйте соответствующий [способ аутентификации](../../../ydb/operations/connection#auth).
* [{{ metadata-hub-full-name }}](../../../metadata-hub/concepts/index.md) — в рамках [{{ schema-registry-full-name }}](../../../metadata-hub/operations/connect-to-namespace.md).

#### См. также {#see-also}

* [{#T}](../../operations/authentication/manage-api-keys.md#create-api-key)
* [{#T}](iam-token.md)
* [{#T}](./index.md)
