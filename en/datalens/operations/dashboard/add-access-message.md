---
title: How to add a dashboard access permission error message in {{ datalens-full-name }}
description: Follow this guide to add a dashboard access permission error message in {{ datalens-full-name }}.
---

# Adding an access error message in {{ datalens-full-name }}

To add a dashboard [access error message](../../dashboard/settings.md#message-settings):


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](../dashboard/create.md).
1. In the top-right corner, click **Edit**.


1. Click ![image](../../../_assets/console-icons/gear.svg) at the top of the screen. The settings window will open on the right.
1. In the **Other settings** section, next to the **Access error message** field, click ![image](../../../_assets/console-icons/pencil.svg).


1. Enter the message text and click **Save**.

   {% note info %}

   The [Markdown](../../dashboard/markdown.md) markup language is supported.

   {% endnote %}


1. In the top-right corner, click **Save**.

Now, if the user has no dashboard view permission, they will see the saved message.


{% include [datalens-access-message-note](../../../_includes/datalens/datalens-access-message-note.md) %}


To delete a message for a permission request, save an empty message in the **Access error message** window.
