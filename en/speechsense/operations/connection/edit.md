---
title: Editing a connection in {{ speechsense-full-name }}
description: Follow this guide to specify additional metadata in a connection.
---

# Editing a connection

After creating a connection, you can edit the description of the existing keys and specify additional metadata. To edit a connection, you need either the `{{ roles-speechsense-admin }}` or `{{ roles-speechsense-editor }}` role for the space.

1. Open the {{ speechsense-name }} [home page]({{ link-speechsense-main }}).
1. Go to the space of your choice.
1. On the **{{ ui-key.yc-ui-talkanalytics.connections.connections }}** tab, find the connection you need and navigate to it.
1. Click ![create](../../../_assets/console-icons/pencil-to-line.svg) **{{ ui-key.yc-ui-talkanalytics.connections.edit-connection-key-value }}**.
1. In the window that opens, edit the required parameters:

   * Connection description.
   * Depending on the type of data, under **{{ ui-key.yc-ui-talkanalytics.dialogs.operator }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.client }}**, **{{ ui-key.yc-ui-talkanalytics.dialogs.bot }}**, **{{ ui-key.yc-ui-talkanalytics.connections.fields.metadata }}**:
   
      * Change the values of the **{{ ui-key.yc-ui-talkanalytics.connections.column.name }}** and **{{ ui-key.yc-ui-talkanalytics.connections.column.description }}** fields for the existing keys.
      * Click **{{ ui-key.yc-ui-talkanalytics.connections.add-key }}** to add more metadata. Make sure to enter the new key name and select a [metadata type](../../concepts/resources-hierarchy.md#connection).

1. Click **{{ ui-key.yc-ui-talkanalytics.common.save }}**.