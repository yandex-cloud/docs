# Synthesis releases

{{ speechkit-name }} provides updates based on the system model and version.

In speech synthesis, the service provides [two types of voices](tts/voices.md): standard and premium. Premium voices use new speech synthesis technology.

For more information about voice models, see [About the technology](tts/index.md#voices).

## Current version {#current}

### Release 17.03.22 {#170322}

1. Added the ability to synthesize audio files in MP3 format. This feature is available in API v3 and when using premium voices in API v1.

1. For new voices, role (extended emotional tone) support was added (see the `emotion` parameter in [API v1](tts/request.md#body_params) and `role` in [API v3](new-v3/api-ref/grpc/tts_service#Hints)). Different roles are available for different voices. For a complete list of values, see [{#T}](tts/voices.md). If an incorrect role is selected, the service will return an error.

1. Degraded quality of emphasis placement has been corrected for `alena` and `filipp`. Emphasis placement and synthesized voice perception have been improved for all voices.

1. A major update of standard voices has begun: `oksana`, `ermil`, `jane`, `omazh`, `zahar` will be replaced with `oksana:rc`, `ermil:rc`, `jane:rc`, `omazh:rc`, `zahar:rc`, respectively. The update will not affect the cost of the regular voices. Existing voices, such as `oksana`, `ermil`, `jane`, `omazh`, and `zahar` are available under the `:deprecated` branch.

## Previous versions {#previous}

### Release 24.01.22 {#240122}

1. Generation model updated. The new version improves the the way numbers and abbreviations from the finance domain are pronounced.

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

{% if lang == "ru" %}We would be glad to hear your [feedback](https://forms.yandex.ru/surveys/10037015.afd97084574df5ac4c7e7199ad406997ac1979e0/) on our new premium voices.{% endif %}