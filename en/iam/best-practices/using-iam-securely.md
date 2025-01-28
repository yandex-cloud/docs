# Secure use of {{ yandex-cloud }}

This section provides recommendations on how to make the best use of {{ iam-short-name }} for secure work with {{ yandex-cloud }} services.

## Do not grant unnecessary access rights {#restrict-access}

For critical resources:

* Assign the minimum required [roles](../concepts/access-control/roles.md). For example, to allow creating VMs from images in {{ compute-name }}, [assign the `compute.images.user` role](../operations/roles/grant.md) rather than `editor` or higher.
* Try assigning service roles rather than primitive ones (`viewer`, `editor`, or `admin`). Primitive roles apply to resources in any service {{ yandex-cloud }}.

    Use primitive roles if there is no suitable service role or you want to confer broad authority on a user.
* Assign only roles you need right now. Do not assign roles you may only need in the future.
* Note that when you assign a role for a folder, cloud, or organization, [all the nested resources will inherit](../concepts/access-control/index.md#inheritance) this role's permissions.
* Assign the [administrator](../roles-reference.md#admin) or [cloud owner](../../resource-manager/security/index.md#resource-manager-clouds-owner) roles only to people responsible for managing the access to resources in your project.

    An administrator can take away another administrator's access permissions, and an owner can revoke a role from another owner. These roles also include all the `editor` permissions, thus allowing to create, edit, and delete resources.

## Protect your Yandex account {#protect-account}

* {% include [yandex-account-2fa-warning.md](../../_includes/iam/yandex-account-2fa-warning.md) %}
* Keep your [OAuth token](../concepts/authorization/oauth-token.md) a secret, since it can be used to get an [IAM token](../concepts/authorization/iam-token.md) and perform operations in the cloud on behalf of you.

   If someone might have discovered your OAuth token, [invalidate it](https://tech.yandex.com/oauth/doc/dg/reference/token-invalidate-docpage/) and issue a new one.
* Avoid using your OAuth token for authentication if you can use an IAM token. OAuth tokens are valid for 1 year while IAM tokens are valid for {{ iam-token-lifetime }}. If your token is compromised, the hacker has limited time to use it.

## Use service accounts {#use-sa}

Automate your {{ yandex-cloud }} operations using [service accounts](../concepts/users/service-accounts.md) and follow these recommendations:

* Control access to your service accounts. The `editor` role for a service account allows the user to perform operations that service account is authorized to perform. If the service account is the cloud administrator, the user can use it to make themselves an administrator.
* Create separate service accounts for different tasks. This will allow you to give them only the roles they really need. You can revoke roles from a service account or delete it without affecting other service accounts.
* Name your service accounts according to their intended purposes and permissions.
* Keep your [service account keys](../concepts/users/service-accounts#sa-key) secret: they can be used to perform operations under your service account. Do not keep your service account keys in the source code.

    Revoke old keys and issue new ones every now and then. Be sure to do this if you think someone has learned your secret key.
* Do not use your keys for authentication if you can use [IAM tokens](../concepts/authorization/iam-token.md). Keys have an unlimited lifetime, while IAM tokens are valid for {{ iam-token-lifetime }}.
* If you perform operations from inside a VM, [link a service account to it](../../compute/operations/vm-connect/auth-inside-vm.md). Thus you will no longer need to store your service account keys on the VM for authentication: your IAM token will be available by a [metadata service link](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).