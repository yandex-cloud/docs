---
title: Clusters and environments in {{ datalens-platform-full-name }}
description: In this article, you will learn why environments and clusters are used in {{ datalens-platform-full-name }}, how computation works in {{ TR }} and {{ SPRK }}, and how to manage cluster resources.
alternate:
  - href: en/datalens/datalens-platform/concepts/clusters/index.md
    type: text/markdown
    title: Markdown version
---

# Clusters and environments in {{ datalens-platform-full-name }}

In {{ datalens-platform-full-name }}, data processing requests and tasks are executed in _clusters_. _Environments_ define the parameters of the cloud infrastructure in which platform resources are created.

To manage clusters and environments, open ![image](../../../../_assets/datalens/compute.svg) **Clusters** in the left-hand panel.

## Workspaces {#environments}

An environment links {{ datalens-platform-short-name }} resources with {{ yandex-cloud }}. When creating an environment, you select a cloud, network, and subnet. The cloud you choose determines the [quotas](../limits.md) and the billing account for the resources you create.

Within the environment, you can create [REST catalogs](../rest-catalog/index.md) and clusters for data processing and [pipeline](../airflow/index.md) execution. Create separate environments for different tasks and user groups.

{% note info %}

For clusters, REST catalogs, and other platform objects to interact with one another, they must reside within the same cloud of {{ yandex-cloud }} and the same environment. When creating linked objects, choose the same environment.

{% endnote %}

During the [initial service setup](../../quickstart.md#activate-service), the platform creates a cloud, a network and subnet, environment, REST catalog, and {{ TR }} and {{ SPRK }} clusters, and then prompts you to connect {{ AF }}. You can [create](../../operations/clusters/manage-environment.md#create-environment) additional environments manually.

### Network with a subnet {#environment-network}

When creating an environment manually, select a [cloud network](../../../../vpc/concepts/network.md#network) within the chosen cloud, and then select one subnet of that network. Selecting a network limits the list of available subnets.

A network provides connectivity between cloud resources. A _subnet_ is a range of internal IP addresses that are assigned to resources. A subnet is located in a specific [availability zone](../../../../overview/concepts/geo-scope.md).

### Internet access via NAT {#environment-nat}

When creating an environment manually, you must ensure internet access from the selected subnet via a _NAT gateway_. It allows resources to establish outbound connections without being assigned public IP addresses. Learn more about a [NAT gateway](../../../../vpc/concepts/gateways.md#nat-gateway).

You can create a NAT gateway in the same directory where the network is located. This network must have a [route table](../../../../vpc/concepts/routing.md) with the `0.0.0.0/0` route via the gateway. The table is linked with an environment subnet in order to route traffic from that subnet outside the network via a NAT gateway. See the [Configuring a NAT gateway](../../../../vpc/operations/create-nat-gateway.md) guide for details.

{% note warning %}

Before creating the environment, manually verify that the route table is linked with the selected subnet and contains a route via the NAT gateway. This is also required when using an existing subnet.

{% endnote %}

## Clusters {#clusters}

A cluster is a set of computing resources for executing requests or data processing tasks. When creating a cluster, you select the environment, compute parameters, and a [collection](../../../workbooks-collections/collections-operations.md) in which to place your object within {{ datalens-platform-short-name }}.

The environment defines the cluster’s cloud infrastructure, while the collection determines its placement within the platform’s navigation. In the list of clusters, this information is displayed separately, in the **Environment** and **Location** columns.

### {{ TR }} clusters {#trino}

The {{ TR }} cluster executes SQL queries against the data. It consists of a _coordinator_ and _workers_. The coordinator receives requests, plans their execution, and distributes tasks among workers. Workers process data and send the results to the coordinator. For more details on the cluster architecture, see the [relevant {{ TR }} guide](https://trino.io/docs/current/overview/concepts.html#architecture).

When [creating a {{ TR }} cluster](../../operations/clusters/manage-clusters.md#create-trino-cluster), you can select REST catalogs from the same environment for it to work with. The size of a worker determines the number of vCPUs and the amount of RAM. You can specify the number of workers as a range: the cluster adds or removes them based on the workload, within the defined limits.


### {{ SPRK }} clusters {#spark}

The {{ SPRK }} cluster is designed for distributed data processing. The _driver_ manages the execution of an application, while the _executors_ carry out its tasks. Learn more about components in [this {{ SPRK }} guide](https://spark.apache.org/docs/latest/cluster-overview.html).

For drivers and executors, the size as well as the minimum and maximum quantity are specified separately. When [creating a cluster](../../operations/clusters/manage-clusters.md#create-spark-cluster), you can specify additional Python packages in the **Pip packages** field.


### {{ AF }} clusters {#airflow}

The {{ AF }} cluster manages the execution of pipelines: it considers schedules and dependencies between tasks, launches them, and monitors their status. Pipeline tasks can utilize compute resources in the {{ TR }} and {{ SPRK }} clusters.

The {{ AF }} cluster is created within an environment, and working with it is described in the [Managing pipelines](../../operations/airflow/manage-airflow.md) section.

## Managing computing resources {#resource-management}

For the {{ TR }} and {{ SPRK }} clusters, the size of computing resources and scaling limits are specified. The platform automatically shuts down idle workers and executors.

You can [manually stop and start](../../operations/clusters/manage-clusters.md#stop-start-cluster) the {{ TR }} and {{ SPRK }} clusters. Upon stopping, the execution of requests is interrupted, and no new requests are accepted. To resume operations, start the cluster and wait for it to switch to **Active**.


The **Cluster** tab displays information about compute resources, ID, environment, and engine version. From the **About cluster** section, you can navigate to the engine's web interface.

The {{ TR }} cluster page also includes the **REST catalogs**, **Connections**, and **Settings** tabs, while the {{ SPRK }} cluster page features the **Settings** tab.

#### Useful links {#see-also}

* [Managing environments](../../operations/clusters/manage-environment.md)
* [Managing clusters](../../operations/clusters/manage-clusters.md)
