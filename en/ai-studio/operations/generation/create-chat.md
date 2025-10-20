---
title: How to create a chat with {{ gpt-lite }} in {{ foundation-models-full-name }}
description: Follow this guide to create a chat with {{ gpt-lite }} using the {{ responses-api }}.
---

# How to build a chat with the {{ responses-api }}

## Getting started {#before-begin}

{% list tabs group=programming_language %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Build a chat {#develop-chat}

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and add the following code to it:

      ```python
      import openai

      YANDEX_CLOUD_MODEL = "yandexgpt-lite"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project=YANDEX_CLOUD_FOLDER
      )

      previous_id = None # Saving the last response ID

      print("💬 Chat with GPT (enter 'exit' to exit)\n")

      while True:
          user_input = input("You: ")
          if user_input.lower() in ("exit", "quit"):
              print("Chat session ended.")
              break

          response = client.responses.create(
              model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
              input=[{"role": "user", "content": user_input}],
              previous_response_id=previous_id  # Providing context, if any
          )

          # Saving the ID for the next step
          previous_id = response.id

          # Printing the agent's response
          print("Agent:", response.output_text)
      ```

  1. Save authentication data into environment variables:

      ```bash
      export YANDEX_CLOUD_FOLDER=<folder_ID>
      export YANDEX_CLOUD_API_KEY=<API_key>
      ```

  1. Run the file you created:

      ```bash
      python index.py
      ```

      Response example:

      ```text
      💬 Chat with GPT (enter 'exit' to exit)

      You: Hi!
      Agent: Hi there! How can I help you?
      You: What exactly can you do?
      Agent: I can answer questions, help solve various problems, and provide information on various topics. For example, I can tell you about the weather, help with translating a text, suggest ideas, or just keep the conversation going. What are you interested in?
      You: Tell me a joke
      Agent: Why do programmers always have a cup of coffee? Because when they are working on a hard problem, they need to overclock their central processing unit... and the coffee helps them do it!
      You: Exit
      Chat session ended.
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/generation/models.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)