# Relationship between service resources

[{{ k8s }}](https://{{ k8s }}.io) is an environment for managing containerized applications. {{ k8s }} offers ways to run clusters that can automate tasks like deploying, scaling, and managing applications in containers.

The main entity used in the service is a _cluster {{ k8s }}_.

## {{ k8s }} cluster {#kubernetes-cluster}

A {{ k8s }} cluster consists of a master and one or more node groups. The master is responsible for managing a {{ k8s }} cluster. Containerized user applications are run on nodes.

The service fully controls the master and monitors the status and health of a node group. The user can manage nodes directly and configure a {{ k8s }} cluster through the Yandex.Cloud management console and the Managed Service for Kubernetes CLI and API.

{% note important %}

{{ k8s }} node groups require internet access to download images and components.
Internet access can be provided in the following ways:
- By assigning each node in the group a [public IP address](../../vpc/concepts/address.md#public-addresses).
- [By configuring a VM as a NAT instance](../operations/nat-instance.md). In this case, only one public IP address will be used: the one that is assigned to the gateway.

{% endnote %}

When working with a {{ k8s }} cluster in the Yandex.Cloud infrastructure, the following resources are used:

| Resource | Amount | Comment |
| ---- | :---: | ---- |
| Subnet | 2 | {{ k8s }} reserves IP address ranges to be used for pods and services. |
| Public IP | N | N includes:</br> - **A single** public IP address for the NAT instance.</br> - A public IP address assigned to **each** node in the group if you use the one-to-one NAT technology.</br> |

### Master {#master}

_A master_ is a node that manages a {{ k8s }} cluster.

The master runs {{ k8s }} control processes that include the {{ k8s }} API server, scheduler, and main resource controllers. The master's lifecycle is managed by the service when creating or deleting a {{ k8s }} cluster. The master is responsible for global solutions that are run on all {{ k8s }} cluster nodes. These include scheduling workloads (such as containerized applications), managing the lifecycle of workloads, and scaling.

### Node group {#node-group}

_A node group_ is a group of VMs with the same configuration in a {{ k8s }} cluster that is running the user's containers.

#### Configuration {#config}

When you create a group of nodes, you can configure the following VM parameters:

- Type of VM.
- Type and number of cores (vCPU).
- Amount of memory (RAM) and disk space.

You can create groups with different configurations in a cluster and place them in different [availability zones](../../overview/concepts/geo-scope.md).

#### Connecting to group nodes {#connect-ssh}

You can connect to nodes in a group via SSH. Learn more in [Connecting to a node over SSH](../operations/node-connect-ssh.md).

