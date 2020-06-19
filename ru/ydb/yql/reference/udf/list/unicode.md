# Unicode UDF


Функции для работы со строками Unicode на основе библиотек `util/charset/` и `library/unicode/`.


**Список функций**

* ```Unicode::IsUtf(String) -> Bool```
* ```Unicode::GetLength(Utf8{Flags:AutoMap}) -> Uint64```
* ```Unicode::Substring(Utf8{Flags:AutoMap}, Uint64?, Uint64?) -> Utf8```
* ```Unicode::Normalize(Utf8{Flags:AutoMap}) -> Utf8 -- NFC```
* ```Unicode::NormalizeNFD(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFC(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFKD(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFKC(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::Translit(Utf8{Flags:AutoMap}, [String?]) -> Utf8```

   Второй аргумент — название языка по-английски.
* ```Unicode::LevensteinDistance(Utf8{Flags:AutoMap}, Utf8{Flags:AutoMap}) -> Uint64```
* ```Unicode::Fold(Utf8{Flags:AutoMap}, [Language:String?,DoLowerCase:Bool?,DoRenyxa:Bool?,DoSimpleCyr:Bool?,FillOffset:Bool?]) -> Utf8```
* ```Unicode::ReplaceAll(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- аргументы: input, find, replacement```
* ```Unicode::ReplaceFirst(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- аргументы: input, find, replacement```
* ```Unicode::ReplaceLast(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- аргументы: input, find, replacement```
* ```Unicode::RemoveAll(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления.
* ```Unicode::RemoveFirst(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления.
* ```Unicode::RemoveLast(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления.
   
**Примеры**

```sql
SELECT Unicode::Fold("Eylül", "Turkish" AS Language); -- "eylul"
SELECT Unicode::GetLength("жніўня");                  -- 6
```
