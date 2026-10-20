The role is useful if the user needs access to {{ yandex-cloud }} resources not only via the CLI, API, and {{ TF }}, but also via the management console.

The `resource-manager.clouds.member` role is one of a few roles that grant users access to the management console. Any role from the list can also be used for this purpose:

* For an organization or cloud:

    * `resource-manager.admin`
    * `resource-manager.editor`
    * `resource-manager.viewer`
    * `resource-manager.auditor`
    * `admin`
    * `editor`
    * `viewer`
    * `auditor`

* For a cloud:

    * `resource-manager.clouds.owner`

Each role from the list will give the user access to the console and permissions for cloud resources or an organization. Depending on the role, this can be either for reading information about all the resources in the cloud or creating and deleting any resource.

To avoid granting the user excessive permissions, use `resource-manager.clouds.member`. The role will provide access to the management console with minimal additional privileges. The user will only see general information about the cloud which they have been assigned the role to, but will not be able to view the cloud resources and access permissions.
