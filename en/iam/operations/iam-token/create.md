---
title: "How to get an IAM token for an account"
description: "This guide describes how you can get an IAM token for an account."
---

# Getting an IAM token for a Yandex account

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Get an IAM token:

  ```bash
  yc iam create-token
  ```

- API

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

### Using an IAM token obtained via the CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}