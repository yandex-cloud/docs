---
title: "{{ datalens-full-name }} data types"
description: "{{ datalens-name }} uses multiple data sources whose fields may take different data types. To enhance data management, {{ datalens-name }} converts the source data types to its own. This optimizes data operations. You can change the field data type in the dataset interface and in the wizard."
---

# {{ datalens-full-name }} data types

{{ datalens-short-name }} uses multiple data sources whose fields may take different data types.

To streamline the data operations, {{ datalens-short-name }} converts the source data types to its own types.
This optimizes data operations. For more information, see [{#T}](../dataset/types-lookup-table.md).

You can change the field data type in the dataset interface and in the wizard.


{% note warning %}

When you upload a CSV file as a [data source](../operations/connection/create-file.md), {{ datalens-short-name }} tries to automatically detect the types of data in its fields.
If it can't identify the data type, DataLens sets the `String` data type for the field.

You can use the dataset interface or the wizard to change the field data type.

{% endnote %}


## Geopoint {#geopoint}

A coordinate point defined by latitude and longitude. In {{ datalens-short-name }}, it's set using the [GEOPOINT](../function-ref/GEOPOINT.md) function.

As an input, the function accepts the `String` and `Geopoint` data types, or two values of the `Fractional number` or `String` type.
If a single string is input, it must contain a list of two numbers in JSON format.

If the source data is a string like `"[55.75222,37.61556]"`, you can use the dataset interface or wizard to change the field data type without a formula.

{% note info %}

{% include notitle [get-geo](../../_qa/datalens/get-geo.md) %}

{% endnote %}

#### Example notation {#geopoint-example}

```sql
GEOPOINT("[55.7912,37.6872]")
GEOPOINT("[55.8538,37.6312]")
```

## Geopolygon {#geopolygon}

Several coordinate points defining the polygon on the map. In {{ datalens-short-name }}, you create one using the [GEOPOLYGON](../function-ref/GEOPOLYGON.md) function.
The [Even-Odd](https://en.wikipedia.org/wiki/Even–odd_rule) algorithm is used to fill in the polygon. This way you can create polygons with holes.

The function accepts strings in `"[[[v1,v1], [v2,v2]], ..., [[vN-1,vN-1], [vN,vN]]]"` format. If the source data is in this format, you can use the dataset interface or wizard to change the field data type without a formula.

{% note info %}

{% include notitle [get-geo](../../_qa/datalens/get-geo.md) %}

{% endnote %}

#### Example notation {#geopolygon-example}

```sql
/* Polygon without a hole */
GEOPOLYGON("[[[55.79421,37.65046],[55.79594,37.6513],[55.79642,37.65133],[55.7969, 37.65114],[55.79783, 37.65098],[55.78871,37.75101]]]")

/* Polygons with a hole */
GEOPOLYGON("[[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
GEOPOLYGON("[[[55.75,37.50],[55.80,37.60],[55.75,37.70],[55.70,37.70],[55.70,37.50]],[[55.75,37.52],[55.75,37.68],[55.65,37.60]],[[55.79,37.60],[55.76,37.57],[55.76,37.63]]]")
```

## Date {#date}

Date without specified time.

When you use a date in formulas, make sure to use hash `#` around it. For example, `DATETRUNC(#2018-07-12#, "year", 5)`.

You can convert the source data type to `Date` using the [DATE](../function-ref/DATE.md) and [DATE_PARSE](../function-ref/DATE_PARSE.md) functions.

#### Example notation {#date-example}

```sql
#2018-01-18#
#2015-01-01#
DATETRUNC(#2018-07-12#, "year", 5)
DATEADD(#2018-01-12#, "day", 6)
```


## Date and time (deprecated) {#datetime-old}

Date with specified time (the value is converted to [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)).

When you use date and time in formulas, make sure to use hash `#` around it. For example, `DATEADD(#2018-01-12 01:02:03#, "second", 6`).

You can convert the source data type to `Date and time (deprecated)` using the [DATETIME](../function-ref/DATETIME.md) and [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md) functions.

#### Example notation {#datetime-old-example}

```sql
#2018-01-12 01:08:03#
#2018-05-01T#
DATEADD(#2018-01-12 01:02:03#, "second", 6)
DATETRUNC(#2018-07-12 11:07:13#, "month", 4)
```

#### Phasing out the Date and time (deprecated) type {#datetime-deprecation}

* Starting September 6 2022, you can use the new [Date and time](#datetime) type, without conversion to UTC.

* October 12, 2022:

  * In all datasets, the fields of the `Date and time (deprecated)` type will be replaced with fields of the `Date and time` type.
  * Using a hash `#` will no longer convert constant values to UTC.
  * The [DATETIME](../function-ref/DATETIME.md) and [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md) functions will no longer convert expressions to UTC.


## Date and time {#datetime}

Date with a specified time (the value is not converted to [UTC](https://en.wikipedia.org/wiki/Coordinated_Universal_Time)).

When you use date and time in formulas, make sure to use a double hash `##` around it. For example, `DATEADD(#2018-01-12 01:02:03#, "second", 6)`.

You can convert the source data type to `Date and time` using the [DATETIME](../function-ref/DATETIME.md) and [DATETIME_PARSE](../function-ref/DATETIME_PARSE.md) functions.

#### Example notation {#datetime-example-tmp}

```sql
##2018-01-12 01:08:03##
##2018-05-01T##
DATEADD(##2018-01-12 01:02:03##, "second", 6)
DATETRUNC(##2018-07-12 11:07:13##, "month", 4)
```

## Floating-point number {#float}

Decimal number. The dot is used as a decimal separator.

You can convert the source data type to a `Floating-point number` using the [FLOAT](../function-ref/FLOAT.md) function.

{% note warning %}

When you convert the `decimal` type to `Floating-point number`, you may lose precision.

{% endnote %}

#### Example notation {#float-example}

```sql
1.47113
0.62024
FLOAT("34.567")
```

## Boolean {#boolean}

A boolean type that can take one of two possible values: `TRUE` or `FALSE`.

You can convert the source data type to `Boolean` using the [BOOL](../function-ref/BOOL.md) function.

#### Example notation {#boolean-example}

```sql
FALSE
```

## String {#string}

A string containing text. It is enclosed in single or double quotes.
If you enclose your string in one type of quotes, you can use the second quote type inside the string without escaping.
For example, `'Double quoted "example" and one " double quote.'`

You can use the following characters inside strings:

* `\n`: Line feed (LF).
* `\r`: Carriage return (CR).
* `\t`: Tab.
* `\"`: Double quote.
* `\'`: Single quote.
* `\\`: Backslash.

You can convert the source data type to `String` by using the [STR](../function-ref/STR.md) function.

#### Example notation {#string-example}

```sql
"String"
'String with a "substring"'
```

## Integer {#integer}

A number with no no fractional part.

You can convert the source data type to `Integer` by using the [INT](../function-ref/INT.md) function.

#### Example notation {#integer-example}

```sql
42
157
```

## Array {#array}

A structure made up of a series of elements of the same type.

{{ datalens-short-name }} supports the processing of columns in one-dimensional arrays for the following databases: {{ CH }} and {{ PG }}. Array elements can be the following types:

* `Integer`
* `Floating-point number`
* `String`

{% note warning %}

You cannot define an array inside {{ datalens-short-name }}.

{% endnote %}

#### Example notation {#array-example}

```sql
[1, 2, 3]
[1.1, 1.2, 1.3]
["Cheese", "Bread"]
```

## Tree of strings {#tree-hierarchy}

{{ datalens-short-name }} lets you create tree hierarchies. To do this, use the **Tree of strings** field type. Data is stored as an [array](#array) with a full path for each node. The sequence of array values determines in what order the tree is expanded.

{% note info %}

A tree can only be used in a **Table** chart.

{% endnote %}

### Creating a tree {#how-to-create-tree}

To create a tree, add a [calculated field](../operations/dataset/create-calculated-field.md) at the dataset or chart level using the formula `TREE(ARRAY([lev_1],[lev_2],[lev_3],[lev_n]))`, where `[lev_1]`,`[lev_2]`,`[lev_3]`, and `[lev_n]` are dataset fields that determine the tree hierarchy.

{% cut "Example of creating a tree for a source DB that contains no data array" %}

1. Prepare data in the source:

   1. Create a table with columns containing hierarchy values.

      {% cut "Example of creating a table in {{ PG }}" %}

      ```sql
      CREATE TABLE table_without_tree (
         id serial primary key,
         country text,
         region text,
         city text
      );
      ```

      {% endcut %}

   1. Add data with a full path for each tree node to the table.

      {% cut "Example of adding data to {{ PG }}" %}

      ```sql
      INSERT INTO table_without_tree (country, region, city)
      VALUES('Russia', 'Altay', 'Barnaul');

      INSERT INTO table_without_tree (country, region, city)
      VALUES('Russia', 'Altay', 'Biysk');

      INSERT INTO table_without_tree (country, region, city)
      VALUES('Russia', 'Altay', 'Aleisk');
      ```

      {% endcut %}

1. In a dataset, create:

   * **Array of strings** calculated field that describes the tree. For example, the `position` field with the `ARRAY([country], [region], [city])` formula.
   * **Tree of strings** calculated field. For example, the `hierarchy` field with the `TREE([position])` formula, where `position` is a field of the **Tree of strings** type describing the tree.

      {% note tip %}

      You can create an array and tree of strings in one field with the `TREE(ARRAY([country], [region], [city]))` formula.

      {% endnote %}

{% endcut %}

{% cut "Example of creating a tree for a source DB that contains an array of data" %}

1. Prepare data in the source:

   1. Create a table with an array of strings.

      {% cut "Example of creating a table in {{ PG }}" %}

      ```sql
      CREATE TABLE table_with_tree (
        id serial primary key,
        position text[]
      );
      ```

      {% endcut %}

   1. Add data as an array with a full path for each tree node to the table.

      {% cut "Example of adding data to {{ PG }}" %}

      ```sql
      INSERT INTO table_with_tree (position)
      VALUES('{"Russia","Altay","Barnaul"}');

      INSERT INTO table_with_tree (position)
      VALUES('{"Russia","Altay","Biysk"}');

      INSERT INTO table_with_tree (position)
      VALUES('{"Russia","Altay","Aleisk"}');
      ```

      {% endcut %}

1. In a dataset, create a **Tree of strings** calculated field. For example, the `hierarchy` field with the `TREE([position])` formula, where `position` is a field of the **Tree of strings** type describing the tree.

{% endcut %}

### Using trees in charts {#how-to-use-tree}

You can use the prepared source data to create a tree in a **Table** chart:

1. [Create](../visualization-ref/table-chart.md#create-diagram) a **Table** chart.
1. Drag a dimension with the **Tree of strings** type to the **Columns** section. You'll see a tree hierarchy in the visualization area. Expand or collapse the tree using **+** or **-**, respectively.

   {% note info %}

   You can only use tree dimensions in the chart.

   {% endnote %}

1. Add the required measures to the **Columns** section.

   ![image](../../_assets/datalens/concepts/chart-tree-hierarchy.png)

### Limitations {#tree-restrictions}

In the current version, a tree hierarchy has the following limitations:

* One tree/hierarchy per chart.
* You can't use the **Pagination** option and **Total** row in a tree table.
* The tree expansion state is not remembered.
* Selectors do not support trees.
* A source should store intermediate tree nodes, even those with no data available.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}