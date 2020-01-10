# How access management in Yandex.Cloud works

Here you can learn how to manage access to your resources and how {{ iam-short-name }} checks access rights for the resources.

## How are access rights verified? {#access-verifying}

All operations in Yandex.Cloud are first sent for verification to {{ iam-short-name }}. For example:

1. A user requests Yandex Compute Cloud to create a new disk in the <q>default</q> folder.
1. The service sends a request to {{ iam-short-name }} to check whether this user is allowed to create disks in this folder.
1. {{ iam-short-name }} checks if the user is a member of the cloud with the <q>default</q> folder and has the necessary permissions to create a disk in this folder.
1. If the user does not have any of the permissions, the operation is not performed and Yandex.Cloud returns an error.
If all the required permissions were granted, {{ iam-short-name }} reports this to the service.
1. The service creates a new disk.

![checkPermissions.png](../../../_assets/checkPermissions.png)

## How do I perform access management? {#how-do-i-perform-access-management}

Access management in Yandex.Cloud leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant users access to a resource, you specify which [roles](roles.md) are assigned to them for that resource.

To assign a role, [select a resource](#resource), [choose a role](#role), and [describe the subject](#subject) assigned to the role. This lets you [bind access rights](#access-bindings) to the resource.

You can also assign a role to a parent resource that [access rights are inherited](#inheritance) from, such as a folder or cloud.

{% note important %}

It usually takes 5 seconds or less to update access rights. If the role was assigned to you, but still you don't have access, try repeating the operation.

For example, you were given the right to create folders in the cloud and you were able to create one folder, but couldn't create another one. This is because the access rights have not yet been updated on the server where the second create folder operation was performed. Try creating the folder again.

{% endnote %}

### Resources that roles can be assigned for {#resource}

You can currently assign roles [for a cloud](../../../resource-manager/operations/cloud/set-access-bindings.md), [folder](../../../resource-manager/operations/folder/set-access-bindings.md), and other resources from the [list](resources-with-access-control.md).

If you need to grant access to a resource that isn't on the list (such as a VM), assign the role to the parent resource it [inherits](#inheritance) permissions from. VM permissions are inherited from their folder.

### Role {#role}

Resource roles can be assigned by users with the [administrator](roles.md#admin) role for the resource, as well as the owners of the cloud that the resource belongs to.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only the user with the [cloud owner](roles.md#owner) role can assign this same role. The administrator role is not enough for this.

To find out what roles exist and the permissions they include, see [{#T}](roles.md).

### Subjects that roles are assigned to {#subject}

To assign a role, you should specify the subject this role is assigned to. From the viewpoint of IAM, a role is assigned to an access subject.

There are three types of subjects:

* `userAccount`: A user's account on Yandex.
* `serviceAccount`: A [service account](../users/service-accounts.md) created in Yandex.Cloud.
* `system`: A [system group](system-group.md).

### Assign access rights {#access-bindings}

Roles to a resource are assigned as a list of _role-subject_ bindings. They are called _access bindings_. You can add or remove these bindings to control access rights to a resource.

![accessBindings.png](../../../_assets/accessBindings.png)

Each binding is a single assignment of a role to a subject. To assign a user multiple roles to a resource, set a separate binding for each role.

### Inheritance of access rights {#inheritance}

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For example, if you assign a user a role for a folder where a VM instance resides, all permissions of this role will also apply to the instance.

If a child resource is also assigned some roles, a list of permissions for this resource will be combined with a list of permissions for its parent resource. You can't limit the list of permissions inherited from the parent resource.

#### See also {#see-also}

For more information about managing access to a specific Yandex.Cloud service, see the <q>Access management</q> section in the documentation on that service.

Step-by-step instructions and examples:

* [{#T}](../../operations/roles/grant.md)
* [{#T}](../../operations/roles/revoke.md)
* [{#T}](../../operations/sa/assign-role-for-sa.md)
* [{#T}](../../operations/sa/set-access-bindings.md)
* [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md)

