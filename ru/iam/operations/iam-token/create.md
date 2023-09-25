---
title: "Как получить IAM-токенн для аккаунта"
description: "Следуя данной инструкции, вы сможете получить IAM-токенн для аккаунта."
---

# Получение IAM-токена для аккаунта на Яндексе

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите IAM-токен:

  ```bash
  yc iam create-token
  ```

- API

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}