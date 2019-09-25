# IAM token

An IAM token (or just token) is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the Yandex.Cloud API and access to resources.

## Using the token {#use}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

In the management console and the command line interface (CLI), the token is obtained and used without the user needing to do anything.

## Lifetime {#lifetime}

The IAM token is usually valid for {{ iam-token-lifetime }}, but we recommend requesting a new token more often, like every hour. This lets you avoid situations where your only token expires right before {{ iam-short-name }} can't generate a new token for some reason.

If you get an IAM token via the metadata server [inside the VM](../../../compute/operations/vm-connect/auth-inside-vm.md), its lifetime may be shorter, since the metadata server returns the last token generated instead of generating new tokens. New tokens are generated periodically.

The metadata server returns the remaining lifetime of the token along with the IAM token. Account for your IAM token lifetime or request the token more often, like once per hour or with every operation.

## Services that support this authentication method {#supported-services}

This authentication method is supported by all services, except for those with AWS-compatible APIs (they only need an IAM token for managing [access keys](access-key.md) and [service accounts](../users/service-accounts.md)).

#### See also

* [{#T}](../../operations/iam-token/create.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
* [{#T}](index.md)

