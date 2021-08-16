# Expressions

## String concatenation {#concatenation}

Executed using the binary operator `||`.

As with other binary operators, if the data on either side is `NULL`, the result is also `NULL`.

Don't confuse this operator with a logical "or": in SQL, it's denoted by the `OR` keyword. It's also not worth doing concatenation using `+`.

**Examples**

```sql
SELECT "fo" || "o";
```

## Matching a string by pattern {#check-match}

`REGEXP` and `RLIKE` are aliases used to call [HyperScan::Grep](../udf/list/hyperscan.md#grep). `MATCH`: Same for [HyperScan::Match](../udf/list/hyperscan.md#match).

`LIKE` works as follows:

* Patterns can include two special characters:
    * `%`: Zero or more of any characters.
    * `_`: Exactly one of any character.
All other characters are literals that represent themselves.
* As opposed to `REGEXP`, `LIKE` must be matched exactly. For example, to search a substring, add `%` at the beginning and end of the pattern.
* `ILIKE` is a case-insensitive version of  `LIKE`.
* If `LIKE` is applied to the key column of the sorted table and the pattern doesn't start with a special character, filtering by prefix drills down directly to the cluster level, which in some cases lets you avoid the full table scan. This optimization is disabled for `ILIKE`.
* To escape special characters, specify the escaped character after the pattern using the `ESCAPE '?'` keyword. Instead of `?` you can use any character except `%` and `_`. For example, if you use a question mark as an escape character, the expressions `?%`, `?_` and `??` will match their second character in the template: percent, underscore, and question mark, respectively. The escape character is undefined by default.

The most popular way to use the `LIKE` and `REGEXP` keywords is to filter a table using the statements with the `WHERE` clause. However, there are no restrictions on using templates in this context: you can use them in most of contexts involving strings, for example, with concatenation by using `||`.

**Examples**

```sql
SELECT * FROM my_table
WHERE string_column REGEXP '\\d+';
-- the second slash is required because
-- all the standard string literals in SQL
-- can accept C-escaped strings
```

```sql
SELECT
    string_column LIKE '___!_!_!_!!!!!!' ESCAPE '!'
    -- searches for a string of exactly 9 characters:
    -- 3 arbitrary characters,
    -- then 3 underscores
    -- and 3 exclamation marks
FROM my_table;
```

```sql
SELECT * FROM my_table
WHERE key LIKE 'foo%bar';
-- would probably only physically scan the keys
-- starting by "foo", and then, among them,
-- will leave only those that end in "bar"
```

## Arithmetic operators {#math-operators}

The operators `+`, `-`, `*`, `/`, `%` are defined for [primitive data types](../types/primitive.md) that are variations of numbers.

For the Decimal data type, bankers rounding is used (to the nearest even integer).

**Examples**

```sql
SELECT 2 + 2;
```

```sql
SELECT 0.0 / 0.0;
```

## Comparison operators {#comparison-operators}

The operators `=`, `==`, `!=`, `<>`, `>`, `<` are defined for:

* Primitive data types except Yson and Json.
* Tuples and structures with the same set of fields. No order is defined for structures, but you can check for (non-)equality. Tuples are compared element-by-element left to right.

**Examples**

```sql
SELECT 2 > 1;
```

## Logical operators {#logic-operators}

Use the operators `AND`, `OR`, `XOR` for logical operations on Boolean values (`Bool`).

**Examples**

```sql
SELECT 3 > 0 AND false;
```

## Bitwise operators {#bit-operators}

Bitwise operations on numbers:

* `&`, `|`, `^`: AND, OR, and XOR, respectively. Don't confuse bitwise operations with the related keywords. The keywords `AND`, `OR`, and `XOR` are used * for Boolean values only*, but not for numbers.
* ` ~ ` : negation.
* `<`, `>>`: Left or right shifts.
* `|<`, `>|`: Circular left or right shifts.

**Examples**

```sql
SELECT
    key << 10 AS key,
    ~value AS value
FROM my_table;
```

## IS \[NOT\] NULL {#is-not-null}

Matching an empty value (`NULL`). Since `NULL` is a special value equal to nothing, the ordinary [comparison operators](#comparison-operators)  can't be used to match it.

**Examples**

```sql
SELECT key FROM my_table
WHERE value IS NOT NULL;
```

## BETWEEN {#between}

Checking whether a value is in a range. It's equivalent to two conditions with `>=` and `<=` (range boundaries are included). Can be used with the  `NOT`  prefix to support inversion.

**Examples**

```sql
SELECT * FROM my_table
WHERE key BETWEEN 10 AND 20;
```

## IN {#in}

Checking whether a value is inside of a set of values. Logically, it's equivalent to a chain of equality comparisons using `OR`, but the operation's complexity doesn't depend on the size of the set of values, since `IN` searches a hash table.

{% note alert %}

Unlike a similar keyword in Python, in YQL `IN` **DOES NOT** searches for a substring inside a string. To search for a substring, use the string [String::Contains](../udf/list/string.md) or [LIKE / REGEXP](#like) mentioned above.

{% endnote %}

Immediately after `IN`, you can specify the `COMPACT` hint.
If `COMPACT` is not specified, then `IN` with a subquery is executed as a relevant `JOIN` (`LEFT SEMI` for `IN` and `LEFT ONLY` for `NOT IN`), if possible.
Using the `COMPACT` hint forces the in-memory execution strategy: a hash table is immediately built from the contents of the right `IN` part in-memory, and then the left part is filtered.

Use the `COMPACT` hint with caution. Since the hash table is built in-memory, the query may fail if the right part of `IN` contains many large and/or different elements.

Since YQL imposes a limit on the query size in bytes (it's about 1Mb), add large lists of values to your query by URLs and use the [ParseFile](../builtins/basic.md#parsefile) function.

**Examples**

```sql
SELECT column IN (1, 2, 3)
FROM my_table;
```

```sql
SELECT * FROM my_table
WHERE string_column IN ("a", "b", "c");
```

```sql
$foo = AsList(1, 2, 3);
SELECT 1 IN $foo;
```

```sql
$values = (SELECT column + 1 FROM table);
SELECT * FROM my_table WHERE
   -- filtering by an in-memory hash table for one_table
   column1 IN COMPACT $values AND
   -- followed by LEFT ONLY JOIN with other_table
   column2 NOT IN (SELECT other_column FROM other_table);
```

## AS {#as}

Can be used in the following scenarios:

* Adding a short name (alias) for columns or tables within the query.
* Using named arguments in function calls.
* To specify the target type in the case of explicit type casting, see [CAST](#cast).

**Examples**

```sql
SELECT key AS k FROM my_table;
```

```sql
SELECT t.key FROM my_table AS t;
```

```sql
SELECT
    MyFunction(key, 123 AS my_optional_arg)
FROM my_table;
```

## CAST {#cast}

Tries to cast the value to the specified [primitive type](../types/primitive.md). The attempt may fail and return `NULL`. When used with numbers, it may lose precision or most significant bits.

{% include notitle [Десятичные типы](../../../_includes/decimal_args.md) %}

**Examples**

```sql
SELECT
    CAST("12345" AS Double),         -- 12345.0
    CAST(1.2345 AS Int8),            -- 1
    CAST(12345 AS String),           -- "12345"
    CAST("1.2345" AS Decimal(5, 2)), -- 1.23
    CAST("xyz" AS Uint64) IS NULL;   -- true, because it failed
```

## CASE {#case}

Conditional expressions and branching. It's similar to `if`, `switch` and ternary operators in the imperative programming languages.

Since its syntax is quite sophisticated, it's often more convenient to use the built-in [IF](../builtins/basic.md#if) function.

**Examples**

```sql
SELECT
  CASE
    WHEN value > 0
    THEN "positive"
    ELSE "negative"
  END
FROM my_table;
```

```sql
SELECT
  CASE value
    WHEN 0 THEN "zero"
    WHEN 1 THEN "one"
    ELSE "not zero or one"
  END
FROM my_table;
```

## Numeric literals {#numeric-literals}

* Integer literals have the default type `Int32`, if they fit within the Int32 range. Otherwise, they automatically expand to `Int64`.
* You can use the following suffixes to explicitly control the literal type:
    * `l`: `Int64`.
    * `s`: `Int16`.
    * `t`: `Int8`.
* Add the suffix `u` to convert a type to its corresponding unsigned type:
    * `ul`: `Uint64`.
    * `u`: `Uint32`.
    * `us`: `Uint16`.
    * `ut`: `Uint8`.
* You can also use hexadecimal, octal, and binary format for integer literals using the prefixes `0x`, `0 o` and `0b`, respectively. You can arbitrarily combine them with the above-mentioned suffixes.
* Floating point literals have the `Double`  type by default, but you can use the suffix `f` to narrow it down to `Float`.

**Examples**

```sql
SELECT
  CAST(123l AS Int64),
  CAST(0b01u AS Uint32),
  CAST(0xfful AS Uint64),
  CAST(0o7ut AS Uint8),
  CAST(456s AS Int16),
  CAST(1.2345f AS Float);
```

## Comments {#comments}

The queries support SQL-style comments and C-style multi-line comments.

**Examples**

```sql
-- comment
```

```sql
/* comment */
```

## Escaping {#escape}

If you enclose a literal in square brackets or backtick, you can use any special characters inside it using the C-escaping format.

**Examples**

```sql
SELECT [Some column] FROM [Some-Table];
```

```sql
SELECT `Some column` FROM `Some\tTable`;
```

## Named expressions {#named-nodes}

Complex queries strictly following the SQL standard may be too sophisticated, containing lots of nested levels and/or repeating parts. You can simplify a complex query using named expressions like `$foo`.

From the functional viewpoint, named expressions in YQL are similar to macros: their values are substituted at every point-of-use prior to the query execution. This lets you use table column names that will appear only later in the query. You may repeatedly assign values to the same named expression. In this case, the last value assigned before the point-of-use is substituted.

{% note info %}

If named expression substitution results in completely identical subgraphs in the query execution graph, the graphs are combined to execute a subgraph only once.

{% endnote %}

If the expression on the right is a tuple, you can automatically unpack it by specifying several named expressions separated by commas on the left. In this case, the number of expressions must match the tuple size.

**Examples**

```sql
$multiplier = 712;
SELECT
  a * $multipler, -- $multiplier is 712
  b * $multiplier,
  (a + b) * $multiplier
FROM abc_table;
$multiplier = c;
SELECT
  a * $multipler -- $multiplier is column c
FROM abc_table;
```

```sql
$intermediate = (
  SELECT
    value * value AS square,
    value
  FROM my_table
);
SELECT a.square * b.value
FROM $intermediate AS a
INNER JOIN $intermediate AS b
ON a.value == b.square;
```

```sql
$a, $b, $c = AsTuple(1, 5u, "test"); -- unpack a tuple
SELECT $a, $b, $c;
```

```sql
$x, $y = AsTuple($y, $x); -- swap expression values
```

## Lambda functions {#lambdas}

Let you combine multiple expressions into a single callable value.

List arguments in round brackets, following them by the arrow and lambda function body in curly brackets. The lambda function body consists of a chain of  [named expressions](#named-nodes) assignments and the call result after the  `RETURN` keyword in the last expression.

The scope for the lambda body: first the local named expressions, then arguments, then named expressions defined above by the lambda function at the top level of the query.

Only use pure expressions inside the lambda body (those might also be other lambdas, possibly passed through arguments). But you can't use [SELECT](select.md), [INSERT INTO](insert_into.md) and other top-level statements inside lambdas.

**Examples**

```sql
$x = ($y) -> {
    $prefix = "x";
    RETURN $prefix || $y;
};

SELECT $x("y"); -- "xy"
```

## Multi-line string literals {#multiline-string-literals}

To use a long text inside a query, such as a script or dictionary, you don't necessarily need to add it as a separate file: enclose it in double-@: `@@ ...  to include it directly into the query text. @@`.

**Examples**

```sql
$text = @@some
multiline
text@@;
SELECT LENGTH($text);
```

## Accessing containers {#items-access}

For accessing the values inside containers:

* `Struct<>` and `Tuple<>` use **dot**. The set of keys is known at the query compilation time. When the value is accessed, the key is validated.
* `List<>` and `Dict<>` use curly **brackets**. The set of keys (set of indexes for keys) is known only at the query execution time. The key validity is not checked at the query time.

If no value is found, an empty value (`NULL`) is returned.

{% note info %}

For a list of available containers, see [Containers](../types/containers.md).

{% endnote %}

When using this syntax to access containers within table columns, be sure to specify the full column name, including the table name or table alias separated by a dot (see the first example below).

**Examples**

```sql
SELECT
  t.struct.member,
  t.tuple.7,
  t.dict{"key"},
  t.list{7}
FROM my_table AS t;
```

```sql
SELECT
  Sample::ReturnsStruct().member;
```

