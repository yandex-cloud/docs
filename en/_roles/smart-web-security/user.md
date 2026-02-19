The `smart-web-security.user` role enables viewing info on Smart Web Security resources, as well as connecting such security profiles to protected resources.

Users with this role can:
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md) in Smart Web Security and connect them to protected resources.
* View the list of [resources](../../smartwebsecurity/operations/host-connect.md) to which a security profile is connected.
* View info on [WAF profiles](../../smartwebsecurity/concepts/waf.md).
* View info on [ARL profiles](../../smartwebsecurity/concepts/arl.md).
* View info on [proxy servers](../../smartwebsecurity/concepts/domain-protect.md#proxy).
* View info on [lists](../../smartwebsecurity/concepts/lists.md).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `smart-web-security.viewer` permissions.

To assign the `smart-web-security.user` role, you need the `admin` role for the cloud or `smart-web-security.admin` for the folder.