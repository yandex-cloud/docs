---
title: Создать текстового агента с вызовом функции в {{ foundation-models-full-name }}
description: Следуя этой инструкции, вы сможете создать простого текстового агента с помощью Responses API в {{ foundation-models-full-name }}.
---

# Создать простого текстового агента с вызовом функции

В {{ foundation-models-full-name }} вы можете создать текстового [агента](../../concepts/agents/index.md) с вызовом функции, способного взаимодействовать с пользователем в текстовом формате и поддерживать диалог, близкий к естественному человеческому общению.

## Перед началом работы {#before-begin}

Чтобы воспользоваться примером:

{% list tabs group=programming_language %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Реализуйте чат {#develop-chat}

{% list tabs group=programming_language %}

- Python {#python}

  1. Создайте файл `index.py` и добавьте в него код:

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

      # 1. Определение списка функций, которые модель может вызывать
      tools = [
          {
              "type": "function",
              "name": "get_weather",
              "description": "Получить текущую погоду для указанного города.",
              "parameters": {
                  "type": "object",
                  "properties": {
                      "city": {
                          "type": "string",
                          "description": "Название города, например: Петербург или Москва",
                      },
                  },
                  "required": ["city"],
              },
          },
      ]

      # Простейшая реализация функции (можно заменить на вызов реального API)
      def get_weather(city):
          # Здесь можно реализовать интеграцию, например, с Яндекс Погодой
          return {
              "город": city,
              "температура": "12 °C",
              "состояние": "Облачно, лёгкий ветер"
          }

      # Формирование списка сообщений, который будет пополняться
      input_list = [
          {"role": "user", "content": "Какая погода в Красноярске?"}
      ]

      # 2. Запрос модели с определенными функциями
      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          tools=tools,
          input=input_list,
      )

      # Добавление ввода модели в историю
      input_list += response.output

      for item in response.output:
          if item.type == "function_call":
              if item.name == "get_weather":
                  # 3. Выполнение функции get_weather
                  weather_info = get_weather(**json.loads(item.arguments))

                  # 4. Передача результата функции обратно модели
                  input_list.append({
                      "type": "function_call_output",
                      "call_id": item.call_id,
                      "output": json.dumps(weather_info)
                  })

      print("Финальный ввод:")
      for item in input_list:
          if isinstance(item, dict) and item.get("type") == "function_call_output":
              parsed = json.loads(item["output"])
              print("function_call_output:", parsed)
          else:
              print(item)

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          instructions="Отвечай только данными о погоде, которые вернула функция.",
          tools=tools,
          input=input_list,
      )

      # 5. Финальный ответ
      print("Финальный вывод:")
      print(response.model_dump_json(indent=2))
      print("\n" + response.output_text)
      ```

  1. Сохраните данные для аутентификации в переменные окружения:

      ```bash
      export YANDEX_CLOUD_FOLDER=<идентификатор_каталога>
      export YANDEX_CLOUD_API_KEY=<API-ключ>
      ```

  1. Выполните созданный файл:

      ```bash
      python index.py
      ```

      Пример ответа:

      ```text
      Финальный ввод:
      {'role': 'user', 'content': 'Какая погода в Красноярске?'}
      ResponseFunctionToolCall(arguments='{"city":"Красноярск"}', call_id='get_weather', name='get_weather', type='function_call', id='get_weather', status='completed', valid=True)
      function_call_output: {'город': 'Красноярск', 'температура': '12 °C', 'состояние': 'Облачно, лёгкий ветер'}
      Финальный вывод:
      {
        "id": "70d96fac-1c4b-4f4a-9f80-56df********",
        "created_at": 1758556157206.0,
        "error": null,
        "incomplete_details": null,
        "instructions": "Отвечай только данными о погоде, которые вернула функция.",
        "metadata": null,
        "model": "gpt://b1gstllj8rgs********/yandexgpt",
        "object": "response",
        "output": [
          {
            "id": "f15c66e8-99a2-4647-a820-406e********",
            "content": [
              {
                "annotations": [],
                "text": "В Красноярске сейчас 12 °C, облачно, легкий ветер.",
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
                  "description": "Название города, например: Петербург или Москва"
                }
              },
              "required": [
                "city"
              ]
            },
            "strict": null,
            "type": "function",
            "description": "Получить текущую погоду для указанного города.",
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

      В Красноярске сейчас 12 °C, облачно, легкий ветер.
      ```

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/generation/index.md)