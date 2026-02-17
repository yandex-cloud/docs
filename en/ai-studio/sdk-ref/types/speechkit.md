# Speechkit

## Text to speech

### *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.result.**TextToSpeechResult**{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult}

A class representing the partially parsed result of a Web search request with XML format.

**chunks**\: *[tuple](https://docs.python.org/3/library/stdtypes.html#tuple)[[TextToSpeechChunk](#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk)*]... ,{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.chunks}

*property* **data**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.data}

*property* **text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.text}

*property* **start\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.start_ms}

*property* **length\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.length_ms}

*property* **end\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.end_ms}

*property* **size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.size_bytes}

*property* **audio\_format**\: *[AudioFormat](#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) | [UnknownEnumValue](other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)[[AudioFormat](#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*]{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult.audio_format}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.result.**TextToSpeechChunk**{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk}

TextToSpeechChunk(data: ‘bytes’, text: ‘str’, start\_ms: ‘int’, length\_ms: ‘int’)

**data**\: *[bytes](https://docs.python.org/3/library/stdtypes.html#bytes)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.data}

**text**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.text}

**start\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.start_ms}

**length\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.length_ms}

*property* **end\_ms**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.end_ms}

*property* **size\_bytes**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechChunk.size_bytes}

## Enum-like settings

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**PCM16**{#yandex_ai_studio_sdk._speechkit.enums.PCM16}

*static* **\_\_new\_\_**(*cls*, *sample\_rate\_hertz*, *channels*){#yandex_ai_studio_sdk._speechkit.enums.PCM16.__new__i}

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_init\_\_**(*sample\_rate\_hertz*, *channels*){#yandex_ai_studio_sdk._speechkit.enums.PCM16.__init__i}

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

*property* **sample\_rate\_hertz**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.sample_rate_hertz}

*property* **channels**\: *[int](https://docs.python.org/3/library/functions.html#int)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.channels}

*property* **value**\: *[Never](https://docs.python.org/3/library/typing.html#typing.Never)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.value}

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.as_integer_ratio}

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

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.conjugate}

Returns self, the complex conjugate of any int.

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.denominator}

the denominator of a rational number in lowest terms

*property* **enum\_type**\: *[type](https://docs.python.org/3/library/functions.html#type)[[ProtoBasedEnumTypeT](other.md#yandex_ai_studio_sdk._types.enum.ProtoBasedEnumTypeT)*]{#yandex_ai_studio_sdk._speechkit.enums.PCM16.enum_type}

**imag**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.imag}

the imaginary part of a complex number

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.PCM16.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.enums.PCM16.name}

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.numerator}

the numerator of a rational number in lowest terms

**real**{#yandex_ai_studio_sdk._speechkit.enums.PCM16.real}

the real part of a complex number

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**AudioFormat**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat}

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) paked into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.AudioFormat.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**LoudnessNormalization**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization}

**MAX\_PEAK** = *1*{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.MAX_PEAK}

The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.

**LUFS** = *2*{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.LUFS}

The type of normalization based on EBU R 128 recommendation

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**EouSensitivity**{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity}

**DEFAULT** = *1*{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.DEFAULT}

Default and more conservative EOU detector.

**HIGH** = *2*{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.HIGH}

A high-sensitive and fast EOU detector, which may produce more false positives

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.denominator}

the denominator of a rational number in lowest terms

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.EouSensitivity.__init__i}

### *class* yandex\_ai\_studio\_sdk.\_speechkit.enums.**LanguageCode**{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode}

**auto** = *'auto'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.auto}

[Automatic language detection](https://yandex.cloud/docs/speechkit/stt/models#language-labels)

**de\_DE** = *'de-DE'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.de_DE}

German

**en\_US** = *'en-US'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.en_US}

English

**es\_ES** = *'es-ES'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.es_ES}

Spanish

**fi\_FI** = *'fi-FI'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.fi_FI}

Finnish

**fr\_FR** = *'fr-FR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.fr_FR}

French

**he\_IL** = *'he-IL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.he_IL}

Hebrew

**it\_IT** = *'it-IT'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.it_IT}

Italian

**kk\_KZ** = *'kk-KZ'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.kk_KZ}

Kazakh

**nl\_NL** = *'nl-NL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.nl_NL}

Dutch

**pl\_PL** = *'pl-PL'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pl_PL}

Polish

**pt\_PT** = *'pt-PT'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pt_PT}

Portuguese

