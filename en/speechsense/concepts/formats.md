# Supported audio formats

{{ speechsense-name }} allows you to [upload audio files](../operations/data/upload-data.md) in these formats:

* [LPCM](#lpcm)
* [WAV](#WAV)
* [MP3](#MP3); preferred format
* [OggOpus](#OggOpus)

## LPCM {#lpcm}

[Linear pulse-code modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation) is a format of uncompressed audio encoding.

LPCM audio requirements:

* Sampling rate: Between 8 kHz and 48 kHz.
* Bit depth: 16 bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.

## WAV {#WAV}

For [WAV](https://en.wikipedia.org/wiki/WAV), data is encoded using LPCM and packaged in a WAV container.

LPCM format requirements also apply to WAV audio files. {{ speechsense-name }} only recognizes WAV if the audio files use the LPCM encoding and comply with the format requirements.

## MP3 {#MP3}

For [MP3](https://en.wikipedia.org/wiki/MP3), data is encoded using the MPEG-1/2/2.5 Layer III audio codec and packaged in an MP3 container.

{{ speechsense-name }} recognizes MP3 without audio file quality and header restrictions.

## OggOpus {#OggOpus}

For [OggOpus](https://wiki.xiph.org/OggOpus), data is encoded using the OPUS audio codec and compressed using the OGG container format.

{{ speechsense-name }} recognizes OggOpus without audio file quality and header restrictions.
