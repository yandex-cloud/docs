# {{ speechkit-full-name }} release notes: Speech synthesis

{{ speechkit-name }} provides updates based on the system model and version.

For more information about voice models, see [About technology](tts/index.md#voices).

## Current version {#current}

### Release on 20/02/24 {#200224}

Improved the [voices](tts/voices.md): `masha`, `marina`, `anton`, `alexander`, `dasha`, `julia`.

## Previous versions {#previous}

### Release on 06/02/24 {#060224}

Added [REST API v3](./tts-v3/api-ref/index.md) support.

### Release on 10/01/24 {#100124}

1. Added support for cardinal number normalization (English). Normalization works for positive integers only. Ordinal numbers are not supported.
1. Added [DurationHint](./tts-v3/api-ref/grpc/tts_service.md#DurationHint) to the API which you can use to specify minimum and maximum time spent on synthesizing the text.
1. Added the `text_chunk`, `start_ms`, and `length_ms` fields to the [UtteranceSynthesisResponse](./tts-v3/api-ref/grpc/tts_service.md#UtteranceSynthesisResponse) message. These fields store the info on the text, as well as the start and end time of the audio that came with the fragment.

### Release on 05/12/23 {#051223}

Improved the quality of speech synthesis for all languages except Russian.

### Release on 23/10/23 {#231023}

1. A new [voice](tts/voices.md), `masha`, is now available in three roles.
1. Additional roles are now available for Russian-language voices.
1. Optimized the normalizer for the Kazakh language.
1. Improved the pronunciation quality of "SMS" for Kazakh and Uzbek.

### Release on 27/07/23 {#270723}

1. Added the `pitch_shift` parameter to [API v3](tts-v3/api-ref/grpc/tts_service.md). You can use it to increase the pitch contour of an entire synthesized audio by a fixed value in Hz. Shifting the contour makes a voice sound more lively.
1. Seven new [voices](tts/voices.md) are now available for speech synthesis in Russian: `dasha`, `julia`, `lera`, `marina`, `alexander`, `kirill`, and `anton`.

### Release on 19/06/23 {#190623}

Improved the quality of pronunciation of car brands for Uzbek.

### Release on 08/06/23 {#080623}

1. Added normalization for cardinal numbers written in Arabic numerals for Uzbek.
1. Improved the quality of speech synthesis for Uzbek. The changes primarily enhance the synthesis of short texts.

### Release on 18/04/23 {#180423}

1. Speech synthesis for Uzbek now supports [phoneme-based format](tts/markup/tts-markup.md#phoneme) to transcribe text (see the list of supported phonemes [here](tts/markup/tts-supported-phonemes.md#phonemes-uz)). In addition, the Uzbek model can now automatically replace apostrophes. However, for efficient speech synthesis, you should only use the straight `ʼ` and reversed `ʻ` typographic apostrophes.
1. For [pattern-based synthesis](tts/templates.md), the default volume normalization has been changed. Now, if the normalization type is not set explicitly, the volume of variables is normalized using the initial pattern.

### Release on 21/03/23 {#210323}

1. A normalizer has been added for the Kazakh language. Now the model can pronounce numbers written in Arabic numerals.
1. Added two types of apostrophes for the Uzbek language: the typographic straight apostrophe `ʼ` and the typographic reversed apostrophe `ʻ`. Now you can synthesize phrases in Uzbek written in Latin script with these apostrophes.

   > Yaʼni mana shu beret kiygan notanish odamni.
   > Soʻng yana pastga qarab ketiladi.

   {% note warning %}

   Use only these options for apostrophes. The model does not support automatic replace, and the synthesis quality strongly depends on the input quality.

   {% endnote %}

### Release on 07/03/23 {#070323}

1. Significantly revised the [{{ brand-voice-name }}](tts/brand-voice/index.md) technology for creating custom voices.
1. Added support for [pauses](tts/markup/tts-markup.md#pause) in all languages in test mode when using TTS markup. Please report any pausing errors by submitting a request to the support team. Your feedback will help us improve the functionality in future releases.

### Release on 07/10/22 {#071022}

The `general` branch has new voices and languages available for testing:
* `lea` female voice: German.
* `madi` male voice: Kazakh.
* `madirus` male voice: Russian.
* `nigora` female voice: Uzbek.

The `general` branch now has `amira` and `john` voices.

### Release on 09/06/22 {#090622}

1. Intonations and emphasis have been improved in all voices.

1. More pausing features were added:
   * The error when pauses shorter than 1200 milliseconds were not taken into account in SSML markup has been fixed. Note that pauses shorter than 700 milliseconds are considered a synthesis cue and do not allow accurate control of the duration of a pause between words.
   * SSML pauses with the `x-weak`, `weak`, and `medium` values have a greater impact on synthesized text.
   * You can now apply pauses when using TTS markup. Using the `<[small]>` tag, you can set the duration of a pause in a synthesized text, for example: `Hello, <[small]>`. The duration of a pause can have the following values: `tiny`, `small`, `medium`, `large`, `huge`.

1. Support for `filipp:deprecated` was ceased. `filipp:deprecated` and `filipp` sound the same now.

### Release on 19/05/22 {#190522}

1. Support for the deprecated voices will cease starting May 31, 2022.

1. The `rc` branch has new voices and languages available for testing:
   * `amira` female voice: Kazakh.
   * `john` male voice: English.

   The voices are only available in API v3 using the `x-service-branch:rc` header.

### Release on 30/03/22 {#300322}

1. The standard voices are currently only available through the `:deprecated` tag and will continue to be supported through May 31, 2022.

1. Intonations and issues with rare artifacts in texts with many numbers have been fixed following a technical support request (issue CLOUDSUPPORT-138703).

### Release on 17/03/22 {#170322}

1. Added the ability to synthesize audio files in MP3 format. This feature is available in API v3 and when using premium voices in API v1.

1. For new voices, we added role, which is extended emotional tone. See the `emotion` parameter in [API v1](tts/request.md#body_params)and `role` in [API v3](tts-v3/api-ref/grpc/tts_service.md#Hints)for details. Different roles are available for different voices. For a complete list of values, see [{#T}](tts/voices.md). If an incorrect role is selected, the service will return an error.

1. Degraded quality of emphasis placement has been corrected for `alena` and `filipp`. Emphasis placement and synthesized voice perception have been improved for all voices.

1. Major update of standard voices started: `oksana`, `ermil`, `jane`, `omazh`, `zahar` will be replaced with `oksana:rc`, `ermil:rc`, `jane:rc`, `omazh:rc`, `zahar:rc`, respectively. The update will not affect the cost of the regular voices. Existing voices, such as `oksana`, `ermil`, `jane`, `omazh`, and `zahar`, are available under the `:deprecated` branch.

### Release on 24/01/22 {#240122}

1. Updated the generation model. The new version improves the way numbers and abbreviations from the finance domain are pronounced.

1. You can now emphasize using markup: `Are you **happy** to see me?`

1. Processing of SSML pauses and SIL tags has been made consistent to support integration with [Yandex.Dialogs](https://dialogs.yandex.ru). Pauses in text in SSML or SIL notation are considered the end of an utterance, causing intonation representing the end of an utterance to replace the tag in the generated text. SSML pauses and SIL tags are supported when generating both short and long speech segments.

### Release on 16/12/21 {#161221}

1. Limits for API v3 requests have been increased: length of a synthesized phrase is 250 characters or 24 seconds of audio. Important: request costs remain unchanged for the time being but may increase.

1. The `unsafe_mode` option available in API v3 enables you to automatically split long segments of text to synthesize into separate phrases.

1. The silence after the last word is synthesized is much shorter. Now, the audio ends almost immediately after the final word is synthesized.

### Release on 18/11/21 {#181121}

1. Fixes have been made to stabilize the way the `alena` premium voice is synthesized. It sounds consistent now.
1. Pronunciation errors have been fixed for `alena`.
1. Pausing in REST API has been improved.
1. New premium voices have been added in test mode:
   * `oksana:rc`
   * `ermil:rc`
   * `jane:rc`
   * `omazh:rc`
   * `zahar:rc`

