# List of voices

This section provides a list of voices available in the service and their characteristics:

* The main language that a voice supports. This is the language used by the speaker when creating this voice.
* Voice gender: male or female.
* Available voice [roles](index.md#role).
   * Supported API version.


You can listen to voice samples on the [service page](/services/speechkit).


## Supported voices {#premium}

The table lists the properties of the supported voices that use deep neural networks to synthesize speech.

| Language code | Language | Voice | Gender | Role | API version | 
|---------| ---- | ---- | -- |--------|---|
| `de-DE` | German | `lea` | F | — | v1, v3 |
| `en-US` | English | `john` | M | — | v1, v3 |
| `he-IL` | Hebrew | `naomi` | F | (default) modern — `modern` </br> classic — `classic` |  v3 |
| `kk-KK` | Kazakh | `amira` | F | — | v1, v3 |
| `kk-KK` | Kazakh | `madi` | M | — | v1, v3 |
| `ru-RU` | Russian | `alena` </br> (default) | F | (default) neutral — `neutral` </br> happy — `good` </br> | v1, v3 |
| `ru-RU` | Russian | `filipp` | M | — | v1, v3 |
| `ru-RU` | Russian | `ermil` | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |
| `ru-RU` | Russian | `jane` | F | (default) neutral — `neutral` </br> happy — `good` </br> angry — `evil` | v1, v3 |
| `ru-RU` | Russian | `madirus` | M | — | v1, v3 |
| `ru-RU` | Russian | `omazh` | F | (default) neutral — `neutral` </br> angry — `evil` | v1, v3 |
| `ru-RU` | Russian | `zahar` | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |
| `ru-RU` | Russian | `dasha`  | F | (default) neutral — `neutral` </br> happy — `good`</br> friendly — `friendly` | v3 |
| `ru-RU` | Russian | `julia`  | F | (default) neutral — `neutral` </br> stern — `strict` | v3 |
| `ru-RU` | Russian | `lera`  | F | (default) neutral — `neutral` </br> friendly — `friendly` | v3 |
| `ru-RU` | Russian | `masha`  | F | (default) happy — `good` </br> stern — `strict` </br> friendly — `friendly` | v3 |
| `ru-RU` | Russian | `marina`  | F | (default) neutral — `neutral` </br> whisper— `whisper` </br> friendly — `friendly` | v3 |
| `ru-RU` | Russian | `alexander` | M | (default) neutral — `neutral` </br> happy — `good` | v3 |
| `ru-RU` | Russian | `kirill` | M | (default) neutral — `neutral` </br> stern — `strict` </br> happy — `good` | v3 |
| `ru-RU` | Russian | `anton` | M | (default) neutral — `neutral` </br> happy — `good` | v3 |
| `uz-UZ` | Uzbek | `nigora` | F | — | v1, v3 |

The `oksana` and `alena` voices were created from the recordings of a single voice artist. The `oksana` voice is no longer on the list of supported voices. Use the `alena` voice with the `good` role instead. The `oksana` voice is still available for legacy projects.

{% note tip %}

If the existing voices are not suitable for your project, {{ speechkit-name }} can create a voice specifically for you. For more information about creating unique voices, see [{{ brand-voice-full-name }}](brand-voice/index.md).

{% endnote %}