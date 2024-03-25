# Formula syntax

The syntax of calculated expressions in {{ datalens-full-name }} is similar to SQL.
For simple expressions, you can use ordinary arithmetic operations:

```
([Sales] - [Profit]) / 10
```

```
[Date] - #2019-01-24#
```

More complex expressions use multiple functions to implement various calculations, aggregations, and conversions of data from one type to another:

```
CONCAT(SUM([Category Sales]) / [Total Sales], ' %')
```

```
DATETRUNC([datetime], 'month')
```

## Dataset fields in calculations {#dataset-fields}

The syntax used for accessing dataset fields is similar to Transact-SQL; in {{ datalens-full-name }}, however, the field name must be enclosed in square brackets (`[]`):

```
[Field name]
```

## Constants {#const}

In addition to fields, operators, and functions, expressions can include constants of different data types:

- Integer: `23`, `-4325653`
- Fractional number: `0.0234`, `-1.0`
- Date: `#2020-01-01#`
- Date and time: `#2020-01-01 11:15:00#`
- String: `"String"`
- Boolean: `TRUE`, `FALSE`
- Geopoint: `GEOPOINT("[55.7912,37.6872]")`

## Operators {#operators}

You can use the following operators in expressions:

- Arithmetic: `+`,` -`,` *`, `/`.

   ```
   ([Sales per Order] * [OrderCount]) - [Profit]
   ```

   ```
   ([Profit] / [Cost Price]) * 100
   ```

   ```
   [City] + " " + "city"
   ```

[Addition (+)](../../function-ref/OP_PLUS.md#description), [subtraction (-)](../../function-ref/OP_MINUS.md#description), and [multiplication (*)](../../function-ref/OP_MULT.md#description) operators behave differently depending on the argument type.

- Exponentiation: `^`.

   ```
   [Mass] * [Speed] ^ 2
   ```

- Remainder of a division: `%`.

   ```
   [Sales] % 10 + [Cost Price] % 10
   ```

- Boolean: `AND`, `OR`, `NOT`, `IN`, `LIKE`, `IS TRUE`, `IS FALSE`, `BETWEEN`.

- Comparisons: `=`, `!=`, `<`, `<=`, `>`, `>=`.

   Comparison operators allow you to create logical chains, such as:

   ```
   1 > x > -4 > y != 8
   ```

You can see the full list of operators [here](../../function-ref/operator-functions.md).

## Formatting formulas {#formatting}

Any formula can be written in one or more lines:

```
CONCAT(
    SUM([Category Sales]) / [Total Sales],
    ' %'
)
```

## Comments {#comments}

You can use comments to add explanations or ignore parts of formulas:

- Single-line comment.

   ```
   -- This is a single-line comment
   ```

- Block comment.

   ```
   /* This is a block
   comment */
   ```

## Logical operations {#logical-operations}

You can use these logical functions for branching calculations in expressions:

- `CASE`:

   ```
   CASE [ProductID]
       WHEN 1 THEN "Bananas"
       WHEN 2 THEN "Apples"
       WHEN 3 THEN "Pears"
       ELSE "Other"
   END
   ```

   ```
   CASE( 
       [Color],
       "R", "Red",
       "G", "Green",
       "B", "Blue",
       "Not RGB" 
   )
   ```

   You can see the full description of the `CASE` function [here](../../function-ref/CASE.md).

- `IF`:

   ```
   IF([MassIndex] BETWEEN 18.5 AND 25, "Normally", "Not normal")
   ```

   ```
   IF
       [Year] % 400 = 0 OR ([Year] % 4 = 0 AND [Year] % 100 != 0)
           THEN "Leap year"
       ELSE "Ordinary year"
   END
   ```
```
IF
    [City] = "Moscow"
        THEN "This is the Capital"
    ELSEIF [City] = "St. Petersburg"
        THEN "This is the northern Capital"
    ELSE "Other city"
END
```


You can see the full description of the `IF` function [here](../../function-ref/IF.md).

- `IFNULL`, `ISNULL`, `ZN`:

   ```
   IFNULL([Cost Price], 10) * [OrderCount]
   ```

   You can see the full description of the `IFNULL` function [here](../../function-ref/IFNULL.md).

   ```
   IF(ISNULL([Product Name]) = TRUE, "Unnamed", [Product Name] + " " + [ProductID])
   ```

   You can see the full description of the `ISNULL` function [here](../../function-ref/ISNULL.md).

   ```
   ZN([Total Sales]) - ZN([Total Cost])
   ```

   You can see the full description of the `ZN` function [here](../../function-ref/ZN.md).

## Strings {#strings}

To process text data, you can use the following [string functions](../../function-ref/string-functions.md):

```
CONCAT([Total Sales], "$")
```

```
IF(CONTAINS([Product Name], "RU"), [Product Cost] + " " + "RUB", [Product Cost] + " " + "USD")
```

```
REPLACE([OrderID], "2020", [Month])
```

```
IF(STARTSWITH([Region Name], "RU_"), SPLIT([Region Name], "_", 2), [Region Name])
```

Strings can be enclosed in single or double quotes. You can also use one type of quotation mark inside the other:

```
FIND([Product Name], 'plus')
```

```
CONCAT('"', [Product Name], '"')
```

You can make different conversions of string data using [special characters](../data-types.md#string) in formulas:

```
REPLACE([ShopAddress], "\n", " ")
```

```
"File path" + " = " + "\\" + [Folder] + '\\' + [Filename]
```

{% note info %}

Such special characters as `\n`, `\t`, or `\r `do not affect the way the source data is displayed.

{% endnote %}

## Converting types {#type-conversions}

You can convert expression values from one type to another:

```
FLOAT([StringWithNumbers])
```

```
DATETIME(STR([Order Date]) + "-" + STR([Order Time]))
```

```
GEOPOINT([Latitude],[Longitude])
```

You can see the full description of the type conversion functions [here](../../function-ref/type-conversion-functions.md).

## Aggregation {#aggregation}

To calculate the resulting values, use [aggregate functions](../../function-ref/aggregation-functions.md):

```
AVG([Check Total]) * COUNTD([CustomerID])
```

```
SUM_IF([Sales], [Category] = "Fruits")
```

```
IF
    MIN[Date] = #2020-01-01#
        THEN SUM[Sales] * 1.1
    ELSE SUM[Sales] * 1.2
END
```

[Window functions](../../function-ref/window-functions.md) allow you to aggregate values from a group of strings without combining these strings into one. This distinguishes them from aggregate functions. You can also use window functions to calculate values for one string in the context of values from other strings.

```
SUM([Sales] WITHIN [PaymentType]) / SUM([Sales] TOTAL)
```

```
MSUM([Sales per Order], 1 WITHIN [ProductID] ORDER BY [Price])
```

```
RANK_DENSE(AVG([Price]), "desc" WITHIN [ShopID] BEFORE FILTER BY [PaymentType])
```

Window functions support [grouping](../../function-ref/window-functions.md#syntax-grouping) and [sorting](../../function-ref/window-functions.md#syntax-order-by) of records, as well as the [BEFORE FILTER BY](../../function-ref/window-functions.md#syntax-before-filter-by) option.

## Text markup {#text-markup}

To create text with markup, use [markup functions](../../function-ref/markup-functions.md):

```
MARKUP(BOLD("This"), " ", ITALIC("is"), " ", URL("https://example.com/", [LinkName]))
```

To use numeric constants when marking up URLs, convert them to the `String` type:

```
URL("https://example.com/?value=" + STR([Value]), [Value])
```
