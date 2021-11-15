| Type | Description | Type declaration | Type example |
| ------------ | ------------------- | --------------- | ------------- |
| List | A variable-length sequence consisting of same-type elements. | `List<Type>` | `List<Int32>` |
| Dictionary | Set of key-value pairs with the specified type of keys and values. | `Dict<KeyType, ValueType>` | `Dict<String, Int32>` |
| Tuple | Set of unnamed fixed-length elements with types specified for all elements. | `Tuple<Type1, ..., TypeN>` | `Tuple<Int32, Double>` |
| Structure | A set of named fields with given value types, fixed at query start and data-independent. | `Struct<Name1:Type1, ..., NameN:TypeN>` | `Struct<Name:String, Age:Int32>` |
| Stream | Single-pass iterator by same-type values, not serializable | `Stream<Type>` | `Stream<Int32>` |
| Variant on tuple | A tuple known to have exactly one element filled | `Variant<Type1, Type2>` | `Variant<Int32, String>` |
| Variant on structure | A structure known to have exactly one element filled | `Variant<Name1:Type1, Name2:Type2>` | `Variant<value:Int32, error:String>` |

