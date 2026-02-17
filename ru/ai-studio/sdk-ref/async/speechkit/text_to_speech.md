# Domain

## *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.function.**AsyncTextToSpeechFunction**{#yandex_ai_studio_sdk._speechkit.text_to_speech.function.AsyncTextToSpeechFunction}

Text to Speech function for creating synthesis object which provides methods for invoking voice synthesizing.

**\_\_call\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *loudness\_normalization=Undefined*, *audio\_format=Undefined*, *model=Undefined*, *voice=Undefined*, *role=Undefined*, *speed=Undefined*, *volume=Undefined*, *pitch\_shift=Undefined*, *duration\_ms=Undefined*, *duration\_min\_ms=Undefined*, *duration\_max\_ms=Undefined*, *single\_chunk\_mode=Undefined*){#yandex_ai_studio_sdk._speechkit.text_to_speech.function.AsyncTextToSpeechFunction.__call__i}

Creates TextToSpeech object with provides methods for voice synthesizing.

To learn more about parameters and their formats and possible values, refer to [TTS documentation](https://yandex.cloud/docs/speechkit/stt)

#|
|| Parameters | 

- **loudness\_normalization** ([*LoudnessNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*LoudnessNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Specifies type of loudness normalization. Default: *LUFS*.
- **audio\_format** ([*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Specifies output audio format. Default: 22050Hz, linear 16-bit signed little-endian PCM, with WAV header.
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – The name of the TTS model to use for synthesis. Currently should be empty. Do not use it.
- **voice** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – The voice to use for speech synthesis.
- **role** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – The role or speaking style. Can be used to specify pronunciation character for the speaker.
- **speed** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Speed multiplier (default: 1.0).
- **volume** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Volume adjustment: \* For *MAX\_PEAK*\: range is (0, 1], default 0.7. \* For *LUFS*\: range is [-145, 0), default -19.
- **pitch\_shift** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Pitch adjustment, in Hz, range [-1000, 1000], default 0.
- **duration\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Limit audio duration to exact value.
- **duration\_min\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Limit the minimum audio duration.
- **duration\_max\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Limit the maximum audio duration
- **single\_chunk\_mode** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined)) – Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible ||
|| Return type | [*TextToSpeechTypeT*](../../types/other.md#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.TextToSpeechTypeT) ||
|#

# TTS object

## *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.tts.**AsyncTextToSpeech**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech}

*async* **run**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.run}

Run a speech synthesis for given *text* and return joined result.

To change initial search settings use **.configure** method:

```python
>>> search = sdk.speechkit.text_to_speech(audio_format='mp3')
>>> search = search.configure(audio_format='WAV')
```

#|
|| Parameters | 

- **text** – Text to vocalize.
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – Timeout, or the maximum time to wait for the request to complete in seconds.
- **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Returns | synthesis result; joined in case of >1 chunks in synthesis response. ||
|| Return type | [*TextToSpeechResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult) ||
|#

*async* **run\_stream**(*input*, *<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=60*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.run_stream}

#|
|| Parameters | 

- **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) ||
|| Return type | [*AsyncIterator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncIterator)[[*TextToSpeechResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult)] ||
|#

#### *class* **AudioFormat**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat}

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.denominator}

the denominator of a rational number in lowest terms

*classmethod* **PCM16**(*sample\_rate\_hertz*, *channels=1*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.PCM16}

Audio bit depth 16-bit signed little-endian (Linear PCM).

#|
|| Parameters | 

- **sample\_rate\_hertz** ([*int*](https://docs.python.org/3/library/functions.html#int))
- **channels** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|| Return type | [*PCM16*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.PCM16) ||
|#

**MP3** = *3*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.MP3}

Data is encoded using MPEG-1/2 Layer III and compressed using the MP3 container format

**WAV** = *1*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.WAV}

Audio bit depth 16-bit signed little-endian (Linear PCM) paked into WAV container format

**OGG\_OPUS** = *2*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.OGG_OPUS}

Data is encoded using the OPUS audio codec and compressed using the OGG container format

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.AudioFormat.__init__i}

