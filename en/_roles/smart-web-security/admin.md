The `smart-web-security.admin` role enables using Smart Web Security resources and managing them.

Users with this role can:
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md) in Smart Web Security, create, modify, and delete them, as well as connect such security profiles to protected resources.
* View the list of [resources](../../smartwebsecurity/operations/host-connect.md) to which a security profile is connected.
* View info on [WAF profiles](../../smartwebsecurity/concepts/waf.md), as well as create, modify, use, and delete them.
* View info on [ARL profiles](../../smartwebsecurity/concepts/arl.md), as well as create, modify, use, and delete them.
* View info on [proxy servers](../../smartwebsecurity/concepts/domain-protect.md#proxy), as well as create, modify, and delete them.
* View info on [lists](../../smartwebsecurity/concepts/lists.md), as well as create, modify, use, and delete them.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `smart-web-security.editor` permissions.

To enable or disable [logging](../../smartwebsecurity/concepts/logging.md) in a security profile, you also need the `logging.writer` role or higher for the [log group](../../logging/concepts/log-group.md) to which logs are transferred.

To assign the `smart-web-security.admin` role, you need the `admin` role for the cloud.