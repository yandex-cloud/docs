The `k8s.editor` role enables managing Kubernetes clusters and node groups.

Users with this role can:
* View the list of [Kubernetes clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) as well as info on them and on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, start, stop and delete Kubernetes clusters.
* View the list of Kubernetes clusters' [node groups](../../managed-kubernetes/concepts/index.md#node-group) and info on such node groups.
* Create, modify, and delete Kubernetes clusters' node groups.
* View and edit settings defining interaction between Kubernetes clusters and Cloud Marketplace.
* View info on Cloud Marketplace applications and access permissions granted for them, as well as install, update, and delete such applications.
* View resource usage stats and info on the [quotas](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) for Managed Service for Kubernetes.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `k8s.viewer` permissions.