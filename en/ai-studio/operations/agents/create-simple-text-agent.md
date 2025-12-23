---
title: Creating a simple text agent in {{ foundation-models-full-name }}
description: Follow this guide to create a simple text agent using the {{ responses-api }} in {{ foundation-models-full-name }}.
---

# Creating a simple text agent

In {{ foundation-models-full-name }}, you can create a text [agent](../../concepts/agents/index.md) that can communicate with the user in text format and maintain a dialogue closely resembling natural human interaction.

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

      YANDEX_CLOUD_MODEL = "yandexgpt"

      client = openai.OpenAI(
          api_key=YANDEX_CLOUD_API_KEY,
          base_url="https://rest-assistant.{{ api-host }}/v1",
          project=YANDEX_CLOUD_FOLDER
      )

      response = client.responses.create(
          prompt={
              "id": "........",
              "variables": {
                  "city": "Chita",
                  "friends_number": "0"
              }
          },
          input="Where should I go for a night out? Where can I smell Ledum?",
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
      You can have a great evening in Chita, and here are some ideas:

      **1. Where to go out in the evening:**
      - **Ostrog art factory**: A modern cultural space that is home to exhibitions, workshops, concerts, and – in summer – frequent themed parties.
      - **Irkutskaya Street** and **Downtown Chita**: Stroll along the pedestrian section of Leningradskaya Street, where you will find cozy cafes and bars (e.g., Kruzhka, Sibirskiy Broi, Craft Pub, and Mamina komnata Sushi) and a vibrant urban atmosphere.
      - **Chita River Embankment**: A peaceful spot for an evening walk with scenic views.
      - **Restaurants with a view**: Try dining on the top floor of Kristall Plaza or at Bely Medved: both offer beautiful city views and a pleasant ambiance.

      ---

      **2. Where to smell Ledum:**
      - Chita Botanical Garden at the Far Eastern Branch of the Russian Academy of Sciences (100 Zhuravlyova Street), is home to Rhododendron dauricum (commonly called Ledum, or bagulnik in Russian). It blooms from late May to early June. Contact the garden's administration for up-to-date information.
      - City outskirts: Ledum blooms in suburban forests, especially around Arakhley and the lakes in Chita District (e.g., near Lake Tatkholey). Consider a day trip by car or join a guided excursion.
      - Eastern and Central Ranges near Chita: From May onward, entire hillsides bloom with fragrant Ledum, perfect for photography and immersive nature experiences.

      **Important:** When enjoying the scent of Ledum, please do not break branches or pick flowers, since it's a rare and ecologically valuable plant in the region!

      If you are interested in finding specific Ledum-related excursions or booking evening venues, let me know your preferences, and I will help you plan!
      ```

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/generation/index.md)