#### *class* **LoudnessNormalization**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization}

*classmethod* **Unknown**(*name*, *value*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.Unknown}

#|
|| Parameters | 

- **name** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **value** ([*int*](https://docs.python.org/3/library/functions.html#int)) ||
|#

**\_\_new\_\_**(*value*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.__new__i}

**conjugate**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.conjugate}

Returns self, the complex conjugate of any int.

**bit\_length**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.bit_length}

Number of bits necessary to represent self in binary.

```python
>>> bin(37)
'0b100101'
>>> (37).bit_length()
6
```

**bit\_count**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.bit_count}

Number of ones in the binary representation of the absolute value of self.

Also known as the population count.

```python
>>> bin(13)
'0b1101'
>>> (13).bit_count()
3
```

**as\_integer\_ratio**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.as_integer_ratio}

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

**is\_integer**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.is_integer}

Returns True. Exists for duck type compatibility with float.is\_integer.

**real**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.real}

the real part of a complex number

**imag**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.imag}

the imaginary part of a complex number

**numerator**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.numerator}

the numerator of a rational number in lowest terms

**denominator**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.denominator}

the denominator of a rational number in lowest terms

**MAX\_PEAK** = *1*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.MAX_PEAK}

The type of normalization, wherein the gain is changed to bring the highest PCM sample value or analog signal peak to a given level.

**LUFS** = *2*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.LUFS}

The type of normalization based on EBU R 128 recommendation

**\_\_init\_\_**(*\*args*, *\*\*kwds*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.LoudnessNormalization.__init__i}

**\_\_init\_\_**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *sdk*, *uri*, *config=None*, *owner=None*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.__init__i}

#|
|| Parameters | 

