---
title: "Tutorials for {{ speechkit-full-name }}"
description: "This page presents a list of tutorials for {{ speechkit-name }}."
---

# Tutorials for {{ speechkit-name }}

* [{#T}](./recognizer-bot.md)
* [{#T}](./speechkit-integrarion-via-agi-gw.md)

## Speech recognition {#stt}

### Streaming recognition {#streaming-stt}

* [{#T}](../stt/api/streaming-examples-v3.md): This example uses the Russian language, 8,000 Hz LPCM streaming audio from file, single audio channel. Profanity filter enabled in recognition settings.

* [{#T}](../stt/api/microphone-streaming.md): This example uses the Russian language, 8,000 Hz LPCM audio, single audio channel. Profanity filter enabled.

* [{#T}](../stt/api/stt-language-labels-example.md): This example uses 8,000 Hz LPCM audio, single audio channel.


* [{#T}](../stt/api/streaming-examples.md): This example uses the Russian language, 8,000 Hz LPCM audio. Profanity and intermediate result filters enabled.

### Synchronous recognition {#sync-stt}

[{#T}](../stt/api/request-examples.md): This example uses the Russian language, other parameters [are at their defaults](../stt/api/request-api.md#query_params).

### Asynchronous recognition {#async-stt}

* [{#T}](../stt/api/transcribation-lpcm.md): This example uses the Russian language, the `general:rc` language model, 8,000 Hz LPCM audio, single audio channel.

* [{#T}](../stt/api/transcribation-ogg.md): This example uses the Russian language, other parameters [are at their defaults](../stt/api/transcribation-api.md#sendfile-params).

* [{#T}](../stt/api/transcribation-api-v3.md): This example uses the `general` language model and WAV audio format, other parameters [are at their defaults](../stt/api/transcribation-api.md#sendfile-params).

* [{#T}](../stt/api/batch-transcribation.md): This example uses the Russian language and the `general` language model. Speech is recognized from audio files of any [supported format](../formats.md).


## Synthesis {#tts}

* [{#T}](../tts/api/tts-examples-v3.md): This example uses 22,050 Hz LPCM audio, WAV container, and LUFS loudness normalization.


* [{#T}](../tts/api/tts-templates.md): This example uses pattern-based synthesis for the {{ brand-voice-core-name }} and {{ brand-voice-premium-name }} voices.

* [{#T}](../tts/api/tts-templates-bvcc.md): This example uses pattern-based synthesis for the {{ brand-voice-cc-name }} voices.

* [{#T}](../tts/api/tts-wav.md): This example uses the Russian language, 48,000 Hz LPCM audio, WAV container, and the `filipp` voice.

* [{#T}](../tts/api/tts-ogg.md): This example uses the Russian language and the `filipp` voice.

* [{#T}](../tts/api/tts-ssml.md): This example uses the Russian language and the `jane` voice.

