# Granting permissions

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant a user certain privileges or access to a resource, you must assign the user the appropriate roles.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only a user with the organization [owner](../security/index.md#admin) role can assign this role: the administrator role is not sufficient to do this.

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For instance, if you assign a user the administrator role for the organization hosting the cloud, all the role's permissions will apply to the cloud and all the cloud's nested resources.

For more information about access control in {{ yandex-cloud }}, see the {{ iam-full-name }} documentation, [{#T}](../../iam/concepts/access-control/index.md).

For more information about roles in {{org-full-name}}, see [{#T}](../security/index.md).