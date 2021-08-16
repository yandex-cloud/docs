# Containers

| **Name** | **Type declaration** | **Type example** | **Explanation** |
| ------------ | ------------------- | --------------- | ------------- |
| List | `List<Type>` | `List<Int32>` | A variable-length sequence consisting of same-type elements. |
| Dictionary | `Dict<KeyType,ValueType>` | `Dict<String,Int32>` | Set of key-value pairs with the specified type of keys and values. |
| Tuple | `Tuple<Type1,...,TypeN>` | `Tuple<Int32,Double>` | Set of unnamed fixed-length elements with types specified for all elements. |
| Structure | `Struct<Name1:Type1,...,NameN:TypeN>` | `Struct<Name:String,Age:Int32>` | A set of named fields with specified value types, fixed at query start (must be data-independent). |
| Stream | `Stream<Type>` | `Stream<Int32>` | Single-pass iterator by same-type values, not serializable |
| Variant on tuple | `Variant<Type1,Type2>` | `Variant<Int32,String>` | A tuple known to have exactly one element filled |
| Variant on structure | `Variant<Name1:Type1,Name2:Type2>` | `Variant<value:Int32,error:String>` | A structure known to have exactly one element filled |

If necessary, you can nest containers in any combination, for example, `List<TupleInt32,Int32>`.

[In certain contexts, optional values](optional.md) can also be considered a container type (`Optional<Type>`) that behaves as a list of length 0 or 1.

To implement sets, use a dictionary with `Void` — `Dict<T, Void>` type values.

To access the container elements, use [dot or curly brackets](../syntax/expressions.md#items-access), depending on the container type.

