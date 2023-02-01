# List of voices

This section provides a list of voices available in the service and their characteristics:

* The main language that a voice supports. This is the language used by the speaker when creating this voice.
* Voice gender: male or female.
* Available voice [modes](index.md#role).
   {% if product == "yandex-cloud" %}* Supported API version.{% endif %}

{% if product == "yandex-cloud" %}

You can listen to voice samples on the [SpeechKit page]{% if lang == "ru" %}(https://cloud.yandex.ru/services/speechkit){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/services/speechkit){% endif %}.

{% endif %}

## Supported voices {#premium}

The table lists the properties of the supported voices that use deep neural networks to synthesize speech.

| Language code | Language | Voice | Gender | Mode | {% if product == "yandex-cloud" %}API version | {% endif %}
|---------| ---- | ---- | -- |--------|{% if product == "yandex-cloud" %}---|{% endif %}
| `de-DE` | German | `lea` | F | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `en-US` | English | `john` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `he-IL` | Hebrew | `naomi` | F | (default) modern — `modern` </br> classic — `classic` | {% if product == "yandex-cloud" %} v3 |{% endif %}
| `kk-KK` | Kazakh | `amira` | F | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `kk-KK` | Kazakh | `madi` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` |  Russian | `alena` </br> (default) | F | (default) neutral — `neutral` </br> happy — `good` </br> | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `filipp` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `ermil` | M | (default) neutral — `neutral` </br> happy — `good` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `jane`  | F | (default) neutral — `neutral` </br> happy — `good` </br> angry — `evil` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `madirus` | M | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `omazh` | F  | (default) neutral — `neutral` </br> angry — `evil` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `ru-RU` | Russian | `zahar` | M | (default) neutral — `neutral` </br> happy — `good` | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}
| `uz-UZ` | Uzbek | `nigora` | F | — | {% if product == "yandex-cloud" %}v1, v3 |{% endif %}

{% if product == "yandex-cloud" %}
The `oksana` and `alena` voices were created from the recordings of a single voice artist. The voice `oksana` is no longer on the supported voice list. The voice `alena` in `good` mode is used instead. The voice `oksana` is available for legacy projects.
{% endif %}

{% note tip %}

If existing voices are not suitable for your project, {{ speechkit-name }} can create a voice specifically for you. For more information about creating unique voices, see [{{ brand-voice-full-name }}](brand-voice/index.md).

{% endnote %}