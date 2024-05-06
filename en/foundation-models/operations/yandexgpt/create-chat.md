---
title: "How to send a series of requests in chat mode to {{ yagpt-full-name }}"
description: "Follow this guide to learn how to use {{ yagpt-full-name }} in chat mode."
---

# How to create a chat with {{ yagpt-name }}

{{ yagpt-full-name }} models do not retain the context of previous messages, so to make a dialog with the model, you need to save the message history on the client side and send it with each request to the model. The [chat](../../concepts/yandexgpt/index.md) available in {{ foundation-models-name }} Playground consists of a series of prompts where the context of each new request includes the model's responses to previous ones. {{ yagpt-full-name }} models can handle a context of up to {{ yagpt-max-tokens }} tokens.

To create a chat with the model in your application and avoid delays in responses, send prompts in [synchronous](../../concepts/index.md#working-mode) mode using the [completion](../../text-generation/api-ref/TextGeneration/completion.md) method.

To create a chat:

1. {% include notitle [ai-before-beginning](../../../_includes/foundation-models/yandexgpt/ai-before-beginning.md) %}

1. Prepare a model request file, e.g., `body.json`:

   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.6,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "system",
         "text": "You are a smart assistant"
       },
       {
         "role": "user",
         "text": "Hello! What fields of science did Albert Einstein study?"
       }
     ]
   }
   ```

   Where:

   {% include [api-parameters](../../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

1. Send a request to the model:

   {% list tabs group=programming_language %}

   - cURL {#curl}

      Run this command:

      ```bash
      export FOLDER_ID=<folder_ID>
      export IAM_TOKEN=<IAM_token>
      curl --request POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -H "x-folder-id: ${FOLDER_ID}" \
        -d "@<path_to_json_file>" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
      ```

      Where:

      * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
      * `IAM_TOKEN`: IAM token of your account.

   - Python 3 {#python}

      1. Create an `index.py` file and add the following code to it:

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

         **Authentication using an IAM token:**

         ```bash
         export IAM_TOKEN=<IAM_token>
         ```

         **Authentication using an API key (for service accounts only):**

         ```bash
         export API_KEY=<API_key>
         ```

      1. Run the created file:

         ```bash
         python index.py
         ```

   {% endlist %}

1. In response to the request, the model will return the generated text:

   {% cut "Result:" %}

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the Universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\n His general relativity works found wide recognition and had a profound influence on the development of modern physics."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "28",
         "completionTokens": "110",
         "totalTokens": "138"
       },
       "modelVersion": "18.01.2024"
     }
   }
   ```

   {% endcut %}

   Save the `message` record value for use in subsequent requests.

1. Add the `message` record value obtained as a result of the previous request to the model, as well as the new user question, to the end of the `messages` array in the request file:

   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.6,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "system",
         "text": "You are a smart assistant"
       },
       {
         "role": "user",
         "text": "Hello! What fields of science did Albert Einstein study?"
       },
       {
         "role": "assistant",
         "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the Universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\n His general relativity works found wide recognition and had a profound influence on the development of modern physics."
       },
       {
         "role": "user",
         "text": "What important discoveries did he make?"
       }
     ]
   }
   ```

1. Send a new request to the model, repeating step 3 of this guide. In response to your request, the model will again return the generated text:

   {% cut "Result:" %}

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "Here are some discoveries commonly associated with the name of Albert Einstein:\n1. **Special theory of relativity (STR)**: Theory describing motion, laws of mechanics, and spatiotemporal relationships at random velocities less than the speed of light in a vacuum.\n1. **General theory of relativity (GTR)**: Geometric theory of gravitation based on the prediction of the interrelation between the spacetime, matter, and energy coordinates.\n1. **Quantum theory of the photoelectric effect**: Explanation of the photoelectric effect, the phenomenon of electron emission from matter under the influence of electromagnetic radiation.\n1. **Brownian motion**: Phenomenon of the chaotic, random movement of microscopic particles suspended in a liquid or a gas, caused by the thermal motion of molecules in the surrounding medium.\n1. **Equivalence principle**: Idea that gravitational and inertial mass are different aspects of the same physical quantity.\n1. **Cosmological solutions of the GTR equations**: Contribution to the theory of the structure and dynamics of the universe.\n1. **Nuclear model of the atom: Description of the atom structure based on protons, neutrons, and electrons.\nThese are just some of the discoveries made by Albert Einstein. His contributions to science and philosophy are immense, and his research continues to influence our ideas of nature and the universe."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "154",
         "completionTokens": "278",
         "totalTokens": "432"
       },
       "modelVersion": "18.01.2024"
     }
   }
   ```

   {% endcut %}

   Once again, save the `message` record value for use in subsequent requests.