**pt\_BR** = *'pt-BR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.pt_BR}

Brazilian Portuguese

**ru\_RU** = *'ru-RU'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.ru_RU}

Russian (default)

**sv\_SE** = *'sv-SE'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.sv_SE}

Swedish

**tr\_TR** = *'tr-TR'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.tr_TR}

Turkish

**uz\_UZ** = *'uz-UZ'*{#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.uz_UZ}

Uzbek (Latin script)

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.__new__i}

**encode**(*encoding='utf-8'*, *errors='strict'*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.encode}

Encode the string using the codec registered for encoding.

encoding

  : The encoding in which to encode the string.

errors

  : The error handling scheme to use for encoding errors. The default is ‘strict’ meaning that encoding errors raise a UnicodeEncodeError.  Other possible values are ‘ignore’, ‘replace’ and ‘xmlcharrefreplace’ as well as any other name registered with codecs.register\_error that can handle UnicodeEncodeErrors.

**replace**(*old*, *new*, *count=-1*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.replace}

Return a copy with all occurrences of substring old replaced by new.

> countMaximum number of occurrences to replace. -1 (the default value) means replace all occurrences.

If the optional argument count is given, only the first count occurrences are replaced.

**split**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.split}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the front of the string and works to the end.

Note, str.split() is mainly useful for data that has been intentionally delimited.  With natural text that includes punctuation, consider using the regular expression module.

**rsplit**(*sep=None*, *maxsplit=-1*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rsplit}

Return a list of the substrings in the string, using sep as the separator string.

> sepThe separator used to split the string.When set to None (the default value), will split on any whitespace character (including n r t f and spaces) and will discard empty strings from the result.maxsplitMaximum number of splits. -1 (the default value) means no limit.

Splitting starts at the end of the string and works to the front.

**join**(*iterable*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.join}

Concatenate any number of strings.

The string whose method is called is inserted in between each given string. The result is returned as a new string.

Example: ‘.’.join([‘ab’, ‘pq’, ‘rs’]) -> ‘ab.pq.rs’

**capitalize**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.capitalize}

Return a capitalized version of the string.

More specifically, make the first character have upper case and the rest lower case.

**casefold**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.casefold}

Return a version of the string suitable for caseless comparisons.

**title**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.title}

Return a version of the string where each word is titlecased.

More specifically, words start with uppercased characters and all remaining cased characters have lower case.

**center**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.center}

Return a centered string of length width.

Padding is done using the specified fill character (default is a space).

**count**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.count}

Return the number of non-overlapping occurrences of substring sub in string S[start:end].  Optional arguments start and end are interpreted as in slice notation.

**expandtabs**(*tabsize=8*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.expandtabs}

Return a copy where all tab characters are expanded using spaces.

If tabsize is not given, a tab size of 8 characters is assumed.

**find**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.find}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**partition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.partition}

Partition the string into three parts using the given separator.

This will search for the separator in the string.  If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing the original string and two empty strings.

**index**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.index}

Return the lowest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**ljust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.ljust}

Return a left-justified string of length width.

Padding is done using the specified fill character (default is a space).

**lower**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.lower}

Return a copy of the string converted to lowercase.

**lstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.lstrip}

Return a copy of the string with leading whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rfind**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rfind}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Return -1 on failure.

**rindex**(*sub*[, *start*[, *end*]]) → [int](https://docs.python.org/3/library/functions.html#int){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rindex}

Return the highest index in S where substring sub is found, such that sub is contained within S[start:end].  Optional arguments start and end are interpreted as in slice notation.

Raises ValueError when the substring is not found.

**rjust**(*width*, *fillchar=' '*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rjust}

Return a right-justified string of length width.

Padding is done using the specified fill character (default is a space).

**rstrip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rstrip}

Return a copy of the string with trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**rpartition**(*sep*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.rpartition}

Partition the string into three parts using the given separator.

This will search for the separator in the string, starting at the end. If the separator is found, returns a 3-tuple containing the part before the separator, the separator itself, and the part after it.

If the separator is not found, returns a 3-tuple containing two empty strings and the original string.

**splitlines**(*keepends=False*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.splitlines}

Return a list of the lines in the string, breaking at line boundaries.

Line breaks are not included in the resulting list unless keepends is given and true.

**strip**(*chars=None*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.strip}

Return a copy of the string with leading and trailing whitespace removed.

If chars is given and not None, remove characters in chars instead.

**swapcase**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.swapcase}

