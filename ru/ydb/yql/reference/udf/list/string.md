# String UDF


Функции для работы со строками ASCII:

**Список функций**

* ```String::Base64Encode(String{Flags:AutoMap}) -> String```
* ```String::Base64Decode(String) -> String?```
* ```String::EscapeC(String{Flags:AutoMap}) -> String```
* ```String::UnescapeC(String{Flags:AutoMap}) -> String```
* ```String::HexEncode(String{Flags:AutoMap}) -> String```
* ```String::HexDecode(String) -> String?```
* ```String::EncodeHtml(String{Flags:AutoMap}) -> String```
* ```String::DecodeHtml(String{Flags:AutoMap}) -> String```
* ```String::CgiEscape(String{Flags:AutoMap}) -> String```
* ```String::CgiUnescape(String{Flags:AutoMap}) -> String```
* ```String::Strip(String{Flags:AutoMap}) -> String```
* ```String::Collapse(String{Flags:AutoMap}) -> String```
* ```String::CollapseText(String{Flags:AutoMap}, Uint64) -> String```
* ```String::Contains(String?, String) -> Bool```
* ```String::Find(String{Flags:AutoMap}, String, [Uint64?]) -> Int64```

   Возвращает первую найденную позицию или -1; Опциональный аргумент - отступ от начала строки.
* ```String::ReverseFind(String{Flags:AutoMap}, String, [Uint64?]) -> Int64```

   Возвращает последнюю найденную позицию или -1; Опциональный аргумент - отступ от конца строки.
* ```String::HasPrefix(String?, String) -> Bool```
* ```String::HasPrefixIgnoreCase(String?, String) -> Bool```
* ```String::StartsWith(String?, String) -> Bool```
* ```String::StartsWithIgnoreCase(String?, String) -> Bool```
* ```String::HasSuffix(String?, String) -> Bool```
* ```String::HasSuffixIgnoreCase(String?, String) -> Bool```
* ```String::EndsWith(String?, String) -> Bool```
* ```String::EndsWithIgnoreCase(String?, String) -> Bool```
* ```String::Substring(String{Flags:AutoMap}, [Uint64?, Uint64?]) -> String```
* ```String::ToLower(String?) -> String?```
* ```String::ToUpper(String?) -> String?```
* ```String::ToTitle(String?) -> String?```
* ```String::SplitToList(String?, String, [DelimeterString:Bool?]) -> List<String> ```

   По умолчанию несколько символов в разделителе интерпретируется как «любой из», а с опциональным булевым флагом — как один многосимвольный.
* ```String::JoinFromList(List<String>{Flags:AutoMap}, String) -> String```
* ```String::ToByteList(List<String>{Flags:AutoMap}) -> List<Byte>```
* ```String::ReplaceAll(String{Flags:AutoMap}, String, String) -> String ```

   Аргументы: input, find, replacement.
* ```String::ReplaceFirst(String{Flags:AutoMap}, String, String) -> String ```

   Аргументы: input, find, replacement, второй и третий аргумент — символ.
* ```String::ReplaceLast(String{Flags:AutoMap}, String, String) -> String ```

   Аргументы: input, find, replacement, второй и третий аргумент — символ.
* ```String::RemoveAll(String{Flags:AutoMap}, String) -> String```

   Второй аргумент интерпретируется как неупорядоченный набор символов для удаления.
* ```String::RemoveFirst(String{Flags:AutoMap}, String) -> String```

   Второй аргумент — символ для удаления.
* ```String::RemoveLast(String{Flags:AutoMap}, String) -> String ```

   Второй аргумент — символ для удаления.
* ```String::IsAscii(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiSpace(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiUpper(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiLower(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiAlpha(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiAlnum(String{Flags:AutoMap}) -> Bool```
* ```String::IsAsciiHex(String{Flags:AutoMap}) -> Bool```
* ```String::LevensteinDistance(String{Flags:AutoMap}, String{Flags:AutoMap}) -> Uint64```
* ```String::RightPad(String{Flags:AutoMap}, Uint64) -> String```
* ```String::Hex(Uint64{Flags:AutoMap}) -> String```
* ```String::SHex(Int64{Flags:AutoMap}) -> String```
* ```String::Bin(Uint64{Flags:AutoMap}) -> String```
* ```String::SBin(Int64{Flags:AutoMap}) -> String```
* ```String::HexText(String{Flags:AutoMap}) -> String```
* ```String::BinText(String{Flags:AutoMap}) -> String```
* ```String::HumanReadableDuration(Uint64{Flags:AutoMap}) -> String```
* ```String::HumanReadableQuantity(Uint64{Flags:AutoMap}) -> String```
* ```String::HumanReadableBytes(Uint64{Flags:AutoMap}) -> String```
* ```String::Prec(Double{Flags:AutoMap}, Uint64) -> String* ```

{% note alert %}

Функции из String UDF не поддерживают кириллицу и умеют работать только с ASCII символами. Для работы со строками в кодировке UTF-8 используйте функции из [Unicode UDF](unicode.md).

{% endnote %}

**Примеры**

```sql
SELECT String::Base64Encode("YQL"); -- "WVFM"
SELECT String::Strip("YQL ");       -- "YQL"
```
