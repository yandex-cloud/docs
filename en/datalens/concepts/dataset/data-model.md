---
title: "Data model in Yandex DataLens"
description: "The article describes the data model of the Yandex DataLens service. One or more tables are used as a data source. If several tables are available in the source, they can be joined using the JOIN operator. The union is performed by creating a link. In a link, you specify the fields of the source table and the fields of the table to be joined to."
---

# Data model

Data in a dataset is represented as fields.

## Data source {#source}

One or more tables are used as the data source. If multiple tables are available in the data source, you can merge them using the JOIN operator.
When the tables are joined, a link is created between them. When you create a link, you specify the fields from the source table and merged table.

Tables are linked automatically by the first match in the field name and field data type.

In this case, you can:

- Edit fields in the link.
- Add new links or delete existing links.
- Change the type of the JOIN operator used in the link (INNER, LEFT, RIGHT, FULL).

The JOIN operator is used if the query made from the chart accesses the fields of two or more tables of the dataset.

The JOIN operator is not used if:

- The dataset contains one table.
- The dataset contains multiple tables, but the query accesses the fields of only one of those tables.

## Data fields {#field}

The fields define the structure and format of the dataset. The following types of fields are available:

- **Dimension**. Contains values that define data characteristics, such as city, date of purchase, or product category. The aggregation function is not applied to fields with a dimension, otherwise the field becomes a measure. In the interface, dimensions are displayed in green.
- **Measure**. Contains numeric values that aggregation functions (information) are applied to, such as the amount of clicks and the number of click-throughs. If you remove the aggregation function from this field, it becomes a dimension. In the interface, measures are displayed in blue.

In the dataset creation interface and wizard, you can duplicate fields, create fields, and use [aggregation functions](#aggregation).

{{ datalens-short-name }} lets you create calculated fields using formulas.
To write formulas, you can use existing dataset fields, constants, and functions.
For a full list of functions, see [Function reference](../../function-ref/all.md).

For more information about calculated fields, see [{#T}](../calculations/index.md).

## Data aggregation {#aggregation}

The following aggregation functions are available for fields with different data types:

| Function | Description | Supported types |
| ----- | ----- | ----- |
| No | Without aggregation | All types |
| Average | Arithmetic mean value | `Fractional number`<br/>`Integer` |
| Amount | Number of records | `String`<br/>`Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Number of unique | Number of unique records | `String`<br/>`Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Maximum | Maximum value | `Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Minimum | Minimum value | `Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Amount | Sum of values | `Fractional number`<br/>`Integer` |

{% note info %}

You can't use aggregation functions for some sources.
The sources you can use aggregation functions for are listed in the **Data source support** section on the aggregation function page in the [reference](../../function-ref/aggregation-functions.md).

{% endnote %}

To learn more about data types, see [{#T}](../data-types.md).

#### See also {#see-also}

- [{#T}](../../operations/dataset/create.md)
- [{#T}](../../operations/dataset/create-calculated-field.md)
- [{#T}](../../operations/dataset/materialize.md)

