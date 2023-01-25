# Getting started with {{ cloud-desktop-name }}

Create a {{ cloud-desktop-name }} desktop group in your cloud:

1. [Prepare your cloud](#before-you-begin).
1. [Create a desktop group](#create-desktop-group).
1. [Create a desktop](#create-desktop).
1. [Connect to the desktop](#connect-desktop).

## Before you begin {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).


## Create a desktop group {#create-desktop-group}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your [desktop group](concepts/desktops-and-groups.md) in.

   1. In the list of services, select **Cloud Desktop**.

   1. Click **Create desktop group**.

   1. Enter a name and description of the desktop group.

   1. Under **Computing resources**:

      * Choose a [platform](../compute/concepts/vm-platforms.md).
      * Specify the [guaranteed share](../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.

   1. Under **Network settings**, select a [cloud network](../vpc/concepts/network.md) and subnets from the list.

   1. Click **Create**.

{% endlist %}

## Create a desktop {#create-desktop}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your [desktop](concepts/desktops-and-groups.md) will be created.
   1. In the list of services, select **Cloud Desktop**.
   1. On the left-hand panel, select ![image](../_assets/cloud-desktop/desktops.svg) **Desktops**.
   1. Click **Create desktop**.
   1. Select the desktop group where you want to create your desktop.
   1. Specify yourself as the user that the desktop is created for.
   1. Click **Create**.

The desktop appears in the list. To connect to the created desktop, download the RDP file.

{% endlist %}

## Connect to the desktop {#connect-desktop}

{% include notitle [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
