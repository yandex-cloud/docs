# S3 Select query language syntax

The S3 Select language only uses the `SELECT` operator from the standard SQL. It supports the following standard ANSI clauses:

* SELECT
* FROM
* WHERE
* LIMIT

{% note info %}

S3 Select does not support nested queries or joins.

{% endnote %}

## SELECT {#select-list}

Object data returned by a query: names of columns, functions, and expressions.

Syntax:

```sql
SELECT *
SELECT projection [ AS column_alias | column_alias ] [, ...]
```

The first form returns each line that satisfies the condition in the `WHERE` clause as is. The second returns a row with a custom projection of the output scalar expressions for each column.


## FROM {#from-clause}

Data source for `SELECT`. Takes the name of a {{ objstorage-name }} object as an argument.

Syntax:

```sql
FROM S3Object
FROM S3Object alias
FROM S3Object AS alias
```

As in standard SQL, the `FROM` clause creates rows filtered using the `WHERE` clause and returned as a list of the data specified in `SELECT`.


## WHERE {#where-clause}

Filters rows based on a specified condition. The condition is set as a logical expression. The result returned only contains rows for which the expression evaluates to `TRUE`.

Syntax:

```sql
WHERE condition
```


## LIMIT {#limit-clause}

Limits the number of records returned by a query.

Syntax:

```sql
LIMIT number
```


## Attribute access {#attribute-access}

`SELECT` and `WHERE` clauses can refer to a data record using file attributes.

CSV file attributes:

* Column numbers.

  In a query, you can refer to a specific column using the name `_N`, where `N` is the column's sequence number in a file.

  Column numbering starts with 1. For example, the first column will have the name `_1`, the second `_2`.

  A column name can be specified both as `_N` and as `alias._N`. For example, the names `_2` and `myAlias._2` are both legal references to a column in `SELECT` and `WHERE` clauses.

* Column headers.

  As in conventional SQL, expressions in `SELECT` and `WHERE` clauses may reference columns by column header, as in `alias.column_name` or `column_name`.

JSON file attributes:

* Document.

  You can access fields in a JSON file by field name, such as `alias.name`.


**Examples**

Sample data in JSON format:

```json
{"timestamp":"2021-02-26T01:27:19Z","object_key":"name1","status":404,"request_time":16}
{"timestamp":"2021-02-26T01:27:19Z","object_key":"name2","status":200,"request_time":12}
{"timestamp":"2021-02-26T01:27:20Z","object_key":"name3","status":200,"request_time":6}
```

Query:

```sql
SELECT "timestamp", object_key, request_time FROM S3Object WHERE status >= 400
```

Query result:

```json
{"timestamp":"2021-02-26T01:27:19Z","object_key":"name1","request_time":16}
```

Query:

```sql
SELECT * FROM S3Object WHERE request_time >= 10
```

Query result:

```json
{"timestamp":"2021-02-26T01:27:19Z","object_key":"name1","status":404,"request_time":16}
{"timestamp":"2021-02-26T01:27:19Z","object_key":"name2","status":200,"request_time":12}
```


## Case sensitivity of headers and attribute names {#sensitivity}

Double quotes indicate that CSV file column headers or JSON file attributes are case-sensitive. Headers or object attributes without double quotes will not be case-sensitive. Therefore, a query error may occur if a field name is ambiguous.

**Examples**

1. A queried object has a **NAME** header/attribute.

    If there is no indication of case sensitivity, the query successfully returns the object's data:

    ```sql
    SELECT s.name FROM S3Object s
    ```

    If you enclose the header/attribute in double quotes, the query results in Error Code 400, `MissingHeaderName`:

    ```sql
    SELECT s."name" FROM S3Object s
    ```

1. A queried object has one header/attribute called **NAME** and another header/attribute called **name**.

    If there is no indication of case sensitivity, there is ambiguity as to which header/attribute to select. The query returns error code 400 `AmbiguousFieldName`:

    ```sql
    SELECT s.name FROM S3Object s
    ```

    If you enclose the header/attribute in double quotes, the request successfully returns the object's data:

    ```sql
    SELECT s."NAME" FROM S3Object s
    ```

## Reserved keywords {#reserved-keywords}

S3 Select has a series of reserved keywords. These are necessary to run SQL expressions when querying the contents of an object. Reserved keywords include, among others, function names, data type names, and operators.

In some cases, user terms may duplicate a reserved keyword. To avoid a conflict, use double quotes to indicate that your use of a certain term is intentional. Otherwise, a 400 syntax error will occur.

**Examples**

A queried object has a header/attribute called **CAST**, which is a reserved keyword.

If you enclose a user-defined header/attribute in double quotes, the request successfully returns the object's data:

```sql
SELECT s."CAST" FROM S3Object s
```

If you do not enclose a user-defined header/attribute in double quotes, there is a conflict with the reserved keyword. Therefore, the query returns a 400 syntax error:

```sql
SELECT s.CAST FROM S3Object s
```

## Scalar expressions {#scalar-expressions}

`WHERE` and `SELECT` clauses may contain SQL scalar expressions that return scalar values. These may appear as follows:

* `literal`. SQL literal. A literal is an explicit numeric, character, string, or boolean value (constant) that is not represented by an identifier.

* `column_reference`. Reference to a column, such as `column_name` or `alias.column_name`. Used to access a column using the column header.

  Example:

  ```sql
  SELECT city.name FROM S3Object city
  ```

* `unary_op expression`. In this expression, `unary_op` is a unary SQL operator. Unary operators perform operations on a single operand. These include, for example, the unary minus, which changes the sign of a number.

  Example:

  ```sql
  SELECT -5 FROM S3Object
  ```

* `expression binary_op expression`. In this expression, `binary_op` is a binary SQL operator. Binary operators perform an operation on two operands. For instance, binary operators include arithmetic, logical, and comparison operators.

  Examples:

  ```sql
  SELECT x FROM S3Object WHERE x=3
  ```

  ```sql
  SELECT result FROM S3Object WHERE result>=1 AND result<=5
  ```

* `func_name`. In this expression, `func_name` is the name of a callable scalar function.

  Example:

  ```sql
  SELECT CAST(status AS INT) FROM S3Object
  ```

* `expression [ NOT ] BETWEEN expression AND expression`. Checking if a value belongs to a range.

  Example:

  ```sql
  SELECT x FROM S3Object WHERE x BETWEEN -1 AND 1
  ```
