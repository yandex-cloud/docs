
The `k8s.admin` role enables managing {{ k8s }} clusters and node groups as well as access to {{ k8s }} clusters.

Users with this role can:
* View the list of [{{ k8s }} clusters](../../managed-kubernetes/concepts/index.md#kubernetes-cluster) and info on them, as well as create, modify, start, stop, and delete {{ k8s }} clusters.
* View info on [access permissions](../../iam/concepts/access-control/index.md) granted for {{ k8s }} clusters and modify such permissions.
* View the list of {{ k8s }} clusters' [node groups](../../managed-kubernetes/concepts/index.md#node-group) and info on such node groups, as well as create, modify, and delete {{ k8s }} clusters' node groups.
* View and edit settings defining interaction between {{ k8s }} clusters and {{ marketplace-name }}.
* View info on {{ marketplace-name }} applications, as well as install, update, and delete such applications.
* View info on access permissions granted for {{ marketplace-name }} applications and modify such permissions.
* View resource usage stats and info on the [quotas](../../managed-kubernetes/concepts/limits.md#managed-k8s-quotas) for {{ managed-k8s-name }}.
* View info on the relevant [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud) and [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role includes the `k8s.editor` permissions.