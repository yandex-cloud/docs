---
title: Getting started with {{ cloud-desktop-name }} for administrators
description: This guide describes how you can create and set up a desktop group.
---

# Getting started with {{ cloud-desktop-full-name }} for administrators

{% note info %}

Follow this guide to create and set up a [desktop group](concepts/desktops-and-groups.md). If you received a link to the [user desktop showcase](concepts/showcase.md) from an administrator, go to [{#T}](quickstart-users.md).

{% endnote %}

{{ cloud-desktop-name }} is a virtual desktop infrastructure management service.

Create a {{ org-full-name }} [user group](../organization/concepts/groups.md) and deploy a {{ cloud-desktop-name }} [desktop group](./concepts/desktops-and-groups.md) for it:

1. [Get your cloud ready](#before-you-begin).
1. [Create a user group](#create-user-group).
1. [Deploy a desktop group](#create-desktop-group).
1. [Configure an ACL for the desktop group](#setup-acl).
1. [Create a desktop](#create-desktop).
1. [Get the connection credentials](#get-credentials).
1. [Connect to the desktop](#connect-desktop).

## Getting started {#before-you-begin}

1. Log in to the [management console]({{ link-console-main }}) or sign up. If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).
1. [Assign](../iam/operations/roles/grant.md) these _minimum_ roles to your {{ yandex-cloud }} account:
    * [organization-manager.admin](../organization/security/index.md#organization-manager-admin) for the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud): To create a user group.
    * [vdi.admin](./security/index.md#vdi-admin) for the [folder](../resource-manager/concepts/resources-hierarchy.md#folder): To create a desktop group and assign an [ACL](./concepts/acl.md) to it.

    If you have a primitive [admin](../iam/roles-reference.md#admin) role for a folder, you do not need to assign any additional roles.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. To make sure your desktops have access to the internet, [set up](../vpc/operations/create-nat-gateway.md) a NAT gateway for the [subnets](../vpc/concepts/network.md#subnet) that will host them.

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

Follow this guide to create a desktop group based on pre-installed `Ubuntu 20.04 LTS`. Also, you can:

* [{#T}](operations/images/create-from-compute-linux.md)
* [{#T}](operations/images/create-from-windows.md)

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your desktop group.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Enter a name for the desktop group.
  1. Select **{{ ui-key.yacloud.vdi.section_type }}**: **{{ ui-key.yacloud.vdi.value_type-personal }}**. Desktops are assigned to users on their first sign-in and remain reserved for them.
  1. Under **{{ ui-key.yacloud.vdi.section_desktop }}**, specify:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}**: `2`, maximum number of desktops per group.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}**: `1`, number of desktops kept always loaded for quick user access.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}** on the **{{ ui-key.yacloud.component.compute.resources.label_tab-standard }}** tab, click **Basic**.
  1. Select `Ubuntu 20.04 LTS` for the OS [image](./concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Select the boot and data [disk](./concepts/disks.md) [types](../compute/concepts/disk.md#disks-types): `SSD`.
      * Set the boot disk size to `60 GB`.
      * Set the data disk size to `4 GB`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the [cloud network](../vpc/concepts/network.md#network) and [subnets](../vpc/concepts/network.md#subnet) where your desktops will reside.
  1. Under **Desktop users**, click **Add users** and specify those the desktops will be available to:
     * [User groups](../iam/concepts/access-control/public-group.md).
     * [Individual users](../iam/concepts/users/accounts.md).
     * Any user's mail address. The user will be sent an invitation to your organization and assigned a role for desktop access.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Configure an ACL for the desktop group {#setup-acl}

{% include [access-options](../_includes/cloud-desktop/access-options.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. To the right of the desktop group you created earlier, click ![image](../_assets/console-icons/ellipsis.svg) and select **Configure ACL**.
  1. In the **{{ ui-key.yacloud.component.acl-dialog.label_title }}** window, select the user group you created earlier, specify the `vdi.viewer` [role](./security/index.md#vdi-viewer) for it, and click **{{ ui-key.yacloud.common.add }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a desktop {#create-desktop}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, select ![image](../_assets/console-icons/display.svg) **{{ ui-key.yacloud.vdi.label_desktops }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_desktop-create }}**.
  1. Select the desktop group you created earlier.
  1. Specify the subnet for the desktop.

      {% note info %}

      Make sure to [configure a NAT gateway](../vpc/operations/create-nat-gateway.md) in this subnet, so your desktop will have internet access.

      {% endnote %}

  1. Specify the desktop user.
  1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Get the connection credentials {#get-credentials}

{% include [get-credentials](../_includes/cloud-desktop/get-credentials.md) %}

## Connect to the desktop {#connect-desktop}

{% include [rdp-is-using](../_includes/cloud-desktop/rdp-is-using.md) %}

{% include [desktop-connect](../_includes/cloud-desktop/desktop-connect.md) %}
