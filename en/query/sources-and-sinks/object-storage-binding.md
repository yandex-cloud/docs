# Reading data from {{ objstorage-name }} using {{ yq-name }} bindings

There are cases when you need to run the same data queries on a regular basis. To avoid entering all the details of handling this data each time you make a query, you can use bindings.

Sample data read query using bindings:

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
1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, go to the **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.connection-type.title }}** field, select `{{ ui-key.yql.yq-connection.action_object-storage }}`.
   1. In the **{{ ui-key.yql.yq-binding-form.connection.title }}** field, select an existing connection or [create a new one](./object-storage.md#create_connection).

1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.binding-name.title }}** field, specify the binding name.
   1. In the **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** field, specify the [path to bucket data](object-storage.md#path_format). Parts of file names can be specified using `/*`, such as `yellow/*.csv`.
   1. In the **{{ ui-key.yql.yq-binding-info.compression.label-text }}** field, specify the [data compression](formats.md#compression) method.
   1. In the **{{ ui-key.yql.yq-binding-info.format.label-text }}** field, specify the [format of stored data](formats.md#formats).
   1. List data columns and their types.
   1. Select a partitioning mode and list [partitioning columns](../concepts/partitioning.md) and their types.

      If you are using the **{{ ui-key.yql.yq-binding-form.projection-radio.enabled.label }}** mode, specify the [partition projection](../concepts/partition-projection.md) columns.

1. To check the data, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
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

* `<binding>`: Name of the previously created data binding.

## Example of reading data using bindings {#binding-example}

Sample query to read data from {{ objstorage-short-name }} using bindings:

```sql
SELECT
    *
FROM
    `binding_name`
```

Where `binding_name` is the name of binding to {{ objstorage-short-name }} data.
