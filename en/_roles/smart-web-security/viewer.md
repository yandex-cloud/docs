The `smart-web-security.viewer` role allows you to view information on security profiles in Smart Web Security, as well as on the relevant cloud and folder.

Users with this role can:
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md) in Smart Web Security.
* View info on access [bindings](../../iam/concepts/access-control/index.md#access-bindings) for security profiles.
* View the list of L7 load balancer [virtual hosts](../../application-load-balancer/concepts/http-router.md#virtual-host) in Yandex Application Load Balancer to which the security profile is connected.
* View information on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `smart-web-security.auditor` permissions.

To assign the `smart-web-security.viewer` role, you either need the `admin` role for the cloud or the `smart-web-security.admin` one for the folder.