# Function

## *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.function.**AsyncSpeechToTextFunction**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction}

Speech to Text function for creating speech recognition object which provides methods for invoking recognition.

*async* **get\_recognition\_result**(*operation\_id*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.get_recognition_result}

Gets results of asynchronous recognition after finishing the operation.

#|
|| Parameters | 

- **operation\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncDeferredSpeechToTextResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult) ||
|#

#### *class* **AudioFormat**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat}

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.denominator}

the denominator of a rational number in lowest terms

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) packed into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.AudioFormat.__init__i}

#### *class* **EndOfUtteranceClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.EndOfUtteranceClassifier}

Class which encapsulates settings [end of utterance classifier](https://aistudio.yandex.ru/docs/speechkit/stt/eou).

Usage this class object in speech to text configuration turning on default end-of-utterance classification.

```python
>>> EndOfUtteranceClassifier()
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=Undefined)
```

```python
>>> EndOfUtteranceClassifier(sensitivity='high')
EndOfUtteranceClassifier(sensitivity=<EndOfUtteranceSensitivity.HIGH: 2>, ...)
```

```python
>>> EndOfUtteranceClassifier(max_pause_between_words_hint_ms=10)
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=10)
```

**\_\_init\_\_**(*sensitivity=Undefined*, *max\_pause\_between\_words\_hint\_ms=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.EndOfUtteranceClassifier.__init__i}

#|
|| Parameters | 

- **sensitivity** ([*EndOfUtteranceSensitivity*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*EndOfUtteranceSensitivity*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **max\_pause\_between\_words\_hint\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**max\_pause\_between\_words\_hint\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.EndOfUtteranceClassifier.max_pause_between_words_hint_ms}

Hint for max pause between words. SpeechKit EOU detector could use this information to adjust the speed of the EOU detection. For example, a long pause between words will help distinguish between the end of utterance from slow speech like **One <long pause> two <long pause> three**. A short pause can be helpful if the speaker is speaking quickly and does not emphasize pauses between sentences.

**sensitivity**\: *[EndOfUtteranceSensitivity](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[EndOfUtteranceSensitivity](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.EndOfUtteranceClassifier.sensitivity}

EOU sensitivity

#### *class* **LLMPostProcessing**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing}

Class for encapsulating [transcription llm post processing settings](https://aistudio.yandex.ru/docs/speechkit/stt/llm-results)

You could pass a full model uri:

```python
>>> llm_post_processor = LLMPostProcessing('gpt://<folder_id>/yandexgt/latest')
```

You could use model name, in this case model uri will be built using configurated folder\_id:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt')
```

You could also pass a model version, which have ‘latest’ by default:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt', model_version='latest')
```

After post processor object creation you should add some instructions into it by using **.with\_instruction** method (which is not mutates the object, but creates a copy):

```python
>>> llm_post_processor = llm_post_processor.with_instruction("Make a short review")
>>> llm_post_processor = llm_post_processor.with_instruction(
...     "What the conversation topic",
...     response_format="json"
... )
```

Created object will looks like this:

```python
>>> llm_post_processor
LLMPostProcessing(model_name='yandexgt', model_version='latest', ...)
>>> llm_post_processor
LLMPostProcessing(..., instructions=(LLMPostProcessingInstruction(...), LLMPostProcessingInstruction(...)))
```

You also can use pydantic model or pydantic dataclass as response format.

**\_\_init\_\_**(*model\_name*, *model\_version='latest'*, *instructions=()*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing.__init__i}

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **instructions** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*LLMPostProcessingInstruction*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*]*) ||
|| Return type | None ||
|#

**instructions**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[LLMPostProcessingInstruction](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*] = *()*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing.instructions}

A list of instructions to perform with transcription.

**model\_version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)* = *'latest'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing.model_version}

The version of the model to use. Defaults to ‘latest’

**with\_instruction**(*instruction*, *response\_format=None*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing.with_instruction}

Creates a new LLMPostProcessing object, but with given instruction appended.

#|
|| Parameters | 

