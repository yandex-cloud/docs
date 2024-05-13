# Data pattern processing

A **data pattern** is a combination of events, as well as conditions and correlations between these events, used to track various regularities and detect events. Pattern searching is used for analyzing and monitoring event streams in real time, enabling prompt response to changes and making crucial decisions. In data analysis systems, a data pattern builds a rule by which the system determines whether the incoming event stream meets certain criteria; this results in triggering specific actions or notifications.

Here is a hands-on example of pattern processing in a data stream produced by an IoT device, where pressing its buttons triggers certain events. Let's assume you need to find and process the following sequence of button presses: `button 1`, `button 2`, and `button 3`. The data is transmitted as JSON strings, which are distributed across the `ts` and `button` columns of the `input_stream` data stream using [data bindings](glossary.md#binding).

The structure of the transmitted data is as follows:
```json
{"ts":1700000000, "button": 1, "device_id": 1, "zone_id": 24}
{"ts":1701000000, "button": 2, "device_id": 2, "zone_id": 12}
```

The body of the SQL query to {{ yql-short-name }} looks like this:

```sql
SELECT * FROM bindings.input_stream MATCH_RECOGNIZE ( -- performing pattern matching from input_stream
    ORDER BY ts -- viewing events in ascending order of the ts column value (Timestamp data type)
    MEASURES
      LAST(B1.ts) AS b1, -- in the query results, we will get the last moment of clicking button 1
      LAST(B3.ts) AS b3  -- in the query results, we will get the last moment of clicking button 3

    ONE ROW PER MATCH    -- we will get one row of results per found match
    AFTER MATCH SKIP TO NEXT ROW -- after the pattern is detected, we move to the next row
    PATTERN (
      B1 B2+ B3 -- We look for a pattern in the data consisting of one click on button 1, one or more clicks on button 2, and one click on button 3
    )
    DEFINE
        B1 AS B1.button = 1, -- we define the B1 condition as clicking button 1 (button field value is 1)
        B2 AS B2.button = 2, -- we define the B2 condition as clicking button 2 (button field value is 2)
        B3 AS B3.button = 3  -- we define the B3 condition as clicking button 3 (button field value is 3)
) AS MATCHED;
```


## Syntax {#syntax}

The `MATCH_RECOGNIZE` command searches for data based on a given pattern and returns the found results. Here is the SQL syntax of the `MATCH_RECOGNIZE` command:
```sql
MATCH_RECOGNIZE (
    [ PARTITION BY <pattern_1> [ ... , <pattern_N>] ]
    ORDER BY orderItem1 [ ... , orderItemN] [ASC]
    MEASURES LAST(<variable_1>)|FIRST(<variable_1>) [AS] <column_1_name> [ ... , LAST(<variable_N>)|FIRST(<variable_N>) [AS] <column_N_name>]
    ONE ROW PER MATCH
    [AFTER MATCH SKIP TO NEXT ROW]
    PATTERN (<search_template>)
    DEFINE <variable_1> AS <expression1>[ ... , <variable_N> AS <expression_N>]
)
```

