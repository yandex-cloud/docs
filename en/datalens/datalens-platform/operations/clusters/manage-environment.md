---
title: Managing environments in {{ datalens-platform-full-name }}
description: Create a {{ yandex-cloud }} environment for {{ datalens-platform-short-name }} resources, change its name and description, and delete the environment.
alternate:
  - href: en/datalens/datalens-platform/operations/clusters/manage-environment.md
    type: text/markdown
    title: Markdown version
---

# Managing environments

An [environment](../../concepts/clusters/index.md#environments) defines the cloud infrastructure for {{ datalens-platform-short-name }} REST catalogs and clusters. This section describes the following:

* [Creating an environment](#create-environment).
* [Viewing a list of environments](#list-environments).
* [Updating environment settings](#update-environment).
* [Deleting an environment](#delete-environment).
* [Checking the billing account and quotas](#billing-and-quotas).

## Creating an environment {#create-environment}

### Cloud and network requirements {#before-you-begin}

For your environment to run, you need a {{ yandex-cloud }} cloud [linked to a billing account](../../../../billing/operations/pin-cloud.md).

Before creating an environment, create the following in your cloud:

* [Cloud network](../../../../vpc/operations/network-create.md) with at least one [subnet](../../../../vpc/operations/subnet-create.md).
* [NAT gateway](../../../../vpc/operations/create-nat-gateway.md) in the folder with the network.
* [Route table](../../../../vpc/operations/static-route-create.md) in the same network the the `0.0.0.0/0` route through the NAT gateway.

{% note warning %}

Make sure to associate the route table with the subnet you choose when creating an environment. You must have internet access through the NAT gateway in this subnet. Learn more about a [network, subnet](../../concepts/clusters/index.md#environment-network), and [NAT gateway](../../concepts/clusters/index.md#environment-nat).

{% endnote %}

### Create an environment {#create}

To create an environment:

1. In the left-hand panel, open ![image](../../../../_assets/datalens/compute.svg) **Clusters** and go to the **Environments** tab.
1. Click **Create**.
1. Under **General settings**, specify the environment settings:

   * **Name**: Environment name
   * **Description**: Tasks and users the environment is suitable for. This is an optional setting.
   * **Cloud**: {{ yandex-cloud }} cloud to create resources in. If you do not have an appropriate cloud, click **Create** and configure it in the window that opens.
   * **Network**: Cloud network that meets the [network requirements](#before-you-begin).
   * **Subnet**: One of the subnets in the selected network. Make sure you associated a route table with a route through the NAT gateway with the subnet.

1. Click **Create environment**.

You can use your environment to create [{{ TR }} and {{ SPRK }} clusters](manage-clusters.md), [REST catalogs](../rest-catalog/create-rest-catalog.md), and [{{ AF }} clusters](../airflow/manage-airflow.md#create-cluster).

For these objects to interact with one another, create them within the same cloud and environment.

## Viewing a list of environments {#list-environments}

To open the list of environments, in the left-hand panel, select **Clusters** and go to the **Environments** tab.

The list shows an environment’s name and description, cloud, and creation date. Use the **Name** field for search. To open an environment’s settings, click its name.

## Updating environment settings {#update-environment}

You can change an environment’s name and description on its page. The **Cloud**, **Network**, and **Subnet** fields are only available for viewing.

To update an environment:

1. In the left-hand panel, open ![image](../../../../_assets/datalens/compute.svg) **Clusters** and go to the **Environments** tab.
1. Click the environment name.
1. Under **Main settings**, change the **Name** or **Description** of your environment.
1. Click **Save changes**.


## Deleting an environment {#delete-environment}

To delete an environment:

1. In the left-hand panel, open ![image](../../../../_assets/datalens/compute.svg) **Clusters** and go to the **Environments** tab.
1. In the environment row, click ![image](../../../../_assets/console-icons/ellipsis.svg) and select **Delete**.

## Checking the billing account and quotas {#billing-and-quotas}

The [{{ yandex-cloud }} {{ TR }} and {{ SPRK }} quotas](../../concepts/limits.md) apply to respective clusters. Quotas set the available number of clusters, vCPUs, and RAM amount in the cloud. The are used by all the environments in the cloud. You can only view and change quotas in the {{ yandex-cloud }} management console.

To check parameters of the cloud used by your environment:

1. Under ![image](../../../../_assets/datalens/compute.svg) **Clusters** on the **Environments** tab, open the environment you need.
1. Under **Main settings**, find which cloud is specified in the **Cloud** field.
1. [Make sure the cloud is linked to the billing account](../../../../billing/operations/pin-cloud.md#check-binding).
1. To view quotas, go to the [quotas page in the management console]({{ link-console-quotas }}) and select this cloud.
