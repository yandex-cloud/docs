---
title: List of voices in {{ speechkit-full-name }}
description: In this tutorial, you will learn about voices available in {{ speechkit-name }}.
---

# List of voices

This section provides a list of voices available in the service and their characteristics:

* Main language the voice supports. This is the language used by the speaker when creating this voice.
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
| `he-IL` | Hebrew | `naomi` | F | (Default) Modern: `modern` </br> Classic: `classic`| v3 |
| `kk-KK` or `kk-KZ` | Kazakh | `amira` | F | — | v1, v3 |
| `kk-KK` or `kk-KZ` | Kazakh | `madi` | M | — | v1, v3 |
| `kk-KK` or `kk-KZ` | Kazakh | `saule` | F | (Default) Neutral: `neutral` </br> Strict: `strict` | v3 |
| `kk-KK` or `kk-KZ` | Kazakh | `zhanar` | F | (Default) Neutral: `neutral` </br>Friendly: `friendly` | v3 |
| `ru-RU` | Russian | `alena` | F | (Default) Neutral: `neutral` </br> Cheerful: `good` </br> | v1, v3 |
| `ru-RU` | Russian | `filipp` | M | — | v1, v3 |
| `ru-RU` | Russian | `ermil` | M | (Default) Neutral: `neutral` </br> Cheerful: `good` | v1, v3 |
| `ru-RU` | Russian | `jane` | F | (Default) Neutral: `neutral` </br> Cheerful: `good` </br> Irritated: `evil` | v1, v3 |
| `ru-RU` | Russian | `omazh` | F | (Default) Neutral: `neutral` </br> Irritated: `evil` | v1, v3 |
| `ru-RU` | Russian | `zahar` | M | (Default) Neutral: `neutral` </br> Cheerful: `good` | v1, v3 |
| `ru-RU` | Russian | `dasha` | F | (Default) Neutral: `neutral` </br> Cheerful: `good`</br> Friendly: `friendly` | v3 |
| `ru-RU` | Russian | `julia` | F | (Default) Neutral: `neutral` </br> Strict: `strict` | v3 |
| `ru-RU` | Russian | `lera` | F | (Default) Neutral: `neutral` </br> Friendly: `friendly` | v3 |
| `ru-RU` | Russian | `masha` | F | (Default) Cheerful: `good` </br> Strict: `strict` </br> Friendly: `friendly` | v3 |
| `ru-RU` | Russian | `marina` </br> (default) | F | (Default) Neutral: `neutral` </br> Whisper: `whisper` </br> Friendly: `friendly` | v1, v3 |
| `ru-RU` | Russian | `alexander` | M | (Default) Neutral: `neutral` </br> Cheerful: `good` | v3 |
| `ru-RU` | Russian | `kirill` | M | (Default) Neutral: `neutral` </br> Strict: `strict` </br> Cheerful: `good` | v3 |
| `ru-RU` | Russian | `anton` | M | (Default) Neutral: `neutral` </br> Cheerful: `good` | v3 |
| `ru-RU` | Russian | `madi_ru` | M | — | v1, v3 |
| `ru-RU` | Russian | `saule_ru` | F | (Default) Neutral: `neutral`</br>Strict: `strict`</br>Whisper: `whisper` | v3 |
| `ru-RU` | Russian | `zamira_ru` | F | (Default) Neutral: `neutral`</br>Strict: `strict` | v3 |
| `ru-RU` | Russian | `zhanar_ru` | F | (Default) Neutral: `neutral`</br>Strict: `strict`</br>Friendly: `friendly` | v3 |
| `ru-RU` | Russian | `yulduz_ru` | F | (Default) Neutral: `neutral`</br>Strict: `strict`</br>Friendly: `friendly` | v3 |
| `uz-UZ` | Uzbek | `nigora` | F | — | v1, v3 |
| `uz-UZ` | Uzbek | `zamira` | F | — | v3 |
| `uz-UZ` | Uzbek | `yulduz` | F | (Default) Neutral: `neutral`</br>Strict: `strict`</br>Friendly: `friendly`</br>Whisper: `whisper` | v3 |


The `oksana` and `alena` voices are based on recordings of the same speaker. The `oksana` voice is no longer on the list of supported voices. Use the `alena` voice with the `good` role instead. The `oksana` voice is still available for legacy projects.


{% note tip %}

If the existing voices are not suitable for your project, {{ speechkit-name }} can create a voice specifically for you. For more information about creating unique voices, see [{{ brand-voice-full-name }}](brand-voice/index.md).

{% endnote %}

## Use cases {#examples}

* [{#T}](api/tts-examples-v3.md)
* [{#T}](api/tts-v3-rest.md)
* [{#T}](api/tts-wav.md)
* [{#T}](api/tts-ogg.md)