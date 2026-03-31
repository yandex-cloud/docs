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

When [creating](../../operations/authentication/manage-api-keys.md#create-api-key) an API key, you can specify one or more _scopes_.

{% include [scoped-api-keys](../../../_includes/iam/scoped-api-keys.md) %}

The scope limits the use of API keys in addition to the service account's personal access permissions.

Additionally, when creating an API key, you can limit its validity period. You can reduce the risk of unauthorized use of your keys by configuring their scope limits and validity periods.

Available scopes are listed below:


* `yc.ai.foundationModels.execute`: To send requests to [{{ assistant-api }}]({{ link-docs-ai }}ai-studio/assistants/api-ref/index), [Image Generation API]({{ link-docs-ai }}ai-studio/image-generation/api-ref/index), [Text Generation API]({{ link-docs-ai }}ai-studio/text-generation/api-ref/index), [{{ speechkit-name }}]({{ link-docs-ai }}speechkit/concepts/api) API, [{{ translate-full-name }}]({{ link-docs-ai }}translate/concepts/api) API, and [{{ vision-name }} API]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.ai.imageGeneration.execute`: To send requests to image generation models in {{ foundation-models-full-name }} via the [Image Generation API]({{ link-docs-ai }}ai-studio/image-generation/api-ref/index).
* `yc.ai.languageModels.execute`: To send requests to text generation models in {{ foundation-models-full-name }} via the [Text Generation API]({{ link-docs-ai }}ai-studio/text-generation/api-ref/index).
* `yc.ai.speechkitStt.execute`: To [recognize speech]({{ link-docs-ai }}speechkit/stt/index) via the [{{ speechkit-name }} API]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.speechkitTts.execute`: To [synthesize speech]({{ link-docs-ai }}speechkit/tts/index) via the [{{ speechkit-name }} API]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.translate.execute`: To translate text via the [{{ translate-full-name }} API]({{ link-docs-ai }}translate/concepts/api).
* `yc.ai.vision.execute`: To perform optical text recognition via the [{{ vision-name }} API]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.datasphere.community-projects.manageResource`: To manage [project](../../../datasphere/concepts/project.md) resources via the [{{ ml-platform-full-name }} API](../../../datasphere/api-ref/overview.md).
* `yc.logging.write`: To write logs to [log groups](../../../logging/concepts/log-group.md) via the [{{ cloud-logging-full-name }} API](../../../logging/api-ref/authentication.md).
* `yc.managed-ytsaurus.cluster.use`: To work with [clusters](../../../managed-ytsaurus/concepts/component-types.md) via the [{{ myt-full-name }} API](../../../managed-ytsaurus/api-ref/authentication.md).
* `yc.monitoring.manage`: To view and write data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read`: To view data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.postbox.send`: To send emails via the [{{ postbox-name }}](../../../postbox/index.yaml) API.
* `yc.search-api.execute`: To send search queries to [{{ search-api-name }}]({{ link-docs-ai }}search-api/api-ref/index).
* `yc.serverless.containers.invoke`: To invoke containers via the [{{ serverless-containers-short-name }} API](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke`: To invoke functions via the [{{ sf-short-name }} API](../../../functions/functions/api-ref/index.md).
* `yc.serverless.mcpGateways.invoke`: To invoke MCP servers via the [{{ foundation-models-full-name }} {{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index).
* `yc.speech-sense.use`: To work with {{ speechsense-name }} [resources](../../../speechsense/concepts/resources-hierarchy.md) via the [{{ speechsense-full-name }} API](../../../speechsense/api-ref/authentication.md).
* `yc.ydb.tables.manage`: For accessing {{ ydb-short-name }} in {{ PG }}-compatible mode.
* `yc.ydb.topics.manage`: For accessing the [Kafka API](../../../data-streams/kafkaapi/auth.md) in {{ yds-full-name }}.

When creating an API key in the [management console]({{ link-console-main }}), scope is a required parameter. When creating an API key using the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/iam/cli-ref/api-key/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_api_key), or [API](../../api-ref/ApiKey/create.md), scope is optional. If you do not specify a scope for the new API key, it will get the following scopes by default:

{% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

## Using an API key {#use}

Enter your API key when accessing {{ yandex-cloud }} resources via the API. Provide the API key in the `Authorization` header in the following format:

```
Authorization: Api-Key <API_key>
```

## Services that support this authentication method {#supported-services}

The following services support authentication based on API keys:

* [{{ ai-studio-full-name }}]({{ link-docs-ai }}ai-studio/api-ref/authentication)
* [{{ sf-full-name }}](../../../functions/operations/function/auth.md)
* [{{ ml-platform-full-name }}](../../../datasphere/api-ref/authentication.md)
* [{{ monitoring-full-name }}](../../../monitoring/api-ref/authentication.md)
* [{{ postbox-full-name }}](../../../postbox/api-ref/authentication.md)
* [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/operations/auth)
* [{{ serverless-containers-full-name }}](../../../serverless-containers/)
* [{{ speechkit-full-name }}]({{ link-docs-ai }}{{ speechkit-slug }}/concepts/auth)
* [{{ speechsense-full-name }}](../../../speechsense/api-ref/authentication.md)
* [{{ translate-full-name }}]({{ link-docs-ai }}translate/api-ref/authentication)
* [{{ vision-full-name }}]({{ link-docs-ai }}vision/api-ref/authentication)
* {{ yds-full-name }}: [Kafka API](../../../data-streams/kafkaapi/index.md).
* {{ ydb-full-name }}: Only in {{ PG }}-compatible mode. Use a suitable [authentication method](../../../ydb/operations/connection.md#auth) for other modes.
* [{{ metadata-hub-full-name }}](../../../metadata-hub/concepts/index.md): Within [{{ schema-registry-full-name }}](../../../metadata-hub/operations/connect-to-namespace.md).
* [{{ cloud-registry-full-name }}](../../../cloud-registry/)

## Use cases {#examples}

* [{#T}](../../../tutorials/ml-ai/speechsense/auto-upload.md)

#### See also {#see-also}

* [{#T}](../../operations/authentication/manage-api-keys.md#create-api-key)
* [{#T}](iam-token.md)
* [{#T}](./index.md)