---
title: Reading data via bindings
description: In this article, you will learn how to create a data binding and read data from {{ yds-full-name }} using {{ yq-full-name }}.
---

# Reading data via bindings

Data bindings allow you to regularly query {{ yds-full-name }} data without having to specify connection settings and data format in each query.

Example of reading data using bindings:

```sql
SELECT
    JSON_VALUE(CAST(Data AS Json), "$.action") AS action
FROM bindings.`input_stream`
LIMIT 10;
```

{% include [limit](../_includes/select-limit.md) %}

## Setting up a data binding {#binding-settings}

To create a binding to read data from {{ yds-full-name }}:

1. [Set up a data connection](./data-streams.md#create_connection).
1. [Navigate]({{ link-console-yq }}) to **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
1. In the left-hand panel, switch to the **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}** tab.
1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.connection-type.title }}** field, select `{{ ui-key.yql.yq-connection.action_datastreams }}`.
   1. In the **{{ ui-key.yql.yq-binding-form.connection.title }}** field, select the connection you created in the first step.

1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

   1. In the **{{ ui-key.yql.yq-binding-form.binding-name.title }}** field, specify the binding name.
   1. In the **{{ ui-key.yql.yq-binding-form.binding-stream.title }}** field, enter the name of the data stream in {{ yds-full-name }}.
   1. In the **{{ ui-key.yql.yq-binding-info.compression.label-text }}** field, specify the [data compression](formats.md#compression) method.
   1. In the **{{ ui-key.yql.yq-binding-info.format.label-text }}** field, specify the [data format](formats.md#formats).
   1. In the **{{ ui-key.yql.yq-binding-form.binding-fields.title }}** fields, specify the list of columns and their data types.

1. To validate the data, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**.
1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

## Data model {#data-model}

Data is transmitted via {{ yds-full-name }} in binary format. To read data using a binding, use an SQL statement of the following format:

```sql
SELECT
    <expression>
FROM bindings.`<binding_name>`
WHERE
    <filter>;
```

Where:

* `<statement>`: Statement that determines the result of the query.
* `<binding_name>`: Name of the data binding you created earlier.
* `<filter>`: Data filtering condition.

## Data reading example {#binding-example}

Query example for reading data from {{ yds-full-name }} via bindings:

```sql
$data =
SELECT
    JSON_VALUE(Data, "$.host") AS host,
    JSON_VALUE(Data, "$.count") AS count,
    JSON_VALUE(Data, "$.tag") AS tag,
FROM
(
    SELECT
        CAST(Data AS Json) AS Data
    FROM bindings.`binding_name`
)
WHERE
    JSON_VALUE(Data, "$.tag") = "my_tag";

SELECT
    *
FROM
    $data
LIMIT 10;
```

Where:

#|
|| **Field** | **Type** | **Description** ||
|| `binding_name` |  | Name of the binding to the data source stream. ||
|| `host` | String | Host name. ||
|| `count` | String | Number of events. ||
|| `tag` | String | Event tag. ||
|#
