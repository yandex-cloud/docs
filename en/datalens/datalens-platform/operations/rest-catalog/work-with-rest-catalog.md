---
title: Working with a REST catalog in {{ datalens-platform-full-name }}
description: Follow this guide to edit the settings for REST catalogs and namespaces, as well as manage access to them.
---

# Managing a REST catalog

Once you have created a REST catalog, you can edit its settings and the settings of its namespaces, as well as manage access to them.

## Editing REST catalog settings {#edit-rest-catalog}

You can view all created REST catalogs in the ![image](../../../../_assets/console-icons/compass.svg) **Navigation** section, under **REST catalogs**. To change the REST catalog settings:

1. Find the catalog in the list. To quickly find it by name, enter part of the name in the **Search by name** field above the list.
1. Hover over the catalog row and click ![image](../../../../_assets/console-icons/ellipsis.svg) on the right side of the row.
1. In the menu that opens, select ![image](../../../../_assets/console-icons/pencil.svg) **Edit**.
1. In the editing form, modify the catalog parameters and save your changes.

To delete a REST catalog:

1. Find the catalog in the list. To quickly find it by name, enter part of the name in the **Search by name** field above the list.
1. Hover over the catalog row and click ![image](../../../../_assets/console-icons/ellipsis.svg) on the right side of the row.
1. In the menu that opens, select ![image](../../../../_assets/console-icons/trash-bin.svg) **Delete**. Confirm the deletion.

{% note warning %}

Deleting a REST catalog will remove all namespaces, tables, and views.

{% endnote %}

## Editing namespace settings {#edit-namespace}

In the selected REST catalog, you can view all created namespaces, edit their settings, or [create a new namespace](create-namespace.md). To change namespace settings:

1. Find the required namespace in the list. To quickly find it by name, enter part of the name in the **Search by name** field above the list.
1. Hover over the namespace row and click ![image](../../../../_assets/console-icons/ellipsis.svg) on the right side of the row.
1. In the menu that appears, select ![image](../../../../_assets/console-icons/pencil.svg) **Edit**, change its description, and save your changes.
1. Click the bucket name in the namespace row and change the value for the maximum bucket size. Save your selection.

## Managing access for a REST catalog {#access-rest-catalog}

Access permissions determine who can work with a REST catalog or namespace, and with what level of authority. Access is granted to users, service accounts, and groups. You can assign a role to a new user or modify the role of someone who already has access. 

The following types of access to REST catalog data, namespaces, or tables are distinguished:

   * `Limited viewer`
   * `Viewer`
   * `Editing`
   * `Admin`

For more details on access levels for a REST catalog, see [this section](../../security/roles.md).

To grant permissions for working with a REST catalog or namespace:

1. Open the **Navigation** page and go to the **REST catalogs** tab.
1. Hover over the row next to the catalog or select a namespace inside it, then click ![image](../../../../_assets/console-icons/ellipsis.svg) on the right.
1. In the menu that opens, select ![image](../../../../_assets/console-icons/persons.svg) **Access permissions**.
   The **Access permissions** window will open, displaying a list of users who have access to the catalog or namespace. For each user, their name, email or type (e.g., **Service account** or **Group**), and current access level (e.g., **Admin**) are displayed.
1. Hover over the user row and click ![image](../../../../_assets/console-icons/gear.svg) on the right.
1. Set up permissions:
   * **Direct permissions** block: roles assigned to a user directly for this resource (**Current object**). To grant access, click ![image](../../../../_assets/console-icons/plus.svg) **Add access**.
   * **Inherited permissions** block: Contains roles that a user has acquired through inheritance from parent objects. If there are none, **No inherited roles** is displayed.
1. In the **Add access** list, select the required access and save your changes.