# Request permissions

To request permission to a directory or object that:

{% list tabs %}

- You have no access to

   1. On the navigation page, find the relevant directory or object and click on it.

      {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

   1. Enter a username, select the permissions, and click **Request**.

- You have access to

   1. On the navigation page, find the relevant directory or object.

      {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

   1. Click the ![image](../../../_assets/datalens/horizontal-ellipsis.svg) by the object or directory and select **Permissions**.
   1. In the window that appears, click **Request**.
   1. Enter a username, select the permissions, and click **Request**.

{% endlist %}

{% note info %}

{% if audience == "internal" %}

A request is stored for 90 days. The expiration of this period triggers an automatic denial, which is recorded in the change history.

{% else %}

A request is stored for a year. The expiration of this period triggers an automatic denial, which is recorded in the change history.

{% endif %}

{% endnote %}