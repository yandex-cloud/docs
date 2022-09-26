This role alone doesn't give you the right to perform any operations and is only used in combination with other roles.

{% if product == "yandex-cloud" %}

How the role can be combined with other roles depends on whether a cloud belongs to an organization or not.


#### For a cloud in an organization {#cloud-inside-org}

{% endif %}

The role is useful if the user needs access to {{ yandex-cloud }} resources not only via the CLI, API, and {{ TF }}, but also via the management console.

`resource-manager.clouds.member` is one of the roles that gives users access to the management console. Any role from the list can also be used for this purpose:

* For an organization or cloud:

   * `resource-manager.admin`
   * `resource-manager.editor`
   * `resource-manager.viewer`
   * `admin`
   * `editor`
   * `viewer`

* For a cloud:

   * `resource-manager.clouds.owner`

Each role from the list will give the user access to the console and permissions for cloud resources or an organization. Depending on the role, this can be either for reading information about all the resources in the cloud or creating and deleting any resource.

To avoid giving the user additional rights, use `resource-manager.clouds.member`. The role will provide access to the management console while giving minimum additional rights. The user will only see general information about the cloud which they have been assigned the role to, but will not be able to view the resources and access rights to the cloud.

> Example:
>
> The administrator must manage the network connectivity of resources in all clouds of the organization. Other team members are responsible for non-network resources. In this case, the following access matrix can be used:
>
> | Role | For a resource | Allows |
> --- | --- | ---
> | `vpc.admin` | Organization | To manage networks, routes, IP addresses and other {{ vpc-name }} resources via the CLI, API, and {{ TF }} in all clouds of the organization |
> | `resource-manager.clouds.member` | All clouds of the organization | To work with {{ vpc-name }} in the management console, view general information about the clouds |

{% note info %}

If there are multiple clouds in the organization and they are created and deleted frequently, it is inconvenient to assign `resource-manager.clouds.member` to a cloud every time. In this case, you can replace `resource-manager.clouds.member` with the `resource-manager.viewer` role: assign it once to an organization and the administrator will be able to work in the management console with {{ vpc-name }} resources of all clouds, including future clouds. The role will enable you to view information about all clouds and folders, including access rights lists.

{% endnote %}

{% if product == "yandex-cloud" %}

#### For a cloud without an organization {#cloud-outside-org}

A role everyone requires to access cloud resources, except for [cloud owners](../resource-manager/concepts/resources-hierarchy.md#owner) and [service accounts](../iam/concepts/users/service-accounts.md).

Without this role, no other roles will work for the user.

The role is assigned automatically when you add a new user to a cloud without an organization.

{% endif %}
