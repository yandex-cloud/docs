---
title: How to update a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to modify connections.
---

# Editing a connection


{% include notitle [preview](../../_includes/note-preview.md) %}


To change connection settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. In the list of connections, click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection you want to edit.
  1. Select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the required connection parameters, such as description, labels, database server settings, or user authentication information.
  1. Click **{{ ui-key.yacloud.common.apply }}** to save the changes.

{% endlist %}


