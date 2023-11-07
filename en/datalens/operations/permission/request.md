# Requesting permissions

You can request permission to a folder or object that you do not have access to.
You can also request editing permissions to a folder or object that you are allowed to view:

{% list tabs %}

- Requesting permissions

   1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or object and click it.

      {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

   1. Enter a username, select the permissions, and click **Request**.

- Editing permissions

   1. On the [navigation page]({{ link-datalens-main }}/navigation), find the folder or object.

      {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

   1. Click the ![image](../../../_assets/datalens/horizontal-ellipsis.svg) next to the object or folder and select **Permissions**.
   1. In the window that opens, click **<Object_type> access**, where `<Object_type>` is a connection, dataset, chart, or dashboard.
   1. Select the permissions and click **Request**.

{% endlist %}

{% note info %}


A request is stored for a year. The expiration of this period triggers an automatic denial, which is recorded in the change history.


{% endnote %}