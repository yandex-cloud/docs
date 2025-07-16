# Совместимость с {{ openai }}

API сервиса {{ foundation-models-name }} частично совместим с {{ openai }} API. Вы можете быстро адаптировать существующие приложения, разработанные для работы с {{ openai }}, изменив несколько параметров в запросе.

Для доступа ко всем возможностям {{ foundation-models-name }} используйте API и библиотеку [{{ ml-sdk-full-name }}](../sdk/index.md).

## Настройка {{ openai }} для работы с {{ foundation-models-name }} {#before-begin}

Чтобы использовать [модели генерации текста](./yandexgpt/models.md) {{ foundation-models-name }} в библиотеках {{ openai }}, измените базовый эндпоинт и укажите [API-ключ](../operations/get-api-key.md).

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai

  client = openai.OpenAI(
      api_key="<значение_API-ключа>",
      base_url="https://{{ api-host-llm }}/v1"
  )
  ```

- Node.js {#node}

  ```js
  import OpenAI from "openai";

  const openai = new OpenAI({
    apiKey:"<значение_API-ключа>",
    baseURL:"https://{{ api-host-llm }}/v1"});
  ```

{% endlist %}

[Как получить API-ключ](../operations/get-api-key.md) для работы с {{ foundation-models-name }}. 

## Примеры использования {#example}

Прежде чем отправлять запрос, в URI модели укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы получали API-ключ.

### Генерация текста {#text-generation}

В режиме совместимости с {{ openai }} API поддерживаются параметры `temperature`, `max_tokens`, `stream`, `response_format`.

{% list tabs group=programming_language %}

- Python {#python}

  * Потоковая обработка ответа:
  
    ```python
    # Установите OpenAI SDK с помощью pip
    # pip install openai 
    import openai
    
    YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
    YANDEX_CLOUD_API_KEY = "<значение_API-ключа>"

    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://{{ api-host-llm }}/v1"
    )

    response = client.chat.completions.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/latest",
        messages=[
            {"role": "system", "content": "Ты очень умный ассистент."},
            {"role": "user", "content": "Что умеют большие языковые модели?"}
        ],
        max_tokens=2000,
        temperature=0.3,
        stream=True
    )

    for chunk in response:
        if chunk.choices[0].delta.content is not None:
            print(chunk.choices[0].delta.content, end="")
    ```

  * Структурированный ответ:
    
    ```python
    import openai

    YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
    YANDEX_CLOUD_API_KEY = "<значение_API-ключа>"

    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://{{ api-host-llm }}/v1"
    )

    json_schema = {
        "type": "object",
        "properties": {
            "skyscraper_name": {"type": "string", "description": "Название небоскрёба."},
            "skyscraper_height": {"type": "integer", "description": "Высота небоскрёба в метрах."},
        },
        "required": ["skyscraper_name", "skyscraper_height"]
    }

    response = client.chat.completions.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/rc",
        messages=[
            {"role": "user", "content": "Шанхайская башня (Шанхай, Китай) — 632 метра, 127 этажей.}
        ],
        max_tokens=200,
        temperature=0.3,
        stream=False,
        response_format={"type": "json_schema", "json_schema": json_schema}}
    )
    print(response)
    ```

- Node.js {#node}

  ```js
  import OpenAI from "openai";

  const openai = new OpenAI({
    apiKey:"<значение_API-ключа>",
    baseURL:"https://{{ api-host-llm }}/v1"});

  async function main() {
    const completion = await openai.chat.completions.create({
      messages: [{"role": "system", "content": "Ты очень умный ассистент."},
        {"role": "user", "content": "Что умеют большие языковые модели?"}],
      model: "gpt://<идентификатор_каталога>/yandexgpt/latest",
    });

  console.log(completion.choices[0]);
  }
  main();
  ```

- cURL {#curl}

  ```bash
  curl https://{{ api-host-llm }}/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <API-ключ>" \
    -d '{
      "model": "gpt://<идентификатор_каталога>/yandexgpt/latest",
      "messages": [
        {
          "role": "system",
          "content": "Ты очень умный ассистент."
        },
        {
          "role": "user",
          "content": "Что умеют большие языковые модели?"
        }
      ]
    }'
  ```

{% endlist %}

### Вызов функций {#function-call}

Перед запуском примера укажите идентификатор каталога и [API-ключ](../operations/get-api-key.md) {{ yandex-cloud }}. Поддерживается параметр `tool_choice` со значениями `auto` и `none`.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import json

  YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
  YANDEX_CLOUD_API_KEY = "<значение_API-ключа>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )

  # Функция Погода
  def get_current_weather(location):
      return {"location": location, "temperature": -22, "weather_condition": "Солнечно"}

  # Функция Калькулятор
  def calculator(a, b):
      return a + b

  def run_conversation(user_input):
      selected_model = f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/rc"

      # Задание функций
      tools = [
          {
              "type": "function",
              "function": {
                  "name": "get_weather",
                  "description": "Получение текущей погоды для указанного местоположения",
                  "parameters": {
                      "type": "object",
                      "properties": {
                          "location": {
                              "type": "string",
                              "description": "Местоположение"
                          }
                      },
                      "required": ["location"]
                  }
              }
          },
          {
              "type": "function",
              "function": {
                  "name": "calculator",
                  "description": "Сложить два числа",
                  "parameters": {
                      "type": "object",
                      "properties": {
                          "a": {
                              "type": "int",
                              "description": "Первое число"
                          },
                          "b": {
                              "type": "int",
                              "description": "Второе число"
                          }
                      },
                      "required": ["a", "b"]
                  }
              }
          }
      ]

      # Выполнение запроса
      response = client.chat.completions.create(
          model=selected_model,
          messages=[
              {"role": "user", "content": user_input}
          ],
          tool_choice="auto",
          tools=tools
      )

      # Ответ модели
      message = response.choices[0].message
      print(message)

      # Вызов запрошенных моделью функций
      if message.tool_calls:
          # Массив сообщений для отправки результатов выполнения
          new_messages = [
              {"role": "user", "content": user_input},
              message
          ]

          # Заполнение результата для каждой вызванной функции
          for tool_call in message.tool_calls:

              function_name = tool_call.function.name
              function_args = json.loads(tool_call.function.arguments)

              if function_name == "get_weather":
                  function_response = get_current_weather(function_args.get("get_current_weather"))
                  new_messages.append({
                      "role": "tool",
                      "tool_call_id": tool_call.id,
                      "content": json.dumps(function_response)
                  })

              if function_name == "calculator":
                  function_response = calculator(function_args.get("a"), function_args.get("b"))
                  new_messages.append({
                      "role": "tool",
                      "tool_call_id": tool_call.id,
                      "content": json.dumps(function_response)
                  })

          second_response = client.chat.completions.create(
              model=selected_model,
              messages=new_messages,
              tools=tools
          )

          # Ответ модели с учетом вызова функций
          return second_response.choices[0].message.content

      # Функции не был вызваны, возвращаем исходный ответ
      return message.content


  if __name__ == "__main__":
      result = run_conversation("2+2 и погода в москве")
      print(result)
  ```

