# Reading data from {{ objstorage-name }} via {{ yq-name }} data bindings

When you need to run the same queries repeatedly, you can use bindings to avoid specifying all query details each time.

Query example for reading data via a binding:

```sql
SELECT
    *
FROM
    `logs`
WHERE
    version>1
```

## Setting up a data binding {#binding-settings}

To create a binding to read data from {{ objstorage-short-name }}:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a binding.
1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.connection-type.title }}** field, select `{{ ui-key.yql.yq-connection.action_object-storage }}`.
   1. In the **{{ ui-key.yql.yq-binding-form.connection.title }}** field, select an existing connection or [create a new one](./object-storage.md#create_connection).

1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.binding-name.title }}** field, specify the binding name.
   1. In the **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** field, specify the [path to bucket data](object-storage.md#path_format). You can specify parts of file names using `/*`, e.g., `yellow/*.csv`.
   1. In the **{{ ui-key.yql.yq-binding-info.compression.label-text }}** field, specify the [data compression](formats.md#compression) method.
   1. In the **{{ ui-key.yql.yq-binding-info.format.label-text }}** field, specify the [data storage format](formats.md#formats).
   1. Select a partitioning mode and specify the list of [partition columns](../concepts/partitioning.md) with their types.

      For the **{{ ui-key.yql.yq-binding-form.projection-radio.enabled.label }}** mode, specify the [partition projection](../concepts/partition-projection.md) columns.
   1. Specify the data columns and their types.
   
      Alternatively, you can click **Detect columns** to do this automatically.

1. To validate the data, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Data model {#data-model}

{{ objstorage-short-name }} stores data as binary files. To read data, use the following SQL statement:

```sql
SELECT
    <expression>
FROM
    `<binding>`
WHERE
    <filter>;
```

Where:

* `<binding>`: Name of the data binding you created earlier.

## Example of reading data via bindings {#binding-example}

Query example for reading {{ objstorage-short-name }} data via bindings:

```sql
SELECT
    *
FROM
    `binding_name`
```

Where `binding_name` is the {{ objstorage-short-name }} data binding name.
