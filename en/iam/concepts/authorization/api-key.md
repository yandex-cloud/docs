---
title: API key
description: In this article, you will learn what an API key is, about its purpose, how to use it, and about the services supporting the API key authentication method.
---

# API key


{% include [access-control-sa-apikey-notice](../../../_includes/iam/access-control-sa-apikey-notice.md) %}

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


* `yc.ai.foundationModels.execute`: For requests to the [{{ ai-studio-name }} API]({{ link-docs-ai }}ai-studio/concepts/api.html#yc), [{{ speechkit-name }} API]({{ link-docs-ai }}speechkit/concepts/api), [{{ translate-full-name }} API]({{ link-docs-ai }}translate/concepts/api), and [{{ vision-name }} API]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.ai.imageGeneration.execute`: For requests to image generation models in {{ ai-studio-full-name }} via the [Image Generation API]({{ link-docs-ai }}ai-studio/image-generation/api-ref/index).
* `yc.ai.languageModels.execute`: For requests to text generation models in {{ ai-studio-full-name }} via the [Text Generation API]({{ link-docs-ai }}ai-studio/text-generation/api-ref/index).
* `yc.ai.speechkitStt.execute`: To [recognize speech]({{ link-docs-ai }}speechkit/stt/index) via the [{{ speechkit-name }} API]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.speechkitTts.execute`: To [synthesize speech]({{ link-docs-ai }}speechkit/tts/index) via the [{{ speechkit-name }} API]({{ link-docs-ai }}speechkit/concepts/api).
* `yc.ai.translate.execute`: To translate text via the [{{ translate-full-name }} API]({{ link-docs-ai }}translate/concepts/api).
* `yc.ai.vision.execute`: To perform optical text recognition via the [{{ vision-name }} API]({{ link-docs-ai }}vision/ocr/api-ref/index).
* `yc.datasphere.community-projects.manageResource`: To manage [project](../../../datasphere/concepts/project.md) resources via the [{{ ml-platform-full-name }} API](../../../datasphere/api-ref/overview.md).
* `yc.logging.write`: To write logs to [log groups](../../../logging/concepts/log-group.md) via the [{{ cloud-logging-full-name }} API](../../../logging/api-ref/authentication.md).
* `yc.managed-ytsaurus.cluster.use`: To work with [clusters](../../../managed-ytsaurus/concepts/component-types.md) via the [{{ myt-full-name }} API](../../../managed-ytsaurus/api-ref/authentication.md).
* `yc.monitoring.manage`: To view and write data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.monitoring.read`: To view data in {{ monitoring-full-name }} via the [{{ monitoring-name }} API](../../../monitoring/api-ref/index.md).
* `yc.monium.logs.write`: To write [logs](../../../monium/logs/quickstart.md) to [{{ monium-name }}](../../../monium/index.yaml).
* `yc.monium.metrics.write`: To write [metrics](../../../monium/metrics/overview.md) to [{{ monium-name }}](../../../monium/index.yaml).
* `yc.monium.traces.write`: To write [distributed traces](../../../monium/traces/index.md) to [{{ monium-name }}](../../../monium/index.yaml).
* `yc.monium.telemetry.write`: To write any type of telemetry to [{{ monium-name }}](../../../monium/index.yaml) over [OTLP](https://opentelemetry.io/docs/specs/otlp/) (OpenTelemetry Protocol).
* `yc.postbox.send`: To send emails via the [{{ postbox-name }}](../../../postbox/index.yaml) API.
* `yc.cloud-registry.artifacts.manage`: To view, publish, and delete artifacts from [{{ cloud-registry-full-name }}](../../../cloud-registry/index.yaml).
* `yc.cloud-registry.artifacts.pull`: To view and download artifacts from [{{ cloud-registry-full-name }}](../../../cloud-registry/index.yaml).
* `yc.cloud-registry.artifacts.push`: To view and publish artifacts in [{{ cloud-registry-full-name }}](../../../cloud-registry/index.yaml).
* `yc.search-api.execute`: To send search queries to [{{ search-api-name }}]({{ link-docs-ai }}search-api/api-ref/index).
* `yc.serverless.containers.invoke`: To invoke containers via the [{{ serverless-containers-short-name }} API](../../../serverless-containers/containers/api-ref/index.md).
* `yc.serverless.functions.invoke`: To invoke functions via the [{{ sf-short-name }} API](../../../functions/functions/api-ref/index.md).
* `yc.serverless.mcpGateways.invoke`: To invoke MCP servers via the [{{ ai-studio-full-name }} {{ mcp-hub-name }}]({{ link-docs-ai }}ai-studio/concepts/mcp-hub/index).
* `yc.serverless.workflows.execute`: To execute [workflows](../../../serverless-integrations/concepts/workflows/execution.md) via the [{{ sw-name }} API](../../../serverless-integrations/concepts/index.md#workflows).
* `yc.speech-sense.use`: To work with {{ speechsense-name }} [resources]({{ link-docs-ai }}speechsense/concepts/resources-hierarchy) via the [{{ speechsense-full-name }} API]({{ link-docs-ai }}speechsense/api-ref/authentication).
* `yc.ydb.tables.manage`: For accessing {{ ydb-short-name }} in {{ PG }}-compatible mode.
* `yc.ydb.topics.manage`: For accessing the [Kafka API](../../../data-streams/kafkaapi/auth.md) in {{ yds-full-name }}.

When creating an API key in the [management console]({{ link-console-main }}), scope is a required parameter. When creating an API key using the [{{ yandex-cloud }} CLI](../../../cli/cli-ref/iam/cli-ref/api-key/create.md), [{{ TF }}]({{ tf-provider-resources-link }}/iam_service_account_api_key), or [API](../../api-ref/ApiKey/create.md), scope is optional. If you do not specify a scope for the new API key, it will get the following scopes by default:

{% include [default-scope-list](../../../_includes/iam/default-scope-list.md) %}

## Identifying an API key {#identify-key}

The [list](../../operations/authentication/manage-api-keys.md#list-api-keys) of API keys in the {{ yandex-cloud }} CLI includes the `MASKED KEY` field which shows the last six characters of the key’s secret part. This helps you match the API key to its ID. Displaying the six characters is secure as the entire key is not revealed.

Use the `MASKED KEY` field to quickly identify a key, e.g., when searching for a key in leak databases or mapping keys in other systems with keys in {{ yandex-cloud }}.

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
* [{{ search-api-full-name }}]({{ link-docs-ai }}search-api/api-ref/authentication)
* [{{ serverless-containers-full-name }}](../../../serverless-containers/)
* [{{ si-full-name }}](../../../serverless-integrations): Within [{{ sw-full-name }}](../../../serverless-integrations/concepts/workflows/workflow.md).
* [{{ speechkit-full-name }}]({{ link-docs-ai }}{{ speechkit-slug }}/concepts/auth)
* [{{ speechsense-full-name }}]({{ link-docs-ai }}speechsense/api-ref/authentication)
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
