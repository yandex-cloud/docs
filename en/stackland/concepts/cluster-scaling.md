# Scaling a cluster

In {{ stackland-name }}, the cluster node composition can be changed post-installation: you can add new nodes and remove existing ones. Cluster scaling and updating are operations that cannot be performed simultaneously.

## StacklandHostConfig resource {#stacklandhostconfig}

Each cluster node is described by a separate instance of the custom `StacklandHostConfig` resource in the `stackland-install` namespace. Existing nodes get the relevant resources during cluster installation or upgrade. The resource contains:

* `spec.role`: Node role: `control-plane`, `worker`, or `combined`.
* `spec.disksConfig`: List of node disks. The list must specify the installation disk.
* `spec.networkConfig`: Network connection parameters: interfaces, addresses, routes, DNS servers, NTP servers.
* `spec.features`: Additional node capabilities, e.g., GPU support.

Fields not explicitly set in the resource are inherited from the `StacklandClusterConfig` template specified during cluster installation.

Creating a resource initiates the connection of a new node to the cluster. Deleting a resource initiates node removal: the node gets cordoned, drained, removed from Kubernetes, and then its operating system enters maintenance mode. Due to the finalizer, the resource is not deleted until the actual completion of the operation.

## Node lifecycle {#lifecycle}

The node's status is displayed in the `status.phase` field of the `StacklandHostConfig` resource:

* `Pending`: Resource created, operation pending.
* `Installing`: Connecting node to the cluster.
* `Installed`: Node connected and running in the cluster.
* `Removing`: Removing node from the cluster.
* `Failed`: Operation failed with an error.

## Node roles {#node-labels}

A node's role is set in the `spec.role` field and decides its purpose:

* `control-plane`: Control plane node. Enables the Kubernetes API, etcd, and controllers.
* `worker`: Workload node. Runs user application pods.
* `combined`: Node combining both roles. Used in small clusters.

For control plane fault tolerance, it is best to maintain an odd number of `control-plane` nodes, with a minimum of three.

You cannot change an existing node's role. To change a role, remove the node and add it again with a new role.

## Related resources {#related-resources}

* `StacklandClusterConfig`: Cluster configuration template set during installation. Default values for `StacklandHostConfig` are inherited from this template.
* `PlatformConfig`: Platform configuration. Decides the cluster's operating mode, including node handling policies.
* `TargetInstallationState`: Cluster installation and upgrade status. Scaling cannot be performed if the cluster is being upgraded to a new version. Scaling requested during that time will start automatically after the upgrade is complete.

## See also {#see-also}

* [{#T}](../operations/cluster/scale-cluster.md)
* [{#T}](../operations/cluster/upgrade-cluster.md)
