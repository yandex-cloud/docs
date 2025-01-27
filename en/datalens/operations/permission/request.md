---
title: Request permissions
description: You can request access permissions for a folder or object that you do not have access to. You can also request new access permissions for a folder or object you have view access to.
---

# Requesting permissions

{% note info %}

To view access permissions for a dashboard with the [access error message](../../dashboard/settings.md#message-settings) enabled, users need the [{{ permission-write }}](../../security/manage-access.md#permission-write) or [{{ permission-admin }}](../../security/manage-access.md#permission-admin) permissions for this dashboard.

Users with the [{{ permission-read }}](../../security/manage-access.md#permission-read) permission cannot view the list of access permissions for this dashboard or request changing access to it via the {{ datalens-short-name }} interface.

{% endnote %}

You can request permission to a folder or object that you do not have access to.
You can also request editing permissions to a folder or object that you are allowed to view:

{% list tabs %}

- Requesting permissions

  1. On the [navigation page]({{ link-datalens-main }}/navigation), find the relevant folder or object and click it.

     {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

  1. Enter a username, select the permissions, and click **Request**.

- Editing access permissions

  1. On the [navigation page]({{ link-datalens-main }}/navigation), find the relevant folder or object.

     {% include [nav-filter-note](../../../_includes/datalens/datalens-nav-filter-note.md) %}

  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the object or folder and select **Permissions**.
  1. In the window that opens, click **<object_type> access**, where `<object_type>` is a connection, dataset, chart, or dashboard.
  1. Select the permissions and click **Request**.

{% endlist %}

{% note info %}


A request is stored for a year. The expiration of this period triggers an automatic denial, which is recorded in the change history.


{% endnote %}
