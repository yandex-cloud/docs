# Formatting of model responses

By default, the model returns a response formatted using [Markdown](https://en.wikipedia.org/wiki/Markdown). Use the prompt text to get a response with additional formatting, e.g., with [emoji](https://en.wikipedia.org/wiki/Emoji), or in a different format, e.g., [JSON](https://en.wikipedia.org/wiki/JSON), [XML](https://en.wikipedia.org/wiki/XML), etc.

Example:

```json
{
  "modelUri": "gpt://<folder_ID>/yandexgpt/latest",
  "completionOptions": {
    "stream": false,
    "temperature": 0.6,
    "maxTokens": "2000",
    "reasoningOptions": {
      "mode": "DISABLED"
    }
  },
  "messages": [
    {
      "role": "system",
      "text": "You are a smart assistant."
    },
    {
      "role": "user",
      "text": "Name any three groups of grocery store products. For each group, give three subgroups. Present the result as a JSON object, where each group of products is represented by a key in the JSON object, and arrays from the relevant subgroups are the values. No introductory phrases or explanations needed, just data. Do not use Markdown."
    }
  ]
}
```

Result:

```json
{
  "result": {
    "alternatives": [
      {
        "message": {
          "role": "assistant",
          "text": "{\n    \"meat\": [\"beef\", \"pork\", \"mutton\"],\n    \"dairy products\": [\"milk\", \"curd\", \"sour cream\"],\n    \"fruit\": [\"apples\", \"bananas\", \"oranges\"]\n}"
        },
        "status": "ALTERNATIVE_STATUS_FINAL"
      }
    ],
    "usage": {
      "inputTextTokens": "87",
      "completionTokens": "58",
      "totalTokens": "145"
    },
    "modelVersion": "07.03.2024"
  }
}
```

The model returned a response in JSON format with line breaks replaced with `\n` and quotation marks escaped.

If you do not get the result you expect using the prompt, try [fine-tuning](../tuning/index.md) the model.

### API parameters for saving the response structure {#structured-output}

Some text generation models support additional control over the response format not only via prompt, but also via query parameters. This way you can use the response formatting options to specify that you want the response in JSON format. There are two options to choose from:

1. JSON with any structure:

   {% list tabs group=programming_language %}

   - SDK {#sdk}

     ```python
     #!/usr/bin/env python3

     from __future__ import annotations

     import json

     import pydantic

     from yandex_cloud_ml_sdk import YCloudML

     text = """
     Name any three groups of grocery store products. 
     For each group, give three subgroups. 
     Present the result in JSON format.
     """


     def main() -> None:
         sdk = YCloudML(
             folder_id="<folder_ID>",
             auth="<API_key>",
         )

         model = sdk.models.completions("yandexgpt", model_version="rc")

         model = model.configure(response_format="json")
         result = model.run(
             [
                 {"role": "user", "text": text},
             ]
         )
         print("JSON result:", result[0].text)


     if __name__ == "__main__":
         main()
     ```

   - API {#api}

     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt/rc",
       "completionOptions": {
         "stream": false
       },
       "messages": [
         {
           "role": "user",
           "text": "Name any three groups of grocery store products. For each group, give three subgroups. Present the result in JSON format."
         }
       ],
       "json_object": true
     }
     ```

   {% endlist %}

   {% note tip %}

   If you want the response to be a JSON with any structure, be sure to additionally specify this in words in your prompt. Otherwise, the model may add extra brackets, spaces, indents and generate excessive tokens.

   {% endnote %}

1. JSON strictly following the specified schema:

   {% list tabs group=programming_language %}

   - SDK {#sdk}

     ```python
     #!/usr/bin/env python3

     from __future__ import annotations

     import json

     import pydantic

     from yandex_cloud_ml_sdk import YCloudML

     text = "Name the date of Gagarin's first flight."


     def main() -> None:
         sdk = YCloudML(
             folder_id="<folder_ID>",
             auth="<API_key>",
         )

         model = sdk.models.completions("yandexgpt", model_version="rc")

         model = model.configure(
             response_format={
                 "json_schema": {
                     "properties": {
                         "day": {
                             "title": "Day",
                             "description": "Day of the month",
                             "type": "integer",
                         },
                         "month": {
                             "title": "Month",
                             "description": "Month, in a word",
                             "type": "string",
                         },
                         "year": {
                             "title": "Year",
                             "description": "Year",
                             "type": "integer",
                         },
                     },
                     "required": ["day", "month", "year"],
                     "type": "object",
                 }
             }
         )
         result = model.run(
             [
                 {"role": "user", "text": text},
             ]
         )
         print("JSON result:", result[0].text)


     if __name__ == "__main__":
         main()
     ```

   - API {#api}

     ```json
     {
       "modelUri": "gpt://<folder_ID>/yandexgpt/rc",
       "completionOptions": {
         "stream": false
       },
       "messages": [
         {
           "role": "user",
           "text": "Name the date of Gagarin's first flight."
         }
       ],
       "json_schema": {
         "schema": {
           "properties": {
             "day": {
               "title": "Day",
               "description": "Day of the month",
               "type": "integer"
             },
             "month": {
               "title": "Month",
               "description": "Month, in a word",
               "type": "string"
             },
             "year": {
               "title": "Year",
               "description": "Year",
               "type": "integer"
             }
           },
           "required": [
             "day",
             "month",
             "year"
           ],
           "type": "object"
         }
       }
     }
     ```

   {% endlist %}

A strict response structure is required when working with external tools using [function calls](./function-call.md). Response structuring is supported in the {{ gpt-pro }} 5th generation model (RC branch).
