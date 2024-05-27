---
title: "How to add a message to be displayed in the event of a dashboard permission error in {{ datalens-full-name }}"
description: "Follow this guide to add a message to be displayed if a dashboard permission error occurs."
---

# Adding an access error message

To add a dashboard [access error message](../../dashboard/settings.md#message-settings):


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](../dashboard/create.md).
1. In the top-right corner, click **Edit**.
1. At the top of the screen, click ![image](../../../_assets/console-icons/gear.svg).
1. In **Other settings**, next to the **Access error message** field, click **Configure**.
1. Enter the message text and click **Save**.

   {% note info %}

   The [Markdown](../../dashboard/markdown.md) markup language is supported.

   {% endnote %}

1. In the **Settings** window, click **Save**.
1. In the top-right corner, click **Save**.

Now, if the user has no dashboard view permission, they will see the saved message.

{% include [datalens-access-message-note](../../../_includes/datalens/datalens-access-message-note.md) %}

To delete a message for a permission request, save an empty message in the **Access error message** window.
