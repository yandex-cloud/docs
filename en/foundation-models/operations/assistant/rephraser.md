# Creating an assistant for RAG with query rephrasing

In {{ assistant-api }}, you can enable an additional rephrasing model to make search index queries more accurate. Rephrasing will correct errors and typos and help you out if the response requires massive volumes of indexed data and heavily relies on the conversation context.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- SDK {#sdk}

  {% include [sdk-before-begin-assistants](../../../_includes/foundation-models/sdk-before-begin-assistants.md) %}

{% endlist %}

## Create an assistant {#create-assistant}

In this example, we are going to use the [tour information scenario](./create-with-searchindex.md) to show how to create an assistant with a search index and an active rephrasing model. 

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. {% include [download-context-file-step](../../../_includes/foundation-models/assistants/download-context-file-step.md) %}
  1. Create a file named `rephraser.py` and paste the following code into it providing the folder ID and authentication credentials:

     {% include [searchindex-assistant](../../../_includes/foundation-models/examples/rephraser-assistant-sdk.md) %}

     Where:
   
     * `<folder_ID>`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) the [service account](../../../iam/concepts/users/service-accounts.md) was created in.
     * `<API_key>`: Service account [API key](../../../iam/concepts/authorization/api-key.md) required for [authentication in the API](../../api-ref/authentication.md).
     
  1. Run the file you created:

      ```bash
      python3 rephraser.py
      ```

      {% cut "Result" %}

      ```text
      Question: Where to escape to?
      Answer without rephraser:
          'The question of "where to escape to?" may be interpreted differently depending on context. If considering a vacation or relocation, the choice of place may depend on your preferences, interests, and budget. Here are some ideas for you:\n\n1. **Nature spots:** If you are a nature lover, consider visiting national parks, nature reserves, or mountain resorts.\n\n2. **Historical cities:** If you are a history and culture geek, explore rich historical heritage sites like Rome, Paris, Istanbul, etc.\n\n3. **Beach getaways:** If you prefer a seaside vacation, consider beach resorts around the world in countries like Thailand, Spain, Greece, etc.\n\n4. **Creative hubs:** If you are a creative person, you might enjoy cities with a vibrant cultural life like New York, London, Berlin, etc.\n\n5. **Exotic destinations:** If looking for something offbeat and exotic, consider visiting countries with unique culture and nature such as India, Peru, Indonesia and the like.\n\nRemember that your "escape" destination depends on your personal interests and preferences. Before you make any travel or relocation decisions, it is a good idea to research the place, its culture, security, and other aspects.\n\nIf your question has a different context, please clarify it, and I will try to give a more specific answer.'
      
      Question: Wher to cuutt looooose?
      Answer without rephraser:
          'It looks like your question contains an error or a typo. Please rephrase it and I will try to help you.'
      
      Question: Where to go for a break?
      Answer without rephraser:
          'Consider a break in Bali. This Indonesian island is famous for its beautiful beaches, unique culture, and warm hospitality of its people. Enjoy its natural beauty, try local cuisine, and make new friends.'
      
      Question: Where to escape to?
      Answer without rephraser:
          'The question of "where to escape to?" can be answered differently depending on your goals and preferences. Here are some ideas for you:\n\n1. **Countryside destinations:** If looking for a break from the urban bustle, consider a country house, summer cottage, or campsite. It can be a great way to enjoy nature and fresh air.\n\n2. **Exploring Russia:** Russia is a large country with diverse regions, each with unique sights and natural landmarks. Explore historical cities like St. Petersburg or Kazan, or embark on a trip around the Golden Ring of Russia.\n\n3. **Traveling abroad:** If you are looking for something more exotic, consider an international destination. Choose a place resonating with your interests – be it a beach stay, mountain ski resort, or a cultural landmark.\n\n4. **Outdoor recreation:** If you enjoy outdoor activities, consider hiking, fishing, or a picnic in nature. It can be the perfect way to spend time in fresh air and enjoy the beauty of nature.\n\n5. **Spa retreat or resort:** For those looking for something peaceful and relaxing, a spa retreat or resort could be a great option. Here you can relax, improve your health, and enjoy spa treatment.\n\nRemember that the choice of destination depends on your personal preferences and goals. Before you make your decision, research the place to make sure it meets your expectations.

      Question: Where to escape to?
      Answer with rephraser:
          'Your question of "where to escape to?" may imply looking for a temporary retreat or a long-term relocation. The choice depends on your goals, interests, and resources. Here are some ideas for you:\n\n1. **Peaceful natural places:** If looking for solitude in nature, consider visiting national parks, nature reserves, or remote islands. It may prove a great place to unwind from the city bustle and recharge.\n\n2. **Historical cities:** If you are a history and culture geek, explore rich heritage sites like St. Petersburg, Prague, Rome, or Tokyo. Here you can dive into the past by visiting museums, castles, and other historical attractions.\n\n3. **Beach vacation:** If you prefer hitting the beach, consider tropical islands or coastlines with beautiful beaches and a warm climate. The options include Seychelles, Hawaii, the Maldives, etc.\n\n4. **Outdoor activities:** There are plenty of options for outdoor enthusiasts including mountain skiing, surfing, rafting, and other sports. Choose a place equipped for your favorite activities.\n\n5. **Moving to another country:** If you are considering a long-term relocation, explore countries offering favorable conditions for life, work, and education. Factor in things like climate, cost of living, safety, and local culture.\n\nRemember that the choice of destination depends on your personal preferences and goals. Before you make your decision, research the place to make sure it meets your expectations.

      Question: Wher to cuutt looooose?
      Answer with rephraser:
          'It looks like your question contains an error or a typo. Please rephrase it and I will try to help you. If you meant "where to go for a break," I can suggest a few ideas:\n\n* **Nature reserves and national parks**: For nature and active lifestyle enthusiasts.\n* **Historical cities**: For culture and history geeks.\n* **Beach vacation**: For those who like to chill in the sun and enjoy sea air.\n* **Ski resorts**: For winter sports enthusiasts.\n\nThe choice of place for a break depends on your interests and preferences.
      ```

      {% endcut %}

      After rephrasing, the model managed to respond to `Wher to cuutt looooose?` and gave a more detailed answer to `Where to escape to?`.

{% endlist %}