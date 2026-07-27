# Resource model

{{ stackland-name }} uses a hierarchical resource model allowing you to group the resources, perform access management, and apply consumption quotas at different levels.

## Resource hierarchy {#hierarchy}

### Cluster {#cluster}

A cluster is a root {{ stackland-name }} entity. At the cluster level, you can manage the following:

* Cluster nodes (`StacklandHostConfig`).
* Platform configuration (`PlatformConfig`).
* Components (`ComponentInstallation`).
* Cluster roles and role bindings (`ClusterRole`, `ClusterRoleBinding`).
* Federations with external IdPs.

For more information about changing the cluster node composition, see [Scaling a cluster](cluster-scaling.md).

### Project {#project}

A project is a logical grouping of namespaces for a team or application. At the project level, you can manage the following:

* Project namespaces.
* Project roles and role bindings (`ProjectRole`, `ProjectRoleBinding`).
* Project resource quotas.
* IAM access bindings (`ProjectAccessBinding`).

For more information, see [Projects](projects.md).

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

* At the cluster level, via `ClusterRoleBinding` or `ClusterAccessBinding`. Access to all resources of the cluster.
* At the project level, via `ProjectRoleBinding` or `ProjectAccessBinding`. Access to all namespaces within a project.
* At the namespace level, via `RoleBinding` or `AccessBinding`. Access limited to a particular namespace.

To learn more, see [Access management](../access-management.md).

## Quotas {#quotas}

You can set quotas at these two levels:

* At the project level, which limits the total consumption of resources for all the project's namespaces. This quota is set by a cluster administrator.
* At the namespace level, which is the standard Kubernetes mechanism called `ResourceQuota`. A project administrator sets this quota.

For more information, see [Setting project quotas](../operations/projects/namespace-quotas.md).
