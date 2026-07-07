# Managing bindings

[Bindings](../concepts/glossary.md#binding) contain information about the connection, data format, and schema. You can use several different bindings in a single query.

## Creating a binding {#create}

To create a binding:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a binding.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:
   1. Select the target connection type for the binding: `{{ ui-key.yql.yq-connection.action_datastreams }}` or `{{ ui-key.yql.yq-connection.action_object-storage }}`.
   1. Select an existing connection or create a new one.
1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:
   1. Specify the binding name and description. The naming requirements are as follows:

      {% include [name-format](../_includes/connection-name-format.md) %}

   1. For the {{ yds-short-name }} connection type, select or create a new data stream.
      For the {{ objstorage-short-name }} connection type, specify the bucket path.
   1. Optionally, select the compression algorithm.
   1. Select data binding format.
   1. Add columns:
      * Specify the column name.
      * Select the column type.
      * Enable **{{ ui-key.yql.yq-binding-form.field-type-required.title }}**, if required.
1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Getting binding details {#get-info}

1. In the [management console]({{ link-console-main }}), select the folder where you created the binding.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Find the binding you need in the list and click ![info](../../_assets/console-icons/circle-info.svg) in its row.
   Binding details will appear under the list:
   **{{ ui-key.yql.yq-binding-info.general.section-header }}**:

     * Data paths
     * Data format
     * Compression

   **{{ ui-key.yql.yq-binding-form.binding-fields.title }}**: Data binding columns and their types.

   **{{ ui-key.yql.yq-binding-info.connection-parameters.section-header }}**:

      * Type
      * Source details
      * Authentication

   **{{ ui-key.yql.yq-common-meta-section.meta.section-header }}**:

      * ID
      * Creation timestamp
      * Creator

## Modifying a binding {#update}

1. In the [management console]({{ link-console-main }}), select the folder with the binding you want to update.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Locate the binding you need in the list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yql.yq-binding-actions.edit-binding.menu-item-text }}**.
1. Update the binding settings. Note that the **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}** section settings are read-only.
1. Click **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

## Deleting a binding {#delete}

1. In the [management console]({{ link-console-main }}), select the folder containing the binding you want to delete.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
1. Locate the binding you need in the list, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) in its row, and select **{{ ui-key.yql.yq-binding-actions.delete-binding.menu-item-text }}**.
1. Confirm the deletion.
