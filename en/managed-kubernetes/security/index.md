---
title: Access management in {{ managed-k8s-name }}
description: Access management in {{ managed-k8s-name }}, a containerized application management service. This section describes the resources for which you can assign a role, the roles existing in the service, the roles required for the {{ managed-k8s-name }} cluster service accounts, and the roles required to work with {{ managed-k8s-name }} from the {{ yandex-cloud }} management console.
---

# Access management in {{ managed-k8s-name }}

In this section, you will learn about:
* [Resources you can assign a role for](#resources).
* [Roles this service has](#roles-list).
* [Roles required for managing {{ managed-k8s-name }}](#required-roles).
* [Roles required for the {{ managed-k8s-name }} cluster service accounts](#sa-annotation).
* [Roles required to use {{ managed-k8s-name }} via the {{ yandex-cloud }} management console](#ui-annotation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

{% include [roles-assign](../../_includes/iam/roles-assign.md) %}

## Resources you can assign a role for {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

You can also [assign a role for a separate cluster](../operations/kubernetes-cluster/kubernetes-cluster-access.md).

## Roles this service has {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/managed-kubernetes/security/service-roles-hierarchy.svg)

### Roles required to access the {{ k8s }} API {#k8s-api}

The following [roles](../../iam/concepts/access-control/roles.md) give the permission to manage [{{ managed-k8s-name }} cluster](../concepts/index.md#kubernetes-cluster) resources via the {{ k8s }} API. Roles of the {{ k8s }} API employ the [role-based access control (RBAC) model](https://kubernetes.io/docs/reference/access-authn-authz/rbac/). To manage a {{ managed-k8s-name }} cluster, combine these roles with [roles for the {{ yandex-cloud }} API](#yc-api). Learn more about roles in the {{ k8s }} RBAC in this [{{ k8s }} guide](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

To view permissions for {{ managed-k8s-name }} cluster resources available for a specific role, run this command:

```bash
kubectl describe clusterrole <role_in_{{ k8s }}_RBAC>
```

#### k8s.cluster-api.viewer {#k8s-cluster-api-viewer}

{% include [k8s.cluster-api.viewer](../../_roles/k8s/cluster-api/viewer.md) %}

#### k8s.cluster-api.editor {#k8s-cluster-api-editor}

{% include [k8s.cluster-api.editor](../../_roles/k8s/cluster-api/editor.md) %}

#### k8s.cluster-api.cluster-admin {#k8s-cluster-api-cluster-admin}

{% include [k8s.cluster-api.cluster-admin](../../_roles/k8s/cluster-api/cluster-admin.md) %}

### {{ managed-k8s-name }} roles {#yc-api}

The roles described below allow you to manage {{ managed-k8s-name }} clusters and [node groups](../concepts/index.md#node-group) without public access via the {{ yandex-cloud }} API. To manage {{ managed-k8s-name }} cluster resources, combine these roles with [roles for the {{ k8s }} API](#k8s-api). When creating a {{ managed-k8s-name }} cluster, the roles of its service account are verified.

To manage a {{ managed-k8s-name }} cluster and a node group without public access, you need the `k8s.clusters.agent` role.

To manage a {{ managed-k8s-name }} cluster and a node group with public access, you need the following roles:
* `k8s.clusters.agent`.
* `{{ roles-vpc-public-admin }}`.

To manage a {{ managed-k8s-name }} cluster with a cloud network from a different folder, you will additionally need the following roles in this folder:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)
* [vpc.bridgeAdmin](../../vpc/security/index.md#vpc-bridge-admin)

To manage a {{ managed-k8s-name }} cluster with [tunnel mode](../concepts/network-policy.md#cilium), you only need the `k8s.tunnelClusters.agent` role.

#### k8s.viewer {#k8s-viewer}

{% include [k8s.viewer](../../_roles/k8s/viewer.md) %}

#### k8s.editor {#k8s-editor}

{% include [k8s.editor](../../_roles/k8s/editor.md) %}

#### k8s.admin {#k8s-admin}

{% include [k8s.admin](../../_roles/k8s/admin.md) %}

#### k8s.tunnelClusters.agent {#k8s-tunnelclusters-agent}

{% include [k8s.tunnelClusters.agent](../../_roles/k8s/tunnelClusters/agent.md) %}

#### k8s.clusters.agent {#k8s-clusters-agent}

{% include [k8s.clusters.agent](../../_roles/k8s/clusters/agent.md) %}

### Primitive roles {#primitive-roles}

#### {{ roles-viewer }} {#viewer}

{% include notitle [roles-viewer](../../_roles/primitive-roles/viewer.md) %}

#### {{ roles-editor }} {#editor}

{% include notitle [roles-editor](../../_roles/primitive-roles/editor.md) %}

#### {{ roles-admin }} {#admin}

{% include notitle [roles-admin](../../_roles/primitive-roles/admin.md) %}

{% note info %}

With the {{ k8s }} RBAC, you can provide users with granular access to cluster namespaces.

{% cut "Example" %}

1. In your cluster, create a role to manage all resources in the specified namespace:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      namespace: <namespace>
      name: <role_name>
    rules:
    - apiGroups: [""]
      resources: ["*"]
      verbs: ["*"]
    ```

1. Bind this role to a user account:

    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: iam-user
      namespace: <namespace>
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: <role_name>
    subjects:
    - kind: User
      name: <account_ID>
    ```

To learn more about getting the account ID, see [Getting user information](../../iam/operations/users/get.md).

Check if you can create resources in the cluster. In other namespaces, you will have no permissions to create or edit resources.

{% endcut %}

{% endnote %}

## Roles required for creating a {{ managed-k8s-name }} {#required-roles}

When creating a {{ managed-k8s-name }} cluster and a node group, make sure the [account](../../iam/concepts/users/accounts.md) used for this purpose has these [roles](../../iam/concepts/access-control/roles.md):
* [{{ roles.k8s.editor }}](#k8s-editor) or higher
* [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user)

To create a {{ managed-k8s-name }} cluster and node group with public access, you will also need the [{{ roles-vpc-public-admin }}](../../vpc/security/index.md#vpc-public-admin) role.

## {{ managed-k8s-name }} cluster service accounts {#sa-annotation}

When creating a cluster in {{ managed-k8s-name }}, specify two [service accounts](../../iam/concepts/users/service-accounts.md):
* **Cluster service account**: On behalf of this service account, {{ managed-k8s-name }} manages cluster nodes, [subnets](../../vpc/concepts/network.md#subnet) for [pods](../concepts/index.md#pod) and [services](../concepts/index.md#service), [disks](../../compute/concepts/disk.md), [load balancers](../../network-load-balancer/concepts/index.md), encrypts and decrypts [secrets](../../lockbox/concepts/secret.md). The minimum recommended role for such an account is `k8s.clusters.agent`.
* **Node group service account**: On behalf of this service account, {{ managed-k8s-name }} cluster nodes are authenticated in [{{ container-registry-full-name }}](../../container-registry/concepts/index.md). To deploy applications in a {{ managed-k8s-name }} cluster using [Docker images](../../container-registry/concepts/docker-image.md) from {{ container-registry-name }}, grant to this account any [service role](../../container-registry/security/index.md#service-roles). If you use a different container registry, you can skip assigning roles to this service account.

To manage a {{ managed-k8s-name }} cluster and node groups with public access, you will also need the `{{ roles-vpc-public-admin }}` role.

If you use a cloud network from a different folder in a {{ managed-k8s-name }} cluster, the cluster service account will additionally need the following roles in this folder:
* [{{ roles-vpc-private-admin }}](../../vpc/security/index.md#vpc-private-admin)
* [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user)
* [vpc.bridgeAdmin](../../vpc/security/index.md#vpc-bridge-admin)

## Accessing the {{ managed-k8s-name }} management console {#ui-annotation}

`k8s.viewer` is the minimum required role to access {{ managed-k8s-name }} via the {{ yandex-cloud }} [management console]({{ link-console-main }}). The role only provides access to basic information about [node groups](../operations/node-group/node-group-list.md#get). 

The combination of the `k8s.viewer` and `k8s.clusters.agent` roles allows you to view all information about node groups, but not about individual cluster nodes.

The combination of the `k8s.cluster-api.cluster-admin`, `k8s.clusters.agent`, and `monitoring.viewer` roles allows you to view detailed information about node groups and individual [cluster nodes](../operations/node-group/node-group-list.md#get-node). All tabs become available for each node in the management console, including the **{{ ui-key.yacloud.k8s.node.overview.label_monitoring }}** tab.

To provide more granular access to resources, you can:
* Configure additional permissions in the {{ k8s }} RBAC for the appropriate users.
* Use [role aggregation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles) to expand the `view` and `edit` roles in the {{ k8s }} RBAC. For example, you can allow all users with the `view` role in the {{ k8s }} API (including users with the `k8s.cluster-api.viewer` cloud role) to view information about nodes by adding the following role to the {{ managed-k8s-name }} cluster:

  ```yaml
  apiVersion: rbac.authorization.k8s.io/v1
  kind: ClusterRole
  metadata:
    name: view-extensions
    labels:
      rbac.authorization.k8s.io/aggregate-to-view: "true"
  rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
  ```

## Workload identity federations {{ iam-full-name }}

{% include [wlif-mk8s-description](../../_includes/managed-kubernetes/wlif-mk8s-description.md) %}

For example, you can configure [{#T}](../tutorials/wlif-managed-k8s-integration.md).