---
title: "Как получить IAM-токен для аккаунта"
description: "Следуя данной инструкции, вы сможете получить IAM-токен для аккаунта."
---

# Получение IAM-токена для аккаунта на Яндексе

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  Получите [IAM-токен](../../concepts/authorization/iam-token.md):

  ```bash
  yc iam create-token
  ```

- API {#api}

  {% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

  {% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}

#### См. также {#see-also}

* [Использовать IAM-токен в Helm-чарте](../../../container-registry/operations/helm-chart/helm-chart-push.md)