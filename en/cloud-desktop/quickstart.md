# Getting started with {{ cloud-desktop-name }}

Create a {{ cloud-desktop-name }} [desktop group](concepts/desktops-and-groups.md) in your cloud:

1. [Prepare your cloud](#before-you-begin).
1. [Create a desktop group](#create-desktop-group).
1. [Create a desktop](#create-desktop).
1. [Get the connection credentials](#get-credentials).
1. [Connect to the desktop](#connect-desktop).

## Getting started {#before-you-begin}

1. Sign in or sign up to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../resource-manager/operations/folder/create.md).
1. To make sure your desktops have access to the internet, [set up](../vpc/operations/create-nat-gateway.md) a NAT gateway for the [subnets](../vpc/concepts/network.md#subnet) that will host them.

## Create a desktop group {#create-desktop-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your desktop group in.
   1. In the list of services, select **Cloud Desktop**.
   1. Click **Create desktop group**.
   1. Enter a name and description of the desktop group.
   1. Select an OS image.
   1. Under **Computing resources**:
      * Choose a [platform](../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed share](../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
   1. Under **Network settings**, select a [cloud network](../vpc/concepts/network.md#network) and subnets from the list.
   1. Click **Create**.

{% endlist %}

## Create a desktop {#create-desktop}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your [desktop](concepts/desktops-and-groups.md) will be created.
   1. In the list of services, select **Cloud Desktop**.
   1. On the left-hand panel, select ![image](../_assets/cloud-desktop/desktops.svg) **Desktops**.
   1. Click **Create desktop**.
   1. Select the previously created desktop group.
   1. Specify the subnet to place the desktop in.
   1. Specify yourself as the user the desktop is being created for.
   1. Click **Create**.

{% endlist %}

## Get the connection credentials {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Connect to the desktop {#connect-desktop}

You can establish a desktop connection using the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
