# Adding a message displayed if an access error occurs

To add a message to be displayed in the event of a dashboard permission error:


{% include [datalens-workbooks-collections-select-note](../../../_includes/datalens/operations/datalens-workbooks-collections-select-note.md) %}


1. In the left-hand panel, click ![image](../../../_assets/datalens/dashboard-0523.svg) **Dashboards** and select the dashboard you need. If you do not have a dashboard, [create one](../dashboard/create.md).
1. In the top-right corner, click **Edit**.
1. At the top of the screen, click ![image](../../../_assets/settings.svg).
1. In **Other settings**, next to the **Access error message** field, click **Configure**.
1. Enter the message text and click **Save**.

   {% note info %}

   The [Markdown](../../dashboard/markdown.md) markup language is supported.

   {% endnote %}

1. In the **Settings** window, click **Save**.
1. In the upper-right corner, click **Save**.

Now, if the user has no dashboard view permission, they'll see the saved message.

To delete a message for a permission request, save an empty message in the **Access error message** window.