Convert uppercase characters to lowercase and lowercase characters to uppercase.

**translate**(*table*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.translate}

Replace each character in the string using the given translation table.

> tableTranslation table, which must be a mapping of Unicode ordinals to Unicode ordinals, strings, or None.

The table must implement lookup/indexing via \_\_getitem\_\_, for instance a dictionary or list.  If this operation raises LookupError, the character is left untouched.  Characters mapped to None are deleted.

**upper**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.upper}

Return a copy of the string converted to uppercase.

**startswith**(*prefix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.startswith}

Return True if S starts with the specified prefix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. prefix can also be a tuple of strings to try.

**endswith**(*suffix*[, *start*[, *end*]]) → [bool](https://docs.python.org/3/library/functions.html#bool){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.endswith}

Return True if S ends with the specified suffix, False otherwise. With optional start, test S beginning at that position. With optional end, stop comparing S at that position. suffix can also be a tuple of strings to try.

**removeprefix**(*prefix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.removeprefix}

Return a str with the given prefix string removed if present.

If the string starts with the prefix string, return string[len(prefix):]. Otherwise, return a copy of the original string.

**removesuffix**(*suffix*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.removesuffix}

Return a str with the given suffix string removed if present.

If the string ends with the suffix string and that suffix is not empty, return string[:-len(suffix)]. Otherwise, return a copy of the original string.

**isascii**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isascii}

Return True if all characters in the string are ASCII, False otherwise.

ASCII characters have code points in the range U+0000-U+007F. Empty string is ASCII too.

**islower**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.islower}

Return True if the string is a lowercase string, False otherwise.

A string is lowercase if all cased characters in the string are lowercase and there is at least one cased character in the string.

**isupper**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isupper}

Return True if the string is an uppercase string, False otherwise.

A string is uppercase if all cased characters in the string are uppercase and there is at least one cased character in the string.

**istitle**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.istitle}

Return True if the string is a title-cased string, False otherwise.

In a title-cased string, upper- and title-case characters may only follow uncased characters and lowercase characters only cased ones.

**isspace**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isspace}

Return True if the string is a whitespace string, False otherwise.

A string is whitespace if all characters in the string are whitespace and there is at least one character in the string.

**isdecimal**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isdecimal}

Return True if the string is a decimal string, False otherwise.

A string is a decimal string if all characters in the string are decimal and there is at least one character in the string.

**isdigit**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isdigit}

Return True if the string is a digit string, False otherwise.

A string is a digit string if all characters in the string are digits and there is at least one character in the string.

**isnumeric**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isnumeric}

Return True if the string is a numeric string, False otherwise.

A string is numeric if all characters in the string are numeric and there is at least one character in the string.

**isalpha**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isalpha}

Return True if the string is an alphabetic string, False otherwise.

A string is alphabetic if all characters in the string are alphabetic and there is at least one character in the string.

**isalnum**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isalnum}

Return True if the string is an alpha-numeric string, False otherwise.

A string is alpha-numeric if all characters in the string are alpha-numeric and there is at least one character in the string.

**isidentifier**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isidentifier}

Return True if the string is a valid Python identifier, False otherwise.

Call keyword.iskeyword(s) to test whether string s is a reserved identifier, such as “def” or “class”.

**isprintable**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.isprintable}

Return True if all characters in the string are printable, False otherwise.

A character is printable if repr() may use it in its output.

**zfill**(*width*, *<span title="Positional-only parameter separator (PEP 570)">/</span>*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.zfill}

Pad a numeric string with zeros on the left, to fill a field of the given width.

The string is never truncated.

**format**(*\*args*, *\*\*kwargs*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.format}

Return a formatted version of S, using substitutions from args and kwargs. The substitutions are identified by braces (‘{’ and ‘}’).

**format\_map**(*mapping*) → [str](https://docs.python.org/3/library/stdtypes.html#str){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.format_map}

Return a formatted version of S, using substitutions from mapping. The substitutions are identified by braces (‘{’ and ‘}’).

*static* **maketrans**(){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.maketrans}

Return a translation table usable for str.translate().

If there is only one argument, it must be a dictionary mapping Unicode ordinals (integers) or characters to Unicode ordinals, strings or None. Character keys will be then converted to ordinals. If there are two arguments, they must be strings of equal length, and in the resulting dictionary, each character in x will be mapped to the character at the same position in y. If there is a third argument, it must be a string, whose characters will be mapped to None in the result.

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.enums.LanguageCode.__init__i}