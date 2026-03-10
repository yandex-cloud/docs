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
**{{ realtime-model }}**</br>`gpt://<folder_ID>/{{ realtime-model }}` | 32,768 | Synchronous

Designed for Russian-language scenarios, the model is well equipped for creating voice assistants, chat environments, and apps requiring a natural, human-like flow of conversation.

{{ realtime-api }} works with audio in [LPCM](https://en.wikipedia.org/wiki/Pulse-code_modulation) format.

### Voices {#voices}

{{ realtime-api }} is compatible with all [standard {{ speechkit-full-name }} voices](../../../speechkit/tts/voices.md) as well as {{ brand-voice-lite-name }} and {{ brand-voice-premium-name }} [voices](../../../speechkit/tts/brand-voice/index.md).

You can listen to voice samples on the [{{ speechkit-name }} page](/services/speechkit).

### Sessions {#sessions}

The client-server communication context is stored in _sessions_. Each session holds the conversation history and configuration settings, such as the model's system prompt, selected speech synthesis voice, and expected modalities (text or voice).

A session is created just once, when the WebSocket connection is established, and stays active until the connection closes. You can edit the session configuration settings while the conversation is in progress. For example, you can update the system prompt, speech synthesis voice, or modalities.

To continue working after the current session is closed, create a new session.

### Events {#events}

_Events_ are the main way to exchange data in {{ realtime-api }}. Each client-server communication takes the form of an event with the required `type` field, which stands for the _[event type](#types)_ to indicate its purpose.

The client sends events to transmit data, instructions, or commands, e.g., to generate a new answer, upload audio, or edit the session settings. The server responds with events containing partial or final results along with state updates.

The event exchange is two-way and asynchronous: the client can send new events to the server without waiting for the result of the previous task. This approach enables real-time handling of responses and reacting to them immediately, without waiting for full processing to complete.

Each event is transmitted as a separate [JSON](https://en.wikipedia.org/wiki/JSON) object over an open WebSocket connection. The client should support processing events as they arrive in real time. Moreover, you need to consider that the response may arrive in parts: first as deltas (partial data), and then as a final completion message.

### Voice agent tools {#tools}

With a system of `tools`, the agent can call functions, search the web, work with your files, and access external systems and tools. This allows you to use the model in a more interactive and effective way in real-world scenarios – from support chatbots to analytical assistants.

#### Function calling {#function-calling}

_Function calling_ is a native {{ realtime-api }} feature that allows the model to call pre-described functions. It comes into play when the model needs to respond with more than just text but also to some action, e.g., get data from a CRM, call an external API, or calculate the result.

Functions are described as JSON schemas when initializing a session:

```py
"tools": [
    # Weather function to demonstrate function calling
    {
        "type": "function",
        "name": "get_weather",
        "description": "Get a brief weather report for the city.",
        "parameters": {
            "type": "object",
            "properties": {"city": {"type": "string"}},
            "required": ["city"],
            "additionalProperties": False,
        },
    }
],
...
```

As soon as the model understands that it needs to call a function, it returns a structured object with the name of the function and arguments. The client executes this call and returns the response to the model, thus forming an interactive _model ↔ application logic_ cycle.

```py
if item.get("type") == "function_call":
...
weather_json = fake_weather(city)
...
payload_item = {
    "type": "conversation.item.create",
    "item": {
        "type": "function_call_output",
        "call_id": call_id,
        "output": weather_json,
    },
}
```

#### Web search {#web-search}

[_Web search_](./tools/websearch.md) is a tool that allows the model to draw information from open sources to generate a response.

For your voice agent to be able to access the internet, list it among the available tools when initializing the session: 

```py
{
  "session": {
    ...
    "tools": [
        # Web search tool.
        {
            "type": "function",
            "name": "web_search", # reserved name of the web search function
            "description": "Web search",
            "parameters": "{}", # temporarily not parameterized
        }
    ],
    ...
  }
}
```

#### File search {#file-search}

The [_File search_ tool](./tools/filesearch.md) enables hybrid search through the user's files when generating the response.

```py
{
  "session": {
    ...
    "tools": [
        # File search tool.
        {
            "type": "function",
            "name": "file_search",  # reserved name of the file search function
            "description": "<search_index_ID>" #index ID generated using the Vector Store API
            "parameters": "{}", # not used for now
        },
    ],
    ...
  }
}
```

This search will work well for:

* Corporate knowledge bases and guidelines.
* Retrieval-augmented generation (RAG) scenarios.
* Customer support based on internal corporate data.

The system adds search results into the response context, allowing the model to generate answers with links to particular documents or citations.

#### MCP {#mcp}

To be able to call third-party APIs and agent services, you can use the Model Context Protocol (MCP). The MCP allows you to connect an external tool server and call its tools automatically during the session. Once there is a connection, all the tools published by the MCP server become available to the agent via the {{ realtime-api }} and can be called by the model automatically during the session.

```py
{
  "session": {
    ...
    "tools": [
      {
        "type": "mcp", # indicates that the tool is an MCP server
        "server_label": "..", # logical server name for the model
        "server_url": "...", # address of the MCP server with third-party APIs
        "authorization": "{access_token}", # MCP server authorization data
        "require_approval": "{never or always}" # approval policy before the tools are called
      }
    ],
    ...
  }
}
```

#### Examples of tool use cases {#use-cases}

* Customer support agents answer documentation-related questions, query internal services, and act on behalf of the user.
* Call center agent assistants offer help based on current internal documents, knowledge bases, and operational data.
* Business bots and analytical assistants gather information from external sources, APIs, and public data to come up with consolidated reports and recommendations.

#### See also {#see-also}

* [{#T}](./index.md)
* [{#T}](./tools/websearch.md)
* [{#T}](./tools/filesearch.md)

## Use cases {#examples}

[{#T}](../../operations/agents/create-voice-agent.md)
