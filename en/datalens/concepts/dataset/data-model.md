# Data model

Data in a dataset is represented as fields.

## Data fields {#field}

The fields define the structure and format of the dataset. The following types of fields are available:

- **Dimension**. Contains values that define data characteristics, such as city, date of purchase, or product category. The aggregation function is not applied to fields with a dimension, otherwise the field becomes an measure. In the interface, dimensions are displayed in green.
- **Measure**. Contains numeric values that aggregation functions (information) are applied to, such as the amount of clicks and the number of click-throughs. If you remove the aggregation function from this field, it becomes a dimension. In the interface, measures are displayed in blue.

In the dataset creation interface and wizard, you can duplicate fields, create fields, and use [aggregation functions](#aggregation).

{{ datalens-short-name }} allows you to create calculated fields using formulas.
To write formulas, you can use existing dataset fields, constants, and functions.
For a full list of functions, see [Function reference](../../function-ref/all.md).

To learn more about calculated fields, see [{#T}](../calculations.md).

## Data aggregation {#aggregation}

The following aggregation functions are available for fields with different data types:

| Functions | Description | Supported types |
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

