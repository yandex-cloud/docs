---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Authenticating as a service account

Learn how to authenticate in the CLI:

- [As a service account](#auth-as-sa).
- [As a service account from inside a VM](#vm-auth-as-sa).

## Before you start {#before-begin}

1. [Authenticate in the CLI as a user](user.md).
1. If you don't have a service account, [create one](../../../iam/operations/sa/create.md) and [set up its access rights](../../../iam/operations/sa/assign-role-for-sa.md).

## Authenticate as a service account {#auth-as-sa}

{% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}

## Authenticate as a service account from inside a VM {#vm-auth-as-sa}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}

Read more about working with {{ yandex-cloud }} from a VM in [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

#### See also

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

