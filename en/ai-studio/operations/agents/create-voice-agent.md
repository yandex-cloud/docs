---
title: Creating a voice agent via {{ realtime-api }}
description: Follow this guide to use the {{ realtime-api }} to create a voice agent in {{ foundation-models-full-name }} for real-time interaction over a WebSocket transport.
---

# Creating a WebSocket-based voice agent via the {{ realtime-api }}

[_{{ realtime-api }}_](../../concepts/agents/realtime.md#realtime-api) is an event-driven {{ foundation-models-name }} interface for real-time voice interaction between the server and the client over a [WebSocket](https://en.wikipedia.org/wiki/WebSocket) transport.

With {{ realtime-api }}, you can create a [voice agent](../../concepts/agents/realtime.md) that will analyze the audio stream from the microphone in real time, provide voice requests for processing to the `{{ realtime-model }}` [model](../../concepts/agents/realtime.md#model), collect the model's response, and play it through the speakers.

The model can invoke various [tools](../../concepts/assistant/tools/index.md) to process user requests. The response to the request is returned both as synthesized speech and in text format.

## User-agent interaction diagram {#dialog-steps}

In the example below, the user interacts with the agent as follows:

1. The user pronounces a request, the microphone records the stream, and the `uplink()` function sends audio fragments to the agent.
1. The server (`{{ realtime-model }}`) detects episodes of silence ([VAD](https://en.wikipedia.org/wiki/Voice_activity_detection)) and returns recognized text in the `conversation.item.input_audio_transcription.completed` event. The agent logs the resulting text.
1. The model generates a response (`response.created`) and starts returning text deltas (`response.output_text.delta`) and audio deltas (`response.output_audio.delta`).
1. The `downlink()` function takes the text of response to the screen and plays back the audio via `AudioOut`.

    However, if the user starts pronouncing a new request, the response playback is interrupted, and a brand new user request processing iteration starts.

{% note tip %}

When testing and debugging voice agents, use headphones for audio playback. This will help you avoid situations where your agent tries to recognize its own voice and interrupts itself, thus causing misrecognized phrases and incomplete responses.

If problems persist even when using headphones, reduce playback volume: your microphone may be sensitive enough to interpret the sound from your headphones as real speech.

{% endnote %}

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- Python {#python}

  1. {% include [before-begin-realtime-step0](../../../_includes/ai-studio/before-begin-realtime-step0.md) %}
  1. {% include [before-begin-realtime-step1](../../../_includes/ai-studio/before-begin-realtime-step1.md) %}
  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Install the required libraries using the [pip](https://pip.pypa.io/en/stable/) package manager:

      ```bash
      pip install numpy sounddevice aiohttp
      ```

      Additional info on installed libraries:

      * `aiohttp`: Asynchronous HTTP and WebSocket clients. Requires library version `3.9.0` or higher.
      * `numpy`: Working with audio arrays and transformations. Requires library version `1.26.0` or higher.
      * `sounddevice`: Recording and playing sound via PortAudio. Requires library version `0.4.6` or higher.

{% endlist %}

## Create a voice agent {#create-agent}

To create a WebSocket-based voice agent:

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `voice-agent.py` and paste the following code into it:

      {% include [va-via-websocket-code](../../../_includes/ai-studio/agents/va-via-websocket-code.md) %}

      Where:

      * Configuration:

          * `YANDEX_CLOUD_API_KEY`: [API key](../../../iam/concepts/authorization/api-key.md) of the [service account](../../../iam/concepts/users/service-accounts.md) used to call {{ realtime-api }} methods. 
          * `YANDEX_CLOUD_FOLDER_ID`: ID of the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the {{ realtime-api }} is called in.
          * `VECTOR_STORE_ID`: [Search index](../../concepts/assistant/search-index.md) ID for built-in search through knowledge base files.
          * `WS_URL`: {{ realtime-api }} WebSocket endpoint.
          * `IN_RATE` and `OUT_RATE`: Audio input and output sampling rates.
          * `VOICE`: [Voice](../../../speechkit/tts/voices.md#premium) used for the agent's response.  
      * Auxiliary functions:
      
          * `float_to_pcm16()`: Converts audio data from `float32` (microphone) to `PCM16`.
          * `b64_encode()` and `b64_decode()`: [Base64](https://en.wikipedia.org/wiki/Base64) encoding and decoding audio fragments for transmission over WebSocket.
          * `log()`: Thread-safe log output.
          * `fake_weather()`: Demo function simulating a weather API. Returns a response containing weather information and advice in [JSON](https://en.wikipedia.org/wiki/JSON) format.
      * Classes:
      
          * The `AudioOut` class manages sound playback. Creates a stream named `sounddevice.RawOutputStream` and a buffer to which PCM blocks received from the server are added. If the queue is empty, silence is played back.
          * The `MicStreamer` class manages the capturing of audio from the microphone in a separate stream and sending audio fragments to an asynchronous queue (`asyncio.Queue`). From this queue, the data then goes to the server in the `uplink()` function.
      * Asynchronous functions:
      
          * `uplink()`: Continuously receives audio fragments from the queue and sends them to the server in the following format:

              ```
              {"type": "input_audio_buffer.append", "audio": "<base64>"}
              ```
          * `downlink()`: Processes incoming messages from {{ realtime-api }}:

              * `conversation.item.input_audio_transcription.completed`: Recognized text of the user's request.
              * `response.output_text.delta`: Fragment of the agent's response in text format.
              * `response.output_audio.delta`: Fragment of the agent's response in audio format (synthesized speech).
              * `response.output_item.done`: Results of a completed [function call](../../concepts/generation/function-call.md) (in the example, `get_weather`).
              * `error`: Error messages.
              * `input_audio_buffer.speech_started`: Start of a new user request (stops playing back the agent's current response).
              
          * Main stream `main()`:

              * Connects to {{ realtime-api }}.
              * Sets up the session: specifies the model, audio parameters, and tools.
              * Starts two background tasks (asynchronous `uplink` and `downlink` functions).
              * Processes **Ctrl + C** events (graceful termination of connection).

  1. Run the file you created:

      ```bash
      python3 voice-agent.py
      ```

      Once you execute the code, the agent will await voice requests and respond to them with text on the screen and simultaneous audio playback through computer speakers.

      To interrupt code execution, use the **Ctrl + C** keyboard shortcut.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/agents/realtime.md)