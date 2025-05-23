The `smart-web-security.admin` role allows you to use security profiles in Smart Web Security, manage them, and manage access to them.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned for security profiles and modify such permissions.
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md) in Smart Web Security, create, modify, and delete them, as well as use these security profiles in other Yandex Cloud services.
* View the list of L7 load balancer [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host) in Yandex Application Load Balancer to which the security profile is connected.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `smart-web-security.editor` permissions.

To assign the `smart-web-security.admin` role, you need the `admin` role for the cloud.