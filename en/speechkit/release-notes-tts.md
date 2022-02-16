# Synthesis releases

{{ speechkit-name }} provides updates based on the system model and version.

In speech synthesis, the service provides [two types of voices](tts/voices.md): standard and premium. Premium voices use new speech-synthesis technology.

For more information about voice models, see [About the technology](tts/index.md#voices).

## Current version {#current}

### Release 24.01.22 {#240122}

1. Updated the generation model. The new version improves the way numbers and abbreviations from the finance domain are pronounced.

1. You can now place emphasis using markup: `Are you **happy** to see me?`

1. Processing SSML pauses and SIL tags has been made consistent to support integration with [Yandex.Dialogs](https://dialogs.yandex.ru). Pauses in text in SSML or SIL notation are considered the end of an utterance, causing intonation representing the end of an utterance to replace the tag in the generated text. SSML pauses and SIL tags are supported when generating both short and long speech segments.

## Previous versions {#previous}

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

{% if lang == "ru" %}We would be happy to hear your [feedback](https://forms.yandex.ru/surveys/10037015.afd97084574df5ac4c7e7199ad406997ac1979e0/) on our new premium voices.{% endif %}