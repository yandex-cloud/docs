# Conversations API

To manage context when using with the Responses API, you can [join responses](../../operations/agents/manage-context.md#previous-response), [provide message history](../../operations/agents/manage-context.md#manual) with each request, or [use the _Conversations API_](../../operations/agents/manage-context.md#conversations-api) to store a conversation as a long-lived object with a stable ID.

The Conversations API recreates the conversation state using saved elements, such as:

* user and assistant messages.
* tool calls (`tool calls`).
* other service messages.

Currently, you cannot edit elements or reset a conversation. To reload a conversation, create the new `conversation` object.

## Example {#example}

In a multi-step conversation, the `conversation` object is provided to subsequent requests to preserve the state and share the context across responses:

```py
import openai

YANDEX_CLOUD_FOLDER = "<folder_ID>"
YANDEX_CLOUD_API_KEY = "<API_key>"
YANDEX_CLOUD_MODEL = "yandexgpt"

client = openai.OpenAI(
    api_key=YANDEX_CLOUD_API_KEY,
    base_url="https://ai.api.cloud.yandex.net/v1",
    project=YANDEX_CLOUD_FOLDER
)

# Creating a conversation
conv = client.conversations.create()

# First message with a system instruction and custom input
r1 = client.responses.create(
    model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
    conversation=conv.id,
    input=[
        {"role": "system", "content": "You are my assistant"},
        {"role": "user", "content": "Hi! Remember: My name is Anastasia."}
    ]
)
print("assistant:", r1.output_text)

# Continue in the same conversation
r2 = client.responses.create(
    model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
    conversation=conv.id,
    input="What is my name?"
)
print("assistant:", r2.output_text)
```