---
title: Как получить IAM-токен для аккаунта
description: Следуя данной инструкции, вы сможете получить IAM-токен для аккаунта.
---


# Получение IAM-токена для аккаунта на Яндексе

[IAM-токен](../../concepts/authorization/iam-token.md) для [аккаунта на Яндексе](../../concepts/users/accounts.md#passport) можно получить двумя способами:

* [С помощью CLI](#via-cli) (рекомендуется) — наиболее безопасный способ. Для получения IAM-токена необходимо установить [YC CLI](../../../cli/).
* [С помощью OAuth-токена](#exchange-token) — наиболее простой способ. Получите [OAuth-токен](../../concepts/authorization/oauth-token.md), который есть у каждого аккаунта на Яндексе, и обменяйте его на IAM-токен, используя любой удобный HTTP-клиент, например cURL или PowerShell.

{% note info %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

{% endnote %}


## Получить IAM-токен с помощью YC CLI {#via-cli}

{% include [cli-install](../../../_includes/cli-install.md) %}

Получите [IAM-токен](../../concepts/authorization/iam-token.md):

```bash
yc iam create-token
```

### Пример использования IAM-токена, полученного с помощью CLI {#use-cli}

{% include [token-examples](../../../_includes/iam/iam-token-usage-examples.md) %}


## Получить и обменять OAuth-токен на IAM-токен {#exchange-token}

{% include [owner-warning](../../../_includes/iam/owner-warning.md) %}

{% include [create-iam-token-api-steps](../../../_includes/iam/create-iam-token-api-steps.md) %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}


#### См. также {#see-also}

* [Использовать IAM-токен в Helm-чарте](../../../container-registry/operations/helm-chart/helm-chart-push.md)
* [Отозвать IAM-токен](./revoke-iam-token.md)