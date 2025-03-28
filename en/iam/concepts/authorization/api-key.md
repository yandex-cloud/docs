---
title: API key
description: In this article, you will learn what an API key is, about its purpose, how to use it, and about the services supporting the API key authentication method.
---

# API key


The _API key_ is a secret key only used for simplified authorization of [service accounts](../users/service-accounts.md) with the {{ yandex-cloud }} API.

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

If someone might have gotten access to your private key, [delete it](../../operations/authentication/manage-api-keys.md#delete-api-key) and [create a new one](../../operations/authentication/manage-api-keys.md#create-api-key).

{% endnote %}

It is the user's responsibility to store the API key. {{ yandex-cloud }} provides access to an API key only during its creation. If the key is lost or damaged, you cannot restore it. In this case, you can [reissue](../../operations/compromised-credentials.md#api-key-reissue) the key or create a new one.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API keys with scope and validity limits {#scoped-api-keys}

You can [create](../../operations/authentication/manage-api-keys.md#create-api-key) API keys with an expiration date and a limited scope.

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

The scope limits the use of API keys in addition to the user's personal access permissions. Configuring scope limits and expiration dates will reduce the risk of unauthorized use of your keys.

{% include [scoped-api-keys-note](../../../_includes/iam/scoped-api-keys-note.md) %}

Available scopes are listed below:


* `yc.ai.foundationModels.execute`: To send requests to [{{ assistant-api }}](../../../foundation-models/assistants/api-ref/index.md), [Image Generation API](../../../foundation-models/image-generation/api-ref/index.md), [Text Generation API](../../../foundation-models/text-generation/api-ref/index.md), [{{ speechkit-name }} API](../../../speechkit/concepts/api.md), [{{ translate-full-name }} API](../../../translate/concepts/api.md), and [{{ vision-name }} API](../../../vision/ocr/api-ref/index.md).
* `yc.ai.imageGeneration.execute`: To send requests to image generation models in {{ foundation-models-full-name }} via the [Image Generation API](../../../foundation-models/image-generation/api-ref/index.md).
* `yc.ai.languageModels.execute`: To send requests to text generation models in {{ foundation-models-full-name }} via the [Text Generation API](../../../foundation-models/text-generation/api-ref/index.md).
* `yc.ai.speechkitStt.execute`: To [recognize speech](../../../speechkit/stt/index.md) via the [{{ speechkit-name }} API](../../../speechkit/concepts/api.md).
* `yc.ai.speechkitTts.execute`: To [synthesize speech](../../../speechkit/tts/index.md) via the [{{ speechkit-name }} API](../../../speechkit/concepts/api.md).
* `yc.ai.translate.execute`: To translate text via the [{{ translate-full-name }} API](../../../translate/concepts/api.md).
* `yc.ai.vision.execute`: To perform optical text recognition via the [{{ vision-name }} API](../../../vision/ocr/api-ref/index.md).
* `yc.monitoring.manage`: To view and write data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read`: To view data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.postbox.send`: To send emails via the [{{ postbox-name }}](../../../postbox/index.yaml) API.
* `yc.search-api.execute`: To send search queries to [{{ search-api-name }}](../../../search-api/api-ref/index.md).
* `yc.serverless.containers.invoke`: To invoke containers via the [{{ serverless-containers-short-name }} API](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke`: To invoke functions via the [{{ sf-short-name }} API](../../../functions/functions/api-ref/index.md).
* `yc.ydb.tables.manage`: For accessing {{ ydb-short-name }} in {{ PG }}-compatible mode.
* `yc.ydb.topics.manage`: For accessing the [Kafka API](../../../data-streams/kafkaapi/auth.md) in {{ yds-full-name }}.

## Using an API key {#use}

Enter your API key when accessing {{ yandex-cloud }} resources via the API. Provide the API key in the `Authorization` header in the following format:

```
Authorization: Api-Key <API_key>
```

## Services that support this authentication method {#supported-services}

The following services support authentication based on API keys:

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
* {{ yds-full-name }}: [Kafka API](../../../data-streams/kafkaapi/index.md).
* {{ ydb-full-name }}: Only in {{ PG }}-compatible mode. Use a suitable [authentication method](../../../ydb/operations/connection#auth) for other modes.
* [{{ metadata-hub-full-name }}](../../../metadata-hub/concepts/index.md): Within [{{ schema-registry-full-name }}](../../../metadata-hub/operations/connect-to-namespace.md).

#### See also {#see-also}

* [{#T}](../../operations/authentication/manage-api-keys.md#create-api-key)
* [{#T}](iam-token.md)
* [{#T}](./index.md)
