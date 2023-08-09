# Managing bindings

[Bindings](../concepts/glossary.md#binding) contain information about a connection, data format, and data schema. You can use different bindings in the same query.

## Creating a binding {#create}

To create a binding:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a binding.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Bindings**.
1. Click ![info](../../_assets/plus.svg) **Create**.
1. Under **Connection parameters**:
   1. Select the type of connection to create a binding for: `{{ yds-short-name }}` or `{{ objstorage-short-name }}`.
   1. Select a connection or create a new one.
1. Under **Data binding parameters**:
   1. Enter a name and description for the binding. The naming requirements are as follows:

      {% include [name-format](../_includes/connection-name-format.md) %}

   1. For the {{ yds-short-name }} connection type, select a data stream or create a new one.
      For the {{ objstorage-short-name }} connection type, specify the bucket path.
   1. (Optional) Select the compression algorithm.
   1. Select data binding format.
   1. Add columns:
      * Enter a name for the column.
      * Select the column type.
      * Enable the **Obligatory** option if needed.
1. Click **Create**.

## Getting information about a binding {#get-info}

1. In the [management console]({{ link-console-main }}) , select the folder where you created the binding.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Bindings**.
1. Click ![info](../../_assets/query/info.svg) next to the name of the desired binding.
   You will see information about the binding under the list of bindings:
   **General**:

     * Data paths.
     * Data format.
     * Compression.

   **Schema**: List of data binding columns and their types.

   **Connection parameters**:

     * Type.
     * Information about the source.
     * Authentication.

   **Meta**:

     * ID.
     * Creation timestamp.
     * Author.

## Changing a binding {#update}

1. In the [management console]({{ link-console-main }}), select the folder where you want to change the binding.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Bindings**.
1. Click ![pencil](../../_assets/query/pensil.svg) next to the name of the desired binding.
1. Specify new parameters for the data binding. You cannot edit information in the **Connection parameters** section.
1. Click **Edit**.

## Deleting a binding {#delete}

1. In the [management console]({{ link-console-main }}), select the folder to delete the binding from.
1. In the list of services, select **{{ yq-full-name }}**.
1. On the left-hand panel, select **Bindings**.
1. Click ![delete](../../_assets/query/delete.svg) next to the name of the appropriate binding.
1. Confirm the deletion.
