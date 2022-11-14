# Supported audio formats

{{ speechkit-name }} enables you to recognize and synthesize the following audio formats:
* LPCM
* OggOpus
* MP3

#### LPCM {#LPCM}

[Linear pulse-code modulation]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Импульсно-кодовая_модуляция){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/Pulse-code_modulation){% endif %} without a WAV header.

Audio features in this format:
* Sampling rate: {% if product == "yandex-cloud" %}8, 16, or 48 kHz for the [synthesis](tts/index.md) API v1 and [recognition](stt/index.md) API v2 and {% endif %}values in the range of 8–48 kHz for the synthesis and recognition API v3.
* Bit depth: 16-bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus) — data is encoded using the OPUS audio codec and compressed using the OGG container format.

{{ speechkit-short-name }} recognizes and synthesizes OggOpus without audio file quality and header restrictions.

#### MP3 {#MP3}

[MP3]{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/MP3){% endif %}{% if lang == "en" %}(https://en.wikipedia.org/wiki/MP3){% endif %}: Data is encoded using the MPEG-1/2/2.5 Layer III audio codec and packaged in an MP3 container.

{{ speechkit-short-name }} recognizes MP3 without audio file quality and header restrictions.

{% if product == "yandex-cloud" %}

{% note warning %}

MP3 format is not supported by API v2 recognition in [streaming](./stt/api/streaming-api.md) or [synchronous](./stt/api/request-api.md) modes.

{% endnote %}

{% endif %}