# Creating a text agent with web search

In {{ foundation-models-full-name }}, you can create a text [agent](../../concepts/agents/index.md) that will access [information from the internet](../../concepts/agents/tools/filesearch.md) to generate a response.

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- Python {#python}

  {% include [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Create an agent {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and add the following code to it:

     ```python
     import openai
     import json
 
     YANDEX_CLOUD_FOLDER = "..."
     YANDEX_CLOUD_API_KEY = "..."
     YANDEX_CLOUD_MODEL = "yandexgpt"
 
     client = openai.OpenAI(
         api_key=YANDEX_CLOUD_API_KEY,
         base_url="https://rest-assistant.api.cloud.yandex.net/v1",
         project=YANDEX_CLOUD_FOLDER
     )
 
     response = client.responses.create(
         model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
         input="Give me a quick overview of LLM news for September 2025.",
         tools=[
             {
                "type": "web_search",
                "filters": {
                    "allowed_domains": [
                        "habr.ru"
                    ]
                },
                "user_location": {
                        "region": "213",
                    }
             }
         ],
         temperature=0.3,
         max_output_tokens=1000
     )
 
     # Response text
     print("Response text:")
     print(response.output_text)
     print("\n" + "=" * 50 + "\n")
 
     # Full response
     print("Full response (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))xs
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

{% endlist %}
