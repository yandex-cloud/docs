---
title: Как получить IAM-токен для аккаунта локального пользователя
description: Следуя данной инструкции, вы сможете получить IAM-токен для аккаунта локального пользователя.
---

# Получение IAM-токена для аккаунта локального пользователя

{% note info %}

Время жизни [IAM-токена](../../../iam/concepts/authorization/iam-token.md) — не больше {{ iam-token-lifetime }} и ограничено временем жизни cookie у [пула пользователей](../../../organization/concepts/user-pools.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Аутентифицируйтесь в CLI от имени локального пользователя](../../../cli/operations/authentication/local-user.md).

  1. Получите IAM-токен:

      ```bash
      yc iam create-token
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}

#### См. также {#see-also}

* [{#T}](./revoke-iam-token.md)