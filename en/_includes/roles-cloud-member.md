When a new user is added to the cloud, they are automatically assigned the role of cloud member: `{{ roles-cloud-member }}`.

Everyone needs this role to access the cloud resources, except the [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../iam/concepts/users/service-accounts.md).

This role alone doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.

