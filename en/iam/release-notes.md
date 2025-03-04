---
title: '{{ iam-full-name }} release notes'
description: This section contains {{ iam-name }} release notes.
---


# {{ iam-full-name }} release notes

{% include [Tags-nosql](../_includes/release-notes-tags-nosql.md) %}


## Q4 2024 {#q4-2024}

* [Added](../iam/at-ref.md#data-plane-events) sending the `CreateIamToken` data event when creating an IAM token.
* Expanded the scope of [limited lifetime API keys](./concepts/authorization/api-key.md#supported-services) to work with [{{ ydb-full-name }}](../ydb/) in compatibility mode with {{ PG }}, [{{ postbox-full-name }}](../postbox/), and [{{ serverless-containers-full-name }}](../serverless-containers/). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* You can now see the service account's last authentication date and time. You can get the information in the `last_authenticated_at` field using the `yc iam user-account get` [{{ yandex-cloud}} CLI](../cli/cli-ref/iam/cli-ref/user-account/get) command. {{ tag-cli }}


## Q3 2024 {#q3-2024}

* Added [Workload Identity Federations](./concepts/workload-identity.md) that allow you to grant access to external applications without using long-lived access keys. This feature is at the [Preview stage](../overview/concepts/launch-stages.md). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* You can now create [API keys with limited scope and validity period](./concepts/authorization/api-key.md#scoped-api-keys). {{ tag-con }} {{ tag-cli }} {{ tag-tf }} {{ tag-api }}
* Added the [ResolveAgent](./api-ref/ServiceControl/resolveAgent.md) REST API method. {{ tag-api }}
* Added the ability to revoke an [IAM token](./concepts/authorization/iam-token.md) using [{{ yandex-cloud}} CLI](../cli/cli-ref/iam/cli-ref/revoke-token.md). {{ tag-cli }}
* Added `All users in organization X` and `All users in federation N` [system groups](./concepts/access-control/system-group.md).
* Added the {{ TF }} data source used to get the [service agent](./concepts/service-control.md#service-agent) ID. {{ tag-tf }}


## Q2 2024 {#q2-2024}

* Added the last used date info for service account access keys. You can find this info on the service account page in the [management console]({{ link-console-main }}) or in the `last_used_at` field when using the API to invoke access key management methods. {{ tag-con }} {{ tag-api }}


## Q1 2024 {#q1-2024}

* Added the [{{ sts-name }}](./concepts/authorization/sts.md) component to get temporary access keys compatible with [AWS S3 API](../storage/s3/index.md). This feature is at the [Preview stage](../overview/concepts/launch-stages.md). {{ tag-cli }} {{ tag-api }}
* Added OAuth client authentication support by authenticating a service account token.
* Added the option of using masked token ID for {{ at-name }} logs.
* Improved the key rotation mechanism in [OpenID Connect](https://openid.net/).