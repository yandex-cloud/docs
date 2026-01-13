The `k8s.admin` role enables managing Kubernetes clusters and node groups as well as access to Kubernetes clusters.

Users with this role can:
* View the list of [Kubernetes clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and info on them, as well as create, modify, start, stop, and delete Kubernetes clusters.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for Kubernetes clusters and modify such permissions.
* View the list of Kubernetes clusters' [node groups](../../managed-kubernetes/concepts/index.md#node-group) and info on such node groups, as well as create, modify, and delete Kubernetes clusters' node groups.
* View and edit settings defining interaction between Kubernetes clusters and Cloud Marketplace.
* View info on Cloud Marketplace applications, as well as install, update, and delete such applications.
* View info on access permissions granted for Cloud Marketplace applications and modify such permissions.
* View resource usage stats and info on the [quotas](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) for Managed Service for Kubernetes.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `k8s.editor` permissions.