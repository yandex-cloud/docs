---
title: How to send multiple requests in chat mode to {{ yagpt-full-name }}
description: Follow this guide to learn how to use {{ yagpt-full-name }} in chat mode.
---

# How to create a chat with {{ yagpt-name }}

{{ yagpt-full-name }} models do not retain the context of previous messages, so to have a continuous dialog with a model, you need to save the message history on your device and send it each time you are requesting the model. The [chat](../../concepts/yandexgpt/index.md) available in {{ foundation-models-name }} Playground consists of multiple prompts where the context of each new request includes the model's responses to previous ones. {{ yagpt-full-name }} models can work with context of up to {{ yagpt-max-tokens }} [tokens](../../concepts/yandexgpt/tokens.md).

{% note tip %}

Use {{ assistant-api }} to create a chat with the model. For an example of a chat implemented using assistants and threads, see the [{#T}](../assistant/create.md) guide.

{% endnote %}

To create a chat with a model in your application and avoid delays in responses, send prompts in [synchronous](../../concepts/index.md#working-mode) mode using the [completion](../../text-generation/api-ref/TextGeneration/completion.md) method or [{{ ml-sdk-full-name }}](../../sdk/index.md).

## Getting started {#before-begin}

{% list tabs group=programming_language %}

- SDK {#sdk}

  To use the examples of requests using SDK:

  {% include [sdk-before-begin-ai-langmodel-user](../../../_includes/foundation-models/sdk-before-begin-ai-langmodel-user.md) %}

- cURL {#curl}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

  {% include [curl](../../../_includes/curl.md) %}

- Python {#python}

  {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

{% endlist %}

## Build a chat {#develop-chat}

{% list tabs group=programming_language %}

- SDK {#sdk}

  1. Create a file named `create-chat.py` and paste the following code into it:

      ```python
      #!/usr/bin/env python3

      from __future__ import annotations
      from yandex_cloud_ml_sdk import YCloudML

      messages = '[\
                    {\
                      "role": "system",\
                      "text": "You are a smart assistant"\
                    },\
                    {\
                      "role": "user",\
                      "text": "Hi! What fields of science did Albert Einstein study?"\
                    }\
                  ]'

      def main() -> None:
          sdk = YCloudML(folder_id='<folder_ID>', auth="<API_key>")

          result = sdk.models.completions('yandexgpt').configure(temperature=0.6).run(messages)

          for alternative in result:
              print(alternative)

      if __name__ == '__main__':
          main()
      ```

      Where:

      {% include [the-messages-parameter](../../../_includes/foundation-models/yandexgpt/the-messages-parameter.md) %}

      {% include [sdk-code-legend](../../../_includes/foundation-models/examples/sdk-code-legend.md) %}

  1. Run the created file:

      ```bash
      python3 create-chat.py
      ```

      Result:

      ```text
      Alternative(role='assistant', text='This looks like the beginning of a dialog between the user and the smart assistant. In response to the user’s question, the smart assistant can provide information about the fields of science studied by Albert Einstein.\n\nHere is an example:\n\n[              {                "role": "system",                "text": “Albert Einstein is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries in this field. In particular, he formulated the special and general theories of relativity and contributed significantly to the development of quantum physics."              }            ]', status=<AlternativeStatus.FINAL: 3>)
      ```

  1. Add the model's response to the previous request and the user's new question to the end of the `messages` array in the `create-chat.py` file:

      ```python
      ...
      messages = '[\
                    {\
                      "role": "system",\
                      "text": "You are a smart assistant"\
                    },\
                    {\
                      "role": "user",\
                      "text": "Hi! What fields of science did Albert Einstein study?"\
                    },\
                    {\
                      "role": "assistant",\
                      "text": “Albert Einstein is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries in this field. In particular, he formulated the special and general theories of relativity and contributed significantly to the development of quantum physics."\
                    },\
                    {\
                      "role": "user",\
                      "text": "What important discoveries did he make?"\
                    }\
                  ]'
      ...
      ```

  1. Execute the file again:

      ```bash
      python3 create-chat.py
      ```

      Result:

      ```text
      Alternative(role='assistant', text='**Albert Einstein** is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries in this field. In particular, he formulated the special and general theories of relativity and contributed significantly to the development of quantum physics.\n\n* The theory of special relativity describes the laws of physics at speeds close to the speed of light. It was published in 1905 and became one of the most important scientific achievements of the early 20th century.\n* The theory of general relativity generalizes the theory of special relativity and describes gravity as a curvature of space-time. This theory was published in 1915.\n* Albert Einstein’s studies in quantum physics have led to the emergence of a new field of science, quantum electrodynamics. They also helped explain multiple phenomena occurring at the atomic and subatomic levels.' status=<AlternativeStatus.FINAL: 3>)
      ```

  1. Continue expanding the request context with the received responses and user questions:

      ```python
      ...
      messages = '[\
                    {\
                      "role": "system",\
                      "text": "You are a smart assistant"\
                    },\
                    {\
                      "role": "user",\
                      "text": "Hi! What fields of science did Albert Einstein study?"\
                    },\
                    {\
                      "role": "assistant",\
                      "text": “Albert Einstein is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries in this field. In particular, he formulated the special and general theories of relativity and contributed significantly to the development of quantum physics."\
                    },\
                    {\
                      "role": "user",\
                      "text": "What important discoveries did he make?"\
                    },\
                    {\
                      "role": "assistant",\
                      "text": "**Albert Einstein** is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries in this field. In particular, he formulated the special and general theories of relativity and contributed significantly to the development of quantum physics.\n\n* The theory of special relativity describes the laws of physics at speeds close to the speed of light. It was published in 1905 and became one of the most important scientific achievements of the early 20th century.\n* The theory of general relativity generalizes the theory of special relativity and describes gravity as a curvature of space-time. This theory was published in 1915.\n* Albert Einstein’s studies in quantum physics have led to the emergence of a new field of science, quantum electrodynamics. They also helped explain multiple phenomena occurring at the atomic and subatomic levels."\
                    },\
                    {\
                      "role": "user",\
                      "text": "Make it shorter"\
                    }\
                  ]'
      ...
      ```

      Result:

      ```text
      Alternative(role='assistant', text='**Albert Einstein** is one of the greatest scientists of the 20th century. He studied physics and made a series of fundamental discoveries:\n* The **theory of special relativity** describes the laws of physics at speeds close to the speed of light.\n* The theory of general relativity generalizes the theory of special relativity and describes gravity as a curvature of space-time.\n* His studies in **quantum physics** have led to the emergence of quantum electrodynamics and helped explain phenomena occurring at the atomic and subatomic levels.' status=<AlternativeStatus.FINAL: 3>)
      ```

- cURL {#curl}

  1. Prepare a model request file, e.g., `body.json`:
  
      {% include notitle [create-chat-body-json-part](../../../_includes/foundation-models/yandexgpt/create-chat-body-json-part.md) %}

  1. Send a request to the model:

      ```bash
      export FOLDER_ID=<folder_ID>
      export IAM_TOKEN=<IAM_token>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --header "x-folder-id: ${FOLDER_ID}" \
        --data "@<path_to_JSON_file>" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
      ```

      Where:

      * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
      * `IAM_TOKEN`: Your account's IAM token.

  1. In response to your request, the model will return the generated text:

      {% include notitle [create-chat-step-3](../../../_includes/foundation-models/yandexgpt/create-chat-step-3.md) %}

  1. Add the `message` record value from the model's response to the previous request and the user's new question to the end of the `messages` array in the request file:

      {% include notitle [create-chat-step-4](../../../_includes/foundation-models/yandexgpt/create-chat-step-4.md) %}

  1. Send a new request to the model repeating Step 2 of this guide. In response to your request, the model will again return the generated text:

      {% include notitle [create-chat-step-5](../../../_includes/foundation-models/yandexgpt/create-chat-step-5.md) %}

  1. Continue expanding the request context with the received responses and user questions:

      {% include notitle [create-chat-step-6](../../../_includes/foundation-models/yandexgpt/create-chat-step-6.md) %}

- Python {#python}

  1. Prepare a model request file, e.g., `body.json`:
  
      {% include notitle [create-chat-body-json-part](../../../_includes/foundation-models/yandexgpt/create-chat-body-json-part.md) %}

  1. Send a request to the model:

      1. Create a file named `index.py` and add the following code to it:

         ```python
         import requests
         import json
         import os

         def gpt(auth_headers):

             url = 'https://llm.api.cloud.yandex.net/foundationModels/v1/completion'

             with open('body.json', 'r', encoding='utf-8') as f:
                 data = json.dumps(json.load(f))
             resp = requests.post(url, headers=auth_headers, data=data)

             if resp.status_code != 200:
                 raise RuntimeError(
                     'Invalid response received: code: {}, message: {}'.format(
                         {resp.status_code}, {resp.text}
                     )
                 )

             return resp.text

         if __name__ == "__main__":
             if os.getenv('IAM_TOKEN') is not None:
                 iam_token = os.environ['IAM_TOKEN']
                 headers = {
                     'Authorization': f'Bearer {iam_token}',
                 }
             elif os.getenv('API_KEY') is not None:
                 api_key = os.environ['API_KEY']
                 headers = {
                     'Authorization': f'Api-Key {api_key}',
                 }
             else:
                 print ('Please save either an IAM token or an API key into a corresponding `IAM_TOKEN` or `API_KEY` environment variable.')
                 exit()

             print(gpt(headers))
         ```

      1. Save the authentication data to the environment variable:

         **Authentication with an IAM token:**

         ```bash
         export IAM_TOKEN=<IAM_token>
         ```

         **Authentication with an API key (for service accounts only):**

         ```bash
         export API_KEY=<API_key>
         ```

      1. Run the created file:

         ```bash
         python index.py
         ```

  1. In response to your request, the model will return the generated text:

      {% include notitle [create-chat-step-3](../../../_includes/foundation-models/yandexgpt/create-chat-step-3.md) %}

  1. Add the `message` record value from the model's response to the previous request and the user's new question to the end of the `messages` array in the request file:

      {% include notitle [create-chat-step-4](../../../_includes/foundation-models/yandexgpt/create-chat-step-4.md) %}

  1. Send a new request to the model repeating Step `2.3` of this guide. In response to your request, the model will again return the generated text:

      {% include notitle [create-chat-step-5](../../../_includes/foundation-models/yandexgpt/create-chat-step-5.md) %}

  1. Continue expanding the request context with the received responses and user questions:

      {% include notitle [create-chat-step-6](../../../_includes/foundation-models/yandexgpt/create-chat-step-6.md) %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/yandexgpt/index.md)
* Examples of working with ML SDK on [GitHub](https://github.com/yandex-cloud/yandex-cloud-ml-sdk/tree/master/examples/sync/completions)