When a new user is added to a cloud that does not belong to the organization, he or she will automatically be assigned the cloud member role: `{{ roles-cloud-member }}`.

The role is only valid for a cloud not owned by the organization.

Everyone needs this role to access the cloud resources, except the {% if audience != "internal" %}[cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../iam/concepts/users/service-accounts.md){% else %}cloud owners and service accounts{% endif %}.

This role alone doesn't give you the right to perform any operations and is only used in combination with other roles, such as `admin`, `editor`, or `viewer`.