This role alone does not provide you with any permissions to perform any operations and is only used in combination with other roles.


How the role can be combined with other roles depends on whether a cloud belongs to an organization or not.

{% list tabs %}

- In an organization

   {% include [roles-cloud-member-organization](./roles-cloud-member-organization.md) %}

- Without organization

   This role is required for everyone who needs to access cloud resources, except for [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../iam/concepts/users/service-accounts.md).

   Without this role, no other roles will work for the user.

   The role is assigned automatically when you add a new user to a cloud without an organization.

{% endlist %}