- **instruction** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – instruction for model.
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_ai\_studio\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| None*) – format of the response returned by the model. Format could be described as:
- *None* for usual text response (default);
- ’*json*’ string to tell a model to return JSON object;
- dictionary with a JsonSchema to enforce a specific JSON structure for the model’s response based on a provided schema;
- pydantic model or pydantic dataclass (which will be transformed into JsonSchema by SDK);
 ||
|| Return type | [*LLMPostProcessing*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing) ||
|#

**model\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LLMPostProcessing.model_name}

The [ID of the model](https://aistudio.yandex.ru/docs/foundation-models/concepts/yandexgpt/models) Model name to be used for completion generation; If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model\_name>/<model\_version>’

#### *class* **LanguageCode**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode}

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

**auto** = *'auto'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.auto}

[Automatic language detection](https://aistudio.yandex.ru/docs/speechkit/stt/models#language-labels)

**de\_DE** = *'de-DE'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.de_DE}

German

**en\_US** = *'en-US'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.en_US}

English

**es\_ES** = *'es-ES'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.es_ES}

Spanish

**fi\_FI** = *'fi-FI'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.fi_FI}

Finnish

**fr\_FR** = *'fr-FR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.fr_FR}

French

**he\_IL** = *'he-IL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.he_IL}

Hebrew

**it\_IT** = *'it-IT'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.it_IT}

Italian

**kk\_KZ** = *'kk-KZ'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.kk_KZ}

Kazakh

**nl\_NL** = *'nl-NL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.nl_NL}

Dutch

**pl\_PL** = *'pl-PL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.pl_PL}

Polish

**pt\_PT** = *'pt-PT'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.pt_PT}

Portuguese

**pt\_BR** = *'pt-BR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.pt_BR}

Brazilian Portuguese

**ru\_RU** = *'ru-RU'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.ru_RU}

Russian (default)

**sv\_SE** = *'sv-SE'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.sv_SE}

Swedish

**tr\_TR** = *'tr-TR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.tr_TR}

Turkish

**uz\_UZ** = *'uz-UZ'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.uz_UZ}

Uzbek (Latin script)

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.LanguageCode.__init__i}

#### *class* **RecognitionClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier}

Classifier to use in speech recognition.

For detailed information refer to [classification documentation](https://aistudio.yandex.ru/docs/speechkit/stt/analysis).

You can pass a string as a trigger:

```python
>>> RecognitionClassifier('insult', 'on_final')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_FINAL: 2>,))
```

Or any iterable of strings to declare few triggers:

```python
>>> RecognitionClassifier('insult', ['on_final', 'on_partial'])
RecognitionClassifier(..., triggers=(...ON_FINAL: 2>, <...ON_PARTIAL: 3>))
```

You could also use alternative constructors when you have only one trigger:

```python
>>> RecognitionClassifier.on_utterance('insult')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_UTTERANCE: 1>,))
```

There are special *RecognitionClassifier.WellKnown* enum with well-known classifier names:

```python
>>> RecognitionClassifier(RecognitionClassifier.WellKnown.gender, 'on_final')
RecognitionClassifier(name=<WellKnownRecognitionClassifiers.gender: 'gender'>, ...)
```

On unknown trigger names there will be exception raised:

```python
>>> RecognitionClassifier('insult', ['on_something'])
Traceback (most recent call last):
    ...
ValueError: wrong value "on_something" for use as an alias ...; known values: ('ON_UTTERANCE', ...)
```

**WellKnown**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.WellKnown}

alias of [**WellKnownRecognitionClassifiers**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers)

**\_\_init\_\_**(*name*, *triggers*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **triggers** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)*] \|* [*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | None ||
|#

*classmethod* **on\_final**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.on_final}

Alternative constructor to use onle ‘on\_final’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_partial**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.on_partial}

Alternative constructor to use onle ‘on\_partial’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_utterance**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.on_utterance}

Alternative constructor to use onle ‘on\_utterance’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.name}

Classifier name.

**triggers**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)] | [RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.RecognitionClassifier.triggers}

Describes the types of responses to which the classification results will come. Classification responses will follow the responses of the specified types.

#### *class* **SpeechAnalysis**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.SpeechAnalysis}

