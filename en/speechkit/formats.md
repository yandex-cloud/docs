---
title: Supported audio formats in {{ speechkit-full-name }}
description: '{{ speechkit-name }} recognizes and synthesizes audio in LPCM, OggOpus, and MP3 formats.'
---

# Supported audio formats

{% include [audio-formats](../_includes/speechkit/audio-formats.md) %}

#### LPCM {#lpcm}


[Linear pulse-code modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation) without a WAV header.

Audio features in this format:

* Sampling frequency:

  | API version | Acceptable values |
  | --- | --- |
  | [Speech synthesis API v1](tts/index.md) | 8, 16, or 48 kHz |
  | [Speech synthesis API v3](tts-v3/api-ref/grpc/index.md) | Any value between 8 and 48 kHz |
  | [Speech recognition API v2](stt/index.md) | 8, 16, or 48 kHz |
  | [Speech recognition API v3](stt-v3/api-ref/grpc/index.md) | 8, 16, or 48 kHz |

* Bit depth: 16 bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.

#### OggOpus {#OggOpus}

For [OggOpus](https://wiki.xiph.org/OggOpus), data is encoded using the OPUS audio codec and compressed using the OGG container format.

{{ speechkit-short-name }} recognizes and synthesizes OggOpus without audio file quality and header restrictions.

#### MP3 {#MP3}

For [MP3](https://en.wikipedia.org/wiki/MP3), data is encoded using the MPEG-1/2/2.5 Layer III audio codec and packaged in an MP3 container.

{{ speechkit-short-name }} recognizes MP3 without audio file quality and header restrictions.


{% note warning %}

The MP3 format is not supported in the API v1 for [synchronous](./stt/api/request-api.md) recognition and API v2 for [streaming](./stt/api/streaming-api.md) recognition.

{% endnote %}

