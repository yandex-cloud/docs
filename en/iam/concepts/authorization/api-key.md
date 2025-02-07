---
title: API key
description: In this article, you will learn what an API key is, about its purpose, how to use it, and about the services supporting the API key authentication method.
---

# API key


The _API key_ is a secret key only used for simplified authorization of [service accounts](../users/service-accounts.md) with the {{ yandex-cloud }} API.

{% include [api-keys-disclaimer](../../../_includes/iam/api-keys-disclaimer.md) %}

{% note alert %}

If someone might have gotten access to your private key, [delete it](../../operations/api-key/delete.md) and [create a new one](../../operations/api-key/create.md).

{% endnote %}

It is the user's responsibility to store the API key. {{ yandex-cloud }} provides access to an API key only during its creation. If the key is lost or damaged, you cannot restore it. In which case you can [reissue](../../operations/compromised-credentials.md#api-key-reissue) the key or create a new one.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

## API keys with scope and validity limits {#scoped-api-keys}

You can [create](../../operations/api-key/create.md) API keys with an expiration date and a limited scope.

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

The scope limits the use of API keys in addition to the user's personal access permissions. Configuring scope limits and expiration dates will reduce the risk of unauthorized use of your keys.

{% include [scoped-api-keys-note](../../../_includes/iam/scoped-api-keys-note.md) %}

Available scopes are listed below:

* `yc.postbox.send`: For sending emails via the [{{ postbox-name }}](../../../postbox/index.yaml) API.
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

* [{#T}](../../operations/api-key/create.md)
* [{#T}](iam-token.md)
* [{#T}](./index.md)
