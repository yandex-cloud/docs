The `smart-web-security.viewer` role enables viewing info on Smart Web Security resources, as well as on the relevant cloud and folder.

Users with this role can:
* View info on [security profiles](../../smartwebsecurity/concepts/profiles.md).
* View the list of [resources](../../smartwebsecurity/operations/host-connect.md) to which a security profile is connected.
* View info on [WAF profiles](../../smartwebsecurity/concepts/waf.md).
* View info on [ARL profiles](../../smartwebsecurity/concepts/arl.md).
* View info on [proxy servers](../../smartwebsecurity/concepts/domain-protect.md#proxy).
* View info on [lists](../../smartwebsecurity/concepts/lists.md).
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `smart-web-security.auditor` permissions.

To assign the `smart-web-security.viewer` role, you need the `admin` role for the cloud or `smart-web-security.admin` for the folder.