# {{ speechkit-full-name }} speech synthesis service releases

{{ speechkit-name }} provides updates based on the system model and version.

In speech synthesis, the service provides [two types of voices](tts/voices.md): standard and premium. Premium voices use new speech synthesis technology.

For more information about voice models, see [About the technology](tts/index.md#voices).

## Current version {#current}

### Release 07.10.22 {#071022}

The `general` branch has new voices and languages available for testing:
* `lea` female voice: German.
* `madi` male voice: Kazakh.
* `madirus` male voice: Russian.
* `nigora` female voice: Uzbek.

The `general` branch also has voices `amira` and `john` available now.

## Previous versions {#previous}

### Release 09.06.22 {#090622}

1. Intonations and emphasis have been improved in all voices.

1. More pausing features were added:
   * The error when pauses shorter than 1200 milliseconds were not taken into account in SSML markup has been fixed. Note that pauses shorter than 700 milliseconds are considered a synthesis cue and do not allow accurate control of the duration of a pause between words.
   * SSML pauses with the `x-weak`, `weak`, and `medium` values have a greater impact on synthesized text.
   * You can now apply pauses when using TTS markup. Using the `<[small]>` tag, you can set the duration of a pause in a synthesized text, for example: `Hello, <[small]>`. The duration of a pause can have the following values: `tiny`, `small`, `medium`, `large`, `huge`.

1. Support for `filipp:deprecated` was ceased. `filipp:deprecated` and `filipp` sound the same now.

### Release 19.05.22 {#190522}

1. Support for the deprecated voices will cease starting May 31, 2022.

1. The `rc` branch has new voices and languages available for testing:
   * `amira` female voice: Kazakh.
   * `john` male voice: English.

   The voices are only available in API v3 using the `x-service-branch:rc` header.

### Release 30.03.22 {#300322}

1. The standard voices are currently only available through the `:deprecated` tag and will continue to be supported through May 31, 2022.

1. Intonations and issues with rare artifacts in texts with many numbers have been fixed following a technical support request (issue CLOUDSUPPORT-138703).

### Release 17.03.22 {#170322}

1. Added the ability to synthesize audio files in MP3 format. This feature is available in API v3 and when using premium voices in API v1.

1. For new voices, we added role, which is extended emotional tone. See the `emotion` parameter in [API v1](tts/request.md#body_params) and `role` in [API v3](tts-v3/api-ref/grpc/tts_service.md#Hints) for details. Different roles are available for different voices. For a complete list of values, see [{#T}](tts/voices.md). If an incorrect role is selected, the service will return an error.

1. Degraded quality of emphasis placement has been corrected for `alena` and `filipp`. Emphasis placement and synthesized voice perception have been improved for all voices.

1. A major update of standard voices has begun: `oksana`, `ermil`, `jane`, `omazh`, `zahar` will be replaced with `oksana:rc`, `ermil:rc`, `jane:rc`, `omazh:rc`, `zahar:rc`, respectively. The update will not affect the cost of the regular voices. Existing voices, such as `oksana`, `ermil`, `jane`, `omazh`, and `zahar` are available under the `:deprecated` branch.

### Release 24.01.22 {#240122}

1. Updated the generation model. The new version improves the way numbers and abbreviations from the finance domain are pronounced.

1. You can now emphasize using markup: `Are you **happy** to see me?`

1. Processing of SSML pauses and SIL tags has been made consistent to support integration with [Yandex.Dialogs](https://dialogs.yandex.ru). Pauses in text in SSML or SIL notation are considered the end of an utterance, causing intonation representing the end of an utterance to replace the tag in the generated text. SSML pauses and SIL tags are supported when generating both short and long speech segments.

### Release 16.12.21 {#161221}

1. Limits for API v3 requests have been increased: length of a synthesized phrase is 250 characters or 24 seconds of audio. Important: request costs remain unchanged for the time being but may increase.

1. The `unsafe_mode` option available in API v3 enables you to automatically split long segments of text to synthesize into separate phrases.

1. The silence after the last word is synthesized is much shorter. Now, the audio ends almost immediately after the final word is synthesized.

### Release 18.11.21 {#181121}

1. Fixes have been made to stabilize the way the `alena` premium voice is synthesized. It sounds consistent now.
1. Pronunciation errors have been fixed for `alena`.
1. Pausing in REST API has been improved.
1. New premium voices have been added in test mode:
   * `oksana:rc`
   * `ermil:rc`
   * `jane:rc`
   * `omazh:rc`
   * `zahar:rc`

