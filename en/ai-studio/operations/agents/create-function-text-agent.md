---
title: Creating a text agent with a function call in {{ foundation-models-full-name }}
description: Follow this guide to create a simple text agent using the {{ responses-api }} in {{ foundation-models-full-name }}.
---

# Creating a simple text agent with a function call

In {{ foundation-models-full-name }}, you can create a text [agent](../../concepts/agents/index.md) with a function call that can communicate with the user in text format and maintain a dialogue closely resembling natural human interaction.

## Getting started {#before-begin}

To use an example:

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

## Build a chat {#develop-chat}

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and add the following code to it:

      ```python
      import openai
      from openai import OpenAI
      import json

      YANDEX_CLOUD_MODEL = "yandexgpt"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project=YANDEX_CLOUD_FOLDER
      )

      # 1. Listing the functions the model can call
      tools = [
          {
              "type": "function",
              "name": "get_weather",
              "description": "Getting current weather for the city you specify.",
              "parameters": {
                  "type": "object",
                  "properties": {
                      "city": {
                          "type": "string",
                          "description": "City, e.g., Petersburg or Moscow",
                      },
                  },
                  "required": ["city"],
              },
          },
      ]

      # The simplest implementation of the function (can be replaced with a call to a real API)
      def get_weather(city):
          # Here you can implement an integration, e.g., with Yandex Weather
          return {
              "city": city,
              "temperature": "12 °C",
              "condition": "Cloudy, light breeze"
          }

      # Forming a list of messages to be updated
      input_list = [
          {"role": "user", "content": "What is the weather like in Krasnoyarsk?"}
      ]

      # 2. Requesting a model with specific features
      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          tools=tools,
          input=input_list,
      )

      # Adding the model's input to history
      input_list += response.output

      for item in response.output:
          if item.type == "function_call":
              if item.name == "get_weather":
                  # 3. Executing the get_weather function
                  weather_info = get_weather(**json.loads(item.arguments))

                  # 4. Providing the result of the function back to the model
                  input_list.append({
                      "type": "function_call_output",
                      "call_id": item.call_id,
                      "output": json.dumps(weather_info)
                  })

      print("Final input:")
      for item in input_list:
          if isinstance(item, dict) and item.get("type") == "function_call_output":
              parsed = json.loads(item["output"])
              print("function_call_output:", parsed)
          else:
              print(item)

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          instructions="Respond only with the weather data returned by the function.",
          tools=tools,
          input=input_list,
      )

      # 5. Final response
      print("Final output:")
      print(response.model_dump_json(indent=2))
      print("\n" + response.output_text)
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
      Final input:
      {'role': 'user', 'content': 'What is the weather like in Krasnoyarsk?'}
      ResponseFunctionToolCall(arguments='{"city":"Krasnoyarsk"}', call_id='get_weather', name='get_weather', type='function_call', id='get_weather', status='completed', valid=True)
      function_call_output: {'city': 'Krasnoyarsk', 'temperature': '12 °C', 'condition': 'Cloudy, light breeze'}
      Final output:
      {
        "id": "70d96fac-1c4b-4f4a-9f80-56df********",
        "created_at": 1758556157206.0,
        "error": null,
        "incomplete_details": null,
        "instructions": "Respond only with the weather data returned by the function.",
        "metadata": null,
        "model": "gpt://b1gstllj8rgs********/yandexgpt",
        "object": "response",
        "output": [
          {
            "id": "f15c66e8-99a2-4647-a820-406e********",
            "content": [
              {
                "annotations": [],
                "text": "It is currently plus 12°C in Krasnoyarsk, cloudy, light breeze.",
                "type": "output_text",
                "logprobs": null,
                "valid": true
              }
            ],
            "role": "assistant",
            "status": "completed",
            "type": "message",
            "valid": true
          }
        ],
        "parallel_tool_calls": true,
        "temperature": null,
        "tool_choice": "auto",
        "tools": [
          {
            "name": "get_weather",
            "parameters": {
              "type": "object",
              "properties": {
                "city": {
                  "type": "string",
                  "description": "City, e.g., Petersburg or Moscow"
                }
              },
              "required": [
                "city"
              ]
            },
            "strict": null,
            "type": "function",
            "description": "Getting current weather for the city you specify.",
            "valid": true
          }
        ],
        "top_p": null,
        "background": false,
        "conversation": null,
        "max_output_tokens": null,
        "max_tool_calls": null,
        "previous_response_id": null,
        "prompt": null,
        "prompt_cache_key": null,
        "reasoning": null,
        "safety_identifier": null,
        "service_tier": null,
        "status": "completed",
        "text": null,
        "top_logprobs": null,
        "truncation": null,
        "usage": null,
        "user": "",
        "valid": true
      }

      It is currently plus 12°C in Krasnoyarsk, cloudy, light breeze.
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/generation/index.md)