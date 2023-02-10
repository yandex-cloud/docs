# Getting an IAM token for a federated account

{% note info %}

Lifetime of an [IAM token](../../../iam/concepts/authorization/iam-token.md) cannot exceed {{ iam-token-lifetime }} and is limited by the cookie lifetime for the [federation](../../../organization/add-federation.md).

{% endnote %}

{% list tabs %}

- CLI

  1. [Authenticate with the CLI as a federated user](../../../cli/operations/authentication/federated-user.md).

  1. Get an IAM token:

      ```bash
      yc iam create-token
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

### Using an IAM token obtained via the CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}

