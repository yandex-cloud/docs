# Совместимость с {{ openai }}

API генерации текста сервиса {{ foundation-models-name }} частично совместим с {{ openai }} API. Вы можете быстро адаптировать существующие приложения, разработанные для работы с {{ openai }}, изменив несколько параметров в запросе.

Для доступа ко всем возможностям {{ foundation-models-name }} используйте API и библиотеку [{{ ml-sdk-full-name }}](../sdk/index.md).

## Настройка {{ openai }} для работы с {{ foundation-models-name }} {#before-begin}

Чтобы использовать [модели генерации текста](./yandexgpt/models.md) {{ foundation-models-name }} в библиотеках {{ openai }}, измените базовый эндпоинт и укажите [API-ключ](../operations/get-api-key.md):

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai

  client = openai.OpenAI(
      api_key="<значение_API-ключа>",
      base_url="{{ api-host-llm }}/v1"
  )
  ```

- Node.js {#node}

  ```js
  import OpenAI from "openai";

  const openai = new OpenAI({
    apiKey:"<значение_API-ключа>",
    baseURL:"{{ api-host-llm }}/v1"});
  ```

{% endlist %}

[Как получить API-ключ](../operations/get-api-key.md) для работы с {{ foundation-models-name }}. 

## Пример запроса к модели {#example}

Прежде чем отправлять запрос, в URI модели укажите [идентификатор каталога](../../resource-manager/operations/folder/get-id.md), в котором вы получали API-ключ.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  # Установите OpenAI SDK с помощью pip
  # pip install openai 
  import openai

  client = openai.OpenAI(
      api_key="<значение_API-ключа>",
      base_url="{{ api-host-llm }}/v1"
  )

  response = client.chat.completions.create(
      model="gpt://<идентификатор_каталога>/yandexgpt/latest",
      messages=[
          {"role": "assistant", "content": "Ты очень умный ассистент."},
          {"role": "user", "content": "Сколько стоит запрос к {{ gpt-pro }}?"}
      ],
      max_tokens=10000,
      temperature=0.7,
      stream=True
  )

  for chunk in response:
      if chunk.choices[0].delta.content is not None:
          print(chunk.choices[0].delta.content, end="")
  ```

- Node.js {#node}

  ```js
  import OpenAI from "openai";

  const openai = new OpenAI({
    apiKey:"<значение_API-ключа>",
    baseURL:"{{ api-host-llm }}/v1"});

  async function main() {
    const completion = await openai.chat.completions.create({
      messages: [{"role": "assistant", "content": "Ты очень умный ассистент."},
        {"role": "user", "content": "Сколько стоит запрос к {{ gpt-pro }}?"}],
      model: "gpt://<идентификатор_каталога>/yandexgpt/latest",
    });

  console.log(completion.choices[0]);
  }
  main();
  ```

- cURL {#curl}

  ```bash
  curl {{ api-host-llm }}/v1/chat/completions \
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
          "content": "Сколько стоит запрос к {{ gpt-pro }}?"
        }
      ]
    }'
  ```

{% endlist %}


## Текущие ограничения {#restrictions}

Сервис {{ foundation-models-name }} частично совместим с {{ openai }} API. Если вы еще не используете {{ openai }} SDK, рекомендуем сразу разрабатывать свои приложения на [{{ ml-sdk-full-name }}](../sdk/index.md) или для API {{ foundation-models-name }}.