{% endlist %}

### Эмбеддинги {#embeddings}

Поддерживаются эмбеддинги для одиночных строк с параметром `encoding_format` в значении `float`.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import numpy as np
  from scipy.spatial.distance import cdist

  YANDEX_CLOUD_FOLDER = "<идентификатор_каталога>"
  YANDEX_CLOUD_API_KEY = "<значение_API-ключа>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )

  # Метод для получения произвольного эмбеддинга
  def get_embedding(text, model):
      # Убираем лишние переносы
      fixed_text = get_trimmed_text(text)
      return (
          (
              client.embeddings.create(
                  input=fixed_text,
                  model=model,
                  encoding_format="float",
              )
          )
          .data[0]
          .embedding
      )

  # Метод для получения эмбеддингов документа
  def get_doc_embeddings(texts):
      doc_embeddings = []
      for text in texts:
          embedding = get_embedding(text, model=f"emb://{YANDEX_CLOUD_FOLDER}/text-search-doc/latest")
          doc_embeddings.append(embedding)
      return doc_embeddings

  # Метод для получения эмбеддинга запроса
  def get_query_embedding(text):
      embedding = get_embedding(text, model=f"emb://{YANDEX_CLOUD_FOLDER}/text-search-query/latest")
      return np.array(embedding)

  # Вспомогательный метод для удаления переносов строк
  def get_trimmed_text(text):
      return ' '.join(text.split())

  def main():
      # Документ для поиска в виде массива текстов
      doc_texts = [
          """Александр Сергеевич Пушкин (26 мая [6 июня] 1799, Москва — 29 января [10 февраля] 1837, Санкт-Петербург)
          — русский поэт, драматург и прозаик, заложивший основы русского реалистического направления,
          литературный критик и теоретик литературы, историк, публицист, журналист.""",
          """Пушкин неоднократно писал о своей родословной в стихах и прозе; он видел в своих предках образец истинной
          «аристократии», древнего рода, честно служившего отечеству, но не снискавшего благосклонности правителей и
          «гонимого». Не раз он обращался (в том числе в художественной форме) и к образу своего прадеда по матери —
          африканца Абрама Петровича Ганнибала, ставшего слугой и воспитанником Петра I, а потом военным инженером и
          генералом""",
      ]

      # Текст поискового запроса
      query_text = "когда день рождения Пушкина?"

      # Получение эмбеддингов документа
      doc_embedding = get_doc_embeddings(doc_texts)
      # Получение эмбеддинга запроса
      query_embedding = get_query_embedding(query_text)
      # Вычисление косинусного расстояния
      cosine_distance = cdist([query_embedding], doc_embedding, metric="cosine")
      # Вычисление схожести
      cosine_similarity = 1 - cosine_distance
      # Вычисление индекса наиболее подходящего текста
      argmax = np.argmax(cosine_similarity)
      # Получение текста по индексу
      result = doc_texts[argmax]

      print(get_trimmed_text(result))


  if __name__ == "__main__":
      main()
  ```

{% endlist %}

### Модели {#models}

Поддерживается метод для получения списка доступных моделей:

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai

  YANDEX_CLOUD_API_KEY = "<значение_API-ключа>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )
  models = client.models.list()
  print(models.data)
  ```

{% endlist %}

## Текущие ограничения {#restrictions}

Сервис {{ foundation-models-name }} частично совместим с {{ openai }} API. Если вы еще не используете {{ openai }} SDK, рекомендуем сразу разрабатывать свои приложения на [{{ ml-sdk-full-name }}](../sdk/index.md) или для API {{ foundation-models-name }}.
