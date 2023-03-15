# Получение IAM-токена для федеративного аккаунта

{% note info %}

Время жизни [IAM-токена](../../../iam/concepts/authorization/iam-token.md) — не больше {{ iam-token-lifetime }} и ограничено временем жизни cookie у [федерации](../../../organization/add-federation.md).

{% endnote %}

{% list tabs %}

- CLI

  1. [Аутентифицируйтесь в CLI от имени федеративного пользователя](../../../cli/operations/authentication/federated-user.md).

  1. Получите IAM-токен:

      ```bash
      yc iam create-token
      ```

- API

  Чтобы получить IAM-токен, воспользуйтесь методом REST API [create](../../api-ref/IamToken/create.md) для ресурса [IamToken](../../api-ref/IamToken/index.md) или вызовом gRPC API [IamTokenService/Create](../../api-ref/grpc/iam_token_service.md#Create).

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Примеры {#examples}

### Использование IAM-токена, полученного с помощью CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}