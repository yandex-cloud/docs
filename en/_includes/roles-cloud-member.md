When a new user is added to the cloud, they are automatically assigned the role of cloud member: `{{ roles-cloud-member }}`.

This role must be assigned to everyone who needs to access cloud resources, except the [owners of the cloud](../resource-manager/concepts/resources-hierarchy.md#owner), [service accounts](../iam/concepts/users/service-accounts.md), and [system group](../iam/concepts/access-control/system-group.md) `allAuthenticatedUsers`.

This role alone does not give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

{% note important %}

To enable a user to work in the cloud through the management console, assign them the  `{{ roles-cloud-member }}` and `viewer` roles for the cloud. If you assign only the cloud member role for the cloud and other roles for the nested resources, the user will only be able to perform resource operations using the API or CLI.

{% endnote %}

