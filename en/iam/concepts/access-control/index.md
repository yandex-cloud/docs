# How access management works in {{ yandex-cloud }}

Here you can learn how to manage access to your resources and how {{ iam-short-name }} checks permissions to access them.

## How are access permissions verified? {#access-verifying}

All operations in {{ yandex-cloud }} are first sent for verification to {{ iam-short-name }}. For example:

1. A user requests {{ compute-name }} to create a new disk in the <q>default</q> folder.
1. {{ compute-name }} sends a request to {{ iam-short-name }} to check whether this user is allowed to create disks in this folder.
1. {{ iam-short-name }} checks if the user is a member of the cloud with the <q>default</q> folder and has the necessary permissions to create a disk in this folder.
1. If any of the permissions are missing, the operation is not allowed and {{ yandex-cloud }} returns an error.
    If all the required permissions were granted, {{ iam-short-name }} reports this to the service.
1. The service creates a new disk.

![checkPermissions.png](../../../_assets/checkPermissions.png)

## How do I perform access management? {#how-do-i-perform-access-management}

Access management in {{ yandex-cloud }} leverages the [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC) policy. To grant users access to a resource, you need to specify their [roles](roles.md) for that resource.

To assign a role, you need to [select a resource](#resource), [choose a role](#role), and [describe the subject](#subject) getting the role. As a result, the subject gets [permissions to access](#access-bindings) the resource.

You can also assign a role for a parent resource to [inherit access permissions](#inheritance) from, e.g., a folder or cloud.

{% note warning %}

It usually takes 5 seconds or less to update access permissions. If the role was assigned to you, but you do not have access yet, repeat the operation.

For example, you were given the right to create folders in the cloud and you were able to create one folder, but couldn't create another one. This is because the access permissions have not yet been updated on the server where the second create folder operation was performed. Try creating the folder again.

{% endnote %}

### Resources you can assign roles for {#resource}

You can assign roles for a [cloud](../../../resource-manager/operations/cloud/set-access-bindings.md), [folder](../../../resource-manager/operations/folder/set-access-bindings.md), and other resources from the [list](resources-with-access-control.md). If you need to grant access to a resource that is not on the list, assign the role for the parent resource it [inherits](#inheritance) permissions from. For example, [{{ mpg-full-name }} clusters](../../../managed-postgresql/concepts/index.md) inherit access permissions from their folder.

### Role {#role}

{% include [roles-assign](../../../_includes/iam/roles-assign.md) %}

Thus, roles for a resource can be assigned by users with the [administrator](../../roles-reference.md#admin) role for the cloud or organization, as well as by the owners of the cloud or organization to which the resource belongs.

Each role consists of a set of permissions that describe operations that can be performed with the resource. A user can assign a role with only those permissions which are available to themselves. For example, only the user with the [cloud owner](../../../resource-manager/security/index.md#resource-manager-clouds-owner) role can assign this same role. The administrator role is not enough for this.

For information about available roles and permissions they offer, see [{#T}](roles.md).

### Subjects that roles are assigned to {#subject}

Roles are assigned to subjects. There are the following subject types:

* `userAccount`: [Yandex account](../users/accounts.md#passport) added to {{ yandex-cloud }} or an account from a [user pool](../../../organization/concepts/user-pools.md):

    Subject ID: `userAccount:<user_ID>`.

    Where `<user_ID>` is the unique [ID](../../../api-design-guide/concepts/resources-identification.md) [assigned](../../operations/users/get.md) to the user, e.g., `userAccount:ajecpdmpr4pr********`.

* `serviceAccount`: [Service account](../users/service-accounts.md) created in {{ yandex-cloud }}:

    Subject ID: `serviceAccount:<service_account_ID>`.

    Where `<service_account_ID>` is the unique ID [assigned](../../operations/sa/get-id.md) to the service account. For example, `serviceAccount:ajevnu4u2q3m********`.

    {% include [include](../../../_includes/sa-assign-role-note.md) %}

* `federatedUser`: User account in an [identity federation](../../../organization/concepts/add-federation.md), e.g., Active Directory.

    Subject ID: `federatedUser:<user_ID>`.

    Where `<user_ID>` is the unique ID [assigned](../../operations/users/get.md) to the federated user, e.g., `federatedUser:aje7b4u65nb6********`.

* `group`: [{{ org-full-name }}](../../../organization/) user group:

    * [User group](../../../organization/concepts/groups.md) created by the organization administrator:

        Subject ID: `group:<user_group_ID>`.

        Where `<user_group_ID>` is the unique ID assigned to the user group created by the organization administrator, e.g., `group:ajeser8mnc4c********`.

    * `All users in organization X` [system group](./system-group.md#allOrganizationUsers):

        Subject ID: `group:organization:<organization_ID>:users`.

        Where `<organization_ID>` is the unique [ID](../../../organization/operations/organization-get-id.md) assigned to the `X` [organization](../../../organization/quickstart.md), e.g., `group:organization:bpfaidqca8vd********:users`.

    * `All users in federation N` [system group](./system-group.md#allFederationUsers):

        Subject ID: `group:federation:<federation_ID>:users`.

        Where `<federation_ID>` is the unique ID assigned to the `N` [identity federation](../../../organization/concepts/add-federation.md), e.g., `group:federation:bpf8tpgggfoi********:users`.

* `system`: [Public group](./public-group.md) of users:

    * `All authenticated users` [public group](./public-group.md#allAuthenticatedUsers) of users:

        Subject ID: `system:allAuthenticatedUsers`.

    * `All users` [public group](./public-group.md#allUsers):

        Subject ID: `system:allUsers`.

### Assigning access permissions {#access-bindings}

Roles for a resource are assigned as a list of _role-subject_ bindings. They are called _access bindings_. You can add or remove these bindings to control permissions to access a resource.

![accessBindings.png](../../../_assets/accessBindings.png)

Each binding is a single assignment of a role to a subject. To assign a user multiple roles for a resource, set a separate binding for each role.

### Inheriting access permissions {#inheritance}

If a resource has child resources, all permissions from the parent resource will be inherited by the child resources. For example, if you assign the user a role for a folder containing a VM, all the role's permissions will also apply to the VM.

If a child resource is also assigned some roles, a list of permissions for this resource will be combined with a list of permissions for its parent resource. You cannot limit the list of permissions inherited from the parent resource.

### Access control restrictions in the management console {#console-restrictions}

Some restrictions apply to [assigning roles](../../operations/roles/grant.md) in the management console:

* You cannot assign roles to multiple subjects at once, unlike in the API or CLI. In the management console, you should first select the subject (user or service account) and then assign roles to it.

## Managing service access to user cloud resources {#service-control}

{{ iam-full-name }} allows you to manage [service access](../service-control.md) to resources in a user cloud by [enabling](../../operations/service-control/enable-disable.md#enable) or [disabling](../../operations/service-control/enable-disable.md#disable) the relevant services.

Service control is the whole of the access permissions needed to create and operate the service's resources in the user's cloud. Such access permissions are assigned to special service accounts, [service agents](../service-control.md#service-agent), which the service uses to access the user's resources in the cloud.

The user cannot directly create or delete service agents. All the required service agents with the appropriate access permissions are automatically created when you enable a service and get deleted when you disable it.

#### See also {#see-also}

For more information about managing access to a specific {{ yandex-cloud }} service, see the <q>Access management</q> section in the documentation for that service.

Step-by-step guides and examples:

* [{#T}](../../operations/roles/grant.md)
* [{#T}](../../operations/roles/revoke.md)
* [{#T}](../../operations/sa/assign-role-for-sa.md)
* [{#T}](../../operations/sa/set-access-bindings.md)
* [{#T}](../../operations/sa/impersonate-sa.md)
* [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md)
* [{#T}](../../operations/service-control/enable-disable.md)