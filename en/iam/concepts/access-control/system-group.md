# System groups

_A system group_ is an ID for a group of users (subjects) that roles can be assigned to.

There are two types of system groups in Yandex.Cloud: `allAuthenticatedUsers` and `allUsers`. These groups let you grant public access to your resources, but only for operations that are allowed by the given role.

{% include [roles-for-system](../../../_includes/iam/roles-for-system.md) %}

### allAuthenticatedUsers {#allAuthenticatedUsers}

`allAuthenticatedUsers`: All users who passed [authentication](../authorization/index.md). These are all registered Yandex.Cloud users or service accounts.

For example, you have an OS disk image that you want to share with all Yandex.Cloud users. To do this, assign the `compute.images.user` role to the `allAuthenticatedUsers` subject for the folder containing the image.

### allUsers {#allUsers}

`allUsers`: Any user. No authentication is required. For example, you don't need to specify the IAM token in an API query.

{% note warning %}

Now `allUsers` is only supported in {{ objstorage-name }} with [ACL-based access management](../../../storage/concepts/acl.md), in {{ container-registry-name }}, and in {{ sf-name }}.

For other services, assigning a role to the `allUsers` group is the equivalent to assigning the role to `allAuthenticatedUsers`.

{% endnote %}

