# Authenticating as a service account

Learn how to authenticate in the CLI:
- [As a service account](#auth-as-sa).
- [As a service account from inside a VM](#vm-auth-as-sa).

## Before you begin {#before-begin}

1. [Authenticate in the CLI as a user](user.md).
{% if audience != "internal" %}
1. If you don't have a service account yet, [create one](../../../iam/operations/sa/create.md) and [configure access rights for it](../../../iam/operations/sa/assign-role-for-sa.md).
{% else %}
1. If you don't have a service account yet, create one and configure access rights for it.
{% endif %}


Learn how to authenticate in the CLI [as a service account](#auth-as-sa).


## Authenticate as a service account {#auth-as-sa}

{% include [auth-as-sa](../../../_includes/cli/auth-as-sa.md) %}


## Authenticate as a service account from inside a VM {#vm-auth-as-sa}

{% include [vm-auth-as-sa](../../../_includes/cli/vm-auth-as-sa.md) %}

{% if audience != "internal" %}

Read more about working with {{ yandex-cloud }} from a VM in [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).

{% endif %}

#### See also

- [{#T}](../../concepts/index.md#manage-properties).
- [{#T}](../profile/profile-create.md).
- [{#T}](../profile/profile-activate.md).
- [{#T}](../profile/manage-properties.md).
{% if audience != "internal" %}- [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md).{% endif %}

