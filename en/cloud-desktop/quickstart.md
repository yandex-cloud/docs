---
title: Getting started with {{ cloud-desktop-name }}
description: This guide describes how you can create and set up a desktop group.
---

# Getting started with {{ cloud-desktop-full-name }}

{% note info %}

This guide contains information on how to create and set up a [desktop group](concepts/desktops-and-groups.md). If you received a link to the [user desktop showcase](concepts/showcase.md) from an administrator, go to [{#T}](#get-credentials).

{% endnote %}

{{ cloud-desktop-name }} is a service to manage virtual Linux-based desktop infrastructure.

Create a {{ org-full-name }} [user group](../organization/concepts/groups.md) and deploy a {{ cloud-desktop-name }} [desktop group](./concepts/desktops-and-groups.md) for it:

1. [Prepare your cloud](#before-you-begin).
1. [Create a user group](#create-user-group).
1. [Deploy a desktop group](#create-desktop-group).
1. [Configure an ACL for the desktop group](#setup-acl).
1. [Create a desktop](#create-desktop).
1. [Get the connection credentials](#get-credentials).
1. [Connect to the desktop](#connect-desktop).

## Getting started {#before-you-begin}

1. Log in or sign up to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it is in `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. Make sure you have the following _minimum_ roles:
    * [organization-manager.admin](../organization/security/index.md#organization-manager-admin) for the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud): To create a user group.
    * [vdi.admin](./security/index.md#vdi-admin) for the [folder](../resource-manager/concepts/resources-hierarchy.md#folder): To create a desktop group and assign an [ACL](./concepts/acl.md) to it.

    If you have a primitive [admin](../iam/roles-reference.md#admin) role for a folder, you do not need to assign any additional roles.

1. To make sure your desktops have access to the internet, [set up](../vpc/concepts/network.md#subnet) a NAT gateway for the [subnets](../vpc/operations/create-nat-gateway.md) that will host them.

## Create a user group {#create-user-group}

{% list tabs group=instructions %}

- {{ cloud-center }} interface {#cloud-center}

  1. Log in to [{{ org-full-name }}]({{ link-org-cloud-center }}) using an administrator or organization owner account.

  1. In the left-hand panel, select ![groups](../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. In the top-right corner of the page, click ![Circles3Plus](../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Enter a name and description for the [group](../organization/concepts/groups.md).

      The name must be unique within the [organization](../overview/roles-and-resources.md) and follow the naming requirements:

      {% include [group-name-format](../_includes/organization/group-name-format.md) %}

  1. Click **{{ ui-key.yacloud_org.groups.action_create-group }}**.

  1. On the page that opens, go to the **{{ ui-key.yacloud_org.entity.group.title_tab-members }}** tab and click **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

  1. In the window than opens, select the users to deploy a desktop group for.

  1. Click **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

{% endlist %}

## Deploy a desktop group {#create-desktop-group}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your desktop group in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Enter a name for the desktop group.
  1. Select `Ubuntu 20.04 LTS` for the OS [image](./concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Select `SSD` for the boot and working [disk](./concepts/disks.md) [types](../compute/concepts/disk.md#disks-types).
      * Set the boot disk size to `60 GB`.
      * Set the working disk size to `4 GB`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Set the number of vCPU cores to `2`.
      * Select `100%` for the [guaranteed vCPU share](../compute/concepts/performance-levels.md).
      * Set RAM to `8 GB`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the [cloud network](../vpc/concepts/network.md#network) and [subnets](../vpc/concepts/network.md#subnet) to host desktops.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Configure an ACL for the desktop group {#setup-acl}

{% include [access-options](../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. To the right of the desktop group created earlier, click ![image](../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.vdi.button_acl }}**.
  1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window that appears, select the user group you created earlier, specify the `vdi.viewer` [role](./security/index.md#vdi-viewer) for it, and click **{{ ui-key.yacloud.common.add }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a desktop {#create-desktop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_desktop-create }}**.
  1. Select the desktop group you created earlier.
  1. Specify the subnet to place the desktop in.

      {% note info %}

      To provide your desktop with internet access, make sure to [configure a NAT gateway](../vpc/operations/create-nat-gateway.md) in the subnet.

      {% endnote %}

  1. Specify the user that the desktop is created for.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Get the connection credentials {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Connect to the desktop {#connect-desktop}

To establish a desktop connection, use the [Remote Desktop Protocol](https://en.wikipedia.org/wiki/Remote_Desktop_Protocol) (RDP).

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
