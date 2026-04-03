---
title: KQL reference for {{ ycdr-full-name }}
description: Reference of KQL functions and operators in {{ ycdr-name }}.
---

# KQL reference

{% include [preview-by-request](../_includes/note-preview-by-request.md) %}

This section provides a reference for the [Kusto Query Language (KQL)](https://learn.microsoft.com/en-us/kusto/) subset used in {{ ycdr-full-name }}.

## System tables {#system-tables}

{{ ycdr-name }} supports the following system tables:

* **Events**: Normalized events in a database or stream.
* **EVENT_CLASS**: Event class names defined in the classifier with the respective field filtering.

## Expression operators in queries {#expression-operators}

### Set {#set-operator}

Use the `set` operator to define query parameters.

```sql
set rule_name = "SomeRuleName";
set window_step = 35m;
set runtime = "database";
```

**Supported parameters**:

#|
|| Parameter | Type | Description ||
|| `rule_name` | string | Rule name to use for runs via an investigation ||
|| `window_step` | interval | Time shift for periodic runs via an investigation ||
|| `runtime` | string | Run type by `database` ||
|#

### Let {#let-operator}

Use the `let` operator to create table variables.

```sql
let someTable = ATiamDetectLeakedCredential | limit 10;
```

## Table operators {#pipeline-operators}

### Where {#where-operator}

The `where` operator filters data by a condition.

```sql
where at_iam_subject_name !contains "test"
where region != "" and 1 != 4 + 2 or x == y
```

### Lookup {#lookup-operator}

The `lookup` operator joins tables. Only `left outer join` is supported.

```sql
lookup (
    abc.quotas | project lookup_c_group, lookup_srv, limits_list
) on $left.service.service_id == $right.lookup_srv,
   $left.c_group == $right.lookup_c_group
```

**Limitation**: During enrichment, use `project` to specify the required external table fields.

### Summarize {#summarize-operator}

The `summarize` operator aggregates data.

```sql
summarize cnt = count(),
            uniq_subjects = dcount(at_iam_subject_id),
            last_event = max(time),
            first_event = min(time),
            sum_logon_type = sum(user_logon_type),
            avg_logon_type = avg(user_logon_type),
            p95_logon_type = percentile(user_logon_type, 95)
by region, bin(time, 1d)
```

**Restrictions**:
* Default field names (e.g., `count_` or etc.) are not supported; specify them explicitly.
* List of aggregate functions is limited.

### Extend {#extend-operator}

The `extend` operator adds calculated columns.

```sql
extend use = extract("user=(^ ]+)\s+ip=(?<ip>[0-9.]+)", 1, Message),
          a = 5, b = c
```

### Mv-expand {#mv-expand-operator}

The `mv-expand` operator expands arrays into individual rows.

```sql
mv-expand grant = grants
```

**Limitation**: Only `kind = bag` and single-column expansion are supported.

### Project {#project-operator}

The `project` operator selects and renames columns.

```sql
| project event_class = "Alert", time, foundHostid = hostid
```

### Top and Sort {#top-sort-operators}

Use the `top` and `sort` operators to sort and limit the returned result.

```sql
sort by field desc
top 5 by anotherField
```

### Limit {#limit-operator}

The `limit` operator limits the number of rows.

```sql
limit 10000
```

## Where conditions {#where-conditions}

### Logical operators {#logical-operators}

#|
|| Operator | Description ||
|| `and` | Logical AND ||
|| `or` | Logical OR ||
|| `not` | Logical NOT ||
|| `()` | Condition grouping ||
|#

```sql
not (ivan >= 1337 or lesha <= 1337)
```

### Comparison operators {#comparison-operators}

#|
|| Operator | Description ||
|| `==` | Equals ||
|| `!=` | Not equals ||
|| `>`, `<` | Comparing numbers and time values ||
|| `>=`, `<=` | Inclusive comparison ||
|#

### Inclusion operators {#inclusion-operators}

#|
|| Operator | Description ||
|| `between` / `!between` | Checks whether a value falls within a range. ||
|| `in` / `!in` | Checks whether a value belongs to a list. ||
|| `has_any` / `!has` | Checks for any of the specified words. ||
|| `contains` / `!contains` | Checks for the specified substring (case-insensitive). ||
|| `matches regex` | Checks for a match with a regular expression. ||
|#

```sql
time between (ago(60m) .. now())
age in (18, 19, 20)
array.obj has_any ('tesla', 'bmw')
field contains "substring"
file_category@object matches regex "app\.compute\..*"
```

## Functions {#functions}

### Type conversion functions {#type-conversion-functions}

#|
|| Function | Description ||
|| `tostring()` | Converts to a string. ||
|| `toint()` | Converts to an integer. ||
|| `todouble()` / `toreal()` | Converts to a non-integer. ||
|| `todatetime()` | Converts a string to date and time. ||
|| `parse_json()` | Parses a string into JSON ||
|#

### Extraction functions {#extraction-functions}

#|
|| Function | Description ||
|| `extract()` | Extracts a regular expression group from a string. ||
|| `external_table()` | Enables referencing an external table. ||
|#

### Time functions {#time-functions}

#|
|| Function | Description ||
|| `now()` | Returns the current time. ||
|| `ago(1h)` | Returns a time in the past. ||
|#

### Other functions {#other-functions}

#|
|| Function | Description ||
|| `isnull()` / `isnotnull()` | Checks for NULL values. ||
|| `bag_pack_columns()` | Creates a dynamic JSON object with fields from specified columns. ||
|| `case()` | Selects a value based on a condition. ||
|#

```sql
case([predicate, valueIfTrue]+, defaultValue)
```

## Aggregation functions for summarize {#aggregate-functions}

#|
|| Function | Description ||
|| `count()` | Counts the total number of rows. ||
|| `count_distinct()` | Counts the number of unique values. ||
|| `avg()` | Calculates the average value. ||
|| `max()` | Returns the maximum value. ||
|| `min()` | Returns the minimum value. ||
|| `percentile()` | Returns the value for the specified percentile. ||
|| `sum()` | Sums up values. ||
|| `dcount()` | Counts the number of unique values. ||
|| `bin()` | Groups by time windows. ||
|#
