---
title: Voice agents in {{ foundation-models-full-name }}
description: Voice agents enable you to create AI-powered applications that engage with users in both written and spoken form.
---

# Voice agents

_Voice agents_ in {{ foundation-models-full-name }} enable you to create AI-powered applications that engage with users in both written and spoken form.

Voice agents support two-way message exchange: the client sends events with audio or text instructions, and the server delivers responses as soon as they are generated. With this streaming mode, you can see partial responses immediately without waiting for full processing, which ensures the dialogue evolves in a natural way.

You can use voice agents for the following scenarios:

* **Suggestions for support agent**: While the support agent communicates with the client through voice or text, the voice agent analyzes their conversation in real time to suggest a ready-made answer or a link to the relevant guide. This enables the support agent to answer questions more quickly and accurately.
* **Voice agent**: Next-level alternative to voice bots. The voice agent can take orders and answer support questions, responding in real time like a human support agent.
* **Automatic call summarization**: The voice agent analyzes the audio stream in real time and highlights key points, such as topics, arrangements, and further steps. As the conversation winds down, it generates a call summary and a checklist and sends them to the [CRM](https://en.wikipedia.org/wiki/Customer_relationship_management) system or chat.

## {{ realtime-api }} {#realtime-api}

In {{ ai-studio-name }}, you can create voice agents using _{{ realtime-api }}_, an event-driven interface for real-time voice interaction between the server and client over [WebSocket](https://en.wikipedia.org/wiki/WebSocket).

### Model {#model}

To process user requests, {{ realtime-api }} runs a multimodal model tailored for interactive voice and mixed voice-and-text scenarios with minimum latency:

**Model and URI** | **Context** | **[Operating modes](../index.md#working-mode)**
--- | --- | ---
**{{ realtime-model }}**</br>`gpt://<folder_ID>/{{ realtime-model }}` | 32,000 | Synchronous

Designed for Russian-language scenarios, the model is well equipped for creating voice assistants, chat environments, and apps requiring a natural, human-like flow of conversation.

### Voices {#voices}

{{ realtime-api }} is compatible with all [standard {{ speechkit-full-name }} voices](../../../speechkit/tts/voices.md) as well as {{ brand-voice-lite-name }} and {{ brand-voice-premium-name }} [voices](../../../speechkit/tts/brand-voice/index.md).

You can listen to voice samples on the [{{ speechkit-name }} page](/services/speechkit).

### Sessions {#sessions}

The client-server communication context is stored in _sessions_. Each session holds the conversation history and configuration settings, such as the model's system prompt, selected speech synthesis voice, and expected modalities (text or voice).

The system creates a session upon establishing a WebSocket connection and keeps it active until either the connection closes or the session lifetime expires.

The session lifetime is five minutes, but it can be increased to ten minutes if required. You can edit the session configuration settings while the conversation is in progress. For example, you can update the system prompt, speech synthesis voice, or modalities.

To continue working after the current session is closed, create a new session.

### Events {#events}

_Events_ are the main way to exchange data in {{ realtime-api }}. Each client-server communication takes the form of an event with the required `type` field, which stands for the _[event type](#types)_ to indicate its purpose.

The client sends events to transmit data, instructions, or commands, e.g., to generate a new answer, upload audio, or edit the session settings. The server responds with events containing partial or final results along with state updates.

The event exchange is two-way and asynchronous: the client can send new events to the server without waiting for the result of the previous task. This approach enables real-time handling of responses and reacting to them immediately, without waiting for full processing to complete.

Each event is transmitted as a separate [JSON](https://en.wikipedia.org/wiki/JSON) object over an open WebSocket connection. The client should support processing events as they arrive in real time. Moreover, you need to consider that the response may arrive in parts: first as deltas (partial data), and then as a final completion message.

#### Event types {#types}

{{ realtime-api }} supports the following event types:

* `session.update`: Session settings update, e.g., change in the synthesis voice or model's system prompt.
* `input_audio_buffer.append`: Transmission of an audio segment (in [PCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format, mono, 24 kHz, 16-bit, [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64)-encoded).
* `input_audio_buffer.commit`: Completion of audio transmission.
* `response.create`: Start of the new model's response generation.
* `response.output_text.delta`: Segment of the response as text (streaming).
* `response.output_text.delta`: Segment of the response as audio (PCM, Base64).
* `response.output_audio.done`: Last segment of the response as audio.
* `response.done`: Completion of the model's response generation.
* `error`: Error message.


#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](../../operations/agents/create-voice-agent.md)