Class which encapsulates [speech analysis settings](https://aistudio.yandex.ru/docs/speechkit/stt/analysis)

**\_\_init\_\_**(*speaker\_analysis=Undefined*, *conversation\_analysis=Undefined*, *descriptive\_statistics\_quantiles=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.SpeechAnalysis.__init__i}

#|
|| Parameters | 

- **speaker\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **conversation\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **descriptive\_statistics\_quantiles** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**conversation\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.SpeechAnalysis.conversation_analysis}

Analyse conversation of two speakers

**descriptive\_statistics\_quantiles**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[float](https://docs.python.org/3/library/functions.html#float)] | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.SpeechAnalysis.descriptive_statistics_quantiles}

Quantile levels in range (0, 1) for descriptive statistics

**speaker\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.SpeechAnalysis.speaker_analysis}

Analyse speech for every speaker

#### *class* **TextNormalization**{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.TextNormalization}

Class which encapsulates [text normaliztion options](https://aistudio.yandex.ru/docs/speechkit/stt/normalization).

Usage of object of this class itself in speech to text configuration is turning on normalization. Options of this class have different defaults at backend, i.e. some options could turn on the feature and others could turn it off.

>> TextNormalization() TextNormalization()

```python
>>> TextNormalization(phone_formatting=False)
TextNormalization(phone_formatting=False, profanity_filter=Undefined, literature_text=Undefined)
```

**\_\_init\_\_**(*phone\_formatting=Undefined*, *profanity\_filter=Undefined*, *literature\_text=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.TextNormalization.__init__i}

#|
|| Parameters | 

- **phone\_formatting** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **profanity\_filter** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **literature\_text** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**literature\_text**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.TextNormalization.literature_text}

Rewrite text in literature style

**phone\_formatting**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.TextNormalization.phone_formatting}

Phone formatting

**profanity\_filter**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.TextNormalization.profanity_filter}

Profanity filter

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *audio\_format*, *model=Undefined*, *language\_codes=Undefined*, *text\_normalization=Undefined*, *eou\_classifier=Undefined*, *recognition\_classifiers=Undefined*, *speech\_analysis=Undefined*, *speaker\_labeling=Undefined*, *llm\_post\_process=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.__call__i}

Creates SpeechToText object with provides methods for speech recognition.

