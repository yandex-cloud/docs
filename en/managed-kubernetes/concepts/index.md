# Relationship between service resources

[{{ k8s }}](https://{{ k8s }}.io) is an environment for managing containerized applications. {{ k8s }} provides mechanisms for interacting with clusters that can automate tasks like deploying, scaling, and managing applications in containers.

The main entity in the service is the _{{ k8s }} cluster_.

## {{ k8s }} cluster {#kubernetes-cluster}

{{ k8s }} clusters consist of a master and one or more node groups. The master is responsible for managing the {{ k8s }} cluster. Containerized user applications are run on nodes.

The service fully controls the master and monitors the status and health of node groups. Users can manage nodes directly and configure {{ k8s }} clusters using the {{ yandex-cloud }} management console and the {{ managed-k8s-name }} CLI and API.

{% note warning %}

Groups of {{ k8s }} nodes require internet access for downloading images and components.

Internet access can be provided in the following ways:
* By assigning each node in the group a [public IP address](../../vpc/concepts/address.md#public-addresses).
* [Configuring a virtual machine as a NAT instance](../../solutions/routing/nat-instance.md).
* [Enabling NAT to the internet](../../vpc/operations/enable-nat.md).

{% endnote %}

{{ k8s }} clusters in the {{ yandex-cloud }} infrastructure use the following resources:

Resource | Amount | Comments
--- | --- | ---
Subnet | 2 | {{ k8s }} reserves ranges of IP addresses to use for pods and services.
Public IP | N | The number N includes:<br>* **One** public IP address for the NAT instance.<br>* A public IP address assigned to **each** node in the group if you use one-to-one NAT technology.

### Master {#master}

_Masters_ are components that manage {{ k8s }} clusters.

They run {{ k8s }} control processes that include the {{ k8s }} API server, scheduler, and main resource controllers. The master lifecycle is managed by the service when creating or deleting a {{ k8s }} cluster. The master is responsible for global solutions that are run on all {{ k8s }} cluster nodes. These include scheduling workloads (such as containerized applications), managing the lifecycle of workloads, and scaling.

There are two types of masters that differ by their location in [availability zones](../../overview/concepts/geo-scope.md):
* _Zonal_: A master created in a subnet in one availability zone.
* _Regional_: A master created and distributed in three subnets in each availability zone. If a zone becomes unavailable, the regional master remains functional.

  {% note warning %}

  The internal IP address of a regional master is only available within a single {{ vpc-full-name }} cloud network.

  {% endnote %}

### Node group {#node-group}

_A node group_ is a group of VMs in a {{ k8s }} cluster that have the same configuration and run the user's containers.

#### Configuration {#config}

When you create a group of nodes, you can configure the following VM parameters:
* Type of VM.
* Type and number of cores (vCPU).
* Amount of memory (RAM) and disk space.

You can create groups with different configurations in a {{ k8s }} cluster and place them in different availability zones.

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

### Node labels {#node-labels}

_Node labels_, `node_labels` are a mechanism for grouping nodes together in {{ k8s }}. You can use node labels to manage pod distribution across the nodes of a cluster. For more information, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/).

{% note warning %}

Don't confuse [node group cloud labels](../../overview/concepts/services.md#labels) (`labels`) with [{{ k8s }} node labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/) (`node_labels`) managed by {{ managed-k8s-name }}.

We recommend managing all node labels via the [{{ managed-k8s-full-name }} API](../api-ref/NodeGroup/index.md) since, by default, when [updating or changing a node group](../operations/node-group/node-group-update.md), some of the nodes are recreated with different names and some of the old ones are deleted. Therefore, labels added using the [{{ k8s }} API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/) may be lost. Conversely, using the {{ k8s }} API to delete labels created via the {{ managed-k8s-name }} API has no effect since they will be restored.

{% endnote %}

Node labels can only be set when creating a node group. Each object can be assigned a set of node labels in the form of a `key:value` pair. Each key must be unique to an object.

Node label keys can consist of two parts: an optional prefix and a name separated by a `/`.

A prefix is an optional part of a key. Prefix requirements:
* It must be a DNS subdomain: a series of DNS tags separated by dots `.`.
* The maximum length is 253 characters.
* The last character must be followed by a `/`.

A name is a required part of a key. Naming requirements:
* The length can be up to 63 characters.
* May contain lowercase Latin letters, numbers, hyphens, underscores, and periods.
* The first and the last characters must be a letter or number.

For managing node labels, see [{#T}](../operations/node-group/node-label-management.md).