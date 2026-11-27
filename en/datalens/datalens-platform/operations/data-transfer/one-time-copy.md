---
title: One-time copy to {{ datalens-platform-full-name }}
description: Follow this guide to create a _one-time copy_ data transfer in {{ datalens-platform-full-name }}.
alternate:
  - href: en/datalens/datalens-platform/operations/data-transfer/one-time-copy.md
    type: text/markdown
    title: Markdown version
---

# Creating a one-time copy job

[One-time copy](../../concepts/data-transfer/index.md#one-time-copy) is a one-time transfer of data from an external source connection, e.g., a {{ PG }} database, to a storage backed by a [REST catalog](../../concepts/rest-catalog/index.md), with no automatic updates. Unlike a regular data copy, a one-time copy has no schedule. Data is loaded once; to reload the data, you need to rerun the transfer.

{% include [sources](../../../../_includes/dlp/transfer/sources.md) %}

To create a one-time copy job:

1. Navigate to ![image](../../../../_assets/console-icons/database-arrow-right.svg) **Data transfers** and click ![image](../../../../_assets/console-icons/plus.svg) **Create data transfer**.
1. In the **Select connection** step, specify the [source connection](../../../concepts/connection/index.md) and proceed to the **Configure data transfer**.
1. Set the transfer type to **One-time copy** to load the data once with no automatic updates.
1. Specify the basic transfer settings:
   * In the **Transfer name** field, enter a name the transfer.
   * Optionally, enter the transfer’s purpose in the **Description** field.
   * In the **Database** field, enter the database name in the selected source connection.
   * In the **Collection** field, select a collection from the list. If you do not have an appropriate collection, click **Create** and [create a new one](../../../workbooks-collections/collections-operations.md#create-collections).
   * Optionally, add a label for searching and filtering the transfer.
1. Under **Destination**, specify where to transfer the data:
   * In the **REST catalog** field, select a REST catalog.
   * In the **Namespace** field, select a namespace within the selected catalog. This field becomes available only after you select a REST catalog. If you do not have an appropriate namespace, click **Create** and [create a new one](../rest-catalog/create-namespace.md).
1. Under **Transfer settings**, select which tables to transfer in the **Tables to transfer** field:
     * **All tables**: Transfer all tables from the source.
     * **List**: Specify the tables to transfer in separate fields.
1. Click **Create transfer**.

{% include [activate](../../../../_includes/dlp/transfer/activate.md) %}

To check the result:

1. On the ingestion page, open the namespace in the REST catalog.
1. Make sure it contains your selected tables.
1. Open a table and verify its structure and data under **Preview**.

Learn more about [transfer management](manage-transfer.md).