Here is a brief description of the SQL syntax elements of the `MATCH_RECOGNIZE` command:
* [`DEFINE`](#define): Conditions the rows must meet for each variable: `<variable_1> AS <expression_1>[ ... , <variable_N> AS <expression_N>]`.
* [`PATTERN`](#pattern): Template for data search. It consists of variables and search rules of the pattern described in the `<search_template>` expression. `PATTERN` works similarly to [regular expressions](https://ru.wikipedia.org/wiki/Regular_expressions).
* [`ONE ROW PER MATCH`](#rows_per_match) determines the amount of output data for each found match.
* [`AFTER MATCH SKIP TO NEXT ROW`](#after_match_skip_to_next_row) defines the method of going to the point of the next match search.
* [`MEASURES`](#measures) specifies a list of output columns. Each column from the `<expression_1> [AS] <column_1_name> [ ... , <expression_N> [AS] <column_N_name>]` list is an independent construct that sets output columns and describes expressions for their computation.
* [`ORDER BY`](#order_by) determines sorting of input data. Pattern search is performed within the data sorted according to the list of columns or expressions listed in `<expression_1> [AS] <column_1_name> [ ... , <expression_N> [AS] <column_N_name>]`.
* [`PARTITION BY`](#partition_by) divides the input data flow as per the specified rules in accordance with `<pattern_1> [ ... , <pattern_N>]`. Pattern search is performed independently in each part.


### DEFINE {#define}

```sql
DEFINE <variable_1> AS <expression_1>[, <variable_2> AS <expression_2>, ...]
```

`DEFINE` declares variables that are searched for in the input data. Variables are names of SQL expressions computed over the input data. SQL expressions in `DEFINE` have the same meaning as search expressions in `WHERE` SQL clause. For example, the `button = 1` expression searches for all rows that contain the `button` column with the value of `1`. Any SQL expressions that can be used to perform a search, including aggregation functions like `LAST` or `FIRST`, can act as conditions. For example, one can use such expressions as `button > 2 AND zone_id < 12` or `LAST(button) > 10`.

In your SQL statements, make sure to specify the variable name for which you are searching for matches. For instance, in the following SQL command, you need to specify the variable name for which the calculation is being performed (`A`), for the `button = 1` condition:

```sql
DEFINE
  A AS A.button = 1
```


{% include [info](../_includes/match_recognize_common_exclusion.md) %}


During the processing of each row of data, all logical expressions of all `DEFINE` keyword variables are calculated. If during the calculation of `DEFINE` variable expressions, it turns out that the logical expression evaluates to `TRUE`, such a row is labeled with the `DEFINE` variable name and added to the list of rows subject to pattern matching.


#### **Examples** {#define-example}

When defining variables in SQL expressions, you can use references to other variables:

```sql
DEFINE
  A AS A.button = 1,
  B AS B.button > 2 AND A.zone_id < 12
```

Here is an example of an SQL expression with references to other variables:
```sql
DEFINE
  A AS A.button = 1,
  B AS A.button > 2 AND A.device_id = 12 OR A.zone_id < 12
```


### PATTERN {#pattern}

```sql
PATTERN (<search_template>)
```

The `PATTERN` keyword describes the data search pattern in the format derived from variables in the `DEFINE` section. The `PATTERN` syntax is similar to [regular expression](https://en.wikipedia.org/wiki/Regular_expressions) syntax.

{% note warning %}

If a variable used in the `PATTERN` section has not been previously described in the `DEFINE` section, it is assumed that it always evaluates to `TRUE`.

{% endnote %}

You can use [quantifiers](https://en.wikipedia.org/wiki/Regular_expression#Quantification_(searching_sequences)) in `PATTERN`. In regular expressions, they determine the number of repetitions of an element or subsequence in the matched pattern. We will use the `A`, `B`, `C`, and `D` variables from the `DEFINE` sections to describe quantifiers. Here is the list of supported quantifiers:

| Quantifier | Description |
|----|-----|
| `A+` | One or more occurrences of variable `A` |
| `A*` | Zero or more occurrences of variable `A` |
| `A?` | Zero or one occurrence of variable `A` |
| `B{n}` | Exactly `n` occurrences of variable `B` |
| `C{n, m}` | From `n` to `m` occurrences of variable `C`, inclusive of `m` |
| `D{n,}` | At least `n` occurrences of variable `D` |
| `(A\|B)` | Occurrence of either variable `A` or `B` in the data |
| `(A\|B){,m}` | No more than `m` occurrences of either variable `A` or `B`, inclusive of `m` |


Supported pattern search sequences:

| Supported sequences | Syntax | Description |
|---|---|----|
| Sequence | `A B+ C+ D+` | The system searches for the exact specified sequence, the occurrence of other variables within the sequence is not allowed. The pattern search is performed in the order of the pattern variables. |
| One of | `A \| B \| C` | Variables are listed in any order with a pipe (`\|`) between them. The search is performed for any variable from the specified list. |
| Grouping | `(A \| B)+ \| C` | Variables inside round brackets are considered a single group. In this case, quantifiers apply to the entire group. |


#### **Example** {#pattern-example}

```sql
PATTERN (
  B1 E* B2+ B3
)
DEFINE
    B1 as B1.button = 1,
    B2 as B2.button = 2,
    B3 as B3.button = 3
```

The `B1`, `B2`, and `B3` variables are defined in the `DEFINE` section, while the `E` variable is not. Such notation allows interpreting `E` as any event, so the following pattern will be searched: one press of `button 1`, one or more presses of `button 2`, and one press of `button 3`. Meanwhile, between a press of `button 1` and `button 2`, any number of any other events can occur.


### ROWS PER MATCH {#rows_per_match}

`ROWS PER MATCH` determines the number of found patterns. `ONE ROW PER MATCH` sets the `ROWS PER MATCH` mode to output one row per found pattern. The data schema of the result will be a union of [partitioning columns](#partition_by) and all [dimension](#measures) columns.



### AFTER MATCH SKIP TO NEXT ROW {#after_match_skip_to_next_row}

`AFTER MATCH SKIP TO NEXT ROW` is an optional parameter. It determines the method of transitioning from the found match to searching the next match.

If a [pattern](#pattern) with a quantifier that implies variable repetition is specified first or last, the search results return a set of rows, each corresponding to the occurrence of the variable.


#### Examples {#match-examples}

The input data for all examples are:
```
 button: 1
 button: 1
 button: 2
 button: 2
 button: 3
 button: 3
 button: 3
```


##### **Example 1** {#match-example1}

If a quantifier allowing only one match is specified first and last in the expression, a single result row is returned.

```sql
MEASURES
  LAST(B1.button) AS b1,
  LAST(B2.button) AS b2,
  LAST(B3.button) AS b3
PATTERN (
  B1 B2+ B3
)
DEFINE
    B1 AS B1.button = 1,
    B2 AS B2.button = 2,
    B3 AS B3.button = 3,

```

Result:
|b1|b2|b3|
|--|--|--|
|1|2|3|


##### **Example 2** {#match-example2}

When a quantifier that allows multiple matches is applied to the first pattern variable, one row will be added to the result for each match of this element. As a result, the number of resulting rows will equal the number of matches of the first element in the pattern.

```sql
MEASURES
  LAST(B1.button) AS b1,
  LAST(B2.button) AS b2,
  LAST(B3.button) AS b3
PATTERN (
  B1+ B2+ B3
)
DEFINE
    B1 AS B1.button = 1,
    B2 AS B2.button = 2,
    B3 AS B3.button = 3
```

Result:
|b1|b2|b3|
|--|--|--|
|1|2|3|
|1|2|3|


##### **Example 3** {#match-example3}

When indicating the last quantifier that allows multiple matches, a set of rows will be returned in accordance with the number of found matches: one row for each match at the beginning and one row for each match at the end. The result will be a Cartesian product of input and output matches.

```sql
MEASURES
  LAST(B1.button) AS b1,
  LAST(B2.button) AS b2,
  LAST(B3.button) AS b3
PATTERN (
  B1 B2+ B3+
)
DEFINE
    B1 AS B1.button = 1,
    B2 AS B2.button = 2,
    B3 AS B3.button = 3
```

Result:
|b1|b2|b3|
|--|--|--|
|1|2|3|
|1|2|3|
|1|2|3|


##### **Example 4** {#match-example3}

When specifying the first and last quantifier, which allows multiple matches, a set of rows will be returned according to the number of found matches.

```sql
MEASURES
  LAST(B1.button) AS b1,
  LAST(B2.button) AS b2,
  LAST(B3.button) AS b3
PATTERN (
  B1+ B2+ B3+
)
DEFINE
    B1 AS B1.button = 1,
    B2 AS B2.button = 2,
    B3 AS B3.button = 3
```

Result:
|b1|b2|b3|
|--|--|--|
|1|2|3|
|1|2|3|
|1|2|3|
|1|2|3|
|1|2|3|
|1|2|3|


### MEASURES {#measures}

```sql
MEASURES LAST(<variable_1>)|FIRST(<variable_1>) [AS] <column_1_name> [ ... , LAST(<variable_N>)|FIRST(<variable_N>) [AS] <column_N_name>]
```

`MEASURES` describes the set of returned columns when a pattern is found. A set of returned columns should be represented by an SQL expression with the `LAST`/`FIRST` aggregate functions over variables declared in the [`DEFINE`](#define) statement.


##### **Example** {#measures-example}

```sql
MEASURES
  LAST(B1.ts) AS b1,
  FIRST(B3.ts) AS b3
```


### ORDER BY {#order_by}

```sql
ORDER BY orderItem1 [ ... , orderItemN] [ASC]

orderItem ::= { <column_names> | <expression> }
```

`ORDER BY` determines sorting of the input data. That is, before all pattern search operations are executed, the data will be pre-sorted according to the specified keys or expressions. The syntax is similar to the `ORDER BY` SQL expression. Sorting is only permitted by fields of the [TimeStamp](https://ydb.tech/en/docs/yql/reference/types/primitive#datetime) type, with only ascending direction (`ASC`) supported.

##### **Example** {#order_by-example}

```sql
ORDER BY CAST(ts AS Timestamp),
         button_index DESC,
         ts2 ASC
```


### PARTITION BY {#partition_by}

```sql
PARTITION BY <pattern_1> [ ... , <pattern_N>]

partition ::= { <column_names> | <expression> }
```

`PARTITION BY` is an optional expression. It partitions the input data according to the list of fields specified in this keyword, converting the source data into several independent stream groups, each used for an independent pattern search. If the command is not specified, all data is processed as a single group.

The syntax is equivalent to the `PARTITION BY` SQL expression for window functions, covering all types of aggregation functions.

#### **Example** {#partition_by-example}

```sql
PARTITION BY building
```


## Limitations {#limitations}

Our support for the `MATCH_RECOGNIZE` command will eventually comply with the [SQL-2016](https://ru.wikipedia.org/wiki/SQL:2016); currently, however, the following limitations apply:
- [`ORDER_BY`](#order_by): As sorting columns, you can specify exactly one column (expression) with the [`Timestamp`](https://ydb.tech/en/docs/yql/reference/types/primitive#datetime) type. Only the ascending (`ASC`) sorting order is supported.
- [`MEASURES`](#measures): Neither aggregation functions nor `PREV`/`NEXT` are supported.
- [`ROWS PER MATCH`](#rows_per_match): Only the `ONE ROW PER MATCH` mode is supported, the `ALL ROWS PER MATCH` mode is not supported.
- [`PATTERN`](#pattern): Union pattern variables are not implemented.
- [`DEFINE`](#define): Aggregation functions are not supported.
