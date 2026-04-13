

Learn how to use a [function](../../functions/concepts/function.md) from {{ sf-name }} with the [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/) to create an [AI agent](https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf), i.e., a personalized assistant integrated with {{ ai-studio-full-name }} [text generation models]({{ link-docs-ai }}ai-studio/concepts/generation/models) to provide generative responses.

Follow this guide to create a simple AI agent that uses a function from {{ sf-name }} to get weather information, interact with the {{ ai-studio-full-name }} [language model]({{ link-docs-ai }}ai-studio/concepts/generation/models), and, to add a touch of fun, respond to the user in [haiku](https://en.wikipedia.org/wiki/Haiku) form.

![create-ai-agent-function](../../_assets/tutorials/create-ai-agent-function.svg)

On the diagram:

1. The user sends a request to the AI agent. The {{ sf-name }} handler receives the request.
1. The {{ sf-name }} handler creates and runs the AI agent.
1. The AI agent requests additional weather data for a given city using the custom `get_weather()` function.
1. The AI agent sends the user request together with the extra context to the {{ foundation-models-name }} text generation model.
1. A [service account](../../iam/concepts/users/service-accounts.md) authorizes the AI agent to access the {{ foundation-models-name }} [Text Generation API]({{ link-docs-ai }}ai-studio/text-generation/api-ref/index) using an [API key](../../iam/concepts/authorization/api-key.md).
1. The service account grants access to the [{{ lockbox-name }}](../../lockbox/index.yaml) secret with the service account API key to the function in {{ sf-name }}.
1. The function in {{ sf-name }} retrieves the service account API key from the {{ lockbox-name }} secret.
1. The {{ foundation-models-name }} model sends the generated response to the AI agent.
1. The AI agent returns the response to the user.

The AI agent you create in this tutorial will be deployed in {{ yandex-cloud }} using {{ sf-full-name }}. You will also create resources to arrange access to the {{ foundation-models-name }} model: a [service account](../../iam/concepts/users/service-accounts.md), the service account [API key](../../iam/concepts/authorization/api-key.md), the {{ lockbox-full-name }} [secret](../../lockbox/concepts/secret.md), and a [function](../../functions/concepts/function.md) in {{ sf-name }}.

You can create these resources [automatically](#automatic-setup) or [manually](#manual-setup).

{% include [ai-agent-about](../_tutorials_includes/ai-agent-about.md) %}


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for this tutorial includes:
* Fee for using the function (see [{{ sf-full-name }} pricing](../../functions/pricing.md)).
* Text generation fee (see [{{ ai-studio-full-name }} pricing]({{ link-docs-ai }}ai-studio/pricing)).
* Fee for storing the secret and operations with it (see [{{ lockbox-full-name }} pricing](../../lockbox/pricing.md)).
* Fee for logging operations and data storage in a [log group](../../logging/concepts/log-group.md) (see [{{ cloud-logging-full-name }} pricing](../../logging/pricing.md)) when using [{{ cloud-logging-name }}](../../logging/).

## Automated AI agent deployment using {{ src-name }} CI/CD {#automatic-sourcecraft-setup}

Run a CI/CD workflow in [{{ src-name }}]({{ link-src-docs }}/) to automatically create all the required resources in your selected folder and deploy a ready-to-use AI agent for you to experiment with.

### Why {{ src-name }} CI/CD is the fastest and most secure way to deploy an AI agent {#why-sourcecraft}

{{ src-name }} provides multiple benefits when deploying AI agents:

* You do not need to set up a local development environment. All the required settings are configured remotely when running CI/CD workflows in {{ src-name }}.
* Deployment is secure as you do not need to store service account secrets locally. In {{ src-name }}, you can use a [service connection]({{ link-src-docs }}/sourcecraft/concepts/service-connections) to request short-living IAM tokens for access to {{ yandex-cloud }} services.

To create an AI agent automatically using {{ src-name }} CI/CD:

1. [Fork]({{ link-src-docs }}/sourcecraft/operations/fork-work#create-fork) the [repository](https://sourcecraft.dev/yandex-cloud-examples/yc-serverless-ai-agent) with scripts for AI agent creation.

    The repository contains scripts for creating the following AI agent types:

    {% list tabs group=difficulty %}

    - Simple AI agent {#simple}

      The `create-simple-ai-agent-workflow` will create a simple AI agent which, when launched, returns information about the weather in Tokyo in haiku form.

    - Advanced AI agent {#advanced}

      The `create-advanced-ai-agent-workflow` will create an advanced AI agent which responds to user requests in haiku form. When there is no user request, the agent returns a response to the default request.

    - Translator agent {#complex}

      The `create-complex-ai-agent-workflow` will create a translator agent which can handle user requests for text translation to the specified language while maintaining the style and tone.

    {% endlist %}

1. [Configure a service connection]({{ link-src-docs }}/sourcecraft/operations/service-connections) in {{ src-name }} for access to your {{ yandex-cloud }}.

1. [Run a workflow]({{ link-src-docs }}/sourcecraft/operations/run-workflow-manually), e.g., `create-simple-ai-agent-workflow`.

1. Test the AI agent.

   You can view the function result in the [logs]({{ link-src-docs }}/sourcecraft/operations/ci-cd#check-ci-cd) of the {{ src-name }} CI/CD cube, e.g., for `create-simple-ai-agent-workflow` this cube is named `deploy-simple-ai-agent`. In addition, you can [test the function](#test-function) in the {{ yandex-cloud }} management console.

1. If you no longer need the resources you created, [delete them](#clear-out).

## Creating an AI agent automatically {#automatic-setup}

Run a script to automatically create all the required resources in your selected folder and deploy a ready-to-use AI agent for you to experiment with.

To create an AI agent automatically:

1. [Install](../../cli/operations/install-cli.md) the {{ yandex-cloud }} CLI and [get authenticated](../../cli/operations/index.md#auth).
1. [Download and install Python](https://www.python.org/downloads/).
1. Clone the [repository](https://sourcecraft.dev/yandex-cloud-examples/yc-serverless-ai-agent) with scripts for creating the AI agent:

    ```bash
    git clone https://git@git.sourcecraft.dev/yandex-cloud-examples/yc-serverless-ai-agent.git
    ```

    The repository contains scripts for creating three types of AI agents:

    {% list tabs group=difficulty %}

    - Simple AI agent {#simple}

      The `create-simple-ai-agent.py` script will create a simple AI agent which returns information about the weather in Tokyo in haiku form when you run it.

    - Advanced AI agent {#advanced}

      The `create-advanced-ai-agent.py` script will create an advanced AI agent which responds to user requests in haiku form. When there is no user request, the agent returns a response to the default request.

    - Translator agent {#complex}

      The `create-complex-ai-agent.py` script will create a translator agent which can handle user requests for text translation to the specified language while maintaining the style and tone.

    {% endlist %}

1. Make the script file executable. Here is an example:

    ```bash
    chmod +x create-simple-ai-agent.py
    ```
1. Run the script:

    ```bash
    ./create-simple-ai-agent.py
    ```

    While the script is running, specify your cloud and folder details, then wait until the resources are created.
1. Test the AI agent.

    {% list tabs group=difficulty %}

    - Simple AI agent {#simple}

      [Test](#test-function) the function in the management console.

    - Advanced AI agent {#advanced}

      [Test](#test-function) the function in the management console.

      You can also test the function by sending a user request to the AI agent via the {{ yandex-cloud }} CLI. To do this, run this command and specify the function ID you obtained when creating the AI agent:

      ```bash
      echo '{"query": "What's the weather in Paris?"}' > request.json \
        yc serverless function invoke <function_ID> --data-file request.json
      ```

    - Translator agent {#complex}

      [Test](#test-function) the function in the management console.

      You can also test the function by sending a user request to the AI agent via the {{ yandex-cloud }} CLI. To do this, run this command and specify the function ID you obtained when creating the AI agent:

      ```bash
      echo '{"text": "Hello, world!", "target_language": "Russian", "tone": "friendly"}' > translate.json \
        yc serverless function invoke <function_ID> --data-file translate.json
      ```

    {% endlist %}

1. If you no longer need the resources you created, [delete them](#clear-out).


## Creating an AI agent manually {#manual-setup}

To create an AI agent manually using a function from {{ sf-name }}:

1. [Create a service account](#create-sa).
1. [Create the service account API key](#create-api-key).
1. [Create a {{ lockbox-full-name }} secret](#create-secret).
1. [Prepare a ZIP archive with the function code](#zip-archive).
1. [Create a function](#create-function).
1. [Test the function](#test-function).

If you no longer need the resources you created, [delete them](#clear-out).

## Create a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you are going to create your infrastructure.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the service account: `function-sa`.
  1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `ai.languageModels.user` [role]({{ link-docs-ai }}ai-studio/security/index#languageModels-user).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account named `function-sa` in the default folder:

      ```bash
      yc iam service-account create \
        --name function-sa
      ```

      Result:

      ```text
      done (1s)
      id: aje23dgspcpi********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-04T19:34:58.145514099Z"
      name: function-sa
      ```

      Save the service account ID (the `id` field value) and the folder ID (the `folder_id` field value) as you will need them later.

      For more information about the `yc iam service-account create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/service-account/create.md).

  1. Assign the `ai.languageModels.user` [role]({{ link-docs-ai }}ai-studio/security/index#languageModels-user) for the folder to the created service account by specifying the folder and service account IDs you saved in the previous step:

      ```bash
      yc resource-manager folder add-access-binding <folder_ID> \
        --role ai.languageModels.user \
        --subject serviceAccount:<service_account_ID>
      ```

      Result:

      ```text
      done (2s)
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: ai.languageModels.user
            subject:
              id: aje23dgspcpi********
              type: serviceAccount
      ```

      For more information about the `yc resource-manager folder add-access-binding` command, see the [CLI reference](../../cli/cli-ref/resource-manager/cli-ref/folder/add-access-binding.md).

- API {#api}

  To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

  To assign the service account the `ai.languageModels.user` role for the folder, use the [updateAccessBindings](../../resource-manager/api-ref/Folder/updateAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/UpdateAccessBindings](../../resource-manager/api-ref/grpc/Folder/updateAccessBindings.md) gRPC API call.

{% endlist %}


## Create the service account API key {#create-api-key}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}** and select the `function-sa` service account you created earlier.
  1. In the top panel, click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_api_key }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-scope }}** field, select the `yc.ai.languageModels.execute` [scope](../../iam/concepts/authorization/api-key.md#scoped-api-keys).
  1. Optionally, set the API key expiration date under **{{ ui-key.yacloud.iam.folder.service-account.overview.field_key-expires-at }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Save the secret key as you will need it to create a function.

      {% note alert %}

      After you close this dialog, the key value will no longer be available.

      {% endnote %}

- CLI {#cli}

  1. Create an API key for the `function-sa` service account:

      ```bash
      yc iam api-key create \
        --service-account-name function-sa \
        --scopes yc.ai.languageModels.execute
      ```

      Result:

      ```yaml
      api_key:
        id: ajemcpt92i9j********
        service_account_id: aje23dgspcpi********
        created_at: "2025-06-04T19:41:28.960624728Z"
        scope: yc.ai.languageModels.execute
        scopes:
          - yc.ai.languageModels.execute
      secret: AQVN1mZ6kUkzDCjhNJxmjDX6WeJdOlJv********
      ```

      Save the key value as you will not be able to get it again.

      For more information about the `yc iam api-key create` command, see the [CLI reference](../../cli/cli-ref/iam/cli-ref/api-key/create.md).

- API {#api}

  To create an API key, use the [create](../../iam/api-ref/ApiKey/create.md) REST API method for the [ApiKey](../../iam/api-ref/ApiKey/index.md) resource or the [ApiKeyService/Create](../../iam/api-ref/grpc/ApiKey/create.md) gRPC API call.

{% endlist %}


## Create a {{ lockbox-full-name }} secret {#create-secret}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** and click **{{ ui-key.yacloud.lockbox.button_create-secret }}**.
  1. In the **{{ ui-key.yacloud.common.name }}** field, specify the secret name: `api-key-secret`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.title_secret-type }}** field, select `{{ ui-key.yacloud.lockbox.forms.title_secret-type-custom }}`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_key }}** field, enter the secret key: `api-key`.
  1. In the **{{ ui-key.yacloud.lockbox.forms.label_value }}** field, paste the secret key you obtained in the previous step.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  1. Create a {{ lockbox-name }} secret named `api-key-secret` in the default folder by specifying the secret key obtained in the previous step:

      ```bash
      yc lockbox secret create \
        --name api-key-secret \
        --payload "[{'key': 'api-key', 'text_value': '<secret_key>'}]"
      ```

      Result:

      ```bash
      done (1s)
      id: e6q7c0n0n7ji********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-04T19:50:38.690Z"
      name: api-key-secret
      status: ACTIVE
      current_version:
        id: e6qhmal099ki********
        secret_id: e6q7c0n0n7ji********
        created_at: "2025-06-04T19:50:38.690Z"
        status: ACTIVE
        payload_entry_keys:
          - api-key
      ```

      For more information about the `yc lockbox secret create` command, see the [CLI reference](../../cli/cli-ref/lockbox/cli-ref/secret/create.md).

- API {#api}

  To create a secret, use the [create](../../lockbox/api-ref/Secret/create.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/Create](../../lockbox/api-ref/grpc/Secret/create.md) gRPC API call.

{% endlist %}

### Grant read permissions for the secret contents to the service account {#grant-secret-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_lockbox }}** and select the secret named `api-key-secret` you created earlier.
  1. On the left-hand panel, select ![persons](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** and click **{{ ui-key.yacloud_components.acl.action.assign-roles }}**. In the window that opens:

      1. In the search bar, enter the name of the `function-sa` service account you created and select it.
      1. Click ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer).
      1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Assign the `lockbox.payloadViewer` [role](../../lockbox/security/index.md#lockbox-payloadViewer) for `api-key-secret` to the `function-sa` service account:

      ```bash
      yc lockbox secret add-access-binding \
          --name api-key-secret \
          --service-account-name function-sa \
          --role lockbox.payloadViewer
      ```

      For more information about the `yc lockbox secret add-access-binding` command, see the [CLI reference](../../cli/cli-ref/lockbox/cli-ref/secret/add-access-binding.md).

- API {#api}

  To assign a role for a secret to a service account, use the [setAccessBindings](../../lockbox/api-ref/Secret/setAccessBindings.md) REST API method for the [Secret](../../lockbox/api-ref/Secret/index.md) resource or the [SecretService/SetAccessBindings](../../lockbox/api-ref/grpc/Secret/setAccessBindings.md) gRPC API call.

{% endlist %}

## Prepare a ZIP archive with the function code {#zip-archive}

1. Save the following code to a file named `index.py`:

    {% list tabs group=difficulty %}

    - Simple AI agent {#simple}

      ```python
      import os

      from openai import AsyncOpenAI

      from agents import (
          Agent,
          OpenAIChatCompletionsModel,
          Runner,
          function_tool,
          set_tracing_disabled,
      )

      BASE_URL = os.getenv("BASE_URL")
      API_KEY = os.getenv("API_KEY")
      MODEL_NAME = os.getenv("MODEL_NAME")

      client = AsyncOpenAI(base_url=BASE_URL, api_key=API_KEY)
      set_tracing_disabled(disabled=True)


      @function_tool
      def get_weather(city: str):
          print(f"[debug] getting weather for {city}")
          return f"The weather in {city} is sunny."


      async def handler(event, context):
          agent = Agent(
              name="Assistant",
              instructions="You only respond in haikus.",
              model=OpenAIChatCompletionsModel(model=MODEL_NAME, openai_client=client),
              tools=[get_weather],
          )

          result = await Runner.run(agent, "What's the weather in Tokyo?")

          return {
              "statusCode": 200,
              "body": result.final_output,
          }
      ```

    - Advanced AI agent {#advanced}

      ```python
      import os
      import json

      from openai import AsyncOpenAI

      from agents import (
          Agent,
          OpenAIChatCompletionsModel,
          Runner,
          function_tool,
          set_tracing_disabled,
      )

      BASE_URL = os.getenv("BASE_URL")
      API_KEY = os.getenv("API_KEY")
      MODEL_NAME = os.getenv("MODEL_NAME")

      client = AsyncOpenAI(base_url=BASE_URL, api_key=API_KEY)
      set_tracing_disabled(disabled=True)


      @function_tool
      def get_weather(city: str):
          print(f"[debug] getting weather for {city}")
          return f"The weather in {city} is sunny."


      async def handler(event, context):
          # Extracting the user request from the event
          user_query = "What's the weather today?"  # Default request
          
          try:
              # Attempting to get the request from the event body
              if event and isinstance(event, dict):
                  body = event.get('body')
                  if body:
                      # If `body ` is provided as a string (which is often the case during API Gateway calls)
                      if isinstance(body, str):
                          try:
                              body_json = json.loads(body)
                              if 'query' in body_json:
                                  user_query = body_json['query']
                          except json.JSONDecodeError:
                              pass  # Using the default request if `body` is not JSON
                      elif isinstance(body, dict) and 'query' in body:
                          user_query = body['query']
                  # If the request was provided directly to `event`:
                  elif 'query' in event:
                      user_query = event['query']
          except Exception as e:
              print(f"Request processing error: {e}")
              # Running the default request in case of an error
          
          print(f"Processed request: {user_query}")
          
          agent = Agent(
              name="Assistant",
              instructions="You only respond in haikus. Be creative and poetic.",
              model=OpenAIChatCompletionsModel(model=MODEL_NAME, openai_client=client),
              tools=[get_weather],
          )

          result = await Runner.run(agent, user_query)

          return {
              "statusCode": 200,
              "body": result.final_output,
              "headers": {
                  "Content-Type": "application/json"
              }
          }
      ```

    - Translator agent {#complex}

      ```python
      import os
      import json
      import re
      from typing import Dict, List, Optional, Any

      from openai import AsyncOpenAI

      from agents import (
          Agent,
          OpenAIChatCompletionsModel,
          Runner,
          function_tool,
          set_tracing_disabled,
      )

      BASE_URL = os.getenv("BASE_URL")
      API_KEY = os.getenv("API_KEY")
      MODEL_NAME = os.getenv("MODEL_NAME")

      client = AsyncOpenAI(base_url=BASE_URL, api_key=API_KEY)
      set_tracing_disabled(disabled=True)

      # Dictionary with language codes to simplify input
      LANGUAGE_CODES = {
          "русский": "ru",
          "russian": "ru",
          "английский": "en",
          "english": "en",
          "французский": "fr",
          "french": "fr",
          "немецкий": "de",
          "german": "de",
          "испанский": "es",
          "spanish": "es",
          "итальянский": "it",
          "italian": "it",
          "китайский": "zh",
          "chinese": "zh",
          "японский": "ja",
          "japanese": "ja",
          "корейский": "ko",
          "korean": "ko",
          "арабский": "ar",
          "arabic": "ar",
          "португальский": "pt",
          "portuguese": "pt",
      }

      # Dictionary with tone codes
      TONE_TYPES = {
          "формальный": "formal",
          "formal": "formal",
          "неформальный": "informal",
          "informal": "informal",
          "дружеский": "friendly",
          "friendly": "friendly",
          "деловой": "business",
          "business": "business",
          "технический": "technical",
          "technical": "technical",
          "простой": "simple",
          "simple": "simple",
          "академический": "academic",
          "academic": "academic",
          "поэтический": "poetic",
          "poetic": "poetic",
          "разговорный": "conversational",
          "conversational": "conversational",
      }

      @function_tool
      def detect_language(text: str) -> dict:
          """Detects the language of the input text.
          
          Args:
              text: Text to analyze
              
          Returns:
              Dictionary with detected language and its code
          """
          # This function uses model capabilities to determine the language
          # In a real application, you could use specialized libraries for more accurate detection
          
          common_words = {
              "en": ["the", "and", "of", "to", "in", "a", "is", "that", "for", "it", "with", "as", "was", "on"],
              "ru": ["и", "в", "не", "на", "что", "с", "по", "это", "я", "он", "как", "из", "то", "а", "все", "так"],
              "fr": ["le", "la", "les", "un", "une", "et", "de", "des", "du", "dans", "en", "est", "que", "pour", "qui"],
              "de": ["der", "die", "das", "und", "in", "von", "mit", "den", "zu", "ist", "für", "auf", "dem", "nicht"],
              "es": ["el", "la", "los", "las", "un", "una", "y", "de", "en", "que", "a", "por", "con", "no", "es"],
              "it": ["il", "la", "i", "le", "e", "di", "un", "una", "in", "che", "per", "con", "è", "non", "sono"],
          }
          
          # Simple detection by characteristic symbols and words
          text_lower = text.lower()
          
          # Check for Cyrillic characters (for Russian)
          if re.search('[а-яА-Я]', text):
              return {"language": "Russian", "code": "ru"}
          
          # Check for characters (for Chinese and Japanese)
          if re.search('[\u4e00-\u9fff]', text):
              return {"language": "Chinese", "code": "zh"}
          
          if re.search('[\u3040-\u309F\u30A0-\u30FF]', text):
              return {"language": "Japanese", "code": "ja"}
          
          # Check by common words
          word_counts = {}
          for lang, words in common_words.items():
              count = 0
              for word in words:
                  pattern = r'\b' + re.escape(word) + r'\b'
                  count += len(re.findall(pattern, text_lower))
              word_counts[lang] = count
          
          # Determine the language with the most matches
          if word_counts:
              detected_code = max(word_counts.items(), key=lambda x: x[1])[0]
              language_names = {
                  "en": "English",
                  "ru": "Russian",
                  "fr": "French",
                  "de": "German",
                  "es": "Spanish",
                  "it": "Italian",
              }
              return {"language": language_names.get(detected_code, "Unknown"), "code": detected_code}
          
          # Default to English
          return {"language": "Unknown (assuming English)", "code": "en"}

      @function_tool
      def translate_text(text: str, target_language: str, source_language: Optional[str] = None, tone: Optional[str] = None) -> str:
          """Translates text to the specified language while preserving tone and style.
          
          Args:
              text: Text to translate
              target_language: Target language for translation (code or name)
              source_language: Source language of the text (code or name, optional)
              tone: Desired tone of translation (formal, informal, business, etc., optional)
              
          Returns:
              Translated text
          """
          # This function would use LLM for translation in reality
          # Here we just return information about the request for demonstration
          
          # Normalize language codes
          target_code = LANGUAGE_CODES.get(target_language.lower(), target_language.lower())
          source_code = None
          if source_language:
              source_code = LANGUAGE_CODES.get(source_language.lower(), source_language.lower())
          
          # Normalize tone
          tone_type = None
          if tone:
              tone_type = TONE_TYPES.get(tone.lower(), tone.lower())
          
          # Return information for LLM to perform translation
          # In a real application, you could call a specialized translation API here
          return {
              "text": text,
              "target_language_code": target_code,
              "source_language_code": source_code,
              "tone": tone_type,
              "length": len(text)
          }

      async def handler(event, context):
          """Function handler"""
          try:
              # Get text for translation and parameters from the request
              text = None
              target_language = None
              source_language = None
              tone = None
              
              # Process different formats of incoming data
              if event and isinstance(event, dict):
                  body = event.get('body')
                  
                  if body:
                      # If body is passed as a string (common when called via API Gateway)
                      if isinstance(body, str):
                          try:
                              body_json = json.loads(body)
                              text = body_json.get('text')
                              target_language = body_json.get('target_language')
                              source_language = body_json.get('source_language')
                              tone = body_json.get('tone')
                          except json.JSONDecodeError:
                              # Maybe it's just text for translation
                              text = body
                      elif isinstance(body, dict):
                          text = body.get('text')
                          target_language = body.get('target_language')
                          source_language = body.get('source_language')
                          tone = body.get('tone')
                  else:
                      # If parameters are passed directly in the event
                      text = event.get('text')
                      target_language = event.get('target_language')
                      source_language = event.get('source_language')
                      tone = event.get('tone')
              
              # Check required parameters
              if not text:
                  return {
                      "statusCode": 400,
                      "body": json.dumps({"error": "Missing 'text' parameter (text to translate)"}),
                      "headers": {"Content-Type": "application/json"}
                  }
              
              if not target_language:
                  return {
                      "statusCode": 400,
                      "body": json.dumps({"error": "Missing 'target_language' parameter (target language)"}),
                      "headers": {"Content-Type": "application/json"}
                  }
                  
              # Create request for AI agent
              user_query = f"Translate the following text to {target_language}:"
              if source_language:
                  user_query += f" from {source_language}"
              if tone:
                  user_query += f". Preserve the {tone} tone and style of the original"
              user_query += f"\\n\\n{text}"
              
              # Set up AI agent
              agent = Agent(
                  name="TranslatorAssistant",
                  instructions="""You are a professional translator assistant who can translate text between different languages 
      while preserving the original tone, style, and context. 

      Your tools:
      1. detect_language - to identify the language of the input text
      2. translate_text - to translate text to the target language

      You should:
      - Understand the tone and style of the original text
      - Preserve formatting, including paragraphs, bullet points, and special symbols
      - Keep names, terms, and brand names unchanged unless translation is specifically required
      - When translating technical or specialized content, use appropriate terminology
      - Be sensitive to cultural context and adapt idioms appropriately
      - For formal documents, maintain formal language in the translation
      - For creative content, preserve the creative elements in the translation

      When responding:
      1. Provide the translation
      2. If requested or if there are important notes about the translation, briefly mention them
      3. Be concise and focus on accurate translation""",
                  model=OpenAIChatCompletionsModel(model=MODEL_NAME, openai_client=client),
                  tools=[detect_language, translate_text],
              )

              # Run the agent
              result = await Runner.run(agent, user_query)
              
              # Format the response
              return {
                  "statusCode": 200,
                  "body": json.dumps({
                      "translation": result.final_output,
                      "original_text": text,
                      "target_language": target_language,
                      "source_language": source_language,
                      "tone": tone
                  }, ensure_ascii=False),
                  "headers": {"Content-Type": "application/json; charset=utf-8"}
              }
              
          except Exception as e:
              print(f"Request processing error: {str(e)}")
              return {
                  "statusCode": 500,
                  "body": json.dumps({"error": f"Internal server error: {str(e)}"}),
                  "headers": {"Content-Type": "application/json"}
              }
      ```

    {% endlist %}

1. Save the following code to a file named `requirements.txt`:

    ```text
    openai-agents
    ```
1. Add the `index.py` and `requirements.txt` files into the `openai-function.zip` archive.


## Create a function {#create-function}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. [Navigate to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:
     1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
     1. In the window that opens, enter `ai-agent-function` as the function name.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a [function version](../../functions/concepts/function.md#version):
     1. Select `{{ python-full-ver }}` as the runtime environment, disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**, and click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
     1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_code-source }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}` and attach the `openai-function.zip` file you created earlier.
     1. Specify the entry point: `index.handler`.
     1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `5 minutes`.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
         * **{{ ui-key.yacloud.forms.label_service-account-select }}**: Select the `function-sa` service account.
         * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
             * `FOLDER_ID`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) you are creating the infrastructure in.
             * `MODEL_NAME`: URI of the {{ ai-studio-full-name }} text generation [model]({{ link-docs-ai }}ai-studio/concepts/generation/models#generation).

                 Example: `gpt://<folder_ID>/yandexgpt/latest`.
                
                 Specify the ID of the folder you are creating the infrastructure in.
             * `BASE_URL`: {{ ai-studio-full-name }} URL, `https://{{ api-host-llm }}/v1`.

         * **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-secret }}**:
             * In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_lockbox-env-key }}** field, specify `API_KEY` and select the previously created `api-key-secret`, its version, and `api-key`.
        * If you prefer to opt out of logging so as not to pay for {{ cloud-logging-name }}, disable the **{{ ui-key.yacloud.logging.field_logging }}** option to disable logging.
     1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

- CLI {#cli}

  1. Create a function named `ai-agent-function` in the default folder:

      ```bash
      yc serverless function create \
       --name ai-agent-function
      ```

      Result:

      ```text
      id: d4edhic2qf3i********
      folder_id: b1gt6g8ht345********
      created_at: "2025-06-04T20:02:14.741Z"
      name: ai-agent-function
      http_invoke_url: https://{{ sf-url }}/d4edhic2qf3i********
      status: ACTIVE
      ```

      For more information about the `yc serverless function create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/create.md).

  1. Create a [version](../../functions/concepts/function.md#version) of the `ai-agent-function` function:

      ```bash
      yc serverless function version create \
        --function-name ai-agent-function \
        --memory=128m \
        --execution-timeout=5m \
        --runtime={{ python-cli-ver }} \
        --entrypoint=index.handler \
        --service-account-id=<service_account_ID> \
        --environment FOLDER_ID="<folder_ID>",MODEL_NAME="gpt://<folder_ID>/yandexgpt/latest",BASE_URL="https://{{ api-host-llm }}/v1" \
        --secret name=api-key-secret,key=api-key,environment-variable=API_KEY \
        --source-path=./openai-function.zip \
        --no-logging
      ```

      Where:

      * `--service-account-id`: [ID](../../iam/operations/sa/get-id.md) of the `function-sa` service account you saved previously.
      * `--environment`: Environment variables:

          * `FOLDER_ID`: [ID](../../resource-manager/operations/folder/get-id.md) of the folder you saved earlier when creating the service account.
          * `MODEL_NAME`: URI of the {{ foundation-models-full-name }} text generation [model]({{ link-docs-ai }}ai-studio/concepts/generation/models#generation).

                 Example: `gpt://<folder_ID>/yandexgpt/latest`.
                
                 Specify the ID of the folder you are creating the infrastructure in.

          * `BASE_URL`: {{ foundation-models-full-name }} URL, `https://{{ api-host-llm }}/v1`.

      Result:

      ```text
      done (16s)
      id: d4e1vnnvhk5p********
      function_id: d4edhic2qf3i********
      created_at: "2025-06-04T20:09:59.675Z"
      runtime: {{ python-cli-ver }}
      entrypoint: index.handler
      resources:
        memory: "134217728"
      execution_timeout: 300s
      service_account_id: aje23dgspcpi********
      image_size: "14958592"
      status: ACTIVE
      tags:
        - $latest
      environment:
        FOLDER_ID: b1gt6g8ht345********
        BASE_URL: https://{{ api-host-llm }}/v1
        MODEL_NAME: gpt://b1gt6g8ht345********/yandexgpt/latest
      secrets:
        - id: e6q7c0n0n7ji********
          version_id: e6qhmal099ki********
          key: api-key
          environment_variable: API_KEY
      log_options:
        disabled: true
        folder_id: b1gt6g8ht345********
      concurrency: "1"
      ```

      For more information about the `yc serverless function version create` command, see the [CLI reference](../../cli/cli-ref/serverless/cli-ref/function/version/create.md).

- API {#api}

  To create a function, use the [create](../../functions/functions/api-ref/Function/create.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/Create](../../functions/functions/api-ref/grpc/Function/create.md) gRPC API call.

  To create a function version, use the [createVersion](../../functions/functions/api-ref/Function/createVersion.md) REST API method for the [Function](../../functions/functions/api-ref/Function/index.md) resource or the [FunctionService/CreateVersion](../../functions/functions/api-ref/grpc/Function/createVersion.md) gRPC API call.

{% endlist %}


## Test the function {#test-function}

{% list tabs group=difficulty %}

- Simple AI agent {#simple}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the infrastructure.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** and select the new function.
  1. Navigate to the ![circle-play](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. Click ![play-fill](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** and look up the test result.

      If the request is successful, the function status will change to `Done` and the output will contain the `200` status code and model response. For example:

      ```json
      {
          "statusCode": 200,
          "body": "In Tokyo's sky,\nSunshine beams so bright and clear,\nWarmth fills the air."
      }
      ```

- Advanced AI agent {#advanced}

  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** and select the new function.
  1. Navigate to the ![circle-play](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, specify:

      ```json
      {
        "query": "What's the weather in Paris?"
      }
      ```

  1. Click ![play-fill](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** and look up the test result.

      If the request is successful, the function status will change to `Done` and the output will contain the `200` status code and model response. For example:

      ```json
      {
          "statusCode": 200,
          "body": "Paris skies so blue,\nSunshine warms the city's heart,\nBreathe in, feel the joy.",
          "headers": {
              "Content-Type": "application/json"
          }
      }
      ```

- Translator agent {#complex}

  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** and select the new function.
  1. Navigate to the ![circle-play](../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab.
  1. In the **{{ ui-key.yacloud.serverless-functions.item.testing.field_payload }}** field, specify:

      ```json
      {
        "text": "Hello, world!",
        "target_language": "Russian",
        "tone": "friendly"
      }
      ```

  1. Click ![play-fill](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}** and look up the test result.

      If the request is successful, the function status will change to `Done` and the output will contain the `200` status code and model response. For example:

      ```json
      {
          "statusCode": 200,
          "body": "{\"translation\": \"Привет, мир!\", \"original_text\": \"Hello, world!\", \"target_language\": \"Russian\", \"source_language\": null, \"tone\": \"friendly\"}",
          "headers": {
              "Content-Type": "application/json; charset=utf-8"
          }
      }
      ```

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete the function](../../functions/operations/function/function-delete.md).
1. [Delete the secret](../../lockbox/operations/secret-delete.md).
1. If you logged data to a log group, [delete it](../../logging/operations/delete-group.md).
