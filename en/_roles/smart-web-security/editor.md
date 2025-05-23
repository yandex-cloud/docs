The `smart-web-security.editor` role allows you to use security profiles in Smart Web Security and manage them.

Users with this role can:
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md) in Smart Web Security, create, modify, and delete them, as well as use these security profiles in other Yandex Cloud services.
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for security profiles.
* View the list of L7 load balancer [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host) in Yandex Application Load Balancer to which the security profile is connected.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `smart-web-security.user` permissions.

To assign the `smart-web-security.editor` role, you need the `admin` role for the cloud or the `smart-web-security.admin` one for the folder.