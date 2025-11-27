# Creating a text agent with file search

In {{ foundation-models-full-name }}, you can create a text [agent](../../concepts/agents/index.md) that will use [information](../../concepts/agents/tools/filesearch.md) from your files to generate a response.

## Getting started {#before-begin}

To use an example:

{% list tabs group=programming_language %}

- Python {#python}

  {% include [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Create the agent {#create-agent}

{% list tabs group=programming_language %}

- Python {#python}

  1. [Create a search index](./manage-searchindex.md#create-index).
  1. Create a file named `index.py` and add the following code to it:

     ```python
     import openai
     import json
     
     YANDEX_CLOUD_MODEL = "yandexgpt"

     client = openai.OpenAI(
         api_key=YANDEX_CLOUD_API_KEY,
         base_url="https://rest-assistant.api.cloud.yandex.net/v1",
         project=YANDEX_CLOUD_FOLDER
     )
     
     response = client.responses.create(
         model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
         instructions="You are a smart assistant. If you get a question about a vacation, search the index for information",
         tools=[{
             "type": "file_search",
             "vector_store_ids": [VECTOR_STORE_ID]
         }],
         input="Where to go for a vacation?"
     )
     
     # Response for the user
     print("Response text:")
     print(response.output_text)
     print("\n" + "=" * 50 + "\n")
     
     # Full response
     print("Full response (JSON):")
     print(json.dumps(response.model_dump(), indent=2, ensure_ascii=False))
     ```

  1. Save authentication data into environment variables:

      ```bash
      export YANDEX_CLOUD_FOLDER=<folder_ID>
      export YANDEX_CLOUD_API_KEY=<API_key>
      export VECTOR_STORE_ID=<search_index_ID>
      ```

  1. Run the file you created:

      ```bash
      python index.py
      ```

      {% cut "Example of a brief response" %}

      ```text
      Response text:
      You may consider two vacation options:
      
      1. **Bali**, a tropical paradise famous for its beautiful beaches, unique culture, and warm hospitality of its people. To visit the island, you need a visa, which you can apply for by submitting your foreign passport, photos, hotel booking confirmation, round-trip tickets, and a special form filled out in English.
      
      2. **Kazakhstan**, a fascinating country where East meets West. Enjoy its endless steppes, majestic mountains, and historical landmarks. To visit Kazakhstan from Russia, you need a foreign passport, migration card, and medical insurance, which is optional, but recommended.
      ```

      {% endcut %}

      {% cut "Example of a full response" %}

      ```json
      Full response (JSON):
      {
        "id": "b9516128-9eab-4bdc-902e-3228********",
        "created_at": 1762862921074.0,
        "error": null,
        "incomplete_details": null,
        "instructions": "You are a smart assistant. If you get a question about a vacation, search the index for information",
        "metadata": null,
        "model": "gpt://b1go3el0d8fs********/yandexgpt",
        "object": "response",
        "output": [
          {
            "id": "b82092d2-dfad-45e6-b5a6-39a7********",
            "queries": [
              "vacation"
            ],
            "status": "completed",
            "type": "file_search_call",
            "results": [
              {
                "attributes": {},
                "file_id": "fvt28d2vl3ep********",
                "filename": "bali.txt",
                "score": 0.5,
                "text": "**Bali is a tropical paradise full of unforgettable experiences.**\n\nWe invite you to spend an amazing vacation in Bali. This magical Indonesian island is famous for its beautiful beaches, unique culture, and warm hospitality of its people. Enjoy its natural beauty, try local cuisine, and make new friends. **What do I need for the trip?** To enter Indonesia, you will need a visa. Here is the list of documents you need to get a visa:\n* Passport valid for at least 6 months from your entry date. * Two photos meeting consulate requirements. * Hotel booking confirmation or a letter for alternative accommodation. * Round-trip booking or tickets. * Form filled out in English. Note that requirements may change, so be sure to check the current information on the consulate or visa center's website when planning your trip. The visa fee is 300 rubles. Don't miss out on the opportunity to visit this beautiful island for a vibrant vacation! Book your Bali vacation today! **We look forward to seeing you!**",
                "valid": true
              },
              {
                "attributes": {},
                "file_id": "fvtgngs87ueo********",
                "filename": "kazakhstan.txt",
                "score": 0.49999997,
                "text": "**Kazakhstan: Journey to the heart of Eurasia**\n\nDiscover Kazakhstan, a fascinating country where East meets West. Enjoy its endless steppes, majestic mountains, historical landmarks, and the warm hospitality of its people. **What do I need for the trip?** To enter Kazakhstan from Russia, you will need the following documents:\n* Passport valid for at least 3 months beyond your trip. * Migration card (issued in-flight or at the border). * Medical insurance (optional but recommended). Don't miss out on the opportunity to visit this beautiful country for a vibrant vacation! Book your Kazakhstan vacation today! **We look forward to seeing you!**",
                "valid": true
              }
            ],
            "valid": true
          },
          {
            "id": "c21d9c45-1c10-4dbb-af49-c0d7********",
            "content": [
              {
                "annotations": [
                  {
                    "file_id": "fvt28d2vl3ep********",
                    "filename": "bali.txt",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  },
                  {
                    "file_id": "fvtgngs87ueo********",
                    "filename": "kazakhstan.txt",
                    "index": 0,
                    "type": "file_citation",
                    "valid": true
                  }
                ],
                "text": "You may consider two vacation options:\n\n1. **Bali**, a tropical paradise famous for its beautiful beaches, unique culture, and warm hospitality of its people. To visit the island, you need a visa, which you can apply for by submitting your foreign passport, photos, hotel booking confirmation, round-trip tickets, and a special form filled out in English.\n\n2. **Kazakhstan**, a fascinating country where East meets West. Enjoy its endless steppes, majestic mountains, and historical landmarks. To visit Kazakhstan from Russia, you need a foreign passport, migration card, and medical insurance, which is optional, but recommended.",
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
            "type": "file_search",
            "vector_store_ids": [
              "fvtbstlb8tkr********"
            ],
            "filters": null,
            "max_num_results": null,
            "ranking_options": null,
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
        "usage": {
          "input_tokens": 0,
          "input_tokens_details": {
            "cached_tokens": 0,
            "valid": true
          },
          "output_tokens": 0,
          "output_tokens_details": {
            "reasoning_tokens": 0,
            "valid": true
          },
          "total_tokens": 0,
          "valid": true
        },
        "user": "",
        "valid": true
      }      
      ```

      {% endcut %}

{% endlist %}
