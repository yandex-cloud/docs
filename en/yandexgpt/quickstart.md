# Getting started with {{ yagpt-full-name }}

In this section, you will learn how to use a neural network for generating texts.

For information about {{ yagpt-name }} usage costs, see [{#T}](pricing.md).

{% include notitle [preview-stage](../_includes/yandexgpt/preview.md) %}

## Getting started {#before-you-begin}

To run API request samples, install [cURL](https://curl.haxx.se).

{% include notitle [ai-before-beginning](../_includes/yandexgpt/ai-before-beginning.md) %}

## Generate the text {#generate-text}

{% note info %}

To improve the quality of generated responses, {{ yagpt-name }} logs user prompts. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   1. In the list of services, select **{{ yagpt-name }}**.
   1. In the left-hand panel, select ![image](../_assets/yandexgpt/playground.svg) **Playground**.
   1. Describe the request context under **Instructions**.
   1. Describe your request to the neural network under **Request**.
   1. In the **Temperature** field, enter a positive number that determines the versatility of the neural network's response. The higher is the value, the less deterministic is the request result.
   1. Click **View answer**. The answer will be shown on the right part of the screen.

- API

   1. Create a file with the request body (for example, `prompt.json`).

      ```json
      {
        "model": "general",
        "instruction_text": "Find errors in the text and fix them",
        "request_text": "Laminate flooring is sutiable for instalation in the kitchen or in a child's room. It withsatnds moisturre and mechanical dammage thanks to a proctive layer of melamine films 0.2 mm thick and a wax-treated interlocking systme.",
        "generation_options": {
          "max_tokens": 1500,  
          "temperature": 0.6
        }
      }
      ```

      Where:

      * `model`: Language model.
      * `instruction_text`: Initial text condition or context of your request. For example, the context can be: "You are a physicist", and the request text can be: "Explain the basics of the quantum theory to a five-year-old".
      * `request_text`: Request for the neural network to execute.
      * `generation_options`: Text generation options:

         * `max_tokens`: Sets the total limit on the model's input and output. The values may range from 1 to 2500.
         * `temperature`: The higher is this value, the more creative and randomized are the neural network's responses. Possible values: 0 or greater.

      {% include [ai-before-beginning](../_includes/yandexgpt/token-limits.md) %}

   1. Use the [instruct](./api-ref/TextGeneration/instruct.md) method to send a request to the neural network in the following command:

      ```bash
      export FOLDER_ID=<folder_ID>
      export IAM_TOKEN=<IAM_token>
      curl --request POST
      -H "Content-Type: application/json"
      -H "Authorization: Bearer ${IAM_TOKEN}"
      -H "x-folder-id: ${FOLDER_ID}"
      -d "@prompt.json"
      "https://llm.api.cloud.yandex.net/llm/v1alpha/instruct"
      ```

      Where:

      * `FOLDER_ID`: ID of the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
      * `IAM_TOKEN`: IAM token received [before starting](#before-begin).

      The service will respond with the generated text:

      ```json
      {
        "result": {
          "alternatives": [
            {
             "text":"Laminate flooring is suitable for installation in the kitchen or in a child's room. It withstands moisture and mechanical damage thanks to a protective layer of melamine films 0.2 mm thick and a wax-treated interlocking system.",
             "score":-0.7030770778656006,
             "num_tokens":"45"
            }
          ]
        }
      }
      ```

{% endlist %}

#### See also {#see-also}

* [Learn more about {{ yagpt-full-name }}](concepts/index.md)
* [Learn about API authentication methods](api-ref/authentication.md)