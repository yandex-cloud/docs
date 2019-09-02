# IAM token

An IAM token (or just token) is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the Yandex.Cloud API and access to resources.

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

{% include [iam-token-lifetime](../../../_includes/iam-token-lifetime.md) %}

In the management console and the command line interface (CLI), the token is obtained and used without the user needing to do anything.

## Services that support this authentication method {#supported-services}

This authentication method is supported by all services, except for those with AWS-compatible APIs (they only need an IAM token for managing [access keys](access-key.md) and [service accounts](../users/service-accounts.md)).

#### See also

* [{#T}](../../operations/iam-token/create.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
* [{#T}](index.md)

