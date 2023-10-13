# Getting started with {{ cloud-desktop-name }}

{% note info %}

This guide contains information on how to create and set up a [desktop group](concepts/desktops-and-groups.md). If you received a link to the [user desktop showcase](concepts/showcase.md) from an admin, proceed to [{#T}](#get-credentials).

{% endnote %}

Create a {{ cloud-desktop-name }} desktop group in your cloud:

1. [Prepare your cloud](#before-you-begin).
1. [Create a desktop group](#create-desktop-group).
1. [Create a desktop](#create-desktop).
1. [Get the connection credentials](#get-credentials).
1. [Connect to the desktop](#connect-desktop).

## Getting started {#before-you-begin}

1. Log in to or register in the [management console]({{ link-console-main }}). If you do not have an account yet, go to the management console and follow the guide.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. To make sure your desktops have access to the internet, [set up](../vpc/operations/create-nat-gateway.md) a NAT gateway for the [subnets](../vpc/concepts/network.md#subnet) that will host them.

## Create a desktop group {#create-desktop-group}

{% include [create-desktop-group](../_includes/cloud-desktop/create-desktop-group.md) %}

## Create a desktop {#create-desktop}

{% include [create-desktop](../_includes/cloud-desktop/create-desktop.md) %}

## Get the connection credentials {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Connect to the desktop {#connect-desktop}

You can establish a desktop connection using the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
