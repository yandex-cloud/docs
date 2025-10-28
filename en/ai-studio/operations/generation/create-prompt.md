---
title: How to send a request to a model in {{ foundation-models-full-name }}
description: Follow this guide to learn how to use the {{ responses-api }} in {{ foundation-models-full-name }} to send a request to {{ gpt-lite }}.
---

# Sending a request in prompt mode

## Getting started {#before-begin}

{% list tabs group=programming_language %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/ai-studio/yandexgpt/ai-before-beginning.md) %}

{% endlist %}


## Send a request to the model {#request}

{% list tabs group=programming_language %}

- Python {#python}

  1. Create a file named `index.py` and add the following code to it:

      ```python
      import openai

      YANDEX_CLOUD_MODEL = "yandexgpt-lite"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project= YANDEX_CLOUD_FOLDER
      )

      response = client.responses.create(
          model=f"gpt://{YANDEX_CLOUD_FOLDER}/{YANDEX_CLOUD_MODEL}",
          input="Come up with three off-beat ideas for a travel startup.",
          temperature=0.8,
          max_output_tokens=1500
      )

      print(response.output[0].content[0].text)
      ```

  1. Save authentication data to environment variables:

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
      1. **Travel search and management platform with astrology factored in.** The service will help travelers choose a destination, trip dates, and activities based on their astrological sign or individual natal chart. This may include recommendations on the best periods for traveling, places that are in tune with your sign's energy, and the choice of cultural and natural attractions that align with your astrological preferences.

      2. **Virtual travel guide with augmented reality features.** This is an app or service allowing users to "come across" a virtual guide wherever they are via augmented reality (AR). This guide can share facts if interest about the location, show hidden sightseeing attractions, and suggest routes for your hikes. The user can ask questions and get answers in real time with the AR technology responsible for visualization.

      3. **AI-based travel management service.** A platform that relies on AI algorithms to personalize your travels. AI can analyze the user’s preferences, budget, season, etc., and propose optimized routes, including flights, transfers, accommodations, and activities. The service can also propose alternatives if there is a change of schedule or other unforeseen events.
      ```

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/generation/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)
