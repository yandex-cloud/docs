---
title: How to configure dashboard access permissions in {{ datalens-full-name }}
description: Follow this guide to configure permissions to a dashboard.
---

# Managing dashboard access



Access settings depend on the dashboard location, either a [workbook](../../workbooks-collections/index.md#enable-workbooks) or a folder.

To find out the dashboard location, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.datalens.component.aside-header.view.switch_dashboards }}** in the left-hand panel. Optionally, use the filter by name to find the dashboard you need.

![image](../../../_assets/datalens/dashboard-navigation.png)

1. ![image](../../../_assets/datalens/icons/square-house.svg): Dashboard stored in a workbook.
1. ![image](../../../_assets/console-icons/folder.svg): Dashboard stored in a folder.

Make sure the user is assigned the required [role](../../security/roles.md#service-roles) to access {{ datalens-name }}. If not, contact your administrator to have them add the user as described in [this guide](../../security/add-new-user.md).

To configure dashboard permissions:

{% list tabs %}

- In a workbook

  1. Assign the user the relevant role for the workbook storing the dashboard. To do this:

     1. Go to the workbook page and click ![image](../../../_assets/console-icons/lock-open.svg) **Access** at the top right.

     1. Click **Add user**.

     1. In the window that opens, select the user, specify their [role](../../security/roles.md#workbook-roles), and click **Save**. The user will get access permissions for the workbook and objects inside it.

- In a folder

  1. In the row with the dashboard, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.datalens.component.access-rights.view.section_main-title }}**.

     ![screen02-1](../../../_assets/datalens/operations/dashboard/manage-access/screen02-1.png)

  1. Click **{{ ui-key.datalens.component.access-rights.view.button_access-to-dash }}**.

     ![screen03-1](../../../_assets/datalens/operations/dashboard/manage-access/screen03-1.png)

  1. Enter a username or select the **All** group.

  1. Optionally, write a comment for the user you are granting permissions to.

  1. Specify the appropriate access permissions and click **{{ ui-key.datalens.component.access-rights.view.button_add }}**.

     ![screen04-1](../../../_assets/datalens/operations/dashboard/manage-access/screen04-1.png)  

  {% endlist %}

{% include [datalens-federation-user-link](../../../_includes/datalens/datalens-federation-user-link.md) %}

