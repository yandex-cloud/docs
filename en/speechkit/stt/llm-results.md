# Using LLMs to process recognition results

With the {{ speechkit-name }} API v3, you can recognize audio and also process recognition results using large language models. This means you can automate processing of speech recognition results, e.g., instantly summarize the recognized audio, use the audio to add data to your CRM, or translate the conversation into English.

To use generative models in audio recognition, fill in the `summarization` section in the request configuration. You can specify only a text _[prompt](../../ai-studio/concepts/index.md#prompt)_ for the model or provide the response structure as JSON. For more information on the response structure, see [{{ foundation-models-name }} documentation](../../ai-studio/concepts/generation/structured-output.md). To work with generative models in the {{ speechkit-name }} API v3, you need the `ai.languageModels.user` role or [higher](../../ai-studio/security/index.md#service-roles).

{% list tabs %}

- Simple response

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<folder_ID>/<model_name>",
      "properties": [
        {
          "instruction": "Model prompt"
        }
      ]
    }
    ...
  }
  ```

- Arbitrary JSON

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<folder_ID>/<model_name>",
      "properties": [
        {
          "instruction": "Model prompt requiring a structured output"
          "jsonObject": true
        }
      ]
    }
    ...
  }
  ```

- Strict JSON schema

  ```json
  {
  ...
    "summarization": {
      "modelUri": "gpt://<folder_ID>/<model_name>",
      "properties": [
        {
          "instruction": "Model prompt requiring a structured output"
          "jsonSchema": {
            // Specified output schema 
            "schema": "<json_schema>"
          }
        }
      ]
    }
    ...
  }
  ```

{% endlist %}

Where: 
* `modelUri`: [Model](../../ai-studio/concepts/generation/models.md) available _in synchronous mode_.
* `instruction`: Model prompt (_Highlight the main points_, _Translate into English_).
* `jsonObject`: If `true`, the model will return JSON output in arbitrary formatting.
* `jsonSchema`: Schema for strictly formatted JSON output.


The model will return its results in the `summarization` object:

```json

{
...
  "result": {
    "summarization": {
      "results": [
        {
          "response": "LLM-generated text"
        },
        {
          "response": "LLM-generated JSON"
        }
      ],
      "contentUsage": {
        "inputTextTokens": 150,    // Input tokens
        "completionTokens": 80,    // Output tokens
        "totalTokens": 230         // Total consumption
      }
    }
  }
...
}
```

The `contentUsage` field contains [token](../../ai-studio/concepts/generation/tokens.md) usage details. Calculated according to the [{{ foundation-models-name }} pricing policy](../../ai-studio/pricing.md), the cost of use depends on the selected model and total number of input and output tokens indicated in `totalTokens`.