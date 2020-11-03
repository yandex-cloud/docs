# Relationship between service resources

[{{ k8s }}](https://{{ k8s }}.io) is an environment for managing containerized applications. {{ k8s }} provides mechanisms for interacting with clusters that can automate tasks like deploying, scaling, and managing applications in containers.

The main entity in the service is the _{{ k8s }} cluster_.

## Cluster {{ k8s }} {#kubernetes-cluster}

{{ k8s }} clusters consist of a master and one or more node groups. The master is responsible for managing the {{ k8s }} cluster. Containerized user applications are run on nodes.

The service fully controls the master and monitors the status and health of node groups. Users can manage nodes directly as well as configure a {{ k8s }} cluster through the {{ yandex-cloud }} management console and the Managed Service for Kubernetes CLI and API.

{% note warning %}

{{ k8s }} node groups require internet access to download images and components.
Internet access can be provided in the following ways:

- By assigning each node in the group a [public IP address](../../vpc/concepts/address.md#public-addresses).
- [Configuring a VM as a NAT instance](../../solutions/routing/nat-instance.md).
- [Enabling NAT to the internet](../../vpc/operations/enable-nat.md).

{% endnote %}

{{ k8s }} clusters in the {{ yandex-cloud }} infrastructure use the following resources:

| Resource | Amount | Comments |
| ---- | :---: | ---- |
| Subnet | 2 | {{ k8s }} reserves IP address ranges to be used for pods and services. |
| Public IP | N | N includes:</br> - **One** public IP address for the NAT instance.</br> - A public IP address assigned to **each** node in the group if you use one-to-one NAT technology.</br> |

### Masters {#master}

_Masters_ are components that manage {{ k8s }} clusters.

They run {{ k8s }} control processes that include the {{ k8s }} API server, scheduler, and main resource controllers. The master lifecycle is managed by the service when creating or deleting a {{ k8s }} cluster. The master is responsible for global solutions that are run on all {{ k8s }} cluster nodes. These include scheduling workloads (such as containerized applications), managing the lifecycle of workloads, and scaling.

There are two types of masters that differ by their location in [availability zones](../../overview/concepts/geo-scope.md):

- _Zonal_: A master created in a subnet in one availability zone.

- _Regional_: A master created and distributed in three subnets in each availability zone. If a zone becomes unavailable, the regional master remains functional.

    {% note warning %}

    The internal IP address of a regional master is only available within a single {{ vpc-full-name }} cloud network.

    {% endnote %}

### Node groups {#node-group}

_A node group_ is a group of VMs in a {{ k8s }} cluster that have the same configuration and run the user's containers.

#### Configuration {#config}

When you create a group of nodes, you can configure the following VM parameters:

- Type of VM.
- Type and number of cores (vCPU).
- Amount of memory (RAM) and disk space.

You can create groups with different configurations in a {{ k8s }} cluster and place them in different [availability zones](../../overview/concepts/geo-scope.md).

#### Connecting to group nodes {#node-connect-ssh}

You can connect to nodes in a group via SSH. Learn more in [Connecting to a node via SSH](../operations/node-connect-ssh.md).

### Pod {#pod}

_A pod_ is a request to run one or more containers on a group node. In a {{ k8s }} cluster, each pod has a unique IP address so that applications do not conflict when using ports.

Containers are described in pods via JSON or YAML objects.

### Service {#service}

_A service_ is an abstraction that provides network load balancing functions. Traffic rules are configured for a group of pods united by a set of labels.

By default, a service is only available within a specific {{ k8s }} cluster, but it can be public and receive [requests from outside](../operations/create-load-balancer.md#lb-create) the {{ k8s }} cluster.

### Namespace {#namespace}

_A namespace_ is an abstraction that logically isolates {{ k8s }} cluster resources and distributes quotas to them. This is useful for isolating resources of different teams and projects in a single {{ k8s }} cluster.

### Labels {#labels}

_Labels_ are the main mechanism of object grouping in {{ k8s }}. Most scenarios involving multiple objects (for example, sending traffic through a service, configuring network policies, and running application controllers) use selectors based on label values. This lets you define subsets of managed objects (usually pods).
