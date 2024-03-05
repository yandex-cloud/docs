# Managing bindings

[Bindings](../concepts/glossary.md#binding) contain information about a connection, data format, and data schema. You can use different bindings in the same query.

## Creating a binding {#create}

To create a binding:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a binding.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. Select the type of connection to create a binding for: `{{ ui-key.yql.yq-connection.datastreams.select-item }}` or `{{ ui-key.yql.yq-connection.object-storage.select-item }}`.
   1. Select a connection or create a new one.

1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. Enter a name and description for the binding. The naming requirements are as follows:

      {% include [name-format](../_includes/connection-name-format.md) %}

   1. For the {{ yds-short-name }} connection type, select a data stream or create a new one.
      For the {{ objstorage-short-name }} connection type, specify the bucket path.
   1. (Optional) Select the compression algorithm.
   1. Select data binding format.
   1. Add columns:

      * Enter a name for the column.
      * Select the column type.
      * Enable the **{{ ui-key.yql.yq-binding-form.field-type-required.title }}** option if needed.

1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Getting information about a binding {#get-info}

1. In the [management console]({{ link-console-main }}) , select the folder where you created the binding.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. In the line with the binding name, click ![info](../../_assets/console-icons/circle-info.svg).
   Under the list of bindings, you will see the following binding information:
   **{{ ui-key.yql.yq-binding-info.general.section-header }}**:

     * Data paths.
     * Data format.
     * Compression.

   **{{ ui-key.yql.yq-binding-form.binding-fields.title }}**: List of data binding columns and their types.

   **{{ ui-key.yql.yq-binding-info.connection-parameters.section-header }}**:

     * Type.
     * Information about the source.
     * Authentication.

   **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}**:

     * ID.
     * Creation timestamp.
     * Author.

## Changing a binding {#update}

1. In the [management console]({{ link-console-main }}), select the folder where you want to change the binding.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. In the line with the binding name, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-binding-actions.edit-binding.menu-item-text }}**.
1. Specify new parameters for the data binding. You cannot edit information in the **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}** section.
1. Click **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

## Deleting a binding {#delete}

1. In the [management console]({{ link-console-main }}), select the folder to delete the binding from.
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. In the line with the binding name, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-binding-actions.delete-binding.menu-item-text }}**.
1. Confirm the deletion.
