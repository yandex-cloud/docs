# Compatibility with {{ openai }}

The {{ foundation-models-name }} text generation API is partially compatible with the {{ openai }} API. You can quickly adapt your applications designed to work with {{ openai }} by changing a few parameters in the query.

Use the [{{ ml-sdk-full-name }}](../sdk/index.md) API and library to access all {{ foundation-models-name }} features.

## Configuring {{ openai }} to work with {{ foundation-models-name }} {#before-begin}

To use the {{ foundation-models-name }} [text generation models](./yandexgpt/models.md) in {{ openai }} libraries, change the basic endpoint and specify the [API key](../operations/get-api-key.md):

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai

  client = openai.OpenAI(
      api_key="<API_key_value>",
      base_url="https://{{ api-host-llm }}/v1"
  )
  ```

- Node.js {#node}

  ```js
  import OpenAI from "openai";

  const openai = new OpenAI({
    apiKey:"<API_key_value>",
    baseURL:"https://{{ api-host-llm }}/v1"});
  ```

{% endlist %}

[How to get an API key](../operations/get-api-key.md) for {{ foundation-models-name }}. 

## Example of a query to a model {#example}

Before sending the query, in the model URI, specify the [ID of the folder](../../resource-manager/operations/folder/get-id.md) you got the API key in.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  # Install OpenAI SDK using pip
  # pip install openai 
  import openai

  client = openai.OpenAI(
      api_key="<API_key_value>",
      base_url="https://{{ api-host-llm }}/v1"
  )

  response = client.chat.completions.create(
      model="gpt://<folder_ID>/yandexgpt/latest",
      messages=[
          {"role": "system", "content": "You are a very smart assistant."},
          {"role": "user", "content": "What can large language models do?"}
      ],
      max_tokens=2000,
      temperature=0.3,
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
    apiKey:"<API_key_value>",
    baseURL:"https://{{ api-host-llm }}/v1"});

  async function main() {
    const completion = await openai.chat.completions.create({
      messages: [{"role": "system", "content": "You are a very smart assistant."},
        {"role": "user", "content": "What can large language models do?"}],
      model: "gpt://<folder_ID>/yandexgpt/latest",
    });

  console.log(completion.choices[0]);
  }
  main();
  ```

- cURL {#curl}

  ```bash
  curl https://{{ api-host-llm }}/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <API_key>" \
    -d '{
      "model": "gpt://<folder_ID>/yandexgpt/latest",
      "messages": [
        {
          "role": "system",
          "content": "You are a very smart assistant."
        },
        {
          "role": "user",
          "content": "What can large language models do?"
        }
      ]
    }'
  ```

{% endlist %}


## Current limitations {#restrictions}

{{ foundation-models-name }} is partially compatible with the {{ openai }} API. If not using the {{ openai }} SDK yet, we recommend you to build your apps with [{{ ml-sdk-full-name }}](../sdk/index.md) or the {{ foundation-models-name }} API right from the start.
