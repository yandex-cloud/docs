# List of voices

This section provides a list of voices available in the service and their characteristics:

* The main language that a voice supports. This is the language used by the speaker when creating this voice.
* Voice gender: male or female.
* Available voice modes.
* Supported API version.

You can listen to voice samples on the [{{ speechkit-name }} page]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit){% endif %}.

## Standard voices {#standard}

{% note warning %}

The voices in this table will be supported until May 31, 2022.

{% endnote %}

| Voice | Main language | Gender | Mode | API version |
---- | ---- | ---- | ---- | ----
| `oksana:deprecated` | Russian (`ru-RU`) | F | — | v1 |
| `jane:deprecated` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> happy — `good` </br> angry — `evil` | v1 |
| `omazh:deprecated` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> angry — `evil` | v1 |
| `zahar:deprecated` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1 |
| `ermil:deprecated` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1 |

## Supported voices {#premium}

The table lists the properties of the supported voices that use deep neural networks to synthesize speech.

| Voice | Main language | Gender | Mode | API version |
---- | ---- | ---- | ---- | ----
| `alena` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> happy — `good` </br> | v1, v3 |
| `filipp` | Russian (`ru-RU`) | M | — | v1, v3 |
| `jane` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> happy — `good` </br> angry — `evil` | v1, v3 |
| `omazh` | Russian (`ru-RU`) | F | (default) neutral — `neutral` </br> angry — `evil` | v1, v3 |
| `zahar` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |
| `ermil` | Russian (`ru-RU`) | M | (default) neutral — `neutral` </br> happy — `good` | v1, v3 |

The voices of `oksana` and `alena` have been created from the recordings of a single voice artist. The voice of `oksana` is no longer on the supported voice list but it is available for legacy projects. Use supported voices for new projects.