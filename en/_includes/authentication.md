# Authentication in the API

To perform operations in Yandex.Cloud via the API, you need an [IAM-token](../iam/concepts/authorization/iam-token.md).

To authenticate successfully in the API:

1. Get an IAM token:
    * [Instructions](../iam/operations/iam-token/create.md) for a Yandex account.
    * [Instructions](../iam/operations/iam-token/create-for-sa.md) for a service account.
    * [Instructions](../compute/operations/vm-connect/auth-inside-vm.md) for authenticating from inside a VM in {{ compute-name }}.
    * [Instructions](../functions/operations/function-sa.md) for authenticating by using a function in {{ sf-name }}.

2. {% include [iam-token-usage](iam-token-usage.md) %}