To learn more about parameters and their formats and possible values, refer to [STT docs](https://aistudio.yandex.ru/docs/speechkit/stt)

#|
|| Parameters | 

- **audio\_format** ([*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) – Specifies the input audio format.
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – The name of the STT model to use for recognition. See the list of available models and versions in the [speech to text documentation](https://aistudio.yandex.ru/docs/speechkit/stt/models).
- **language\_codes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*LanguageCode*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LanguageCode) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*LanguageCode*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LanguageCode)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – The list of [language codes](https://aistudio.yandex.ru/docs/speechkit/stt/models) to restrict recognition in the case of an automatic model, or a single language code.
- **text\_normalization** ([*TextNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization) *\|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – [Text normalization options](https://aistudio.yandex.ru/docs/speechkit/stt/normalization)\:
- **True** — turn on text normalization with default parameters;
- **False** — turn text normalization off;
- [**yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.TextNormalization**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization) instance — text normalization with custom parameters;
- **None** — for server default.

- **eou\_classifier** ([*EndOfUtteranceClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier) *\|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Configuration for [end of utterance detection model](https://aistudio.yandex.ru/docs/speechkit/stt/eou)\:
- **True** — use default EOU classifier;
- **False** — disable EOU classifier (“external EOU classifier” in documentation);
- [**yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.EndOfUtteranceClassifier**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier) instance — use custom EOU classifier settings;
- **None** — for server default.

- **recognition\_classifiers** ([*RecognitionClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*RecognitionClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier)*] \|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Classifier or list of [classifiers for speech recognition](https://aistudio.yandex.ru/docs/speechkit/stt/analysis#classifier).
- **speech\_analysis** ([*SpeechAnalysis*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Configuration for [speech analysis over speech recognition](https://aistudio.yandex.ru/docs/speechkit/stt/analysis#statistics).
- **speaker\_labeling** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Configuration for [speaker labeling](https://aistudio.yandex.ru/docs/speechkit/stt/speaker-labeling).
- **llm\_post\_process** ([*LLMPostProcessing*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Configuration for [LLM recognition results processing](https://aistudio.yandex.ru/docs/speechkit/stt/llm-results). (Also known as Summarization in earlier documentation.) ||
|| Return type | [*SpeechToTextTypeT*](../../types/other.md#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.SpeechToTextTypeT) ||
|#

**\_\_init\_\_**(*name*, *sdk*, *parent\_resource*){#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **sdk** ([*BaseSDK*](../../internals/bases.md#yandex_ai_studio_sdk._sdk.BaseSDK))
- **parent\_resource** ([*BaseDomain*](../../internals/bases.md#yandex_ai_studio_sdk._types.domain.BaseDomain)) ||
|#

# STT object

## *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.stt.**AsyncSpeechToText**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText}

*async* **run**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.run}

Run a speech recognition for given *input* and return joined result.

To change initial stt settings use **.configure** method:

```python
>>> stt = sdk.speechkit.speech_to_text(audio_format='mp3')
>>> stt = stt.configure(audio_format='WAV')
```

#|
|| Parameters | 

- **input** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)*]*) – In case of bytes input, input treated as an audio-data. In case of bytes/int sequence, input treated as chunks of audio data with integers for silence chunks.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | recognition result ||
|| Return type | [*SpeechToTextResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.SpeechToTextResult) ||
|#

*async* **run\_stream**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.run_stream}

Run a speech recognition for given *input*; method have an iterator return.

To change initial stt settings use **.configure** method:

```python
>>> stt = sdk.speechkit.speech_to_text(audio_format='mp3')
>>> stt = stt.configure(audio_format='WAV')
```

#|
|| Parameters | 

- **input** ([*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)*]*) – In case of bytes input, input treated as an audio-data. In case of bytes/int sequence, input treated as chunks of audio data with integers for silence chunks.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | recognition result ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*SpeechToTextStreamingEvent*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.result.event.SpeechToTextStreamingEvent)] ||
|#

*async* **run\_deferred**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.run_deferred}

Run a speech recognition for given *input* and return operation object to track progress of recognition and result retrieval.

To change initial stt settings use **.configure** method:

```python
>>> stt = sdk.speechkit.speech_to_text(audio_format='mp3')
>>> stt = stt.configure(audio_format='WAV')
```

#|
|| Parameters | 

- **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*bytes*](https://docs.python.org/3/library/stdtypes.html#bytes)) – In case of bytes input, input treated as an audio-data. In case of str input, input treated as a S3 url.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds. ||
|| Returns | Operation object. ||
|| Return type | [*AsyncOperation*](../../types/operation.md#yandex_ai_studio_sdk._types.operation.AsyncOperation)[[*AsyncDeferredSpeechToTextResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult)] ||
|#

*async* **attach\_deferred**(*operation\_id*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.attach_deferred}

Attaches to an ongoing deferred operation using its operation id.

#|
|| Parameters | 

- **operation\_id** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – the id of the deferred operation to attach to.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – the timeout, or the maximum time to wait for the request to complete in seconds. Defaults to 60 seconds. ||
|| Return type | [*AsyncOperation*](../../types/operation.md#yandex_ai_studio_sdk._types.operation.AsyncOperation)[[*AsyncDeferredSpeechToTextResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.result.top_containers.AsyncDeferredSpeechToTextResult)] ||
|#

#### *class* **AudioFormat**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat}

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.as_integer_ratio}

Return a pair of integers, whose ratio is equal to the original int.

The ratio is in lowest terms and has a positive denominator.

```python
>>> (10).as_integer_ratio()
(10, 1)
>>> (-10).as_integer_ratio()
(-10, 1)
>>> (0).as_integer_ratio()
(0, 1)
```

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.denominator}

the denominator of a rational number in lowest terms

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) packed into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.AudioFormat.__init__i}

#### *class* **EndOfUtteranceClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.EndOfUtteranceClassifier}

Class which encapsulates settings [end of utterance classifier](https://aistudio.yandex.ru/docs/speechkit/stt/eou).

Usage this class object in speech to text configuration turning on default end-of-utterance classification.

```python
>>> EndOfUtteranceClassifier()
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=Undefined)
```

```python
>>> EndOfUtteranceClassifier(sensitivity='high')
EndOfUtteranceClassifier(sensitivity=<EndOfUtteranceSensitivity.HIGH: 2>, ...)
```

```python
>>> EndOfUtteranceClassifier(max_pause_between_words_hint_ms=10)
EndOfUtteranceClassifier(sensitivity=Undefined, max_pause_between_words_hint_ms=10)
```

**\_\_init\_\_**(*sensitivity=Undefined*, *max\_pause\_between\_words\_hint\_ms=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.EndOfUtteranceClassifier.__init__i}

#|
|| Parameters | 

- **sensitivity** ([*EndOfUtteranceSensitivity*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*EndOfUtteranceSensitivity*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **max\_pause\_between\_words\_hint\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**max\_pause\_between\_words\_hint\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.EndOfUtteranceClassifier.max_pause_between_words_hint_ms}

Hint for max pause between words. SpeechKit EOU detector could use this information to adjust the speed of the EOU detection. For example, a long pause between words will help distinguish between the end of utterance from slow speech like **One <long pause> two <long pause> three**. A short pause can be helpful if the speaker is speaking quickly and does not emphasize pauses between sentences.

**sensitivity**\: *[EndOfUtteranceSensitivity](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[EndOfUtteranceSensitivity](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceSensitivity)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.EndOfUtteranceClassifier.sensitivity}

EOU sensitivity

#### *class* **LLMPostProcessing**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing}

Class for encapsulating [transcription llm post processing settings](https://aistudio.yandex.ru/docs/speechkit/stt/llm-results)

You could pass a full model uri:

```python
>>> llm_post_processor = LLMPostProcessing('gpt://<folder_id>/yandexgt/latest')
```

You could use model name, in this case model uri will be built using configurated folder\_id:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt')
```

You could also pass a model version, which have ‘latest’ by default:

```python
>>> llm_post_processor = LLMPostProcessing('yandexgt', model_version='latest')
```

After post processor object creation you should add some instructions into it by using **.with\_instruction** method (which is not mutates the object, but creates a copy):

```python
>>> llm_post_processor = llm_post_processor.with_instruction("Make a short review")
>>> llm_post_processor = llm_post_processor.with_instruction(
...     "What the conversation topic",
...     response_format="json"
... )
```

Created object will looks like this:

```python
>>> llm_post_processor
LLMPostProcessing(model_name='yandexgt', model_version='latest', ...)
>>> llm_post_processor
LLMPostProcessing(..., instructions=(LLMPostProcessingInstruction(...), LLMPostProcessingInstruction(...)))
```

You also can use pydantic model or pydantic dataclass as response format.

**\_\_init\_\_**(*model\_name*, *model\_version='latest'*, *instructions=()*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing.__init__i}

#|
|| Parameters | 

- **model\_name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **model\_version** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **instructions** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*LLMPostProcessingInstruction*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*]*) ||
|| Return type | None ||
|#

**instructions**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[LLMPostProcessingInstruction](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessingInstruction)*] = *()*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing.instructions}

A list of instructions to perform with transcription.

**model\_version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)* = *'latest'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing.model_version}

The version of the model to use. Defaults to ‘latest’

**with\_instruction**(*instruction*, *response\_format=None*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing.with_instruction}

Creates a new LLMPostProcessing object, but with given instruction appended.

#|
|| Parameters | 

- **instruction** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) – instruction for model.
- **response\_format** ([*Literal*](https://docs.python.org/3/library/typing.html#typing.Literal)*['json'] \| ~yandex\_ai\_studio\_sdk.\_types.schemas.JsonSchemaResponseType \| type \| None*) – format of the response returned by the model. Format could be described as:
- *None* for usual text response (default);
- ’*json*’ string to tell a model to return JSON object;
- dictionary with a JsonSchema to enforce a specific JSON structure for the model’s response based on a provided schema;
- pydantic model or pydantic dataclass (which will be transformed into JsonSchema by SDK);
 ||
|| Return type | [*LLMPostProcessing*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing) ||
|#

**model\_name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LLMPostProcessing.model_name}

The [ID of the model](https://aistudio.yandex.ru/docs/foundation-models/concepts/yandexgpt/models) Model name to be used for completion generation; If the name contains ‘://’, it is treated as a full URI. Otherwise constructs a URI in the form ‘gpt://<folder\_id>/<model\_name>/<model\_version>’

#### *class* **LanguageCode**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode}

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

**auto** = *'auto'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.auto}

[Automatic language detection](https://aistudio.yandex.ru/docs/speechkit/stt/models#language-labels)

**de\_DE** = *'de-DE'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.de_DE}

German

**en\_US** = *'en-US'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.en_US}

English

**es\_ES** = *'es-ES'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.es_ES}

Spanish

**fi\_FI** = *'fi-FI'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.fi_FI}

Finnish

**fr\_FR** = *'fr-FR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.fr_FR}

French

**he\_IL** = *'he-IL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.he_IL}

Hebrew

**it\_IT** = *'it-IT'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.it_IT}

Italian

**kk\_KZ** = *'kk-KZ'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.kk_KZ}

Kazakh

**nl\_NL** = *'nl-NL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.nl_NL}

Dutch

**pl\_PL** = *'pl-PL'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.pl_PL}

Polish

**pt\_PT** = *'pt-PT'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.pt_PT}

Portuguese

**pt\_BR** = *'pt-BR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.pt_BR}

Brazilian Portuguese

**ru\_RU** = *'ru-RU'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.ru_RU}

Russian (default)

**sv\_SE** = *'sv-SE'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.sv_SE}

Swedish

**tr\_TR** = *'tr-TR'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.tr_TR}

Turkish

**uz\_UZ** = *'uz-UZ'*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.uz_UZ}

Uzbek (Latin script)

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.LanguageCode.__init__i}

#### *class* **RecognitionClassifier**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier}

Classifier to use in speech recognition.

For detailed information refer to [classification documentation](https://aistudio.yandex.ru/docs/speechkit/stt/analysis).

You can pass a string as a trigger:

```python
>>> RecognitionClassifier('insult', 'on_final')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_FINAL: 2>,))
```

Or any iterable of strings to declare few triggers:

```python
>>> RecognitionClassifier('insult', ['on_final', 'on_partial'])
RecognitionClassifier(..., triggers=(...ON_FINAL: 2>, <...ON_PARTIAL: 3>))
```

You could also use alternative constructors when you have only one trigger:

```python
>>> RecognitionClassifier.on_utterance('insult')
RecognitionClassifier(name='insult', triggers=(<RecognitionTriggerType.ON_UTTERANCE: 1>,))
```

There are special *RecognitionClassifier.WellKnown* enum with well-known classifier names:

```python
>>> RecognitionClassifier(RecognitionClassifier.WellKnown.gender, 'on_final')
RecognitionClassifier(name=<WellKnownRecognitionClassifiers.gender: 'gender'>, ...)
```

On unknown trigger names there will be exception raised:

```python
>>> RecognitionClassifier('insult', ['on_something'])
Traceback (most recent call last):
    ...
ValueError: wrong value "on_something" for use as an alias ...; known values: ('ON_UTTERANCE', ...)
```

**WellKnown**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.WellKnown}

alias of [**WellKnownRecognitionClassifiers**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.WellKnownRecognitionClassifiers)

**\_\_init\_\_**(*name*, *triggers*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **triggers** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)*] \|* [*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*RecognitionTriggerType*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | None ||
|#

*classmethod* **on\_final**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.on_final}

Alternative constructor to use onle ‘on\_final’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_partial**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.on_partial}

Alternative constructor to use onle ‘on\_partial’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

*classmethod* **on\_utterance**(*name*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.on_utterance}

Alternative constructor to use onle ‘on\_utterance’ trigger

#|
|| Parameters | **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.name}

Classifier name.

**triggers**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)] | [RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType) | [UnknownEnumValue](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[RecognitionTriggerType](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionTriggerType)] | [str](https://docs.python.org/3/library/stdtypes.html#str) | [int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.RecognitionClassifier.triggers}

Describes the types of responses to which the classification results will come. Classification responses will follow the responses of the specified types.

#### *class* **SpeechAnalysis**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.SpeechAnalysis}

Class which encapsulates [speech analysis settings](https://aistudio.yandex.ru/docs/speechkit/stt/analysis)

**\_\_init\_\_**(*speaker\_analysis=Undefined*, *conversation\_analysis=Undefined*, *descriptive\_statistics\_quantiles=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.SpeechAnalysis.__init__i}

#|
|| Parameters | 

- **speaker\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **conversation\_analysis** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **descriptive\_statistics\_quantiles** ([*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*float*](https://docs.python.org/3/library/functions.html#float)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**conversation\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.SpeechAnalysis.conversation_analysis}

Analyse conversation of two speakers

**descriptive\_statistics\_quantiles**\: *[Sequence](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)[[float](https://docs.python.org/3/library/functions.html#float)] | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.SpeechAnalysis.descriptive_statistics_quantiles}

Quantile levels in range (0, 1) for descriptive statistics

**speaker\_analysis**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.SpeechAnalysis.speaker_analysis}

Analyse speech for every speaker

#### *class* **TextNormalization**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.TextNormalization}

Class which encapsulates [text normaliztion options](https://aistudio.yandex.ru/docs/speechkit/stt/normalization).

Usage of object of this class itself in speech to text configuration is turning on normalization. Options of this class have different defaults at backend, i.e. some options could turn on the feature and others could turn it off.

>> TextNormalization() TextNormalization()

```python
>>> TextNormalization(phone_formatting=False)
TextNormalization(phone_formatting=False, profanity_filter=Undefined, literature_text=Undefined)
```

**\_\_init\_\_**(*phone\_formatting=Undefined*, *profanity\_filter=Undefined*, *literature\_text=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.TextNormalization.__init__i}

#|
|| Parameters | 

- **phone\_formatting** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **profanity\_filter** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined))
- **literature\_text** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) ||
|| Return type | None ||
|#

**literature\_text**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.TextNormalization.literature_text}

Rewrite text in literature style

**phone\_formatting**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.TextNormalization.phone_formatting}

Phone formatting

**profanity\_filter**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [Undefined](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)* = *Undefined*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.TextNormalization.profanity_filter}

Profanity filter

**\_\_init\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *sdk*, *uri*, *config=None*, *owner=None*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.__init__i}

#|
|| Parameters | 

- **sdk** ([*yandex\_ai\_studio\_sdk.\_sdk.BaseSDK*](../../internals/bases.md#yandex_ai_studio_sdk._sdk.BaseSDK))
- **uri** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **config** ([*ConfigTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT) *\| None*)
- **owner** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\| None*) ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *audio\_format=Undefined*, *model=Undefined*, *language\_codes=Undefined*, *text\_normalization=Undefined*, *eou\_classifier=Undefined*, *recognition\_classifiers=Undefined*, *speech\_analysis=Undefined*, *speaker\_labeling=Undefined*, *llm\_post\_process=Undefined*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.configure}

Returns the new object with config fields overrode by passed values.

To return set value back to default, pass *None* value.

To learn more about parameters and their formats and possible values, refer to [STT documentation](https://aistudio.yandex.ru/docs/speechkit/stt)

#|
|| Parameters | 

- **audio\_format** ([*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Specifies the input audio format.
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – The name of the STT model to use for recognition. See the list of available models and versions [in the documentation](https://aistudio.yandex.ru/docs/speechkit/stt/models).
- **language\_codes** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*LanguageCode*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LanguageCode) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*LanguageCode*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LanguageCode)*] \|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – The list of [language codes](https://aistudio.yandex.ru/docs/speechkit/stt/models) to restrict recognition in the case of an automatic model, or a single language code.
- **text\_normalization** ([*TextNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization) *\|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – [Text normalization options](https://aistudio.yandex.ru/docs/speechkit/stt/normalization)\:
- **True** — turn on text normalization with default parameters;
- **False** — turn text normalization off;
- [**yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.TextNormalization**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.TextNormalization) instance — text normalization with custom parameters;
- **None** — for server default.

- **eou\_classifier** ([*EndOfUtteranceClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier) *\|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Configuration for [end of utterance detection model](https://aistudio.yandex.ru/docs/speechkit/stt/eou)\:
- **True** — use default EOU classifier;
- **False** — disable EOU classifier (“external EOU classifier” in documentation);
- [**yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.structures.EndOfUtteranceClassifier**](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.EndOfUtteranceClassifier) instance — use custom EOU classifier settings;
- **None** — for server default.

- **recognition\_classifiers** ([*RecognitionClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier) *\|* [*Sequence*](https://docs.python.org/3/library/collections.abc.html#collections.abc.Sequence)*[*[*RecognitionClassifier*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.RecognitionClassifier)*] \|* [*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Classifier or list of [classifiers for speech recognition](https://aistudio.yandex.ru/docs/speechkit/stt/analysis#classifier).
- **speech\_analysis** ([*SpeechAnalysis*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.SpeechAnalysis) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Configuration for [speech analysis over speech recognition](https://aistudio.yandex.ru/docs/speechkit/stt/analysis#statistics).
- **speaker\_labeling** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Configuration for [speaker labeling](https://aistudio.yandex.ru/docs/speechkit/stt/speaker-labeling).
- **llm\_post\_process** ([*LLMPostProcessing*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.speech_to_text.structures.LLMPostProcessing) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Configuration for [LLM recognition results processing](https://aistudio.yandex.ru/docs/speechkit/stt/llm-results). (Also known as Summarization in earlier documentation.) ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**create\_bistream**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=600*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.create_bistream}

Creates a bidirectional stream object for using [Yandex SpeechKit Streaming speech recognition](https://aistudio.yandex.ru/docs/speechkit/stt/streaming).

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – GRPC timeout in seconds that defines the maximum lifetime of the entire stream. The timeout countdown begins from the moment of the first stream interaction. ||
|| Return type | [*STTBidirectionalStreamTypeT*](../../types/other.md#yandex_ai_studio_sdk._speechkit.speech_to_text.bistream.STTBidirectionalStreamTypeT) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSpeechToText.version}

## *class* yandex\_ai\_studio\_sdk.\_speechkit.speech\_to\_text.stt.**AsyncSTTBidirectionalStream**{#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream}

Bidirectional SpeechKit  API which allows to write requests and read synthesized result in realtime

*async* **write\_silence**(*duration\_ms*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.write_silence}

Send payload with silence to not to send useless bytes with silence

#|
|| Parameters | **duration\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | None ||
|#

*async* **write\_end\_of\_utterance**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.write_end_of_utterance}

Send end of utterance signal in case of disabled end of utterance classifier (or “external” end of utterance classifier according to the backend documentation)

#|
|| Return type | None ||
|#

*async* **eou**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.eou}

Send end of utterance signal in case of disabled end of utterance classifier (or “external” end of utterance classifier according to the backend documentation)

#|
|| Return type | None ||
|#

*async* **done\_writing**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.done_writing}

Close the stream to tell to a server you done writing.

Closing the stream will allow any iteration over this stream to exit.

It is very important to close the stream to properly release resources.

#|
|| Return type | None ||
|#

*async* **gen**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.gen}

Returns generator over all synthesized result parts.

#|
|| Return type | [*AsyncGenerator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncGenerator)[[*ProtoModelResultTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.result.ProtoModelResultTypeT)] ||
|#

*async* **read**(){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.read}

Read chunk of synthesized result.

Returns **None** in case of closed stream.

#|
|| Return type | [*ProtoModelResultTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.result.ProtoModelResultTypeT) \| None ||
|#

*async* **write**(*input*){#yandex_ai_studio_sdk._speechkit.speech_to_text.stt.AsyncSTTBidirectionalStream.write}

Send given input into the stream.

#|
|| Parameters | **input** ([*InputTypeT*](../../types/other.md#yandex_ai_studio_sdk._speechkit.bistream.InputTypeT)) ||
|| Return type | None ||
|#