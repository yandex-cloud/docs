
The `k8s.editor` role enables managing {{ k8s }} clusters and node groups.

Users with this role can:
* View the list of [{{ k8s }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) as well as info on them and on [access permissions](../../iam/concepts/access-control/index.md) granted for them.
* Create, modify, start, stop and delete {{ k8s }} clusters.
* View the list of {{ k8s }} clusters' [node groups](../../managed-kubernetes/concepts/index.md#node-group) and info on such node groups.
* Create, modify, and delete {{ k8s }} clusters' node groups.
* View and edit settings defining interaction between {{ k8s }} clusters and {{ marketplace-name }}.
* View info on {{ marketplace-name }} applications and access permissions granted for them, as well as install, update, and delete such applications.
* View resource usage stats and info on the [quotas](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) for {{ managed-k8s-name }}.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `k8s.viewer` permissions.