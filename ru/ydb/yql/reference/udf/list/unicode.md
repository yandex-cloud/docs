---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Unicode UDF


Функции для работы с Unicode строками:

**Список функций**

* ```Unicode::IsUtf(String) -> Bool```

   Проверяет является ли строка валидной utf-8 последовательностью. Например, строка ```"\xF0"``` не является валидной utf-8 последовательностью, а строка ```"\xF0\x9F\x90\xB1"``` корректно описывает utf-8 emoji с котиком.
* ```Unicode::GetLength(Utf8{Flags:AutoMap}) -> Uint64```

   Возвращает длину utf-8 строки в символах (unicode code points). Суррогатные пары учитываются как один символ.
* ```Unicode::Substring(Utf8{Flags:AutoMap}, from:Uint64?, len:Uint64?) -> Utf8```

   Возвращает подстроку начиная с символа ```from``` длиной в ```len``` символов. Если аргумент ```len``` опущен, то подстрока берется до конца исходной строки.
* ```Unicode::Normalize(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFD(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFC(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFKD(Utf8{Flags:AutoMap}) -> Utf8```
* ```Unicode::NormalizeNFKC(Utf8{Flags:AutoMap}) -> Utf8```

   Вышеперечисленные функции приводят переданную utf-8 строку в одну из [нормальных форм](https://unicode.org/reports/tr15/#Norm_Forms).
* ```Unicode::Translit(Utf8{Flags:AutoMap}, [String?]) -> Utf8```

   Транслитерирует в латинский алфавит слова переданной строки, целиком состоящие из символов алфавита языка, переданного вторым аргументом. Если язык не указан, то транслитерация ведется с русского. Доступные языки: "kaz", "rus", "tur", "ukr".
* ```Unicode::LevensteinDistance(Utf8{Flags:AutoMap}, Utf8{Flags:AutoMap}) -> Uint64```

   Вычисляет расстояние Левенштейна для переданных строк.
* ```Unicode::Fold(Utf8{Flags:AutoMap}, [Language:String?, DoLowerCase:Bool?]) -> Utf8```

   Выполняет [case folding](https://www.w3.org/TR/charmod-norm/#definitionCaseFolding) для переданной строки. ```Language``` задается по тем же правилам, что и в ```Unicode::Translit()```; ```DoLowerCase``` приводит строку к нижнему регистру, по умолчанию ```true```.
* ```Unicode::ReplaceAll(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8```

   Aргументы: ```input```, ```find```, ```replacement```. Заменяет все вхождения строки ```find``` в ```input``` на ```replacement```.
* ```Unicode::ReplaceFirst(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- аргументы: input, find, replacement```

   Aргументы: ```input```, ```findSymbol```, ```replacementSymbol```. Заменяет первое вхождение символа ```findSymbol``` в ```input``` на ```replacementSymbol```. Символ не может быть суррогатной парой.
* ```Unicode::ReplaceLast(Utf8{Flags:AutoMap}, Utf8, Utf8) -> Utf8 -- аргументы: input, find, replacement```

   Aргументы: ```input```, ```findSymbol```, ```replacementSymbol```. Заменяет последнее вхождение символа ```findSymbol``` в ```input``` на ```replacementSymbol```. Символ не может быть суррогатной парой.
* ```Unicode::RemoveAll(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления. Удаляются все вхождения.
* ```Unicode::RemoveFirst(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления. Удаляется первое вхождение.
* ```Unicode::RemoveLast(Utf8{Flags:AutoMap}, Utf8) -> Utf8```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления. Удаляется последнее вхождение.
* ```Unicode::Reverse(Utf8{Flags:AutoMap})```

   Разворачивает переданную строку.

**Примеры**

```sql
SELECT Unicode::Fold("Eylül", "tur" AS Language); -- "eylul"
SELECT Unicode::GetLength("жніўня");              -- 6
```
