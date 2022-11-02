# Speech synthesis

_Speech synthesis_ in {{ speechkit-full-name }} lets you convert any text to speech in multiple languages.

{{ speechkit-name }} voice models use deep neural network technology. When synthesizing speech, the model pays attention to many details in the original voice. The model evaluates the entire text, not individual sentences, before starting the synthesis. This enables the synthesized voice to sound clear and natural, without electronic distortion, and reproduce appropriate intonations of a real person's speech.





## Synthesis options {#features}

{% include [api-concepts](../../_includes/speechkit/api-concepts.md) %}

{{ speechkit-name }} synthesis has two APIs: [API v1](request.md) (REST) and [API v3](../tts-v3/api-ref/grpc/) (gRPC).

|                                                    | API v1 | API v3 |
|----------------------------------------------------|---|---------------------------------------------|
| Specification | REST | gRPC |
| Selecting voice | `voice` parameter | `hint: voice` parameter |
| Selecting language | Depends on the voice </br>`lang` parameter | Depends on the voice, not specified explicitly in the request |
| Specifying mode | Depends on the voice  </br>`emotion` parameter | Depends on the voice </br>`hint: role` parameter |
| [Controlling pronunciation](#markup) | SSML </br> TTS | TTS |
| [Pronunciation speed](#speed) | `speed` parameter | `hint: speed` parameter |
| [Adjusting volume](#volume) | No | `loudness_normalization_type` parameter |
| [Output audio format](#format) | `format` parameter | `output_audio_spec` parameter |
| Specifying [LPCM](../formats.md#lpcm) parameters | `sampleRateHertz` parameter | `output_audio_spec: raw_audio` parameter |
| [Template synthesis](brand-voice/index.md#adaptive) | No | ` text_template` parameter |
| [Pricing method](../pricing.md#rules-tts) | Total number of characters in the requests | By request |
| Automatic splitting of long phrases | Not required | `unsafe_mode` parameter |


## Languages and voices {#langs}

You can select a voice to convert your text to speech. Each voice corresponds to a model trained on the speaker's speech pattern. Voices differ by tone, gender, and language. For a list of voices and their characteristics, see [{#T}](voices.md).

If no voice suits your business, {{ speechkit-name }} can create a unique one specifically for you. For more information, see [{#T}](brand-voice/index.md).

{{ speechkit-name }} can synthesize speech in different languages. Each voice is designed to synthesize speech in a specific language. Voices can also read text in a <q>foreign</q> language, but the quality of the synthesized speech will be poorer in this case: <q>the speaker</q> will pronounce the text with an accent, and there may be errors in word synthesis. 

### Mode {#role}

The synthesized speech will sound different, depending on the selected mode. Mode is the manner of pronunciation for the same speaker. Different sets of modes are available for different voices. Attempting to use a mode that the selected voice does not have will cause a service error.

## Controlling pronunciation {#markup}


To control pronunciation in the synthesized speech, mark up the source text. {{ speechkit-name }} can synthesize speech from text marked up using [Speech Synthesis Markup Language](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language) (SSML) or TTS markup. These markup methods enable you to set the length of pauses, the pronunciation of individual sounds, and more. SSML and TTS markup have different data transmission parameters:

* SSML is only supported in API v1 requests. To transmit text in SSML format, include the `ssml` parameter in the call body and use the `<speak>` tag as a wrapper for the text. For more information about SSML tags, see [{#T}](ssml.md).
* TTS markup is supported in API v1 and API v3. In API v1 requests, transmit the text marked up according to TTS rules in the `text` parameter in the request body. API v3 requires no special parameters and considers any transmitted text as marked up according to TTS rules. For more information about TTS markup, see [{#T}](tts-markup.md).


## Synthesis settings {#settings}

You can configure both pronunciation and technical characteristics of the synthesized speech.

### Synthesized speech speed {#speed}

The speed of synthesized speech affects perception of information. If the speech is too fast or too slow, it sounds unnatural. However, this can be useful in commercials where every second of air time counts.

By default, the speed of generated speech corresponds to the average speed of human speech.

### Volume normalization {#volume}

In [API v3](../tts-v3/api-ref/grpc/) requests, you can set the type and level of volume normalization. This can be useful if you are using {{ speechkit-name }} synthesis along with other sound sources. For example, so that the volume of the voice assistant does not differ from the phone notifications.

{{ speechkit-name }} supports two normalization types:
* [Peak normalization](https://en.wikipedia.org/wiki/Audio_normalization#Peak_normalization) `MAX_PEAK`, at which the audio signal level rises to the maximum possible digital audio value without distortion.
* `LUFS` normalization is weighted normalization based on the [EBU R 128](https://en.wikipedia.org/wiki/EBU_R_128) standard according to which volume is normalized relative to the full digital scale.

You can set the normalization type in the `loudness_normalization_type` parameter.  By default, {{ speechkit-name }} uses LUFS.

The level of normalization is set in the `hint: volume` parameter. Possible values depend on the normalization type:
* For `MAX_PEAK`, the parameter can have values in the `(0;1]` range, default value is `0.7`.
* For `LUFS`, the parameter can change in the range `[-149;0)`, default value is `-19`.

If the normalization level value does not fall within the range supported by the normalization level, the {{ speechkit-name }} server will return an `InvalidArgument` error.

### Synthesized audio file format {#format}

You can select the audio file format that will be used by {{ speechkit-name }} to synthesize speech.

For a full list of available formats and their characteristics, see [{#T}](../formats.md).

#### See also {#see-also}



* Try synthesizing speech using demo on the [service page](https://cloud.yandex.com/services/speechkit#demo).
* Review the parameters of the [API v1](request.md) method and [API v3](../tts-v3/api-ref/grpc/) requests.
* See examples of using the {{ speechkit-name }} API:
   * [{#T}](api/tts-ogg.md)
   * [{#T}](api/tts-wav.md)
   * [{#T}](api/tts-ssml.md)


