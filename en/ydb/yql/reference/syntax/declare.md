# DECLARE

Declares a typed [named expression](expressions.md#named-nodes) whose value will be passed separately from the query text.

**Syntax**

```sql
DECLARE $named-node AS data_type;
```

1. `DECLARE` keyword.
1. `$named-node` is a named expression to be used to access the passed value.
1. `AS` keyword.
1. `data_type` is the data type [represented as a string in the accepted format](../misc/type_string.md).

Accepts only serializable data types:

* [Primitive types](../types/primitive.md).
* [Optional types](../types/optional.md).
* [Containers](../types/containers.md), except `Stream<Type>`.
* `Void` is the only supported [special type](../types/special.md).

**Example**

```sql
DECLARE $x AS String;
DECLARE $y AS String?;
DECLARE $z AS List<String>;

SELECT $x, $y, $z;
```

