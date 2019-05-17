# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden. Any user can view reference lists of availability zones, regardless of roles.

To grant access to [!KEYREF managed-k8s-name] resources (Kubernetes clusters and node groups), assign applicable roles to the user from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

> [!NOTE]
> 
> For more information about role inheritance, see [[!TITLE]](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the [!KEYREF resmgr-full-name] documentation.

## Assigning roles {#grant-role}

To assign a role to a user:

[!INCLUDE [grant-role-console](../../_includes/grant-role-console.md)]

## Roles {#role}

The list below shows all roles that are considered when verifying access rights in the [!KEYREF managed-k8s-name] service.

### Service roles {#service-role}

_Service roles_ are roles that allow access to the resources of a particular service.

[!INCLUDE [cloud-roles](../../_includes/cloud-roles.md)]

### Primitive roles {#primitive-role}

You can assign primitive roles to any resource in any service.

[!KEYREF k8s] has its own [role model](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings). During authentication, the user is assigned a group and `username` that access rights can be granted for.

> [!NOTE]
> **Username** is the user ID in the [!KEYREF iam-short-name] service. For information on how to find out the user ID, see [Getting user ID or email](../../iam/operations/users/get.md).

The table below shows how roles in Yandex.Cloud correspond to groups and roles in [!KEYREF k8s]. This is configured **by default** during authentication in [!KEYREF k8s].

> [!IMPORTANT]
>
> If necessary, the user can change the roles that [!KEYREF k8s] group members will be assigned in a [!KEYREF k8s] cluster.

| Role in Yandex.Cloud | Group in [!KEYREF k8s] | Role in [!KEYREF k8s] | Description of role in Yandex.Cloud |
| ---- | ---- | ---- | ---- |
| `[!KEYREF roles-viewer]` | `yc:viewer` | `view` | The user can view information about resources, such as the list of nodes, or get information about a [!KEYREF k8s] cluster. |
| `[!KEYREF roles-editor]` | `yc:editor` | `cluster-admin` | The user can manage any resources, including creating a [!KEYREF k8s] cluster and adding or removing nodes in a [!KEYREF k8s] cluster.<br/> Includes all permissions of the `[!KEYREF roles-viewer]` role. |
| `[!KEYREF roles-admin]` | `yc:admin` | `cluster-admin` | The user can manage resource access rights to allow other users to create [!KEYREF k8s] clusters or view information about them.<br/> Includes all permissions of the `[!KEYREF roles-editor]` role. |

