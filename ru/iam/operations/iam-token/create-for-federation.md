---
title: "Как получить IAM-токен для федеративного аккаунта"
description: "Следуя данной инструкции, вы сможете получить IAM-токен для федеративного аккаунта."
---

# Получение IAM-токена для федеративного аккаунта

{% note info %}

Время жизни [IAM-токена](../../../iam/concepts/authorization/iam-token.md) — не больше {{ iam-token-lifetime }} и ограничено временем жизни cookie у [федерации](../../../organization/concepts/add-federation.md).

{% endnote %}

{% list tabs %}

- CLI

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Аутентифицируйтесь в CLI от имени федеративного пользователя](../../../cli/operations/authentication/federated-user.md).

  1. Получите IAM-токен:

      ```bash
      yc iam create-token
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}