# System groups

_A system group_ is an ID for a group of users (subjects) that roles can be assigned to.

There are two types of system groups in {{ yandex-cloud }}: `allAuthenticatedUsers` and `allUsers`. These groups let you grant public access to your resources, but only for operations that are allowed by the given role.

{% include [roles-for-system](../../../_includes/iam/roles-for-system.md) %}

### allAuthenticatedUsers {#allAuthenticatedUsers}

`allAuthenticatedUsers`: All users who passed [authentication](../authorization/index.md). These are all registered users or service accounts in {{ yandex-cloud }}: both from your clouds and other users'.

> For example, let's say you have an OS disk image that you want to share with all {{ yandex-cloud }} users. To do this, assign the `compute.images.user` role to the `allAuthenticatedUsers` subject for the folder containing the image.

{% note alert %}

Assigning the role to the `allAuthenticatedUsers` system group opens public access to your resources. This role grants rights to your resources to **every** user authenticated in {{ yandex-cloud }} rather than **just users from your cloud**.

{% endnote %}

### allUsers {#allUsers}

`allUsers`: Any user. No authentication is required.

> For example, when making an API request to your resource, users don't need to specify their IAM tokens.

{% note warning %}

Now `allUsers` is only supported in {{ objstorage-name }} with [ACL-based access management](../../../storage/concepts/acl.md), in {{ container-registry-name }}, and in {{ sf-name }}.

For other services, assigning a role to the `allUsers` group is the equivalent to assigning the role to `allAuthenticatedUsers`.

{% endnote %}
