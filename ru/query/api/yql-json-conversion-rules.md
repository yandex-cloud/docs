# Соответствие YQL и Json-типов 

Ниже приведены правила преобразования YQL-типов в Json-результаты.

## Скалярные типы
| YQL тип| Json-тип|   Пример в json|
|---|---|---|
| `Int8`/`Int16`/`Int32`<br/>`Uint8`/`Uint16`/`Uint32`  | Integer| 647713|
| `Int64`/`Uint64` | Integer[-(2^53-1^) ... (2^53-1^)] Integer, вне - String| -9007199254740991<br/>"-9007199254740991"<br/>"10446744073709551615" <br/>|
| `Bool` | Bool| true|
| `Float`/`Double` | Double, NaN и Inf - пишутся в String| 7.88731023<br/>"nan"<br/>"inf"|
| `Decimal` | String | "45.23410083" |
| `String` | строка в Base64(bytes array of string) | "0LDQsdGB0ZHQmWFiYw==" |
| `Utf8` | String  |  |


## Сложные типы
| YQL тип| Json-тип|   Пример в json|
|---|---|---|
| `Json`/`JsonDocument` | String (весь узел вставляется как строка) | "{\\\"a\\\":[1,2,3]}" |
| `Yson` | | |
| `Uuid`| String | "1c77e2b2-0e19-4371-bd72-e8fd207b028d" |
| `Date`/`Datetime`/`Timestamp` | String, кодирование в ISO-8601 | "2022-02-09"<br/>"2021-01-01T14:05:43Z"<br/>"2022-02-13T12:26:52.879622Z"|
| `TzDate`/`TzDatetime`/`TzTimestamp` | String, кодирование в ISO-8601| "2023-04-14,Pacific/Easter"<br/>"2023-04-14T00:15:00,Pacific/Easter"<br/>"2022-02-13T19:32:44.087924,Asia/Vientiane"
 |
| Interval | String, Кодировка в [ISO-8601](https://en.wikipedia.org/wiki/ISO_8601#Durations) | "PT1M" |


## Опциональные типы

| YQL тип| Json-тип|   Пример в json|
|---|---|---|
| `Optional` | массив [] | [] - Nothing [10] - Just 10 |

Вложенность Optional сохраняется, Nothing(Nothing(Just 10)) - `[[[10]]]`.


## Контейнеры

| YQL тип| Json-тип|   Пример в json|
|---|---|---|
| `List<Type>`  | массив | [1,2,3,4]  |
| `Dict<KeyType, ValueType>` | массив массивов | [[key1, value1], [key2, value2]]`  |
| `Set<KeyType>` | массив  | `[key_value1, key_value2]`  |
| `Tuple<Type1, Type2>` | массив | [element1, element2, ..]<br/>[] - пустой tuple  |
| `Struct<Name:String,Age:Int32>`| объект {} | {"a":6473,"b":[1,2,3,4]}  |
| `Variant<Type1, Type2>` c tuple | массив из 2-х элементов [filled_index, Value_by_index] | `Variant<Utf8, Int32> Variant(64563, 1) - [1, 64563]` |
| `Variant<value:Int32,error:String>` с структурой | массив из 2-х элементов  [filled_member_name, Value] | `Variant<complete:Bool,error:Utf8>`<br/>`Variant(false, "complete")` - ["complete", false]`  |


## Специальные типы

| YQL тип| Json-тип|   Пример в json|
|---|---|---|
| `Void`/`Null` | null |  |
| `EmptyList`/`EmptyDict` | [] |  |
| `Tagged` | сохраняется исходный тип, имя пользовательского тега теряется |  |
