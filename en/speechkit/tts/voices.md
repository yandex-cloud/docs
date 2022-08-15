# List of voices

This section provides a list of voices available in the service and their characteristics:

* The main language that a voice supports. This is the language used by the speaker when creating this voice.
* Voice gender: male or female.
* Available voice [modes](index.md#role).
* Supported API version.

You can listen to voice samples on the [SpeechKit page]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit){% endif %}.

## Supported voices {#premium}

The table lists the properties of the supported voices that use deep neural networks to synthesize speech.

| Voice | Main language | Gender | Mode | API version |
|---------| ---- | ---- | ---- |--------|
| `alena` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> happy — `good` </br> | v1, v3 |
| `filipp` | Russian (`ru-RU`) | M | — | v1, v3 |
| `jane` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> happy — `good` </br> angry — `evil` | v1, v3 |
| `omazh` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> angry — `evil` | v1, v3 |
| `zahar` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |
| `ermil` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |
| `amira` | Kazakh: `kk-KK`. | F | — | v3 with the `x-service-branch:rc` http header. |
| `john` | English: `en-US` | M | — | v3 with the `x-service-branch:rc` http header. |

The voices of `oksana` and `alena` have been created from the recordings of a single voice artist. The voice `oksana` is no longer on the supported voice list, the voice `alena` in `good` mode is used instead. The voice `oksana` is available for legacy projects.

If existing voices are not suitable for your project, {{ speechkit-name }} can create a voice specifically for you. For more information about creating unique voices, see [{#T}](brand-voice/index.md).
