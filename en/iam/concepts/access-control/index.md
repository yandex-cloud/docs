# How access management in Yandex.Cloud works

On this page, you can find out how to manage access to resources and how [!KEYREF iam-short-name] checks access rights to them.

## How are access rights verified?

All operations with resources in Yandex.Cloud are first sent for verification to [!KEYREF iam-short-name]. For example:

1. A user wants the Yandex Compute Cloud service to create a new disk in the <q>default</q> folder.
1. The service sends a request to [!KEYREF iam-short-name] to check whether this user is allowed to create disks in this folder.
1. [!KEYREF iam-short-name] checks if the user is a member of the cloud with the <q>default</q> folder and has the necessary permissions to create a disk in this folder.
1. If the user does not have any of the permissions, the operation is not performed and Yandex.Cloud returns an error.
If all the required permissions are granted, [!KEYREF iam-short-name] reports this to the service.
1. The service creates a new disk.

![checkPermissions.png](../../../_assets/checkPermissions.png)

## How do I perform access management?

Access management in Yandex.Cloud leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant users access to a resource, you specify which [roles](roles.md) are assigned to them for that resource.

To assign a role, you [select a resource](#resource), [choose a role](#role), and [describe a subject](#subject) assigned the role. This way you [bind access rights](#access-bindings) to the resource.

You can also assign a role to a parent resource that [access rights are inherited](#inheritance) from, such as a folder or cloud.

### Resources that roles can be assigned for {#resource}

You can currently assign a role [for a cloud](../../../resource-manager/operations/cloud/set-access-bindings.md), [folder](../../../resource-manager/operations/folder/set-access-bindings.md), or [service account](../../operations/sa/set-access-bindings.md).

If you need to grant access to another resource, such as a VM, assign a role for the resource that access rights to that VM are inherited from, such as [a folder](../../../resource-manager/operations/folder/set-access-bindings.md).

### Role {#role}

Resource roles can be assigned by users with the [administrator](roles.md#admin) role for the resource, as well as the owners of the cloud the resource belongs to.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, to assign somebody the role of [cloud owner](roles.md#owner), the user must be granted this role, while the admin role is not sufficient for this.

For information about what roles exist and what permissions they include, see [[!TITLE]](roles.md).

### Subject that a role is assigned to {#subject}

To assign a role, you should specify the subject this role is assigned to. From the viewpoint of IAM, a role is assigned to an access subject.

There are three types of subjects:

* `userAccount`: a user's account on Yandex.
* `serviceAccount`: a service account created in Yandex.Cloud.
* `system` : a [system group](system-group.md). At the moment, there is just one system group, `[!KEYREF subjects-allAuthenticatedUsers]`, that incudes all users registered with and [authenticated](../authorization/) in Yandex.Cloud.

### Binding access rights {#access-bindings}

Roles to a resource are assigned as a list of _role-subject_ bindings. They are called _access bindings_. You can add or remove these bindings to control access rights to a resource.

![accessBindings.png](../../../_assets/accessBindings.png)

Each binding is a single assignment of a role to a subject. To assign a user multiple roles for a resource, set a separate binding for each role.

### Inheritance of access rights {#inheritance}

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For example, if you assign a user a role for a folder where a VM instance resides, all permissions of this role will also apply to the instance.

If a child resource is also assigned some roles, a list of permissions for this resource will be combined with a list of permissions for its parent resource.

#### See also

For more information about managing access to a specific Yandex.Cloud service, see the <q>Access management</q> section in the documentation on that service.

Step-by-step instructions and examples:

* [[!TITLE]](../../operations/roles/grant.md)
* [[!TITLE]](../../operations/roles/revoke.md)
* [[!TITLE]](../../operations/sa/assign-role-for-sa.md)
* [[!TITLE]](../../operations/sa/set-access-bindings.md)
* [[!TITLE]](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [[!TITLE]](../../../resource-manager/operations/folder/set-access-bindings.md)

