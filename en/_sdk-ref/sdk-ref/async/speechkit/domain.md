# SpheechKit domain

## *class* yandex\_ai\_studio\_sdk.\_speechkit.domain.**AsyncSpeechKitDomain**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain}

Domain for working with [Yandex SpeechKit services](https://aistudio.yandex.ru/docs/speechkit/overview).

**text\_to\_speech**\: *[AsyncTextToSpeechFunction](text_to_speech.md#yandex_ai_studio_sdk._speechkit.text_to_speech.function.AsyncTextToSpeechFunction)*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.text_to_speech}

API for [text to speech](https://aistudio.yandex.ru/docs/speechkit/tts/) service

**tts**\: *[AsyncTextToSpeechFunction](text_to_speech.md#yandex_ai_studio_sdk._speechkit.text_to_speech.function.AsyncTextToSpeechFunction)*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.tts}

Synonym for *text\_to\_speech* function

**speech\_to\_text**\: *[AsyncSpeechToTextFunction](speech_to_text.md#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction)*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.speech_to_text}

API for [speech to text](https://aistudio.yandex.ru/docs/speechkit/stt/) service

**stt**\: *[AsyncSpeechToTextFunction](speech_to_text.md#yandex_ai_studio_sdk._speechkit.speech_to_text.function.AsyncSpeechToTextFunction)*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.stt}

Synonym for *speech\_to\_text* function

#### *class* **AudioFormat**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat}

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.denominator}

the denominator of a rational number in lowest terms

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) packed into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.AudioFormat.__init__i}

**\_\_init\_\_**(*name*, *sdk*){#yandex_ai_studio_sdk._speechkit.domain.AsyncSpeechKitDomain.__init__i}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **sdk** ([*yandex\_ai\_studio\_sdk.\_sdk.BaseSDK*](../../internals/bases.md#yandex_ai_studio_sdk._sdk.BaseSDK)) ||
|#