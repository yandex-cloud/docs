# String UDF

Functions for ASCII strings:

**List of functions**

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

   Returns the first position found or -1. The optional argument is the offset from the beginning of the string.

* ```String::ReverseFind(String{Flags:AutoMap}, String, [Uint64?]) -> Int64```

   Returns the last position found or -1. The optional argument is the offset from the end of the string.

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

   By default, multiple characters in the delimiter are interpreted as "any of". With the optional Boolean flag, they are interpreted as one multi-character delimiter.

* ```String::JoinFromList(List<String>{Flags:AutoMap}, String) -> String```

* ```String::ToByteList(List<String>{Flags:AutoMap}) -> List<Byte>```

* ```String::ReplaceAll(String{Flags:AutoMap}, String, String) -> String ```

   Arguments: input, find, replacement.

* ```String::ReplaceFirst(String{Flags:AutoMap}, String, String) -> String ```

   Arguments: input, find, replacement, the second argument and the third argument is a character.

* ```String::ReplaceLast(String{Flags:AutoMap}, String, String) -> String ```

   Arguments: input, find, replacement, the second argument and the third argument is a character.

* ```String::RemoveAll(String{Flags:AutoMap}, String) -> String```

   The second argument is interpreted as an unordered set of characters to be removed.

* ```String::RemoveFirst(String{Flags:AutoMap}, String) -> String```

   The second argument is the character to be removed.

* ```String::RemoveLast(String{Flags:AutoMap}, String) -> String ```

   The second argument is the character to be removed.

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

The functions from String UDF don't support Cyrillic and can only work with ASCII characters. To work with UTF-8 encoded strings, use the functions from [Unicode UDF](unicode.md).

{% endnote %}

**Examples**

```sql
SELECT String::Base64Encode("YQL"); -- "WVFM"
SELECT String::Strip("YQL ");       -- "YQL"
```

