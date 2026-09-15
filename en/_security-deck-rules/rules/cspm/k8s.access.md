### Separate service accounts are used for cluster and node group {#access}

#|
|| **kind** | **severity** | **ID** ||
|| manual | high | k8s.access ||
|#

#### Description

A cluster in [Managed Service for Kubernetes](https://yandex.cloud/en/docs/managed-kubernetes/) uses two service accounts:

* **Cluster service account** — Managed Service for Kubernetes uses it to manage cluster nodes, subnets for Pods and Services, disks, load balancers, and to encrypt and decrypt secrets.
* **Node group service account** — cluster nodes use it to authenticate in [Container Registry](https://yandex.cloud/en/docs/container-registry/) when pulling images. For other registries, no roles need to be granted to this service account.

Using the same service account for both purposes is convenient at first, but it gives every node in the cluster the permissions of the cluster service account — including the ability to manage nodes, subnets, and load balancers. A compromised node can then change the cluster's network or scale node groups, not only pull images.

Splitting the roles between two service accounts limits the blast radius of a compromised node to what it actually needs.

**Risks if the rule is not followed:** If a single service account is used for both the cluster and node groups, a compromised node gains full cluster management permissions. An attacker who takes control of a node can modify the cluster's network configuration, scale or delete node groups, and access secrets — far beyond what a node should be able to do.

#### Instructions and solutions

Use two separate service accounts for the cluster:

1. Create a service account for the cluster and grant it the [roles required for cluster management](https://yandex.cloud/en/docs/managed-kubernetes/security/#yc-api).
2. Create a separate service account for the node group and grant it only the [`container-registry.images.puller`](https://yandex.cloud/en/docs/container-registry/security/) role on the registries from which the cluster pulls images.
3. For an existing cluster with a shared service account, create the missing one and switch the cluster or node group to it through [updating the cluster](https://yandex.cloud/en/docs/managed-kubernetes/operations/update-cluster) or [updating the node group](https://yandex.cloud/en/docs/managed-kubernetes/operations/node-group/node-group-update).

For details on access management in Managed Service for Kubernetes, see the [service security documentation](https://yandex.cloud/en/docs/managed-kubernetes/security/).
