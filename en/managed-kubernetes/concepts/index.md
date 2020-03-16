# Relationship between service resources

[{{ k8s }}](https://{{ k8s }}.io) is an environment for managing containerized applications. {{ k8s }} offers ways to run clusters that can automate tasks like deploying, scaling, and managing applications in containers.

The main entity used in the service is a _cluster {{ k8s }}_.

## {{ k8s }} cluster {#kubernetes-cluster}

A {{ k8s }} cluster consists of a master and one or more node groups. The master is responsible for managing a {{ k8s }} cluster. Containerized user applications are run on nodes.

The service fully controls the master and monitors the status and health of a node group. The user can manage nodes directly and configure a {{ k8s }} cluster through the Yandex.Cloud management console and the Managed Service for Kubernetes CLI and API.

{% note warning %}

{{ k8s }} node groups require internet access to download images and components.
Internet access can be provided in the following ways:
- By assigning each node in the group a [public IP address](../../vpc/concepts/address.md#public-addresses).
- [By configuring a VM as a NAT instance](../../solutions/routing/nat-instance.md).

{% endnote %}

When working with a {{ k8s }} cluster in the Yandex.Cloud infrastructure, the following resources are used:

| Resource | Amount | Comment |
| ---- | :---: | ---- |
| Subnet | 2 | {{ k8s }} reserves IP address ranges to be used for pods and services. |
| Public IP | N | N includes:</br> - **A single** public IP address for the NAT instance.</br> - A public IP address assigned to **each** node in the group if you use the one-to-one NAT technology.</br> |

### Master {#master}

_Masters_ are components that manage {{ k8s }} clusters.

They run {{ k8s }} control processes that include the {{ k8s }} API server, scheduler, and main resource controllers. The master lifecycle is managed by the service when creating or deleting a {{ k8s }} cluster. The master is responsible for global solutions that are run on all {{ k8s }} cluster nodes. These include scheduling workloads (such as containerized applications), managing the lifecycle of workloads, and scaling.

There are two types of masters that differ by their location in [availability zones](../../overview/concepts/geo-scope.md):

- _Zonal_: A master created in a subnet in one availability zone.

- _Regional_: A master created and distributed in three subnets in each availability zone. If a zone becomes unavailable, the regional master remains functional.

    {% note warning %}
    
    The internal IP address of a regional master is only available within a single {{ vpc-full-name }} cloud network.

    {% endnote %}
    
### Node group {#node-group}

_A node group_ is a group of VMs with the same configuration in a {{ k8s }} cluster that is running the user's containers.

#### Configuration {#config}

When you create a group of nodes, you can configure the following VM parameters:

- Type of VM.
- Type and number of cores (vCPU).
- Amount of memory (RAM) and disk space.

You can create groups with different configurations in a cluster and place them in different [availability zones](../../overview/concepts/geo-scope.md).

#### Connecting to group nodes {#node-connect-ssh}

You can connect to nodes in a group via SSH. Learn more in [Connecting to a node over SSH](../operations/node-connect-ssh.md).

