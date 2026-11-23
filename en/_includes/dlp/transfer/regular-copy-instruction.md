1. Navigate to ![image](../../../_assets/console-icons/database-arrow-right.svg) **Data transfer** and click ![image](../../../_assets/console-icons/plus.svg) **Create data transfer**.
1. In the **Select connection** step, specify the [source connection](../../../datalens/concepts/connection/index.md) and proceed to the **Data transfer configuration**.
1. In the transfer type switch, select **Regular copy** for copying with scheduled data updates.
1. Specify the basic transfer settings:
   * In the **Transfer name** field, enter a name the delivery.
   * Optionally, enter the delivery’s purpose in the **Description** field.
   * In the **Database** field, enter the database name in the selected source connection.
   * In the **Collection** field, select a collection from the list. If you do not have an appropriate collection, click **Create** and [create a new one](../../../datalens/workbooks-collections/collections-operations.md#create-collections).
   * Optionally, add a label for searching and filtering the delivery.
1. Under **Destination**, specify where to deliver the data:
   * In the **REST catalog** field, select a [REST catalog](../../../datalens/datalens-platform/operations/rest-catalog/create-rest-catalog.md).
   * In the **Namespace** field, select a namespace within the selected catalog. If you do not have an appropriate namespace, click **Create** and [create a new one](../../../datalens/datalens-platform/operations/rest-catalog/create-namespace.md).
1. Under **Transfer parameters**, configure the schedule and included data:
   * In the **Frequency** field, select the update frequency, e.g., **Monthly**, and, in the field below, specify a start day and time, e.g., `1 at 12:00`.
   * Select which tables to transfer in the **Tables to transfer** field:
     * **All tables**: Transfer all tables from the source.
     * **List**: Specify the tables to deliver in separate fields.
   * Optionally, under **Partial table transfer**, configure incremental copying by the cursor column.

     {% cut "Configuring incremental tables" %}

     With incremental copying, each transfer starts copying only those rows whose cursor column value exceeds the one saved from the previous start. As the result, only the new data is sent to the target, not the entire table.
     You can fill each section in two modes that you can switch using buttons on the right side of its header: each field separately or in table format. Each configured table is displayed as a separate numbered section (**Table 1**, **Table 2**, etc.). To delete a table, click ![image](../../../_assets/console-icons/trash-bin.svg) in its header.
     For each incremental table, specify these settings:
     * Optionally, in the **Table namespace** field, specify the namespace (schema) of the table in the source. If you need the default namespace, you can leave this field empty.
     * In the **Table name** field, specify the name of the table to configure incremental copying for.
     * In the **Cursor column** field, specify a column to track new data in, e.g., a monotonously incrementing ID or a column with date and time of the record change.
     * Optionally, in the **Initial value** field, specify the cursor value to start copying data from on the first start. If you leave the field empty, copying will start from the earliest available value.

     {% endcut %}

1. Click **Create transfer**.
