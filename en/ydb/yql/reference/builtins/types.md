---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Functions for types

## FormatType {#formattype}

Serializing the type to a human-readable string. This helps at debugging and will also be used in the next examples of this section. Read more about the function in the [documentation](../misc/type_string.md).

## ParseType {#parsetype}

Building a type from a string with description. Read more about the function in the [documentation](../misc/type_string.md).

**Examples**

```sql
SELECT FormatType(ParseType("List<Int32>"));  -- List<int32>
```

## TypeOf {#typeof}

Getting the type of value passed to the argument.

**Examples**

```sql
SELECT FormatType(TypeOf("foo"));  -- String
```

```sql
SELECT FormatType(TypeOf(AsTuple(1, 1u))); -- Tuple<Int32,Uint32>
```

## InstanceOf {#instanceof}

Returns an instance of the specified type that can only be used to get the type of the result of an expression that uses this type.

If this instance remains in the computation graph at the end of optimization, the optimization fails.

**Examples**

```sql
SELECT FormatType(TypeOf(
    InstanceOf(ParseType("Int32")) +
    InstanceOf(ParseType("Double"))
)); -- Double, because "Int32 + Double" returns Double
```

## DataType {#datatype}

Returns a type for primitive data types based on type name.

**Examples**

```sql
SELECT FormatType(DataType("Bool")); -- Bool
```

## OptionalType {#optionaltype}

Adds the option to contain NULL to the passed type.

**Examples**

```sql
SELECT FormatType(OptionalType(DataType("Bool"))); -- Bool?
```

## ListType and StreamType {#listtype}

Builds a list type or stream type based on the passed element type.

**Examples**

```sql
SELECT FormatType(ListType(DataType("Bool"))); -- List<Bool>
```

## DictType {#dicttype}

Builds a dictionary type based on the passed key types (first argument) and value types (second argument).

**Examples**

```sql
SELECT FormatType(DictType(
    DataType("String"),
    DataType("Double")
)); -- Dict<String,Double>
```

## TupleType {#tupletype}

Builds the tuple type from the passed element types.

**Examples**

```sql
SELECT FormatType(TupleType(
    DataType("String"),
    DataType("Double"),
    OptionalType(DataType("Bool"))
)); -- Tuple<String,Double,Bool?>
```

## StructType {#structtype}

Builds the structure type based on the passed element types. The standard syntax of named arguments is used to specify the element names.

**Examples**

```sql
SELECT FormatType(StructType(
    DataType("Bool") AS MyBool,
    ListType(DataType("String")) AS StringList
)); -- Struct<'MyBool':Bool,'StringList':List<String>>
```

## VariantType {#varianttype}

Returns the type of a variant based on the underlying type (structure or tuple).

**Examples**

```sql
SELECT FormatType(VariantType(
  ParseType("Struct<foo:Int32,bar:Double>")
)); -- Variant<'bar':Double,'foo':Int32>
```

## ResourceType {#resourcetype}

Returns the resource type based on the string label passed.

**Examples**

```sql
SELECT FormatType(ResourceType("Foo")); -- Resource<'Foo'>
```

## CallableType {#callabletype}

Constructs the type of the called value using the following arguments:

Required:

1. Number of optional arguments (if all arguments are required — 0).
2. Result type.

All the next arguments of `CallableType` are treated as types of arguments of the called value, but with a shift for two required arguments (the third argument of the `CallableType` describes the type of the first argument in the called value).

**Examples**

```sql
SELECT FormatType(CallableType(
  1, -- optional args count
  DataType("Double"), -- result type
  DataType("String"), -- arg #1 type
  OptionalType(DataType("Int64")) -- arg #2 type
)); -- Callable<(String,[Int64?])->Double>
```

## GenericType, UnitType, and VoidType {#generictype}

Return data types of the same name. They have no arguments, because they are not parameterized in any way.

**Examples**

```sql
SELECT FormatType(VoidType()); -- Void
```

## OptionalItemType, ListItemType, and StreamItemType {#optionalitemtype}

Do the action reverse to [OptionalType](#optionaltype), [ListType](#listtype), and [StreamType](#streamtype): return the item type based on the type of the applicable container.

**Examples**

```sql
SELECT FormatType(ListItemType(
  ParseType("List<Int32>")
)); -- Int32
```

## DictKeyType and DictPayloadType {#dictkeytype}

Returns the type of the key or value based on the dictionary type.

**Examples**

```sql
SELECT FormatType(DictKeyType(
  ParseType("Dict<Int32,String>")
)); -- Int32
```

## TupleElementType {#tupleelementtype}

Returns the tuple's element type based on the tuple type and the element index (index starts from zero).

**Examples**

```sql
SELECT FormatType(TupleElementType(
  ParseType("Tuple<Int32,Double>"), "1"
)); -- Double
```

## StructMemberType {#structmembertype}

Returns the type of the structure element based on the structure type and element name.

**Examples**

```sql
SELECT FormatType(StructMemberType(
  ParseType("Struct<foo:Int32,bar:Double>"), "foo"
)); -- Int32
```

## CallableResultType and CallableArgumentType {#callableresulttype}

`CallableResultType` returns the result type based on the type of the called value. `CallableArgumentType` returns the argument type based on the called value type and its index (index starts from zero).

**Examples**

```sql
$callable_type = ParseType("(String,Bool)->Double");
SELECT FormatType(CallableResultType(
    $callable_type
)), -- Double
FormatType(CallableArgumentType(
    $callable_type, 1
)); -- Bool
```

## VariantUnderlyingType {#variantunderlyingtype}

Performs the action reverse to [VariantType](#varianttype): returns the underlying type based on the variant type.

**Examples**

```sql
SELECT FormatType(VariantUnderlyingType(
  ParseType("Variant<foo:Int32,bar:Double>")
)), -- Struct<'bar':Double,'foo':Int32>
FormatType(VariantUnderlyingType(
  ParseType("Variant<Int32,Double>")
)); -- Tuple<Int32,Double>
```

