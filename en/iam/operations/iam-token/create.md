---
title: How to get an IAM token for an account
description: Follow this guide to get an IAM token for an account.
---

{% note info %}

These methods of getting an [IAM token](../../concepts/authorization/iam-token.md) are intended for requests by a [Yandex user account](../../concepts/users/accounts.md#passport) and are not recommended for automated solutions. If you want to automate your work with the {{ yandex-cloud }} API and get IAM tokens in software, see [{#T}](create-for-sa.md).

{% endnote %}

# Getting an IAM token for a Yandex account

You can get an IAM token for your Yandex account [using the CLI](#via-cli). You need to install the [YC CLI](../../../cli/) to do it.

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}


## Getting an IAM token using the YC CLI {#via-cli}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Authenticate in the CLI as a user](../../../cli/operations/authentication/user.md).
  1. Get an IAM token:

      ```bash
      yc iam create-token
      ```

      Result:

      ```text
      t1.9euelZrLop7Uz8up********
      ```

      The value you get is an IAM token. You can copy it, save it to a file, or write it into a variable:

      ```bash
      export IAM_TOKEN=`<IAM_token>`
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


## Example of using an IAM token obtained through the CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}


#### See also {#see-also}

* [Using an IAM token in a Helm chart](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Revoking an IAM token](./revoke-iam-token.md)