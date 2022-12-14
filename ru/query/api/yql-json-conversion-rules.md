# Соответствие YQL и Json-типов

Ниже приведены правила преобразования YQL-типов в Json-результаты.

## Скалярные типы {#scalars-types}

| YQL-тип | Json-тип | Пример в json |
| --- | --- | --- |
| `Int8`, `Int16`, `Int32`<br/>`Uint8`, `Uint16`, `Uint32` | Integer | 647713 |
| `Int64`, `Uint64` | Integer, если значение в диапазоне [-(2^53-1^) ... (2^53-1^)], иначе String | -9007199254740991<br/>"-9007199254740991"<br/>"10446744073709551615" <br/> |
| `Bool` | Bool | True |
| `Float`, `Double` | Double<br/>NaN и Inf (пишутся в String) | 7,88731023<br/>"nan"<br/>"inf" |
| `Decimal` | String | "45,23410083" |
| `String` | Строка в Base64 (байтовый массив строк) | "0LDQsdGB0ZHQmWFiYw==" |
| `Utf8` | String | "Текст строки" |

## Сложные типы {#complex-types}

| YQL-тип | Json-тип | Пример в json |
| --- | --- | --- |
| `Json`, `JsonDocument` | String (весь узел вставляется как строка) | "{\\\"a\\\":[1,2,3]}" |
| `Date`, `Datetime`, `Timestamp` | String (кодировка в [ISO-8601](https://en.wikipedia.org/wiki/ISO_8601#Durations)) | "2022-02-09"<br/>"2021-01-01T14:05:43Z"<br/>"2022-02-13T12:26:52.879622Z" |
| `Interval` | String (кодировка в ISO-8601) | "PT1M" |

## Опциональные типы {#optional-types}

| YQL-тип | Json-тип | Пример в json |
| --- | --- | --- |
| `Optional` | Массив [] | [] — Nothing [10] — Just 10 |

Вложенность Optional сохраняется: Just(Just(Just(10))) — `[[[10]]]`.

## Контейнеры {#containers}

| YQL-тип | Json-тип | Пример в Json |
| --- | --- | --- |
| `List<Type>` | Массив | [1,2,3,4] |
| `Dict<KeyType, ValueType>` | Массив массивов | [[key1, value1], [key2, value2]] |
| `Set<KeyType>` | Массив | [key_value1, key_value2] |
| `Tuple<Type1, Type2>` | Массив | [element1, element2, ..]<br/>[] — пустой tuple |
| `Struct<Name:Utf8,Age:Int32>`| Объект {} | `{ "Name": "John", "Age": 128 }` |
| `Variant<Type1, Type2>` c tuple | Массив из двух элементов [filled_index, Value_by_index] | Variant\<Utf8, Int32> Variant(64563, 1) — [1, 64563] |
| `Variant<value:Int32,error:String>` со структурой | Массив из двух элементов [filled_member_name, Value] | Variant\<complete:Bool,error:Utf8><br/>Variant(false, "complete") — ["complete", false] |

## Специальные типы {#special-types}

| YQL-тип | Json-тип |
| --- | --- |
| `Void`, `Null` | Null |
| `EmptyList`, `EmptyDict` | [] |
| `Tagged` | Сохраняется исходный тип, имя пользовательского тега теряется |
