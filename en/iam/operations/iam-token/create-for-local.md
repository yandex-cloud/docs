---
title: How to get an IAM token for a local user account
description: Follow this guide to get an IAM token for a local user account.
---

# Getting an IAM token for a local user account

{% note info %}

The [IAM token](../../../iam/concepts/authorization/iam-token.md) lifetime cannot exceed {{ iam-token-lifetime }} and is limited by the cookie lifetime for the [user pool](../../../organization/concepts/user-pools.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  1. [Authenticate in the CLI as a local user](../../../cli/operations/authentication/local-user.md).

  1. Get an IAM token:

      ```bash
      yc iam create-token
      ```

{% endlist %}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

## Examples {#examples}

### Using an IAM token obtained via the CLI {#use-cli}

{% include [include](../../../_includes/iam/iam-token-usage-examples.md) %}

#### See also {#see-also}

* [{#T}](./revoke-iam-token.md)