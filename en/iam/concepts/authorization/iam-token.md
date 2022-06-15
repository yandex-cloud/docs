# IAM token

An IAM token is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the {{ yandex-cloud }} API and access to resources.

## Using the token {#use}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

In the management console and the command line interface (CLI), the token is obtained and used without the user needing to do anything.

## Lifetime {#lifetime}

The IAM token is valid for no more than {{ iam-token-lifetime }}, but we recommend requesting a new token more often, like every hour. This lets you avoid situations where your only token expires right before {{ iam-short-name }} can't generate a new token for some reason.

The IAM token lifetime can be less than 12 hours if:

* You get an IAM token using the metadata service [inside the VM](../../../compute/operations/vm-connect/auth-inside-vm.md){% if product == "yandex-cloud" %} or [from the function call context](../../../functions/operations/function-sa.md#context){% endif %}.

  The metadata service returns the remaining token lifetime along with the IAM token. Account for your token lifetime or request the token more often, like once per hour or with every operation.

* You passed [federated authentication](../../../cli/operations/authentication/federated-user.md) in the CLI. Then the IAM token lifetime is also limited by the cookie lifetime in the [federation](../../../organization/add-federation.md).

## Services that support this authentication method {#supported-services}

This authentication method is supported by all services, except for those with AWS-compatible APIs (they only need an IAM token for managing [access keys](access-key.md) and [service accounts](../users/service-accounts.md)).

#### See also {#see-also}

{% if product == "yandex-cloud" %}
* [{#T}](../../operations/iam-token/create.md)
{% endif %}
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
{% if product == "yandex-cloud" %}
* [{#T}](../../../functions/operations/function-sa.md)
{% endif %}
* [{#T}](./index.md)

