# Compatibility with {{ openai }}

The {{ foundation-models-name }} API is partially compatible with the {{ openai }} API. You can quickly adapt your applications designed to work with {{ openai }} by changing a few parameters in the query.

Use the [{{ ml-sdk-full-name }}](../sdk/index.md) API and library to access all {{ foundation-models-name }} features.

## Configuring {{ openai }} to work with {{ foundation-models-name }} {#before-begin}

To use [text generation models](./yandexgpt/models.md) from {{ foundation-models-name }} in {{ openai }} libraries, change the basic endpoint and specify the [API key](../operations/get-api-key.md).

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

## Use cases {#example}

Before sending the query, in the model URI, specify the [ID of the folder](../../resource-manager/operations/folder/get-id.md) you got the API key in.

### Text generation {#text-generation}

In {{ openai }}-compatible mode, API supports the following parameters: `temperature`, `max_tokens`, `stream`, and `response_format`.

{% list tabs group=programming_language %}

- Python {#python}

  * Streaming response processing:
  
    ```python
    # Install OpenAI SDK using pip
    # pip install openai 
    import openai
    
    YANDEX_CLOUD_FOLDER = "<folder_ID>"
    YANDEX_CLOUD_API_KEY = "<API_key_value>"

    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://{{ api-host-llm }}/v1"
    )

    response = client.chat.completions.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/latest",
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

  * Structured response:
    
    ```python
    import openai

    YANDEX_CLOUD_FOLDER = "<folder_ID>"
    YANDEX_CLOUD_API_KEY = "<API_key_value>"

    client = openai.OpenAI(
        api_key=YANDEX_CLOUD_API_KEY,
        base_url="https://{{ api-host-llm }}/v1"
    )

    json_schema = {
        "type": "object",
        "properties": {
            "skyscraper_name": {"type": "string", "description": "Skyscraper name."},
            "skyscraper_height": {"type": "integer", "description": "Skyscraper height in meters."},
        },
        "required": ["skyscraper_name", "skyscraper_height"]
    }

    response = client.chat.completions.create(
        model=f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/rc",
        messages=[
            {"role": "user", "content": "Shanghai Tower (Shanghai, China): 632 meters, 127 floors."}
        ],
        max_tokens=200,
        temperature=0.3,
        stream=False,
        response_format={"type": "json_schema", "json_schema": json_schema}
    )
    print(response)
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

### Function calling {#function-call}

Before running the example, specify the folder ID and {{ yandex-cloud }} [API key](../operations/get-api-key.md). The `tool_choice` parameter with `auto` and `none` values is supported.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import json

  YANDEX_CLOUD_FOLDER = "<folder_ID>"
  YANDEX_CLOUD_API_KEY = "<API_key_value>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )

  # Weather function
  def get_current_weather(location):
      return {"location": location, "temperature": -22, "weather_condition": "Sunny"}

  # Calculator function
  def calculator(a, b):
      return a + b

  def run_conversation(user_input):
      selected_model = f"gpt://{YANDEX_CLOUD_FOLDER}/yandexgpt/rc"

      # Defining functions
      tools = [
          {
              "type": "function",
              "function": {
                  "name": "get_weather",
                  "description": "Getting current weather for the specified location",
                  "parameters": {
                      "type": "object",
                      "properties": {
                          "location": {
                              "type": "string",
                              "description": "Location"
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
                  "description": "Adding two numbers",
                  "parameters": {
                      "type": "object",
                      "properties": {
                          "a": {
                              "type": "int",
                              "description": "First number"
                          },
                          "b": {
                              "type": "int",
                              "description": "Second number"
                          }
                      },
                      "required": ["a", "b"]
                  }
              }
          }
      ]

      # Running a query
      response = client.chat.completions.create(
          model=selected_model,
          messages=[
              {"role": "user", "content": user_input}
          ],
          tool_choice="auto",
          tools=tools
      )

      # Model response
      message = response.choices[0].message
      print(message)

      # Calling model-requested functions
      if message.tool_calls:
          # Array of messages to send execution results
          new_messages = [
              {"role": "user", "content": user_input},
              message
          ]

          # Populating the result for each function call
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

          # Model response with information from function calls
          return second_response.choices[0].message.content

      # No functions were called, returning the original response
      return message.content


  if __name__ == "__main__":
      result = run_conversation("2+2 and weather in moscow")
      print(result)
  ```

{% endlist %}

### Embeddings {#embeddings}

Supported embeddings for single strings with the `encoding_format` parameter set to `float`.

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai
  import numpy as np
  from scipy.spatial.distance import cdist

  YANDEX_CLOUD_FOLDER = "<folder_ID>"
  YANDEX_CLOUD_API_KEY = "<API_key_value>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )

  # Method for getting a random embedding
  def get_embedding(text, model):
      # Removing excessive line breaks
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

  # Method for getting document embeddings
  def get_doc_embeddings(texts):
      doc_embeddings = []
      for text in texts:
          embedding = get_embedding(text, model=f"emb://{YANDEX_CLOUD_FOLDER}/text-search-doc/latest")
          doc_embeddings.append(embedding)
      return doc_embeddings

  # Method for getting query embeddings
  def get_query_embedding(text):
      embedding = get_embedding(text, model=f"emb://{YANDEX_CLOUD_FOLDER}/text-search-query/latest")
      return np.array(embedding)

  # Helper method for removing line breaks
  def get_trimmed_text(text):
      return ' '.join(text.split())

  def main():
      # Document for search as an array of texts
      doc_texts = [
          """Alexander Sergeyevich Pushkin (May 26 [June 6], 1799, Moscow – January 29 [February 10], 1837, St. Petersburg)
          was a Russian poet, playwright, and novelist, the progenitor of Russian realism,
          a literary critic and theorist, historian, essay writer, and journalist.""",
          """Pushkin repeatedly wrote about his ancestry in poems and prose, seeing in his ancestors an example of true
          aristocracy, an ancient lineage that faithfully served the fatherland yet never gained rulers' favor and was
          persecuted. He often referred to, also through literary forms, the image of his maternal great-grandfather
          of African origin, Abraham Petrovich Gannibal, who became a servant and ward of Peter I, later a military engineer and
          general""",
      ]

      # Search query text
      query_text = "when is Pushkin's birthday?"

      # Getting document embeddings
      doc_embedding = get_doc_embeddings(doc_texts)
      # Getting a query embedding
      query_embedding = get_query_embedding(query_text)
      # Calculating cosine distance
      cosine_distance = cdist([query_embedding], doc_embedding, metric="cosine")
      # Calculating similarity
      cosine_similarity = 1 - cosine_distance
      # Calculating the index of the most relevant text
      argmax = np.argmax(cosine_similarity)
      # Getting text by index
      result = doc_texts[argmax]

      print(get_trimmed_text(result))


  if __name__ == "__main__":
      main()
  ```

{% endlist %}

### Models {#models}

Supported method for getting a list of available models:

{% list tabs group=programming_language %}

- Python {#python}

  ```python
  import openai

  YANDEX_CLOUD_API_KEY = "<API_key_value>"

  client = openai.OpenAI(
      api_key=YANDEX_CLOUD_API_KEY,
      base_url="https://{{ api-host-llm }}/v1"
  )
  models = client.models.list()
  print(models.data)
  ```

{% endlist %}

## Current limitations {#restrictions}

{{ foundation-models-name }} is partially compatible with the {{ openai }} API. If not using the {{ openai }} SDK yet, we recommend you to build your apps with [{{ ml-sdk-full-name }}](../sdk/index.md) or the {{ foundation-models-name }} API right from the start.
