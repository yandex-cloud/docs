# Supported audio formats

The service can recognize audio in the following formats:

#### LPCM {#LPCM}

[Linear pulse-code modulation](https://en.wikipedia.org/wiki/Pulse-code_modulation) with no WAV header.

Audio features in this format:

* Sampling: 8, 16, or 48 kHz, depending on the `sampleRateHertz` value.
* Bit depth: 16-bit.
* Byte order: Reversed (little-endian).
* Audio data is stored as signed integers.

#### OggOpus {#OggOpus}

[OggOpus](https://wiki.xiph.org/OggOpus) — data is encoded using the OPUS audio codec and compressed using the OGG container format.

