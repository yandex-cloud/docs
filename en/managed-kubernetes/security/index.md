# Access management

Yandex.Cloud users can only perform operations on resources that are allowed by the roles assigned to them. If a user doesn't have any roles assigned, almost all operations are forbidden. Any user can view reference lists of availability zones, regardless of roles.

To grant access to {{ managed-k8s-name }} resources (Kubernetes clusters and node groups), assign applicable roles to the user from the list below. For now, a role can only be assigned for a parent resource (folder or cloud), and roles are inherited by nested resources.

{% note info %}

For more information about role inheritance, see [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) in the {{ resmgr-full-name }} documentation.

{% endnote %}

## Assigning roles {#grant-roles}

To assign a role to a user:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Roles {#roles}

The list below shows all roles that are considered when verifying access rights in the {{ managed-k8s-name }} service.

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Primitive roles {#primitive-roles}

You can assign primitive roles to any resource in any service.

{{ k8s }} has its own [role model](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#default-roles-and-role-bindings). During authentication, the user is assigned a group and `username` that access rights can be granted for.

{% note info %}

**Username** is the user ID in the {{ iam-short-name }} service. For information on how to find out the user ID, see [Getting user ID or email](../../iam/operations/users/get.md).

{% endnote %}

The table below shows how roles in Yandex.Cloud correspond to groups and roles in {{ k8s }}. This is configured **by default** during authentication in {{ k8s }}.

{% note warning %}

If necessary, the user can change the roles that {{ k8s }} group members will be assigned in a {{ k8s }} cluster.

{% endnote %}

| Role in Yandex.Cloud | Group in {{ k8s }} | Role in {{ k8s }} | Description of role in Yandex.Cloud |
| ---- | ---- | ---- | ---- |
| `{{ roles-viewer }}` | `yc:viewer` | `view` | The user can view information about resources, such as the list of nodes, or get information about a {{ k8s }} cluster. |
| `{{ roles-editor }}` | `yc:editor` | `cluster-admin` | The user can manage any resources, including creating a {{ k8s }} cluster and adding or removing nodes in a {{ k8s }} cluster.<br/> Includes all permissions of the `{{ roles-viewer }}` role. |
| `{{ roles-admin }}` | `yc:admin` | `cluster-admin` | The user can manage resource access rights to allow other users to create {{ k8s }} clusters or view information about them.<br/> Includes all permissions of the `{{ roles-editor }}` role. |