1. Continue to expand the request context with the received responses and user questions:

   ```json
   {
     "modelUri": "gpt://<folder_ID>/yandexgpt-lite",
     "completionOptions": {
       "stream": false,
       "temperature": 0.6,
       "maxTokens": "2000"
     },
     "messages": [
       {
         "role": "system",
         "text": "You are a smart assistant"
       },
       {
         "role": "user",
         "text": "Hello! What fields of science did Albert Einstein study?"
       },
       {
         "role": "assistant",
         "text": "Albert Einstein was an outstanding physicist, whose works in theoretical physics, theoretical mechanics, and philosophy of science became fundamental. He dedicated his career to studying the fundamentals of the Universe, including the theory of relativity, both special and general. Additionally, Albert Einstein studied:\n\n* thermodynamics,\n* statistical mechanics,\n* electromagnetism,\n* quantum theory,\n* special relativity, and more.\n\n His general relativity works found wide recognition and had a profound influence on the development of modern physics."
       },
       {
         "role": "user",
         "text": "What important discoveries did he make?"
       },
       {
         "role": "assistant",
         "text": "Here are some discoveries commonly associated with the name of Albert Einstein:\n1. **Special theory of relativity (STR)**: Theory describing motion, laws of mechanics, and spatiotemporal relationships at random velocities less than the speed of light in a vacuum.\n1. **General theory of relativity (GTR)**: Geometric theory of gravitation based on the prediction of the interrelation between the spacetime, matter, and energy coordinates.\n1. **Quantum theory of the photoelectric effect**: Explanation of the photoelectric effect, the phenomenon of electron emission from matter under the influence of electromagnetic radiation.\n1. **Brownian motion**: Phenomenon of the chaotic, random movement of microscopic particles suspended in a liquid or a gas, caused by the thermal motion of molecules in the surrounding medium.\n1. **Equivalence principle**: Idea that gravitational and inertial mass are different aspects of the same physical quantity.\n1. **Cosmological solutions of the GTR equations**: Contribution to the theory of the structure and dynamics of the universe.\n1. **Nuclear model of the atom: Description of the atom structure based on protons, neutrons, and electrons.\nThese are just some of the discoveries made by Albert Einstein. His contributions to science and philosophy are immense, and his research continues to influence our ideas of nature and the universe."
       },
       {
         "role": "user",
         "text": "Provide me with a shorter response"
       }
     ]
   }
   ```

   {% cut "Result:" %}

   ```json
   {
     "result": {
       "alternatives": [
         {
           "message": {
             "role": "assistant",
             "text": "Albert Einstein was an outstanding physicist who studied the fundamentals of the universe, including the theory of relativity, thermodynamics, and electromagnetism.\n\nSome of his well-known discoveries include the following: special and general theories of relativity, quantum theory of the photoelectric effect, and others."
           },
           "status": "ALTERNATIVE_STATUS_FINAL"
         }
       ],
       "usage": {
         "inputTextTokens": "452",
         "completionTokens": "54",
         "totalTokens": "506"
       },
       "modelVersion": "18.01.2024"
     }
   }
   ```

   {% endcut %}

