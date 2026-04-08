# Resource model

{{ stackland-name }} uses a hierarchical resource model allowing you to group the resources, perform access management, and apply consumption quotas at different levels.

## Resource hierarchy {#hierarchy}

### Cluster {#cluster}

A cluster is a root {{ stackland-name }} entity. At the cluster level, you can manage the following:

* Cluster nodes.
* Platform configuration (`PlatformConfig`).
* Components (`ComponentInstallation`).
* Cluster roles and role bindings (`ClusterRole`, `ClusterRoleBinding`).
* Federations with external IdPs.

### Project {#project}

A project is a logical grouping of namespaces for a team or application. At the project level, you can manage the following:

* Project namespaces.
* Project roles and role bindings (`ProjectRole`, `ProjectRoleBinding`).
* Project resource quotas.
* IAM access bindings (`ProjectAccessBinding`).

For more information, see [Projects](../../data-transfer/concepts/use-cases.md).

### Namespace {#namespace}

A namespace is a standard resource isolation unit in Kubernetes. A namespace contains the following:

* Workloads (Pod, Deployment, StatefulSet).
* Services (Service, Ingress).
* Resources of the platform services ({{ PG }} and {{ KF }} clusters, {{ objstorage-name }} buckets).
* Roles and role bindings (`Role`, `RoleBinding`).
* Access bindings (`AccessBinding`).

## Services with a custom resource model {#custom-resource-model}

Some services have a resource model of their own, different from the {{ stackland-name }} hierarchy. Such services are deployed as stand-alone installations with their own UI. Within these services, access management uses their native mechanisms.

## Access management {#access-management}

You can grant access at any hierarchy level:

* At the cluster level, via `ClusterRoleBinding` or `ClusterAccessBinding`. For access to all the cluster's resources.
* At the project level, via `ProjectRoleBinding` or `ProjectAccessBinding`. For access to all the project's namespaces.
* At the namespace level, via `RoleBinding` or `AccessBinding`. For access limited to a particular namespace.

To learn more, see [Access management](../access-management.md).

## Quotas {#quotas}

You can set quotas at these two levels:

* At the project level to limit the total of resources consumed by all the project's namespaces. This quota is set by the cluster administrator.
* At the namespace level via Kubernetes' standard `ResourceQuota` mechanism. This quota is set by the project administrator.

For more information, see [Setting project quotas](../operations/projects/namespace-quotas.md).
