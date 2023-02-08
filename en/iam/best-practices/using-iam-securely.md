# How to use {{ yandex-cloud }} securely

This section provides recommendations for using {{ iam-short-name }} features to ensure the secure operation of {{ yandex-cloud }} services.

## Don't grant unnecessary access rights {#restrict-access}

For critical resources:

* Assign the minimum required [roles](../concepts/access-control/roles.md). For example, to allow the creation of virtual machines from images in {{ compute-name }}, [assign](../operations/roles/grant.md) `compute.images.user` role instead of the `editor` role or higher.
* Try to assign service roles rather than primitive roles (`viewer`, `editor`, `admin`). Primitive roles apply to resources in any service {{ yandex-cloud }}.

   Use primitive roles if you don't have an applicable service role or if you want to grant a user total access.
* Assign only the roles you need at the moment. Don't assign roles that might only be needed in the future.
* Keep in mind that when you assign a role for a folder or cloud, the permissions under this role [inherit all the nested resources](../concepts/access-control/index.md#inheritance).
* Only assign the [administrator](../concepts/access-control/roles.md#admin) role or [cloud owner](../concepts/access-control/roles.md#owner) role to the people responsible for managing resource access in your project.

   Administrators can revoke one another's access rights, while owners can revoke the owner role from one another. These roles also include all the permissions under the `editor` role — they let you create, edit, and delete resources.

## Protect your Yandex account {#protect-account}

* {% include [yandex-account-2fa-warning.md](../../_includes/iam/yandex-account-2fa-warning.md) %}
* Keep your [OAuth token](../concepts/authorization/oauth-token.md) a secret, since it can be used to get an [IAM token](../concepts/authorization/iam-token.md) and perform operations in the cloud on behalf of you.

   If someone might have discovered your OAuth token, [invalidate it](https://tech.yandex.com/oauth/doc/dg/reference/token-invalidate-docpage/) and issue a new one.
* Avoid using your OAuth token for authentication if you can use an IAM token. OAuth tokens are valid for 1 year while IAM tokens are valid for {{ iam-token-lifetime }}. If your token is compromised, the hacker has limited time to use it.

## Use service accounts {#use-sa}

Use [service accounts](../concepts/users/service-accounts.md) to automate work with {{ yandex-cloud }} and follow these recommendations:

* Control access to your service accounts. The `editor` role for a service account lets the user perform operations permitted under the service account. If the service account has the administrator role for the cloud, the user can use it to make themselves an administrator.
* Create separate service accounts for different tasks. This way you can only assign them the roles you actually need. You can revoke roles from a service account or delete it without affecting other service accounts.
* Name your service accounts according to their intended purposes and permissions.
* Keep your [service account keys](../concepts/users/service-accounts#sa-key) a secret — they can be used to perform operations on behalf of your service accounts. Don't keep the service account keys in the source code.

   Periodically revoke old keys and issue new ones. Be sure to do this if you think someone discovered your secret key.
* Don't use your keys for authentication if you can use [IAM tokens](../concepts/authorization/iam-token.md). Keys have an unlimited lifetime, while IAM tokens are valid for {{ iam-token-lifetime }}.
* If you perform operations from inside a VM, [link a service account to it](../../compute/operations/vm-connect/auth-inside-vm.md). In this case, you don't need to store service account keys on the VM to enable authentication: the IAM token is available from a [metadata service link](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).