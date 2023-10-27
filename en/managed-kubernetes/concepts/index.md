---
title: "{{ k8s }} resource interdependencies"
description: "The main entity in this managed service is a {{ k8s }} cluster. A {{ k8s }} cluster consists of a master and one or more node groups. The master is responsible for managing the {{ k8s }} cluster. Containerized user applications are run on nodes."
---

# Resource relationships in {{ managed-k8s-name }}

[{{ k8s }}](https://kubernetes.io/) is an environment for managing containerized applications. {{ k8s }} provides tools for working with clusters that can automate such tasks as deploying, scaling, and managing applications in containers.

The main entity in the service is the _{{ k8s }} cluster_.

## {{ k8s }} cluster {#kubernetes-cluster}

{{ k8s }} clusters consist of a master and one or more node groups. The master is responsible for managing the {{ k8s }} cluster. Containerized user applications are run on nodes.

The service fully manages the master and monitors the status and health of node groups. Users can manage nodes directly and configure {{ k8s }} clusters using the {{ yandex-cloud }} management console and the {{ managed-k8s-name }} CLI and API.

{% note warning %}

Groups of {{ k8s }} nodes require internet access for downloading images and components.

Internet access can be provided in the following ways:
* By assigning a [public IP address](../../vpc/concepts/address.md#public-addresses) to each node in the group.
* By [configuring a VM as a NAT instance](../../tutorials/routing/nat-instance.md).
* By [setting up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{% endnote %}

{{ k8s }} clusters in the {{ yandex-cloud }} infrastructure use the following resources:

Resource | Amount | Comment
--- | --- | ---
Subnet | 2 | {{ k8s }} reserves ranges of IP addresses to use for pods and services.
Public IP | N | The N number includes:<br>* **One** public IP address for the NAT instance.<br>* A public IP address assigned to **each** node in the group if you use one-to-one NAT technology.

## Master {#master}

_Masters_ are components that manage {{ k8s }} clusters.

They run {{ k8s }} control processes that include the {{ k8s }} API server, scheduler, and main resource controllers. The master lifecycle is managed by the service when creating or deleting a {{ k8s }} cluster. The master is responsible for global solutions that are run on all {{ k8s }} cluster nodes. These include scheduling workloads (such as containerized applications), managing the lifecycle of workloads, and scaling.

There are two types of masters that differ by their location in [availability zones](../../overview/concepts/geo-scope.md):
* _Zonal_: Master created in a subnet in one availability zone.
* _Regional_: Master created and distributed in three subnets in each availability zone. If a zone becomes unavailable, the regional master remains functional.

  {% note warning %}

  The internal IP address of a regional master is only available within a single {{ vpc-full-name }} cloud network.

  {% endnote %}

## Node group {#node-group}

A _node group_ is a group of VMs in a {{ k8s }} cluster that have the same configuration and run the user's containers.

### Configuration {#config}

When creating a group of nodes, you can configure the following VM parameters:
* VM type.
* Type and number of cores (vCPU).
* Amount of memory (RAM) and disk space.
* Kernel parameters.
  * _Safe_ kernel parameters are isolated between pods.
  * _Unsafe_ parameters affect the operation of the pods and the node as a whole. In {{ managed-k8s-name }}, you cannot change unsafe kernel parameters unless their names have been explicitly specified when [creating a node group](../operations/node-group/node-group-create.md).

   {% note info %}

   You should only specify kernel parameters that belong to [namespaces](#namespace), such as `net.ipv4.ping_group_range`. Parameters that do not belong to namespaces, such as `vm.max_map_count`, should be resolved directly in the OS or using a DaemonSet with containers in privileged mode after creating a [{{ managed-k8s-name }} node group](#node-group).

   {% endnote %}

   For more information about kernel parameters, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/).

You can create groups with different configurations in a {{ k8s }} cluster and place them in different availability zones.

For {{ managed-k8s-name }}, the following container runtime environments are available:
* The [`Docker` platform](https://www.docker.com/) is selected by default when you create a group of nodes.
* The [`containerd` platform](https://containerd.io/) may be selected when you create or update a group of nodes with {{ k8s }} version 1.19 or higher.

### Connecting to group nodes {#node-connect-ssh}

You can connect to nodes in a group via SSH. Learn more in [Connecting to a node via SSH](../operations/node-connect-ssh.md).

### Taints and tolerations policies {#taints-tolerations}

_Taints_ are special policies applied to nodes in the group. Using taint policies, you can prohibit some pods from running on certain nodes. For example, you can specify that rendering pods can only be run on [nodes with GPUs](node-group/node-group-gpu.md).

Advantages of taint policies:
* The policies are preserved when a node is restarted or replaced.
* The policies are applied automatically to nodes added to the group.
* The policies are automatically applied to new nodes [during node group scaling](autoscale.md).

You can only apply a taint policy to a node group when [creating](../operations/node-group/node-group-create.md) it.

{% note warning %}

Do not confuse [{{ k8s }} node labels](#node-labels) (`node_labels`) managed by {{ managed-k8s-name }} and taint policies.

{% endnote %}

Every taint policy consists of three parts:

```text
<key> = <value>:<effect>
```

A list of available taint effects:
* `NO_SCHEDULE`: Prohibit running new pods on group nodes (it does not affect running pods).
* `PREFER_NO_SCHEDULE`: Avoid running pods on group nodes if there are available resources for this in other groups.
* `NO_EXECUTE`: Evict pods from nodes in this group to other groups, and prohibit running new pods.

_Tolerations_ are exceptions from taint policies. Tolerations allow you to permit certain pods to run on nodes even if a taint policy prevents it.

For example, if the `key1=value1:NoSchedule` taint policy is set for group nodes, you can place pods on this node using tolerations:

```yaml
apiVersion: v1
kind: Pod
...
spec:
  ...
  tolerations:
  - key: "key1"
    operator: "Equal"
    value: "value1"
    effect: "NoSchedule"
```

{% note info %}

For system pods, tolerations permitting them to run on all available nodes are automatically set.

{% endnote %}

For more information about taints and tolerations, see the [{{ k8s }} documentation](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/).

## Pod {#pod}

A _pod_ is a request to run one or more containers on a group node. In a {{ k8s }} cluster, each pod has a unique IP address so that applications do not conflict when using ports.

Containers are described in pods via JSON or YAML objects.

### IP masquerade for pods {#pod-ip-masquerade}

If a pod needs access to resources outside the cluster, its IP address will be replaced by the IP address of the node the pod is running on. For this purpose, the cluster uses [IP masquerading](https://kubernetes.io/docs/tasks/administer-cluster/ip-masq-agent/).

By default, IP masquerade is enabled for the entire range of pod IP addresses.

To implement IP masquerading, the `ip-masq-agent` pod is deployed on each cluster node. The settings for this pod are stored in a ConfigMap object called `ip-masq-agent`. If you need to disable pod IP masquerading, e.g., to access the pods over a VPN or [{{ interconnect-full-name }}](../../interconnect/index.yaml), specify the IP ranges you need in the `data.config.nonMasqueradeCIDRs` parameter:

```yaml
...
data:
  config: |+
    nonMasqueradeCIDRs:
      - <CIDR of pod IP addresses to skip masquerading>
...
```

## Service {#service}

A [_service_](service.md) is an abstraction that provides network load balancing functions. Traffic rules are configured for a group of pods united by a set of labels.

By default, a service is only available within a specific {{ k8s }} cluster, but it can be public and receive [requests from outside](../operations/create-load-balancer.md#lb-create) the {{ k8s }} cluster.

## Namespace {#namespace}

A _namespace_ is an abstraction that logically isolates {{ k8s }} cluster resources and distributes [quotas]({{ link-console-quotas }}) to them. This is useful for isolating resources of different teams and projects in a single {{ k8s }} cluster.

## Service accounts {#service-accounts}

{{ managed-k8s-name }} clusters use two types of service accounts:
* **Cloud service accounts**

  These accounts exist at the level of an individual folder in the cloud and can be used both by {{ managed-k8s-name }} and other services.

  For more information, see [{#T}](../security/index.md) and [{#T}](../../iam/concepts/users/service-accounts.md).
* **{{ k8s }} Service accounts**

  These accounts exist and run only at a level of an individual {{ managed-k8s-name }} cluster. {{ k8s }} uses them for:
  * To authenticate cluster API calls from applications deployed in the cluster.
  * To configure access for these applications.

  A number of {{ k8s }} service accounts are automatically created in the `kube-system` namespace when deploying a {{ managed-k8s-name }} cluster.

  For authentication within the {{ k8s }} cluster hosting the service account, create a token for this account manually.

  For more information, see [{#T}](../operations/connect/create-static-conf.md) and the [{{ k8s }} documentation](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/).

{% note warning %}

Do not confuse [cloud service accounts](../security/index.md#sa-annotation) with {{ k8s }} service accounts.

In the service documentation, _service account_ refers to a regular cloud service account unless otherwise specified.

{% endnote %}

## Node labels {#node-labels}

_Node labels_, `node_labels` are a mechanism for grouping nodes together in {{ k8s }}. You can use node labels to manage pod distribution across the nodes of a cluster. For more information, see the [{{ k8s }} documentation](https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes).

{% note warning %}

Do not confuse [cloud node group labels](../../resource-manager/concepts/labels.md) (`labels`) with [{{ k8s }} node labels]({{ k8s-docs }}/concepts/overview/working-with-objects/labels/) (`node_labels`) managed by {{ managed-k8s-name }}.

We recommend managing all node labels via the [{{ managed-k8s-name }} API](../api-ref/NodeGroup/index.md) method, because by default, when [updating or changing a node group](../operations/node-group/node-group-update.md) some of the nodes are recreated with different names and some of the old ones are deleted. That is why labels added via the [{{ k8s }} API]({{ k8s-docs }}/concepts/overview/kubernetes-api) can be lost. Conversely, using the {{ k8s }} API to delete labels created via the {{ managed-k8s-name }} API has no effect since such labels will be restored.

{% endnote %}

Node labels can only be set when creating a node group. Each object can be assigned a set of node labels in the form of a `key:value` pair. Each key must be unique to an object.

Node label keys can consist of two parts: an optional prefix and a name separated by a `/`.

A prefix is an optional part of a key. The prefix requirements are as follows:
* It must be a DNS subdomain, i.e., a series of DNS tags separated by periods `.`.
* It may be up to 253 characters long.
* The last character must be followed by a `/`.

A name is a required part of a key. The naming requirements are as follows:
* It may be up to 63 characters long.
* It may contain lowercase Latin letters, numbers, hyphens, underscores, and periods.
* The first and the last characters must be a letter or number.

For managing node labels, see [{#T}](../operations/node-group/node-label-management.md).