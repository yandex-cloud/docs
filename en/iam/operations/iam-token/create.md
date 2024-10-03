---
title: How to get an IAM token for an account
description: Follow this guide to get an IAM token for an account.
---

# Getting an IAM token for a Yandex account

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get an [IAM token](../../concepts/authorization/iam-token.md):

  ```bash
  yc iam create-token
  ```

- API {#api}

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

### Using an IAM token obtained via the CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}

#### See also {#see-also}

* [Using an IAM token in a Helm chart](../../../container-registry/operations/helm-chart/helm-chart-push.md)