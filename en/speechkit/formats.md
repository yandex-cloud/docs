# Supported audio formats

The service helps recognize and synthesize the following audio formats:
* LPCM
* OggOpus
* MP3

#### LPCM {#LPCM}

[Linear pulse-code modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation) without a WAV header.

Audio features in this format:
* Sampling: 8, 16, or 48 kHz, depending on the `sampleRateHertz` value.
* Bit depth: 16-bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus): Data is encoded using the OPUS audio codec and compressed using the OGG container format.

{{ speechkit-short-name }} recognizes OggOpus without limitations on quality or audio file headers.

#### MP3 {#MP3}

[MP3](https://en.wikipedia.org/wiki/MP3): Data is encoded using the MPEG-1/2/2.5 Layer III audio codec and packaged in an MP3 container.

{{ speechkit-short-name }} recognizes MP3 without limitations on quality or audio file headers.

{% note warning %}

MP3 format is not supported by API v2 recognition in [streaming](./stt/api/streaming-api.md) or [synchronous](./stt/api/request-api.md) modes.

{% endnote %}