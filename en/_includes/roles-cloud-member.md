When a new user is added to the cloud, they are automatically assigned the role of a cloud member: `[!KEYREF roles-cloud-member]`.

This role is necessary for accessing cloud resources to everyone except the [owners of the cloud](../resource-manager/concepts/resources-hierarchy.md#owner) and [system group](../iam/concepts/users/users.md#system) `allAuthenticatedUsers`.

This role alone does not give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

> [!IMPORTANT]
>
> To enable a user to work in the cloud through the Management Console, assign them the  `[!KEYREF roles-cloud-member]` and `viewer` roles for the cloud. If you assign only the cloud member role for the cloud and other roles for the nested resources, the user will only be able to perform resource operations using the API or CLI.

