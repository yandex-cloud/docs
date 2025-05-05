---
title: How to get an IAM token for an account
description: Follow this guide to get an IAM token for an account.
---

{% note info %}

These methods of getting an [IAM token](../../concepts/authorization/iam-token.md) are intended for requests by a [Yandex user account](../../concepts/users/accounts.md#passport) and are not recommended for automated solutions. If you want to automate your work with the {{ yandex-cloud }} API and get IAM tokens in software, see [{#T}](create-for-sa.md).

{% endnote %}

# Getting an IAM token for a Yandex account

You can get an IAM token for your Yandex account in two ways:

* [Using the CLI](#via-cli) (recommended). This is the most secure method. To get an IAM token, you need to install the [YC CLI](../../../cli/).
* [Using an OAuth token](#exchange-token). This method is the simplest. Get an [OAuth token](../../concepts/authorization/oauth-token.md), which every Yandex account has, and exchange it for an IAM-token using any HTTP client you like, e.g., cURL or PowerShell.

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}


## Getting an IAM token using the YC CLI {#via-cli}

{% include [cli-install](../../../_includes/cli-install.md) %}

Get an [IAM token](../../concepts/authorization/iam-token.md):

```bash
yc iam create-token
```

### Example of using an IAM token obtained through the CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}


## Getting and exchanging an OAuth token for an IAM token {#exchange-token}

{% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

{% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


#### See also {#see-also}

* [Using an IAM token in a Helm chart](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Revoking an IAM token](./revoke-iam-token.md)