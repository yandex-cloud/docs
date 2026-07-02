# YQL to JSON type mapping

The following rules apply when converting YQL types to JSON types.

## Scalar types {#scalars-types}

| YQL type | JSON type | JSON example |
| --- | --- | --- |
| `Int8`, `Int16`, `Int32`<br/>`Uint8`, `Uint16`, `Uint32` | Integer | 647713 |
| `Int64`, `Uint64` | Integer if the value is in the range [-(2^53-1^) ... (2^53-1^)]; otherwise, String | -9007199254740991<br/>"-9007199254740991"<br/>"10446744073709551615" <br/> |
| `Bool` | Bool | True |
| `Float`, `Double` | Double<br/>NaN and Inf (written as String) | 7,88731023<br/>"nan"<br/>"inf" |
| `Decimal` | String | "45,23410083" |
| `String` | Base64 string (string as a byte array) | "0LDQsdGB0ZHQmWFiYw==" |
| `Utf8` | String | "String text" |

## Complex types {#complex-types}

| YQL type | JSON type | JSON example |
| --- | --- | --- |
| `Json`, `JsonDocument` | String (whole node serialized to a string) | "{\\\"a\\\":[1,2,3]}" |
| `Date`, `Datetime`, `Timestamp` | String in [ISO-8601](https://en.wikipedia.org/wiki/ISO_8601#Durations) format | "2022-02-09"<br/>"2021-01-01T14:05:43Z"<br/>"2022-02-13T12:26:52.879622Z" |
| `Interval` | String in ISO-8601 format | "PT1M" |

## Optional types {#optional-types}

| YQL type | JSON type | JSON example |
| --- | --- | --- |
| `Optional` | Array [] | []: Nothing [10]: Just 10 |

Optional type nesting is preserved: Just(Just(Just(10))): `[[[10]]]`.

## Containers {#containers}

| YQL type | JSON type | JSON example |
| --- | --- | --- |
| `List<Type>` | Array | [1,2,3,4] |
| `Dict<KeyType, ValueType>` | Array of arrays | [[key1, value1], [key2, value2]] |
| `Set<KeyType>` | Array | [key_value1, key_value2] |
| `Tuple<Type1, Type2>` | Array | [element1, element2, ..]<br/>[]: Empty tuple |
| `Struct<Name:Utf8,Age:Int32>` | Object {} | `{ "Name": "John", "Age": 128 }` |
| `Variant<Type1, Type2>` with a tuple | Two-element array: [filled_index, Value_by_index] | Variant\<Utf8, Int32> Variant(64563, 1) — [1, 64563] |
| `Variant<value:Int32,error:String>` structured string | Two-element array: [filled_index, Value_by_index] | Variant\<complete:Bool,error:Utf8><br/>Variant(false, "complete") — ["complete", false] |

## Special types {#special-types}

| YQL type | JSON type |
| --- | --- |
| `Void`, `Null` | Null |
| `EmptyList`, `EmptyDict` | [] |
| `Tagged` | The original type is preserved, but the custom tag name is lost |