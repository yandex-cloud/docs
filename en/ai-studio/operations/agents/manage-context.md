---
title: Managing conversation context in {{ ai-studio-name }}
description: Follow this guide to learn three ways to manage conversation context during agent interaction in {{ ai-studio-full-name }}.
---

# Managing conversation context

When using the Responses API in {{ ai-studio-full-name }}, there are three ways to provide context in a multi-step conversation with an [agent](../../concepts/agents/index.md):

* [Conversations API](#conversations-api): This option involves saving the conversation into an object with a unique ID.
* [Chaining responses](#previous-response): This option implements real-time chat by chaning responses together with the `previous_response_id` parameter.
* [Manual context management](#manual): This option allows you to edit the conversation history provided to the agent.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- Python {#python}

  1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) the `ai.assistants.editor` and `ai.languageModels.user` [roles](../../security/index.md#service-roles) to it.
  1. [Get](../get-api-key.md#run-client) and save the service account's [API key](../../../iam/concepts/authorization/api-key.md) with `yc.ai.foundationModels.execute` for its [scope](../../../iam/concepts/authorization/api-key.md#scoped-api-keys).

      {% include [sdk-windows-wsl-notice](../../../_includes/ai-studio/sdk-windows-wsl-notice.md) %}

  1. {% include [sdk-before-begin-step3](../../../_includes/ai-studio/sdk-before-begin-step3.md) %}
  1. {% include [sdk-before-begin-step4](../../../_includes/ai-studio/sdk-before-begin-step4.md) %}
  1. {% include [sdk-before-begin-step5](../../../_includes/ai-studio/sdk-before-begin-step5.md) %}
  1. Install the OpenAI [library](https://github.com/openai/openai-python) for Python:

      ```bash
      pip install openai
      ```

{% endlist %}

## Managing context with the Conversations API {#conversations-api}

You can use the [Conversations API](../../concepts/agents/conversations-api.md) to create the `conversation` object, which is provided to subsequent requests to preserve the state and share the context across responses. The conversation is stored as a long-lived object with a unique ID.

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `dialogue.py` and add the following code to it:
  
     ```py
     import openai
   
     YC_MODEL = "yandexgpt"
     
     def print_conversation(conv_id):
         print(f"\nConversation {conv_id}")
         items = client.conversations.items.list(conversation_id=conv_id)
         print(f"\nFound {len(items.data)} items in conversation:")
         
         for item in items.data:
             print(f"\nItem: {item}")
         print("-" * 80)
     
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.{{ api-host }}/v1",
         project=YC_FOLDER_ID
     )
     
     # 1) Creating a conversation.
     conv = client.conversations.create()
     print("conversation id:", conv.id)
     print_conversation(conv.id)
     
     # 2) First message with a system instruction and user input.
     r1 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input=[
             {"role": "developer", "content": "You are my assistant."},
             {"role": "user", "content": "Hi! Remember: I live in Serpukhov."}
         ]
     )
     print("assistant:", r1.output_text)
     print_conversation(conv.id)
     
     
     # 3) Proceeding in the same conversation.
     r2 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input="What city do I live in?"
     )
     print("assistant:", r2.output_text)
     print_conversation(conv.id)
     
     
     # 4) Calling web_search.
     r3 = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         conversation=conv.id,
         input="What will the weather be like this weekend?",
         tools=[{
             "type": "web_search",
         }]
     )
     print("assistant:", r3.output_text)
     print_conversation(conv.id)
     ```

  1. Save authentication data into environment variables:

      ```bash
      export YC_FOLDER_ID=<folder_ID>
      export YC_API_KEY=<API_key>
      ```

  1. Run the file you created:

      ```bash
      python dialogue.py
      ```

     {% cut "Response fragment" %}
     
     ```text
     assistant: The weather forecast for Serpukhov this weekend is as follows:
     
     - **Saturday, January 31**:
       - Night: -9°C, feels like -15°C
       - Morning: -10°C, feels like -17°C
       - Day: -5°C, feels like -10°C
       - Evening: -7°C, feels like -13°C
     
     - **Sunday, February 1**:
       - Night: -21°C, feels like -27°C
       - Morning: -21°C, feels like -27°C
       - Day: -19°C, feels like -25°C
       - Evening: -20°C, feels like -26°C
     ```
     
     {% endcut %}

{% endlist %}

{% note info %}

Currently, you cannot edit elements or reset a conversation. To start a new conversation, create a new `conversation` object.

{% endnote %}

## Managing context by chaining responses {#previous-response}

The `previous_response_id` parameter allows you to chain responses together and start a conversation from a certain point.

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `dialogue.py` and add the following code to it:

     ```py
     import openai     

     YC_MODEL = "yandexgpt"
     
     previous_id = None  # parameter for saving the ID of the assistant's last response
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         project=YC_FOLDER_ID,
         base_url="https://ai.{{ api-host }}/v1",
     )
     
     print("Chat with agent (to exit, type 'exit')\n")
     
     while True:
         user_input = input("You: ")
         if user_input.lower() in ("exit", "quit"):
             print("Chat session ended.")
             break
     
         response = client.responses.create(
             model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
             input=user_input,
             instructions="You are a text agent that engages in a conversation with the user and provides meaningful responses to their questions.",
             previous_response_id=previous_id  # providing context, if any
         )
     
         # saving the ID for the next step
         previous_id = response.id
     
         # outputting the agent's response
         print("Agent:", response.output_text)
     ```

  1. Save authentication data to environment variables:

      ```bash
      export YC_FOLDER_ID=<folder_ID>
      export YC_API_KEY=<API_key>
      ```

  1. Run the file you created:

      ```bash
      python dialogue.py
      ```

     This opens a chat where you can talk to the agent in real time while maintaining context.

     {% cut "Conversation example" %}

     ```text     
     Chat with agent (to exit, type 'exit')
     
     You: Hi! Remember: my cat's name is Muffin, she’ll be one year old this month.
     Agent: Hi! Okay, I've got it: your cat's name is Muffin, and she'll be one year old this month. If you have any other questions or need help, let me know!
     You: How old is Muffin?
     Agent: Muffin will turn one year old this month.
     ```
     
     {% endcut %}

{% endlist %}

## Manually managing conversation state {#manual}

For maximum control over the conversation state, you can store the history in the application and explicitly provide the required messages as `input` with each Responses API request. This is especially useful when you need to flexibly clean up or compress context or edit the history you provide.

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `dialogue.py` and add the following code to it:

     ```py
     import openai     

     YC_MODEL = "yandexgpt"
     
     client = openai.OpenAI(
         api_key=YC_API_KEY,
         base_url="https://ai.{{ api-host }}/v1",
         project=YC_FOLDER_ID,
     )
     
     response = client.responses.create(
         model=f"gpt://{YC_FOLDER_ID}/{YC_MODEL}",
         input=[
             {"role": "user", "content": "Hi! Help me choose a gift for myself."},
             {"role": "assistant", "content": "Hi! Tell me about yourself"},
             {"role": "user", "content": "My name is George."},
             {"role": "user", "content": "I love to travel."},
             {"role": "user", "content": "I'm into anime and design."},
         ],
     )
     
     print(response.output_text)
     ```

  1. Save authentication data into environment variables:

      ```bash
      export YC_FOLDER_ID=<folder_ID>
      export YC_API_KEY=<API_key>
      ```

  1. Run the file you created:

      ```bash
      python dialogue.py
      ```

      {% cut "Response example:" %}
      
      ```text
      Here are some gift ideas you might like:
      
      1. **Travel accessories.** For example, a high-quality backpack or carry-on bag, a compact hygiene kit, or a universal adapter for different power outlets.
      
      2. **Books on design.** You can choose both classic design theory texts and contemporary books with examples and advice from leading designers.
      
      3. **Anime figures and merchandise.** If you're a fan of a particular anime, look for figurines, posters, clothing, and various other items featuring symbols from your favorite show.
      
      4. **Graphics tablet.** If you're interested in design and want to develop your skills, a graphics tablet can be a useful tool for drawing and creating digital illustrations.
      
      5. **Camera or accessories for it.** If you enjoy taking photos while traveling, you might consider getting a camera, extra lens, or other helpful photography gear.
      
      6. **Courses.** Whether it's design, photography, animation, or something else entirely, courses are a great way to boost skills and learn something new.
      
      7. **Subscribtion to anime streaming services.** Enjoy your favorite anime shows in high quality and ad-free.
      
      I hope this helps you find a gift you’ll enjoy!
      ```
      
      {% endcut %}

{% endlist %}