- **sdk** ([*yandex\_ai\_studio\_sdk.\_sdk.BaseSDK*](../../internals/bases.md#yandex_ai_studio_sdk._sdk.BaseSDK))
- **uri** ([*str*](https://docs.python.org/3/library/stdtypes.html#str))
- **config** ([*ConfigTypeT*](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT) *\| None*)
- **owner** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\| None*) ||
|#

*property* **config**\: *[ConfigTypeT](../../types/other.md#yandex_ai_studio_sdk._types.model_config.ConfigTypeT)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.config}

**configure**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *loudness\_normalization=Undefined*, *audio\_format=Undefined*, *model=Undefined*, *voice=Undefined*, *role=Undefined*, *speed=Undefined*, *volume=Undefined*, *pitch\_shift=Undefined*, *duration\_ms=Undefined*, *duration\_min\_ms=Undefined*, *duration\_max\_ms=Undefined*, *single\_chunk\_mode=Undefined*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.configure}

Returns the new object with config fields overrode by passed values.

To return set value back to default, pass *None* value.

To learn more about parameters and their formats and possible values, refer to [TTS documentation](https://yandex.cloud/docs/speechkit/stt)

#|
|| Parameters | 

- **loudness\_normalization** ([*LoudnessNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*LoudnessNormalization*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.LoudnessNormalization)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Specifies type of loudness normalization. Default: *LUFS*.
- **audio\_format** ([*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat) *\|* [*UnknownEnumValue*](../../types/other.md#yandex_ai_studio_sdk._types.schemas.yandex_ai_studio_sdk._types.enum.UnknownEnumValue)*[*[*AudioFormat*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.enums.AudioFormat)*] \|* [*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Specifies output audio format. Default: 22050Hz, linear 16-bit signed little-endian PCM, with WAV header.
- **model** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – The name of the TTS model to use for synthesis. Currently should be empty. Do not use it.
- **voice** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – The voice to use for speech synthesis.
- **role** ([*str*](https://docs.python.org/3/library/stdtypes.html#str) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – The role or speaking style. Can be used to specify pronunciation character for the speaker.
- **speed** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Speed multiplier (default: 1.0).
- **volume** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Volume adjustment: \* For *MAX\_PEAK*\: range is (0, 1], default 0.7. \* For *LUFS*\: range is [-145, 0), default -19.
- **pitch\_shift** ([*float*](https://docs.python.org/3/library/functions.html#float) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Pitch adjustment, in Hz, range [-1000, 1000], default 0.
- **duration\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Limit audio duration to exact value.
- **duration\_min\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Limit the minimum audio duration.
- **duration\_max\_ms** ([*int*](https://docs.python.org/3/library/functions.html#int) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Limit the maximum audio duration.
- **single\_chunk\_mode** ([*bool*](https://docs.python.org/3/library/functions.html#bool) *\|* [*Undefined*](../../types/other.md#yandex_ai_studio_sdk._types.misc.Undefined) *\| None*) – Automatically split long text to several utterances and bill accordingly. Some degradation in service quality is possible ||
|| Return type | [*Self*](https://docs.python.org/3/library/typing.html#typing.Self) ||
|#

**create\_bistream**(*<span title="Keyword-only parameters separator (PEP 3102)">\*</span>*, *timeout=600*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.create_bistream}

Creates a bidirectional stream object for using [Yandex SpeechKit Streaming synthesis](https://yandex.cloud/en/docs/speechkit/tts/api/tts-streaming).

#|
|| Parameters | **timeout** ([*float*](https://docs.python.org/3/library/functions.html#float)) – GRPC timeout in seconds that defines the maximum lifetime of the entire stream. The timeout countdown begins from the moment of the first stream interaction. ||
|| Return type | [*TTSBidirectionalStreamTypeT*](../../types/other.md#yandex_ai_studio_sdk._speechkit.text_to_speech.bistream.TTSBidirectionalStreamTypeT) ||
|#

*property* **fine\_tuned**\: *[bool](https://docs.python.org/3/library/functions.html#bool) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.fine_tuned}

*property* **name**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.name}

*property* **owner**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.owner}

*property* **uri**\: *[str](https://docs.python.org/3/library/stdtypes.html#str)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.uri}

*property* **version**\: *[str](https://docs.python.org/3/library/stdtypes.html#str) | [None](https://docs.python.org/3/library/constants.html#None)*{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTextToSpeech.version}

## *class* yandex\_ai\_studio\_sdk.\_speechkit.text\_to\_speech.tts.**AsyncTTSBidirectionalStream**{#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream}

Bidirectional SpeechKit TTS API which allows to write requests and read synthesized result in realtime

*async* **write**(*input*){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream.write}

Write a input to be synthesized

#|
|| Parameters | **input** ([*str*](https://docs.python.org/3/library/stdtypes.html#str)) ||
|| Return type | None ||
|#

*async* **read**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream.read}

Read chunk of synthesized result.

Returns **None** in case of closed stream.

#|
|| Return type | [*TextToSpeechResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult) \| None ||
|#

*async* **gen**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream.gen}

Returns generator over all synthesized result parts.

#|
|| Return type | [*AsyncGenerator*](https://docs.python.org/3/library/collections.abc.html#collections.abc.AsyncGenerator)[[*TextToSpeechResult*](../../types/speechkit.md#yandex_ai_studio_sdk._speechkit.text_to_speech.result.TextToSpeechResult)] ||
|#

*async* **done\_writing**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream.done_writing}

Close the stream to tell to a server you done writing.

Closing the stream will allow any iteration over this stream to exit.

It is very important to close the stream to properly release resources.

#|
|| Return type | None ||
|#

*async* **flush**(){#yandex_ai_studio_sdk._speechkit.text_to_speech.tts.AsyncTTSBidirectionalStream.flush}

Send message to server to force synthesis with already given input

#|
|| Return type | None ||
|#