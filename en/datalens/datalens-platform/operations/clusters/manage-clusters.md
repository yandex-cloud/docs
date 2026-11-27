---
title: Managing clusters шт {{ datalens-platform-full-name }}
description: Create and configure {{ TR }} and {{ SPRK }} clusters in {{ datalens-platform-short-name }}, view information about their status and computing resources.
alternate:
  - href: en/datalens/datalens-platform/operations/clusters/manage-clusters.md
    type: text/markdown
    title: Markdown version
---

# Cluster management

Under ![image](../../../../_assets/datalens/compute.svg) **Clusters**, you can manage [clusters and environments](../../concepts/clusters/index.md). In this guide, you will learn how to:

* [View a list of clusters](#list-clusters).
* [Create a {{ TR }} cluster](#create-trino-cluster).
* [Create an {{ SPRK }} cluster](#create-spark-cluster).
* [View cluster details](#view-cluster).
* [Update cluster settings](#update-cluster).
* [Stop and restart a cluster](#stop-start-cluster).
* [Go to REST catalogs and connections](#catalogs-and-connections).


For information on how to set up environments, see [Managing environments](manage-environment.md). For information on how to create an {{ AF }} cluster, see [Managing pipelines](../airflow/manage-airflow.md#create-cluster).

## Getting started {#before-you-begin}

Set up an [environment](manage-environment.md#create-environment) and [collection](../../../workbooks-collections/collections-operations.md#create-collections) where you plan to deploy your cluster. Make sure you have the required permissions to create objects in the collection.

If your {{ TR }} cluster will use tables in a REST catalog, [create the REST catalog](../rest-catalog/create-rest-catalog.md) in advance.

## Viewing a list of clusters {#list-clusters}

In the left-hand panel, open the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section and go to the **Clusters** tab. The list shows each cluster’s name, description, status, ID, environment, location, and creation date.

To find a cluster, enter its name or ID in the **Name or ID** field. Use the **Type**, **Environment**, and **Status** filters to narrow down the list. To open a cluster’s page, click its name.

## Creating a {{ TR }} cluster {#create-trino-cluster}

1. In the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section, open the **Clusters** tab, click **Create**, and select {{ TR }}.
1. Under **General settings**, specify the following settings:

   * **Name**: Cluster name.
   * **Description** (optional): Brief explanation of the cluster’s purpose.
   * **Environment**: Environment to create the cluster in. The cluster and the REST catalogs it uses must reside in the same cloud and environment. If you do not have the appropriate environment, click **Create** to [set up a new one](manage-environment.md#create-environment).
   * **REST catalogs**: REST catalogs your cluster will use.

1. Under **Cluster resource configuration**, configure the cluster computing resources:

   * **Worker size**: Number of vCPUs and amount of RAM allocated to each worker.
   * **Worker count**: Minimum and maximum number of workers. The cluster will automatically adjust the number of workers within the specified limits based on the workload.

1. Under **Other settings**, configure the following settings:


   * **Write logs**: Enable this option to write cluster logs.


1. Click **Create cluster**.
1. In the **Select where to create the cluster** window, select a collection and click **Create**.
1. Wait for the cluster creation to complete. The status will change from **Creating** to **Active** on the cluster page.

## Creating an {{ SPRK }} cluster {#create-spark-cluster}

1. In the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section, open the **Clusters** tab, click **Create**, and select {{ SPRK }}.
1. Under **General settings**, specify the following settings:

   * **Name**: Cluster name.
   * **Description** (optional): Brief explanation of the cluster’s purpose.
   * **Environment**: Environment to create the cluster in. The cluster and the REST catalogs it uses must reside in the same cloud and environment. If you do not have the appropriate environment, click **Create** to [set up a new one](manage-environment.md#create-environment).


1. Under **Cluster resource configuration**, configure the cluster computing resources:

   * **Executor size**: Number of vCPUs and amount of RAM allocated to each executor.
   * **Executor count**: Minimum and maximum number of executors.
   * **Driver size**: Number of vCPUs and amount of RAM allocated to each driver.
   * **Driver count**: Minimum and maximum number of drivers.

1. Under **Cluster parameters**, specify additional Python packages in the **Pip packages** field as needed. List package names separated by spaces.

1. Under **Other settings**, enable **Write logs** if you want to have cluster logs written.


1. Click **Create cluster**.
1. In the **Select where to create the cluster** window, select a collection and click **Create**.
1. Wait until the cluster status changes to **Active**.

## Viewing cluster details {#view-cluster}

To view cluster details, navigate to the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section, select the **Clusters** tab, and open the cluster in question.

The **Clusters** tab displays the following information:

* For {{ TR }}: Number of coordinators and active workers, and the maximum resource size.
* For {{ SPRK }}: Number of drivers and active executors, and the maximum resource size.
* In the **About cluster** section: Cluster ID, environment, and engine version.

To open the engine’s web UI, go to the **About cluster** section and click **Go** in the **Web UI** row.

## Updating cluster settings {#update-cluster}

1. In the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section, open the **Clusters** tab and select the cluster.
1. Go to the **Settings** tab.
1. Change the cluster’s computing resource size and scaling limits.
1. Under **Other settings**, update the logging settings.


1. Click **Save changes**.

## Stopping and restarting a cluster {#stop-start-cluster}

{% note warning %}

Stopping the cluster interrupts running queries and prevents new queries from being accepted. This may affect users and tasks that use the cluster.

{% endnote %}

To stop a cluster:

1. In the ![image](../../../../_assets/datalens/compute.svg) **Clusters** section, open the **Clusters** tab and select the cluster.
1. In the top-right corner, click **Stop**.
1. In the confirmation window, click **Stop cluster**.
1. Wait for the **Stopping** status to change to **Stopped**.

To restart a stopped cluster, open its page and click **Start** in the top-right corner. Wait until the cluster status changes to **Active** before running queries and tasks.

## REST catalogs and connections {#catalogs-and-connections}

The {{ TR }} cluster page displays the following tabs:

* **REST catalogs**: List of catalogs used by the cluster. To [start working with a catalog](../rest-catalog/work-with-rest-catalog.md), click its name.
* **Connections**: List of cluster [connections](../../../concepts/connection/index.md). To open a connection, click its name.

To search the lists, use the **Name** field. To create an object, click **Create** on the relevant tab.

