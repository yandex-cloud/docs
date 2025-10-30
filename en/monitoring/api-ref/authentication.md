---
title: Authentication in the {{ monitoring-full-name }} API
description: 'To work via the {{ monitoring-full-name }} API, get an IAM token for your account. Specify this IAM token to access {{ yandex-cloud }} resources through the API formatted as Authorization: Bearer <IAM-TOKEN>.'
sourcePath: en/monitoring_includes/api-ref/authentication.md
---

# Authentication in the {{ yandex-cloud }} API

To work via the API, you can use an [IAM token](../../iam/concepts/authorization/iam-token.md) or an [API key](../../iam/concepts/authorization/api-key.md). You can use any of these authentication methods to work with [{{ prometheus-name }}](../../monitoring/operations/prometheus/index.md).

## IAM token {#iam-token}

{% include [authentication-iam-token](../../_includes/authentication-iam-token.md) %}

## API key {#api-key}

{% include [authentication-api-key](../../_includes/authentication-api-key.md) %}

#### See also {#see-also}

[{#T}](../../iam/concepts/users/accounts.md)