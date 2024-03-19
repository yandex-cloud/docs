# Getting started with {{ yagpt-full-name }}

In this section, you will learn how to use a neural network for generating texts.

For information about {{ yagpt-full-name }} usage costs, see [{#T}](pricing.md).

{% include notitle [preview-stage](../_includes/yandexgpt/preview.md) %}

## Getting started {#before-begin}

You can start working from the management console right away.

To run sample requests using the API, install [cURL](https://curl.haxx.se).

{% include notitle [ai-before-beginning](../_includes/yandexgpt/ai-before-beginning.md) %}

## Generate the text {#generate-text}

{% note info %}

To improve the quality of generated responses, {{ yagpt-full-name }} logs user prompts. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `{{ roles-yagpt-user }}` role or higher.
   1. In the list of services, select **{{ yagpt-name }}**.
   1. In the left-hand panel, select ![image](../_assets/console-icons/dice-3.svg) **{{ ui-key.yacloud.yagpt.label_promt }}**.
   1. Describe the request context under **{{ ui-key.yacloud.yagpt.label_instruction-text }}**.
   1. Describe your request to the model under **{{ ui-key.yacloud.yagpt.label_request-text }}**.
   1. In the **{{ ui-key.yacloud.yagpt.label_temperature-text }}** field, enter a value between `0` and `1` that determines the versatility of the model's response. With a higher value, you get less deterministic request result.
   1. Click **{{ ui-key.yacloud.yagpt.label_button-instruct-submit }}**. The answer will be shown on the right part of the screen.

- API {#api}

   1. Create a file with the request body (for example, `prompt.json`).

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
            "text": "Find errors in the text and fix them"
          },
          {
            "role": "user",
            "text": "Laminate flooring is sutiable for instalation in the kitchen or in a child's room. It withsatnds moisturre and mechanical dammage thanks to a proctive layer of melamine films 0.2 mm thick and a wax-treated interlocking systme."
          }
        ]
      }
      ```

      Where:

      {% include [api-parameters](../_includes/yandexgpt/api-parameters.md) %}

   1. Use the [completion](./text-generation/api-ref/TextGeneration/completion.md) method to send a request to the neural network in the following command:

      ```bash
      export FOLDER_ID=<folder_ID>
      export IAM_TOKEN=<IAM_token>
      curl --request POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -H "x-folder-id: ${FOLDER_ID}" \
        -d "@prompt.json" \
        "https://llm.{{ api-host }}/foundationModels/v1/completion"
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
              "message": {
                "role": "assistant",
                "text": "Laminate flooring is suitable for installation in the kitchen or in a child's room. It withstands moisture and mechanical damage thanks to a protective layer of melamine films 0.2 mm thick and a wax-treated interlocking system."
              },
              "status": "ALTERNATIVE_STATUS_TRUNCATED_FINAL"
            }
          ],
          "usage": {
            "inputTextTokens": "67",
            "completionTokens": "50",
            "totalTokens": "117"
          },
          "modelVersion": "06.12.2023"
        }
      }
      ```

{% endlist %}

#### See also {#see-also}

* [Learn more about {{ yagpt-full-name }}](concepts/index.md)
* [Learn about API authentication methods](api-ref/authentication.md)
