The role is useful if the user needs access to {{ yandex-cloud }} resources not only via the CLI, API, and {{ TF }}, but also via the management console.

`resource-manager.clouds.member` is one of the roles that gives users access to the management console. Any role from the list can also be used for this purpose:

* For an organization or cloud:

   * `resource-manager.admin`.
   * `resource-manager.editor`.
   * `resource-manager.viewer`.
   * `admin`.
   * `editor`.
   * `viewer`.

* For a cloud:

   * `resource-manager.clouds.owner`.

Each role from the list will give the user access to the console and permissions for cloud resources or an organization. Depending on the role, this can be either for reading information about all the resources in the cloud or creating and deleting any resource.

To avoid giving the user additional rights, use `resource-manager.clouds.member`. The role will provide access to the management console while giving minimum additional rights. The user will only see general information about the cloud which they have been assigned the role to, but will not be able to view the resources and access rights to the cloud.

> Example:
>
> Let's assume the administrator needs to manage the network connectivity of resources in all organization clouds, while other team members are in charge of non-network resources. In this case, you can use the following access matrix:
>
> | Role | For a resource | Allows |
> --- | --- | ---
> | `vpc.admin` | Organization | To manage networks, routes, IP addresses and other {{ vpc-name }} resources via the CLI, API, and {{ TF }} in all clouds of the organization. |
> | `resource-manager.clouds.member` | All clouds of the organization | To work with {{ vpc-name }} in the management console, view general information about the clouds. |
>

{% note info %}

If there are multiple clouds in the organization and they are created and deleted frequently, it might not be handy to assign `resource-manager.clouds.member` to a cloud every time. In this case, you can replace the `resource-manager.clouds.member` role with the `resource-manager.viewer` one: if you assign it once to an organization, the administrator will be able to work in the management console with {{ vpc-name }} resources of all clouds, including those you create moving forward. This role will also enable you to view information about all clouds and folders, including access rights lists.

{% endnote %}
