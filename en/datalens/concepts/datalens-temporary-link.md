---
title: Temporary link in {{ datalens-full-name }}
description: In this article, you will learn how to make a workbook dashboard public using a temporary link in {{ datalens-full-name }}.
---

# Publishing using a temporary link

You can use a temporary link to make a [workbook](../workbooks-collections/index.md) dashboard public for a limited period of time. A link like that can be created by a user with the `Administration` [role](../security/roles.md#datalens-workbooks-admin) for the workbook.

As long as the link is active, any user can use it and view the dashboard without logging in. However, no user can view the chart settings, connections, dataset, or run an SQL query.

{% include [share-note](../../_includes/datalens/datalens-share-note.md) %}

The [rules](./datalens-public.md#rules) for granting access to a dashboard via a temporary link are the same as those for object publishing. Once the link expires, you no longer can use it to access the dashboard.

A user with the `Administration` [role](../security/roles.md#datalens-workbooks-admin) for the workbook the temporary link was created in can [revoke](#link-disable) the link before it expires.

Dashboard views via a temporary link are counted for billing purposes because they are using up the quota for requests from [private embedded objects](../pricing.md#embeds).

## Creating a temporary link {#create-link}

1. In the left-hand panel, select ![collections](../../_assets/console-icons/rectangles-4.svg) **Collections and workbooks**.
1. Open the workbook of interest and select a dashboard.
1. At the top of the object, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, go to the ![image](../../_assets/console-icons/globe.svg) **Public** tab.
1. Under **Temporary link**, click ![image](../../_assets/console-icons/plus.svg) **Create**. In the window that opens:

   1. Select the temporary link active period from the drop-down list: `1 hour`, `2 hour`, `3 hours`, `5 hours`, `10 hours`, or `24 hours`. The maximum validity period for a temporary link is `24 hours`. The default value is `10 hours`.
   1. Click **Create**. A temporary link will be created and copied to the clipboard.

      {% note info %}

      * Via the temporary link, the dashboard and all its linked objects will be available to any internet user.
      * The link from the browser address bar provides access to the dashboard and all its linked objects only to authenticated users with appropriate permissions.

      {% endnote %}

      {% cut "Public access and temporary links" %}
   
      ![image](../../_assets/datalens/concepts/datalens-public/temporary-link.png =465x439)

      {% endcut %}

## Revoking a temporary link {#link-disable}

A user with the `Administration` [role](../security/roles.md#datalens-workbooks-admin) for the workbook the temporary link was created in can revoke the link before it expires.

1. Open the workbook of interest and select a dashboard.
1. At the top of the object, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, go to the ![image](../../_assets/console-icons/globe.svg) **Public** tab.
1. If at least one temporary link is active for the current dashboard, there will be a button in the **Temporary link** section showing the number of active links and the total number of links. Click this button. In the window that opens:

   1. Click ![image](../../_assets/console-icons/trash-bin.svg) (Revoke) next to the link. The temporary link will be revoked, and no user will be able to use it to view the dashboard.
   1. Click **Close**.

      {% cut "Temporary links" %}
   
      ![image](../../_assets/datalens/concepts/datalens-public/temporary-link-list.png =465x300)

      {% endcut %}

## Copying a temporary link {#link-copy}

A user with the `Administration` [role](../security/roles.md#datalens-workbooks-admin) for for the workbook the temporary link was created in can copy the link and share it with another user.

1. Open the workbook of interest and select a dashboard.
1. At the top of the object, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![image](../../_assets/console-icons/arrow-shape-turn-up-right.svg) **Share**.
1. In the window that opens, go to the ![image](../../_assets/console-icons/globe.svg) **Public** tab.
1. If at least one temporary link is active for the current dashboard, there will be a button in the **Temporary link** section showing the number of active links and the total number of links. Click this button. In the window that opens:

   1. Next to the link, click ![image](../../_assets/console-icons/link.svg) (Copy link). Your temporary link will be copied to the clipboard.
   1. Click **Close**.

      {% note info %}

      * Via the temporary link, the dashboard and all its linked objects will be available to any internet user.
      * The link from the browser address bar provides access to the dashboard and all its linked objects only to authenticated users with appropriate permissions.

      {% endnote %}

      {% cut "Temporary links" %}
   
      ![image](../../_assets/datalens/concepts/datalens-public/temporary-link-list.png =465x300)

      {% endcut %}

    If there are no active links, [create](#create-link) a new one.

#### Useful links {#see-also}

* [{#T}](../security/embedded-objects.md)
