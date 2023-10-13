---
title: "Access management in {{ managed-k8s-name }}"
description: "Access management in {{ managed-k8s-name }}, a service for running containerized applications. The section describes for which resources you can grant a role, which roles are used in the service, which roles are needed for service accounts of a {{ managed-k8s-name }} cluster, which roles you need to work with {{ managed-k8s-name }} from the {{ yandex-cloud }} management console."
---

# Access management in {{ managed-k8s-name }}

In this section, you will learn:
* [Which resources you can assign roles to](#resources).
* [What roles exist in the service](#roles-list).
* [What roles are required for {{ managed-k8s-name }} cluster service accounts](#sa-annotation).
* [What roles are required to work with {{ managed-k8s-name }} via the {{ yandex-cloud }} management console](#ui-annotation).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## Which resources you can assign roles to {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Which roles exist in the service {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/managed-kubernetes/security/service-roles-hierarchy.svg)

### Roles required to access the {{ k8s }} API {#k8s-api}

The following roles give the right to manage cluster resources via the {{ k8s }} API. Roles of the {{ k8s }} API employ the [role-based access control (RBAC) model](https://kubernetes.io/docs/reference/access-authn-authz/rbac/). To manage a {{ managed-k8s-name }} cluster, combine these roles with [roles for the {{ yandex-cloud }} API](#yc-api). For more information about roles in {{ k8s }} RBAC, see the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles).

{% include [k8s-cluster-api-viewer](../../_includes/iam/roles/k8s-cluster-api-viewer.md) %}

{% include [k8s-cluster-api-editor](../../_includes/iam/roles/k8s-cluster-api-editor.md) %}

{% include [k8s-cluster-api-cluster-admin](../../_includes/iam/roles/k8s-cluster-api-cluster-admin.md) %}

To view the rights to the {{ managed-k8s-name }} cluster resources available for a specific role, run this command:

```bash
kubectl describe clusterrole <role in {{ k8s }} RBAC>
```

### {{ managed-k8s-name }} roles {#yc-api}

The roles described below allow you to manage {{ managed-k8s-name }} clusters and node groups without public access via the {{ yandex-cloud }} API. To manage {{ managed-k8s-name }} cluster resources, combine these roles with [roles for the {{ k8s }} API](#k8s-api). When creating a cluster, the roles of its service account are verified.

To create a {{ managed-k8s-name }} cluster and node groups without public access, you need the `k8s.clusters.agent` role.

To create a {{ managed-k8s-name }} cluster and node groups with public access, you need the following roles:
* `k8s.clusters.agent`
* `vpc.publicAdmin`

To create a {{ managed-k8s-name }} cluster with [tunnel mode](../concepts/network-policy.md#cilium), you need the `k8s.tunnelClusters.agent` role.

{% include [k8s-tunnel-clusters-agent](../../_includes/iam/roles/k8s-tunnel-clusters-agent.md) %}

{% include [k8s-clusters-agent](../../_includes/iam/roles/k8s-clusters-agent.md) %}

{% include [k8s-viewer](../../_includes/iam/roles/k8s-viewer.md) %}

{% include [k8s-editor](../../_includes/iam/roles/k8s-editor.md) %}

{% include [k8s-admin](../../_includes/iam/roles/k8s-admin.md) %}

### Primitive roles {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## {{ managed-k8s-name }} cluster service accounts {#sa-annotation}

When creating a cluster in {{ managed-k8s-name }}, you should specify two service accounts:
* **Cluster service account**: On behalf of this service account, a {{ managed-k8s-name }} service manages cluster nodes, subnets for pods and services, disks, load balancing, encrypts and decrypts secrets. The minimum recommended role for this account is `k8s.clusters.agent`.
* **Node group service account**: On behalf of this service account, {{ managed-k8s-name }} cluster nodes are authenticated in [{{ container-registry-full-name }}](../../container-registry/concepts/index.md). To deploy applications in a {{ managed-k8s-name }} cluster using images from {{ container-registry-name }}, grant to this account a [service role](../../container-registry/security/index.md#service-roles) in {{ container-registry-name }}. If you use a different container registry, you can skip assigning roles to this service account.

To manage a {{ managed-k8s-name }} cluster and node groups with public access, you will also need the `vpc.publicAdmin` role.

## Accessing the {{ managed-k8s-name }} management console {#ui-annotation}

To access {{ managed-k8s-name }} via the {{ yandex-cloud }} [management console]({{ link-console-main }}), the minimum required role is `k8s.viewer`.

To get detailed information about a {{ managed-k8s-name }} cluster and node group, you will need the additional `k8s.cluster-api.viewer` role. This role corresponds to the `viewer` role in {{ k8s }} RBAC and grants access rights to a limited set of resources in the {{ k8s }} API, so the console's features are limited.

Users with the `k8s.cluster-api.cluster-admin` role have full access to the {{ managed-k8s-name }} cluster's {{ k8s }} API and can use all the management console features.

To provide more granular access to the necessary resources, you can:
* Configure additional rights in {{ k8s }} RBAC for the appropriate users.
* Expand the `view` and `edit` role in {{ k8s }} RBAC using [role aggregation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#user-facing-roles). For example, you can allow all users with the `view` role in the {{ k8s }} API (including users with the `k8s.cluster-api.viewer` cloud role) to view information about nodes by adding the following role to the {{ managed-k8s-name }} cluster:

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