---
title: "Tutorials for {{ speechkit-full-name }}"
description: "This page gives a list of tutorials for {{ speechkit-name }}."
---

# {{ speechkit-name }} tutorials

* [{#T}](./recognizer-bot.md)

## Speech recognition {#stt}

### Streaming recognition {#streaming-stt}

* [{#T}](../stt/api/streaming-examples-v3.md): The example uses the Russian language, 8,000 Hz LPCM streaming audio from file, single audio channel. Profanity filter enabled in recognition settings.

* [{#T}](../stt/api/microphone-streaming.md): The example uses the Russian language, 8,000 Hz LPCM audio, single audio channel. Profanity filter enabled.

* [{#T}](../stt/api/stt-language-labels-example.md): The example uses 8,000 Hz LPCM audio, single audio channel.


* [{#T}](../stt/api/streaming-examples.md): The example uses the Russian language, 8,000 Hz LPCM audio. Profanity and intermediate result filters enabled.

### Synchronous recognition {#sync-stt}

[{#T}](../stt/api/request-examples.md): The example uses the Russian language and other parameters [with their default values](../stt/api/request-api.md#query_params).

### Asynchronous recognition {#async-stt}

* [{#T}](../stt/api/transcribation-lpcm.md): The example uses the Russian language, the `general:rc` language model, 8,000 Hz LPCM audio, single audio channel.

* [{#T}](../stt/api/transcribation-ogg.md): The example uses the Russian language and other parameters [with their default values](../stt/api/transcribation-api.md#sendfile-params).

* [{#T}](../stt/api/transcribation-api-v3.md): The example uses the `general` language model and WAV audio format with other parameters [set to defaults](../stt/api/transcribation-api.md#sendfile-params).

* [{#T}](../stt/api/batch-transcribation.md): The example uses the Russian language and the `general` model. Speech is recognized from audio files of any [supported format](../formats.md).


## Synthesis {#tts}

* [{#T}](../tts/api/tts-examples-v3.md): The example uses 22,050 Hz LPCM audio, WAV container, and LUFS loudness normalization.


* [{#T}](../tts/api/tts-templates.md): The example uses pattern-based synthesis for {{ brand-voice-core-name }} and {{ brand-voice-premium-name }} voices.

* [{#T}](../tts/api/tts-templates-bvcc.md): The example uses pattern-based synthesis for {{ brand-voice-cc-name }} voices.

* [{#T}](../tts/api/tts-wav.md): The example uses the Russian language, 48,000 Hz LPCM audio, WAV container, and the `filipp` voice.

* [{#T}](../tts/api/tts-ogg.md): The example uses the Russian language and the `filipp` voice.

* [{#T}](../tts/api/tts-ssml.md): The example uses the Russian language and the `jane` voice.

