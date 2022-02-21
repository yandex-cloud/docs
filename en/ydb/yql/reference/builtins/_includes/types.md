---
sourcePath: en/ydb/ydb-docs-core/en/core/yql/reference/yql-docs-core-2/builtins/_includes/types.md
sourcePath: en/ydb/yql/reference/yql-docs-core-2/builtins/_includes/types.md
---

# Functions for data types

## FormatType {#formattype}

Serializing a type  to a human-readable string. This helps at debugging and will also be used in the next examples of this section. [Documentation for the format](../../types/type_string.md).

## ParseType {#parsetype}

Building a type from a string with description. [Documentation for its format](../../types/type_string.md).

**Examples**
``` yql
SELECT FormatType(ParseType("List<Int32>"));  -- List<int32>
```

## TypeOf {#typeof}

Getting the type of value passed to the argument.

**Examples**
``` yql
SELECT FormatType(TypeOf("foo"));  -- String
```
``` yql
SELECT FormatType(TypeOf(AsTuple(1, 1u))); -- Tuple<Int32,Uint32>
```

## InstanceOf {#instanceof}

Returns an instance of the specified type that can only be used to get the type of the result of an expression that uses this type.

If this instance remains in the computation graph by the end of optimization, the operation fails.

**Examples**
``` yql
SELECT FormatType(TypeOf(
    InstanceOf(ParseType("Int32")) +
    InstanceOf(ParseType("Double"))
)); -- Double, because "Int32 + Double" returns Double
```

## DataType {#datatype}

Returns a type for [primitive data types](../../types/primitive.md) based on type name.

**Examples**
``` yql
SELECT FormatType(DataType("Bool")); -- Bool
SELECT FormatType(DataType("Decimal","5","1")); -- Decimal(5,1)
```

## OptionalType {#optionaltype}

Adds the option to assign `NULL` to the passed type.

**Examples**
``` yql
SELECT FormatType(OptionalType(DataType("Bool"))); -- Bool?
```

## ListType and StreamType {#listtype}

Builds a list type or stream type based on the passed element type.

**Examples**
``` yql
SELECT FormatType(ListType(DataType("Bool"))); -- List<Bool>
```

## DictType {#dicttype}

Builds a dictionary type based on the passed key types (first argument) and value types (second argument).

**Examples**
``` yql
SELECT FormatType(DictType(
    DataType("String"),
    DataType("Double")
)); -- Dict<String,Double>
```

## TupleType {#tupletype}

Builds the tuple type from the passed element types.

**Examples**
``` yql
SELECT FormatType(TupleType(
    DataType("String"),
    DataType("Double"),
    OptionalType(DataType("Bool"))
)); -- Tuple<String,Double,Bool?>
```

## StructType {#structtype}

Builds the structure type based on the passed element types. The standard syntax of named arguments is used to specify the element names.

**Examples**
``` yql
SELECT FormatType(StructType(
    DataType("Bool") AS MyBool,
    ListType(DataType("String")) AS StringList
)); -- Struct<'MyBool':Bool,'StringList':List<String>>
```

## VariantType {#varianttype}

Returns the type of a variant based on the underlying type (structure or tuple).

**Examples**
``` yql
SELECT FormatType(VariantType(
  ParseType("Struct<foo:Int32,bar:Double>")
)); -- Variant<'bar':Double,'foo':Int32>
```

## ResourceType {#resourcetype}

Returns the type of the [resource](../../types/special.md) based on the passed string label.

**Examples**
``` yql
SELECT FormatType(ResourceType("Foo")); -- Resource<'Foo'>
```

## CallableType {#callabletype}

Constructs the type of the called value using the following arguments:

1. Number of optional arguments (if all arguments are required — 0).
2. Result type.
3. All the next arguments of CallableType are treated as types of arguments of the callable value, but with a shift for two required arguments (for example, the third argument of the CallableType describes the type of the first argument in the callable value).

**Examples**
``` yql
SELECT FormatType(CallableType(
  1, -- optional args count
  DataType("Double"), -- result type
  DataType("String"), -- arg #1 type
  OptionalType(DataType("Int64")) -- arg #2 type
)); -- Callable<(String,[Int64?])->Double>
```

## GenericType, UnitType and VoidType {#generictype}

Return the same-name [special data types](../../types/special.md). They have no arguments because they are not parameterized.

**Examples**
``` yql
SELECT FormatType(VoidType()); -- Void
```

## OptionalItemType, ListItemType and StreamItemType {#optionalitemtype}

Do the action reverse to [OptionalType](#optionaltype), [ListType](#listtype), and [StreamType](#streamtype): return the element type based on its container type.

**Examples**
``` yql
SELECT FormatType(ListItemType(
  ParseType("List<Int32>")
)); -- Int32
```

## DictKeyType and DictPayloadType {#dictkeytype}

Returns the type of the key or value based on the dictionary type.

**Examples**
``` yql
SELECT FormatType(DictKeyType(
  ParseType("Dict<Int32,String>")
)); -- Int32
```

## TupleElementType {#tupleelementtype}

Returns the tuple's element type based on the tuple type and the element index (index starts from zero).

**Examples**
``` yql
SELECT FormatType(TupleElementType(
  ParseType("Tuple<Int32,Double>"), "1"
)); -- Double
```

## StructMemberType {#structmembertype}

Returns the type of the structure element based on the structure type and element name.

**Examples**
``` yql
SELECT FormatType(StructMemberType(
  ParseType("Struct<foo:Int32,bar:Double>"), "foo"
)); -- Int32
```

## CallableResultType and CallableArgumentType {#callableresulttype}

`CallableResultType` returns the result type based on the type of the called value. `CallableArgumentType` returns the argument type based on the called value type and its index (index starts from zero).

**Examples**
``` yql
$callable_type = ParseType("(String,Bool)->Double");

SELECT FormatType(CallableResultType(
    $callable_type
)), -- Double
FormatType(CallableArgumentType(
    $callable_type, 1
)); -- Bool
```

## VariantUnderlyingType {#variantunderlyingtype}

Does an action reverse to [VariantType](#varianttype): it returns the underlying type based on the variant type.

**Examples**
``` yql
SELECT FormatType(VariantUnderlyingType(
  ParseType("Variant<foo:Int32,bar:Double>")
)), -- Struct<'bar':Double,'foo':Int32>
FormatType(VariantUnderlyingType(
  ParseType("Variant<Int32,Double>")
)); -- Tuple<Int32,Double>
```

