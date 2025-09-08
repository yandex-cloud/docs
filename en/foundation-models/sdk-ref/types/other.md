---
sourcePath: en/_sdk-ref/sdk-ref/types/other.md
---
# Other types

## Settings types

### *class* yandex\_cloud\_ml\_sdk.\_models.completions.config.**ReasoningMode**{#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode}

Enumeration for reasoning modes.

This class defines the various modes of reasoning that can be used in the model’s configurations.

**REASONING\_MODE\_UNSPECIFIED** = *0*{#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode.REASONING_MODE_UNSPECIFIED}

indicates that the reasoning mode is unspecified

**DISABLED** = *1*{#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode.DISABLED}

indicates that reasoning is disabled

**ENABLED\_HIDDEN** = *2*{#yandex_cloud_ml_sdk._models.completions.config.ReasoningMode.ENABLED_HIDDEN}

indicates that reasoning is enabled but hidden

### *class* yandex\_cloud\_ml\_sdk.\_chat.completions.config.**ChatReasoningMode**{#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode}

**LOW** = *'low'*{#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.LOW}

**MEDIUM** = *'medium'*{#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.MEDIUM}

**HIGH** = *'high'*{#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.HIGH}

**\_\_new\_\_**(*value*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_cloud_ml_sdk._chat.completions.config.ChatReasoningMode.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

## Generic types

### *class* yandex\_cloud\_ml\_sdk.\_types.model.**ModelTypeT**{#yandex_cloud_ml_sdk._types.model.ModelTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_types.model.**ConfigTypeT**{#yandex_cloud_ml_sdk._types.model.ConfigTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_types.batch.domain.**BatchSubdomainTypeT**{#yandex_cloud_ml_sdk._types.batch.domain.BatchSubdomainTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_tools.tool\_call.**ToolCallTypeT**{#yandex_cloud_ml_sdk._tools.tool_call.ToolCallTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_tools.function.**FunctionToolsTypeT**{#yandex_cloud_ml_sdk._tools.function.FunctionToolsTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_tools.function\_call.**FunctionCallTypeT**{#yandex_cloud_ml_sdk._tools.function_call.FunctionCallTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_datasets.draft.**DatasetDraftT**{#yandex_cloud_ml_sdk._datasets.draft.DatasetDraftT}

### *class* yandex\_cloud\_ml\_sdk.\_tuning.tuning\_task.**TuningResultTypeT\_co**{#yandex_cloud_ml_sdk._tuning.tuning_task.TuningResultTypeT_co}

### *class* yandex\_cloud\_ml\_sdk.\_types.operation.**ResultTypeT\_co**{#yandex_cloud_ml_sdk._types.operation.ResultTypeT_co}

### *class* yandex\_cloud\_ml\_sdk.\_search\_api.generative.generative.**GenerativeSearchTypeT**{#yandex_cloud_ml_sdk._search_api.generative.generative.GenerativeSearchTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_runs.result.**StatusTypeT**{#yandex_cloud_ml_sdk._runs.result.StatusTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_runs.result.**MessageTypeT**{#yandex_cloud_ml_sdk._runs.result.MessageTypeT}

### *class* yandex\_cloud\_ml\_sdk.\_types.operation.**AnyResultTypeT\_co**{#yandex_cloud_ml_sdk._types.operation.AnyResultTypeT_co}

### *class* yandex\_cloud\_ml\_sdk.\_types.operation.**OperationStatusTypeT**{#yandex_cloud_ml_sdk._types.operation.OperationStatusTypeT}

## Miscellaneous types

### *class* yandex\_cloud\_ml\_sdk.\_types.misc.**Undefined**{#yandex_cloud_ml_sdk._types.misc.Undefined}

Class for making possible to differ None and not-passed default value.

Sentinel until PEP 0661.

### *class* yandex\_cloud\_ml\_sdk.\_types.misc.**UndefinedOr**{#yandex_cloud_ml_sdk._types.misc.UndefinedOr}

### *class* yandex\_cloud\_ml\_sdk.\_types.misc.**PathLike**{#yandex_cloud_ml_sdk._types.misc.PathLike}

yandex\_cloud\_ml\_sdk.\_types.misc.**UNDEFINED** = *Undefined*{#yandex_cloud_ml_sdk._types.misc.UNDEFINED}

Default, non-passed value

yandex\_cloud\_ml\_sdk.\_types.schemas.**LITERAL\_RESPONSE\_FORMATS** = *('json',)*{#yandex_cloud_ml_sdk._types.schemas.LITERAL_RESPONSE_FORMATS}

Available response formats

yandex\_cloud\_ml\_sdk.\_types.schemas.**StrResponseType**{#yandex_cloud_ml_sdk._types.schemas.StrResponseType}

Type for string response formats

Alias of **Literal**[**'json'**]

yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonVal**{#yandex_cloud_ml_sdk._types.schemas.JsonVal}

Recurrent json object

Alias of **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), [**JsonArray**](#yandex_cloud_ml_sdk._types.schemas.JsonArray), [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]

yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonArray**{#yandex_cloud_ml_sdk._types.schemas.JsonArray}

Json array

Alias of [**list**](https://docs.python.org/3/library/stdtypes.html#list)[**Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), [**JsonArray**](#yandex_cloud_ml_sdk._types.schemas.JsonArray), [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]

yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonObject**{#yandex_cloud_ml_sdk._types.schemas.JsonObject}

Json object

Alias of [**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), [**JsonArray**](#yandex_cloud_ml_sdk._types.schemas.JsonArray), [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]

yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonSchemaType**{#yandex_cloud_ml_sdk._types.schemas.JsonSchemaType}

Type for json schema

Alias of [**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), [**JsonArray**](#yandex_cloud_ml_sdk._types.schemas.JsonArray), [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonSchemaResponseType**{#yandex_cloud_ml_sdk._types.schemas.JsonSchemaResponseType}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

Dict with json schema response settings

#|
|| Required Keys | 

- **json\_schema** ([**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]]]) – Field with json schema which describes response format
- **strict** ([**bool**](https://docs.python.org/3/library/functions.html#bool))
- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

yandex\_cloud\_ml\_sdk.\_types.schemas.**ResponseType**{#yandex_cloud_ml_sdk._types.schemas.ResponseType}

Types availailable for response format

Alias of **Union**[**Literal**[**'json'**], [**JsonSchemaResponseType**](#yandex_cloud_ml_sdk._types.schemas.JsonSchemaResponseType), [**type**](https://docs.python.org/3/library/functions.html#type)]

yandex\_cloud\_ml\_sdk.\_types.schemas.**ParametersType**{#yandex_cloud_ml_sdk._types.schemas.ParametersType}

Types available for function call parameters

Alias of **Union**[[**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), [**JsonArray**](#yandex_cloud_ml_sdk._types.schemas.JsonArray), [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]], [**type**](https://docs.python.org/3/library/functions.html#type)]

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonObjectProtoFormat**{#yandex_cloud_ml_sdk._types.schemas.JsonObjectProtoFormat}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **json\_object** ([**bool**](https://docs.python.org/3/library/functions.html#bool)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonSchemaProtoFormat**{#yandex_cloud_ml_sdk._types.schemas.JsonSchemaProtoFormat}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **json\_schema** ([**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]]]) – Field with json schema which describes response format ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**EmptyProtoFormat**{#yandex_cloud_ml_sdk._types.schemas.EmptyProtoFormat}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonSchemaResponseFormat**{#yandex_cloud_ml_sdk._types.schemas.JsonSchemaResponseFormat}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **schema** ([**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**dict**](https://docs.python.org/3/library/stdtypes.html#dict)[[**str**](https://docs.python.org/3/library/stdtypes.html#str), **Union**[[**None**](https://docs.python.org/3/library/constants.html#None), [**bool**](https://docs.python.org/3/library/functions.html#bool), [**str**](https://docs.python.org/3/library/stdtypes.html#str), [**float**](https://docs.python.org/3/library/functions.html#float), [**int**](https://docs.python.org/3/library/functions.html#int), **TypeAliasForwardRef**, [**JsonObject**](#yandex_cloud_ml_sdk._types.schemas.JsonObject)]]]])
- **strict** ([**bool**](https://docs.python.org/3/library/functions.html#bool))
- **name** ([**str**](https://docs.python.org/3/library/stdtypes.html#str)) ||
|#

*typeddict* yandex\_cloud\_ml\_sdk.\_types.schemas.**JsonSchemaParameterType**{#yandex_cloud_ml_sdk._types.schemas.JsonSchemaParameterType}

Bases: [**TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict)

[**typing.TypedDict**](https://docs.python.org/3/library/typing.html#typing.TypedDict).

#|
|| Required Keys | 

- **type** (**Literal**[**'json\_object'**, **'json\_schema'**])
- **json\_schema** ([**JsonSchemaResponseFormat**](#yandex_cloud_ml_sdk._types.schemas.JsonSchemaResponseFormat)) – Field with json schema which describes response format ||
|#

yandex\_cloud\_ml\_sdk.\_types.schemas.**make\_response\_format\_kwargs**(*response\_format*){#yandex_cloud_ml_sdk._types.schemas.make_response_format_kwargs}

Here we are transforming 1) http\_schema <- schema\_from\_response\_format(response\_format) 2) grpc\_schema <- http\_schema

#|
|| Parameters | **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_cloud\_ml\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| None*) ||
|| Return type | [*JsonObjectProtoFormat*](#yandex_cloud_ml_sdk._types.schemas.JsonObjectProtoFormat) \| [*JsonSchemaProtoFormat*](#yandex_cloud_ml_sdk._types.schemas.JsonSchemaProtoFormat) \| [*EmptyProtoFormat*](#yandex_cloud_ml_sdk._types.schemas.EmptyProtoFormat) ||
|#

### *class* yandex\_cloud\_ml\_sdk.\_tools.tool\_call\_list.**HttpToolCallList**{#yandex_cloud_ml_sdk._types.schemas.yandex_cloud_ml_sdk._tools.tool_call_list.HttpToolCallList}