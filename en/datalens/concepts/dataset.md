# Datasets

_A dataset_ describes a set of data and its structure. Data in a dataset is represented as fields. For more information, see [{#T}](#data-model).

{{ datalens-full-name }} lets you create datasets based on data sources that have a connection.
Only one table can be a data source for a dataset.

{{ datalens-short-name }} offers several modes for datasets to work with data sources. For more information, see [{#T}](#mode).

## Data model {#data-model}

Data in a dataset is represented as a set of fields.

### Data field {#field}

Fields define the structure and format of a dataset. A field can be one of the following types:

- **Dimension**. Contains values that define data characteristics, such as city, date of purchase, or product category. The aggregation function is not applied to fields with a dimension, otherwise the field becomes an measure. In the interface, dimensions are displayed in green.
- **Measure**. Contains numeric values that aggregation functions (information) are applied to, such as the amount of clicks and the number of click-throughs. If you remove the aggregation function from this field, it becomes a dimension. In the interface, measures are displayed in blue.

When creating datasets, you can duplicate existing fields and create new ones.

### Calculated field {#calculated-field}

{{ datalens-short-name }} lets you create calculated fields using [aggregation functions](#aggregation) and functions available for the data source.

### Data types {#data-types}

{{ datalens-short-name }} offers the following data types:

- `Logical`
- `Date` (in `YYYY-MM-DD` format)
- `Date and time` (in `YYYY-MM-DD hh:mm:ss` format)
- `Fractional number`
- `Integer`
- `String`

### Data aggregation {#aggregation}

The following aggregation functions are available for measures:

| Name | Description | Supported types |
| ----- | ----- | ----- |
| No | Without aggregation | All types |
| Average | Arithmetic mean value | `Fractional number`<br/>`Integer` |
| Amount | Number of records | `String`<br/>`Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Number of unique | Number of unique records | `String`<br/>`Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Maximum | Maximum value | `Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Minimum | Minimum value | `Date`<br/>`Date and time`<br/>`Fractional number`<br/>`Integer` |
| Amount | Sum of values | `Fractional number`<br/>`Integer` |

## Data source operation mode {#mode}

Datasets work with data sources in the following modes:

- Direct access.
- One-time materialization.
- Periodic materialization.

### Direct access {#direct}

All data requests are executed on the data source side.

{% note info %}

If you use the Metrica API as the data source, {{ datalens-short-name }} uses direct data access.

{% endnote %}

### One-time materialization {#single-materialization}

Data is only loaded to the {{ datalens-full-name }} internal storage once. All subsequent requests are processed using the loaded data.
To sync {{ datalens-full-name }} storage with the source, you can reload the data.

{% note info %}

If you use a CSV file as the data source, {{ datalens-short-name }} automatically materializes the dataset.

{% endnote %}

### Periodic materialization {#periodic-materialization}

Data is periodically loaded to {{ datalens-full-name }} storage according to certain rules. The rules are defined in the dataset settings.

## Access management {#access-management}

You can configure dataset permissions. For more information, see [{#T}](../security/index.md).

#### See also {#see-also}

- [{#T}](../operations/dataset/create.md)

