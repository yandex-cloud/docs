---
title: String functions
editable: false
sourcePath: en/_api-ref/datalens/function-ref/string-functions.md
---

# String functions


## [ASCII](ASCII.md)

**Syntax:**`ASCII( string )`

Returns the numeric representation of the first character of the string.



## [CHAR](CHAR.md)

**Syntax:**`CHAR( string )`

Converts the numeric representation of an ASCII character to a value.



## [CONCAT](CONCAT.md)

**Syntax:**`CONCAT( arg_1, arg_2, arg_3 [ , ... ] )`

Merges any number of strings. When non-string types are used, they're converted to strings and then merged.



## [CONTAINS](CONTAINS.md)

**Syntax:**`CONTAINS( string, substring )`

Returns `TRUE` if `string` contains `substring`. For case-insensitive searches, see [ICONTAINS](ICONTAINS.md).



## [ENDSWITH](ENDSWITH.md)

**Syntax:**`ENDSWITH( string, substring )`

Returns `TRUE` if `string` ends in `substring`. For case-insensitive searches, see [IENDSWITH](IENDSWITH.md).



## [FIND](FIND.md)

**Syntax:**`FIND( string, substring [ , start_index ] )`

Returns the index of the position of the first character of the substring `substring` in the string `string`.

If the `start_index` option is specified, the search starts from the specified position.



## [ICONTAINS](ICONTAINS.md)

**Syntax:**`ICONTAINS( string, substring )`

Case-insensitive version of [CONTAINS](CONTAINS.md). Returns `TRUE` if `string` contains `substring`.



## [IENDSWITH](IENDSWITH.md)

**Syntax:**`IENDSWITH( string, substring )`

Case-insensitive version of [ENDSWITH](ENDSWITH.md). Returns `TRUE` if `string` ends in `substring`.



## [ISTARTSWITH](ISTARTSWITH.md)

**Syntax:**`ISTARTSWITH( string, substring )`

Case-insensitive version of [STARTSWITH](STARTSWITH.md). Returns `TRUE`  if `string` starts with `substring`.



## [LEFT](LEFT.md)

**Syntax:**`LEFT( string, number )`

Returns a string that contains the number of characters specified in `number` from the beginning of the string `string`.



## [LEN](LEN.md)

**Syntax:**`LEN( value )`

Returns the number of characters in the string or items in array `value`.



## [LOWER](LOWER.md)

**Syntax:**`LOWER( string )`

Returns the string `string` in lowercase.



## [LTRIM](LTRIM.md)

**Syntax:**`LTRIM( string )`

Returns the string `string` without spaces at the beginning of the string.



## [REGEXP_EXTRACT](REGEXP_EXTRACT.md)

**Syntax:**`REGEXP_EXTRACT( string, pattern )`

Returns the substring `string` that matches the regular expression pattern `pattern`.



## [REGEXP_EXTRACT_NTH](REGEXP_EXTRACT_NTH.md)

**Syntax:**`REGEXP_EXTRACT_NTH( string, pattern, match_index )`

Returns a substring `string` that matches the regular expression pattern `pattern` starting from the specified index.



## [REGEXP_MATCH](REGEXP_MATCH.md)

**Syntax:**`REGEXP_MATCH( string, pattern )`

Returns 'TRUE' if the string `string` has a substring that matches the regular expression pattern `pattern`.



## [REGEXP_REPLACE](REGEXP_REPLACE.md)

**Syntax:**`REGEXP_REPLACE( string, pattern, replace_with )`

Searches for a substring in the string `string` using the regular expression pattern `pattern` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.



## [REPLACE](REPLACE.md)

**Syntax:**`REPLACE( string, substring, replace_with )`

Searches for the substring `substring` in the string `string` and replaces it with the string `replace_with`.

If the substring is not found, the string is not changed.



## [RIGHT](RIGHT.md)

**Syntax:**`RIGHT( string, number )`

Returns a string that contains the number of characters specified in `number` from the end of the string `string`.



## [RTRIM](RTRIM.md)

**Syntax:**`RTRIM( string )`

Returns the string `string` without spaces at the end of the string.



## [SPACE](SPACE.md)

**Syntax:**`SPACE( value )`

Returns a string with the specified number of spaces.



## [SPLIT](SPLIT.md)

**Syntax:**`SPLIT( orig_string [ , delimiter [ , part_index ] ] )`

Returns a substring from `orig_string` using the `delimiter` delimiter character to divide the string into a sequence of `part_index` parts. Delimiter is a comma by default. If `part_index` is not passed, an array is returned (only for `ClickHouse`, `PostgreSQL` sources)



## [STARTSWITH](STARTSWITH.md)

**Syntax:**`STARTSWITH( string, substring )`

Returns `TRUE` if `string` starts with `substring`. For case-insensitive searches, see [ISTARTSWITH](ISTARTSWITH.md).



## [SUBSTR](SUBSTR.md)

**Syntax:**`SUBSTR( string, from_index [ , length ] )`

Returns the substring `string` starting from the index `from_index`. The numbering starts with one.

If an additional argument `length` is specified, a substring of the specified length is returned.



## [TRIM](TRIM.md)

**Syntax:**`TRIM( string )`

Returns the string `string` without spaces at the beginning or end of the string.



## [UPPER](UPPER.md)

**Syntax:**`UPPER( string )`

Returns the string `string` in uppercase.



## [UTF8](UTF8.md)

**Syntax:**`UTF8( string, old_encoding )`

Converts the `string` string encoding to `UTF8`.


