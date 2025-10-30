---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/assistants/v1/assistants
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. 
          type: string
        name:
          description: |-
            **string**
            Name of the assistant.
          type: string
        description:
          description: |-
            **string**
            Description of the assistant.
          type: string
        expirationConfig:
          description: |-
            **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**
            Expiration configuration for the assistant.
          $ref: '#/definitions/ExpirationConfig'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Set of key-value pairs to label the user.
          type: object
          additionalProperties:
            type: string
        modelUri:
          description: |-
            **string**
            Required field. The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation.
          type: string
        instruction:
          description: |-
            **string**
            Instructions or guidelines that the assistant should follow when generating responses or performing tasks.
            These instructions can help guide the assistant's behavior and responses.
          type: string
        promptTruncationOptions:
          description: |-
            **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**
            Configuration options for truncating the prompt when the token count exceeds a specified limit.
          $ref: '#/definitions/PromptTruncationOptions'
        completionOptions:
          description: |-
            **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**
            Configuration options for completion generation.
          $ref: '#/definitions/CompletionOptions'
        tools:
          description: |-
            **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**
            List of tools that the assistant can use to perform additional tasks.
            One example is the SearchIndexTool, which is used for Retrieval-Augmented Generation (RAG).
          type: array
          items:
            $ref: '#/definitions/Tool'
        responseFormat:
          description: |-
            **[ResponseFormat](#yandex.cloud.ai.assistants.v1.ResponseFormat)**
            Specifies the format of the model's response.
          $ref: '#/definitions/ResponseFormat'
      required:
        - folderId
        - modelUri
      additionalProperties: false
    definitions:
      ExpirationConfig:
        type: object
        properties:
          expirationPolicy:
            description: |-
              **enum** (ExpirationPolicy)
              - `EXPIRATION_POLICY_UNSPECIFIED`
              - `STATIC`
              - `SINCE_LAST_ACTIVE`
            type: string
            enum:
              - EXPIRATION_POLICY_UNSPECIFIED
              - STATIC
              - SINCE_LAST_ACTIVE
          ttlDays:
            description: '**string** (int64)'
            type: string
            format: int64
      AutoStrategy:
        type: object
        properties: {}
      LastMessagesStrategy:
        type: object
        properties:
          numMessages:
            description: |-
              **string** (int64)
              The number of most recent messages to retain in the prompt.
              If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.
            type: string
            format: int64
      PromptTruncationOptions:
        type: object
        properties:
          maxPromptTokens:
            description: |-
              **string** (int64)
              The maximum number of tokens allowed in the prompt.
              If the prompt exceeds this limit, the thread messages will be truncated.
              Default max_prompt_tokens: 7000
            type: string
            format: int64
          autoStrategy:
            description: |-
              **object**
              Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.
              Specifies the truncation strategy to use when the prompt exceeds the token limit.
            $ref: '#/definitions/AutoStrategy'
          lastMessagesStrategy:
            description: |-
              **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**
              Retains only the last `num_messages` messages in the thread.
              If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.
              Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.
              Specifies the truncation strategy to use when the prompt exceeds the token limit.
            $ref: '#/definitions/LastMessagesStrategy'
        oneOf:
          - required:
              - autoStrategy
          - required:
              - lastMessagesStrategy
      CompletionOptions:
        type: object
        properties:
          maxTokens:
            description: |-
              **string** (int64)
              The limit on the number of tokens used for single completion generation.
              Must be greater than zero. This maximum allowed parameter value may depend on the model being used.
            type: string
            format: int64
          temperature:
            description: |-
              **number** (double)
              Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
              Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
              Default temperature: 0.3
            type: number
            format: double
      RephraserOptions:
        type: object
        properties:
          rephraserUri:
            description: |-
              **string**
              Required field. The ID of the model used to rephrase the last user message for search.
            type: string
        required:
          - rephraserUri
      AlwaysCall:
        type: object
        properties: {}
      AutoCall:
        type: object
        properties:
          name:
            description: |-
              **string**
              The name of the tool as exposed to the model.
            type: string
          instruction:
            description: |-
              **string**
              Required field. Required instruction that helps the model decide when to call the tool.
            type: string
        required:
          - instruction
      CallStrategy:
        type: object
        properties:
          alwaysCall:
            description: |-
              **object**
              Includes only one of the fields `alwaysCall`, `autoCall`.
              One of `always_call` or `auto_call`.
              always_call is used if no strategy is explicitly set
            $ref: '#/definitions/AlwaysCall'
          autoCall:
            description: |-
              **[AutoCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall)**
              Includes only one of the fields `alwaysCall`, `autoCall`.
              One of `always_call` or `auto_call`.
              always_call is used if no strategy is explicitly set
            $ref: '#/definitions/AutoCall'
        oneOf:
          - required:
              - alwaysCall
          - required:
              - autoCall
      SearchIndexTool:
        type: object
        properties:
          searchIndexIds:
            description: |-
              **string**
              A list of search index IDs that this tool will query. Currently, only a single index ID is supported.
            type: array
            items:
              type: string
          maxNumResults:
            description: |-
              **string** (int64)
              The maximum number of results to return from the search.
              Fewer results may be returned if necessary to fit within the prompt's token limit.
              This ensures that the combined prompt and search results do not exceed the token constraints.
            type: string
            format: int64
          rephraserOptions:
            description: |-
              **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions)**
              Options for rephrasing user queries.
              Used to rewrite the last user message for search,
              incorporating context from the previous conversation.
            $ref: '#/definitions/RephraserOptions'
          callStrategy:
            description: |-
              **[CallStrategy](#yandex.cloud.ai.assistants.v1.CallStrategy)**
              Defines the strategy for triggering search.
              Controls whether search results are always included or returned only when
              the model explicitly calls the tool.
            $ref: '#/definitions/CallStrategy'
      FunctionTool:
        type: object
        properties:
          name:
            description: |-
              **string**
              The name of the function.
            type: string
          description:
            description: |-
              **string**
              A description of the function's purpose or behavior.
            type: string
          parameters:
            description: |-
              **object**
              A JSON Schema that defines the expected parameters for the function.
              The schema should describe the required fields, their types, and any constraints or default values.
            type: object
      SiteOption:
        type: object
        properties:
          site:
            description: '**string**'
            type: array
            items:
              type: string
      HostOption:
        type: object
        properties:
          host:
            description: '**string**'
            type: array
            items:
              type: string
      UrlOption:
        type: object
        properties:
          url:
            description: '**string**'
            type: array
            items:
              type: string
      SearchFilter:
        type: object
        properties:
          date:
            description: |-
              **string**
              Restrict by document date
              Includes only one of the fields `date`, `lang`, `format`.
              Includes only one of the fields date, lang, format.
            type: string
          lang:
            description: |-
              **string**
              Restrict by document language. Use ISO 639-1 language codes.
              Includes only one of the fields `date`, `lang`, `format`.
              Includes only one of the fields date, lang, format.
            type: string
          format:
            description: |-
              **enum** (DocFormat)
              Restrict by document format.
              Includes only one of the fields `date`, `lang`, `format`.
              Includes only one of the fields date, lang, format.
              - `DOC_FORMAT_UNSPECIFIED`
              - `DOC_FORMAT_PDF`
              - `DOC_FORMAT_XLS`
              - `DOC_FORMAT_ODS`
              - `DOC_FORMAT_RTF`
              - `DOC_FORMAT_PPT`
              - `DOC_FORMAT_ODP`
              - `DOC_FORMAT_SWF`
              - `DOC_FORMAT_ODT`
              - `DOC_FORMAT_ODG`
              - `DOC_FORMAT_DOC`
            type: string
            enum:
              - DOC_FORMAT_UNSPECIFIED
              - DOC_FORMAT_PDF
              - DOC_FORMAT_XLS
              - DOC_FORMAT_ODS
              - DOC_FORMAT_RTF
              - DOC_FORMAT_PPT
              - DOC_FORMAT_ODP
              - DOC_FORMAT_SWF
              - DOC_FORMAT_ODT
              - DOC_FORMAT_ODG
              - DOC_FORMAT_DOC
        oneOf:
          - required:
              - date
          - required:
              - lang
          - required:
              - format
      GenSearchOptions:
        type: object
        properties:
          site:
            description: |-
              **[SiteOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption)**
              Includes only one of the fields `site`, `host`, `url`.
              Restricts the search to the specific websites, hosts or pages.
              Includes only one of the fields site, host, url.
            $ref: '#/definitions/SiteOption'
          host:
            description: |-
              **[HostOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption)**
              Includes only one of the fields `site`, `host`, `url`.
              Restricts the search to the specific websites, hosts or pages.
              Includes only one of the fields site, host, url.
            $ref: '#/definitions/HostOption'
          url:
            description: |-
              **[UrlOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption)**
              Includes only one of the fields `site`, `host`, `url`.
              Restricts the search to the specific websites, hosts or pages.
              Includes only one of the fields site, host, url.
            $ref: '#/definitions/UrlOption'
          enableNrfmDocs:
            description: |-
              **boolean**
              Use the documents inaccessible from the front page.
            type: boolean
          searchFilters:
            description: |-
              **[SearchFilter](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SearchFilter)**
              Restricts the search by date, document formats or language.
            type: array
            items:
              $ref: '#/definitions/SearchFilter'
        oneOf:
          - required:
              - site
          - required:
              - host
          - required:
              - url
      GenSearchTool:
        type: object
        properties:
          options:
            description: |-
              **[GenSearchOptions](#yandex.cloud.ai.assistants.v1.GenSearchOptions)**
              Scoping and filtering rules for the search query
            $ref: '#/definitions/GenSearchOptions'
          description:
            description: |-
              **string**
              Required field. description of the purpose
            type: string
        required:
          - description
      Tool:
        type: object
        properties:
          searchIndex:
            description: |-
              **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**
              SearchIndexTool tool that performs search across specified indexes.
              Includes only one of the fields `searchIndex`, `function`, `genSearch`.
            $ref: '#/definitions/SearchIndexTool'
          function:
            description: |-
              **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**
              Function tool that can be invoked by the assistant.
              Includes only one of the fields `searchIndex`, `function`, `genSearch`.
            $ref: '#/definitions/FunctionTool'
          genSearch:
            description: |-
              **[GenSearchTool](#yandex.cloud.ai.assistants.v1.GenSearchTool)**
              Performs web retrieval and generative synthesis.
              Includes only one of the fields `searchIndex`, `function`, `genSearch`.
            $ref: '#/definitions/GenSearchTool'
        oneOf:
          - required:
              - searchIndex
          - required:
              - function
          - required:
              - genSearch
      JsonSchema:
        type: object
        properties:
          schema:
            description: |-
              **object**
              The JSON Schema that the model's output must conform to.
            type: object
      ResponseFormat:
        type: object
        properties:
          jsonObject:
            description: |-
              **boolean**
              When set to true, the model will respond with a valid JSON object.
              Be sure to explicitly ask the model for JSON.
              Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.
              Includes only one of the fields `jsonObject`, `jsonSchema`.
            type: boolean
          jsonSchema:
            description: |-
              **[JsonSchema](#yandex.cloud.ai.assistants.v1.JsonSchema)**
              Enforces a specific JSON structure for the model's response based on a provided schema.
              Includes only one of the fields `jsonObject`, `jsonSchema`.
            $ref: '#/definitions/JsonSchema'
        oneOf:
          - required:
              - jsonObject
          - required:
              - jsonSchema
sourcePath: en/_api-ref/ai/assistants/v1/assistants/api-ref/Assistant/create.md
---

# AI Assistants API, REST: Assistant.Create

Create a new assistant.

## HTTP request

```
POST https://rest-assistant.{{ api-host }}/assistants/v1/assistants
```

## Body parameters {#yandex.cloud.ai.assistants.v1.CreateAssistantRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "labels": "object",
  "modelUri": "string",
  "instruction": "string",
  "promptTruncationOptions": {
    "maxPromptTokens": "string",
    // Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`
    "autoStrategy": "object",
    "lastMessagesStrategy": {
      "numMessages": "string"
    }
    // end of the list of possible fields
  },
  "completionOptions": {
    "maxTokens": "string",
    "temperature": "number"
  },
  "tools": [
    {
      // Includes only one of the fields `searchIndex`, `function`, `genSearch`
      "searchIndex": {
        "searchIndexIds": [
          "string"
        ],
        "maxNumResults": "string",
        "rephraserOptions": {
          "rephraserUri": "string"
        },
        "callStrategy": {
          // Includes only one of the fields `alwaysCall`, `autoCall`
          "alwaysCall": "object",
          "autoCall": {
            "name": "string",
            "instruction": "string"
          }
          // end of the list of possible fields
        }
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "object"
      },
      "genSearch": {
        "options": {
          // Includes only one of the fields `site`, `host`, `url`
          "site": {
            "site": [
              "string"
            ]
          },
          "host": {
            "host": [
              "string"
            ]
          },
          "url": {
            "url": [
              "string"
            ]
          },
          // end of the list of possible fields
          "enableNrfmDocs": "boolean",
          "searchFilters": [
            {
              // Includes only one of the fields `date`, `lang`, `format`
              "date": "string",
              "lang": "string",
              "format": "string"
              // end of the list of possible fields
            }
          ]
        },
        "description": "string"
      }
      // end of the list of possible fields
    }
  ],
  "responseFormat": {
    // Includes only one of the fields `jsonObject`, `jsonSchema`
    "jsonObject": "boolean",
    "jsonSchema": {
      "schema": "object"
    }
    // end of the list of possible fields
  }
}
```

Request to create a new assistant.

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| name | **string**

Name of the assistant. ||
|| description | **string**

Description of the assistant. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the assistant. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs to label the user. ||
|| modelUri | **string**

Required field. The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| instruction | **string**

Instructions or guidelines that the assistant should follow when generating responses or performing tasks.
These instructions can help guide the assistant's behavior and responses. ||
|| promptTruncationOptions | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that the assistant can use to perform additional tasks.
One example is the SearchIndexTool, which is used for Retrieval-Augmented Generation (RAG). ||
|| responseFormat | **[ResponseFormat](#yandex.cloud.ai.assistants.v1.ResponseFormat)**

Specifies the format of the model's response. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| maxPromptTokens | **string** (int64)

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| autoStrategy | **object**

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| lastMessagesStrategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| numMessages | **string** (int64)

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|| genSearch | **[GenSearchTool](#yandex.cloud.ai.assistants.v1.GenSearchTool)**

Performs web retrieval and generative synthesis.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **string** (int64)

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|| rephraserOptions | **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions)**

Options for rephrasing user queries.
Used to rewrite the last user message for search,
incorporating context from the previous conversation. ||
|| callStrategy | **[CallStrategy](#yandex.cloud.ai.assistants.v1.CallStrategy)**

Defines the strategy for triggering search.
Controls whether search results are always included or returned only when
the model explicitly calls the tool. ||
|#

## RephraserOptions {#yandex.cloud.ai.assistants.v1.RephraserOptions}

Options for configuring the rephrasing the last user message for search using context from previous conversation.

#|
||Field | Description ||
|| rephraserUri | **string**

Required field. The ID of the model used to rephrase the last user message for search. ||
|#

## CallStrategy {#yandex.cloud.ai.assistants.v1.CallStrategy}

Defines when the assistant uses the search tool.

#|
||Field | Description ||
|| alwaysCall | **object**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|| autoCall | **[AutoCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall)**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|#

## AutoCall {#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall}

Exposes the tool as a callable function.
The model decides when to trigger search based on the instruction.

#|
||Field | Description ||
|| name | **string**

The name of the tool as exposed to the model. ||
|| instruction | **string**

Required field. Required instruction that helps the model decide when to call the tool. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#

## GenSearchTool {#yandex.cloud.ai.assistants.v1.GenSearchTool}

#|
||Field | Description ||
|| options | **[GenSearchOptions](#yandex.cloud.ai.assistants.v1.GenSearchOptions)**

Scoping and filtering rules for the search query ||
|| description | **string**

Required field. description of the purpose ||
|#

## GenSearchOptions {#yandex.cloud.ai.assistants.v1.GenSearchOptions}

#|
||Field | Description ||
|| site | **[SiteOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| host | **[HostOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| url | **[UrlOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| enableNrfmDocs | **boolean**

Use the documents inaccessible from the front page. ||
|| searchFilters[] | **[SearchFilter](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SearchFilter)**

Restricts the search by date, document formats or language. ||
|#

## SiteOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption}

Restricts the search to the specific websites.

#|
||Field | Description ||
|| site[] | **string** ||
|#

## HostOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption}

Restricts the search to the specific hosts.

#|
||Field | Description ||
|| host[] | **string** ||
|#

## UrlOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption}

Restricts the search to the specific pages.

#|
||Field | Description ||
|| url[] | **string** ||
|#

## SearchFilter {#yandex.cloud.ai.assistants.v1.GenSearchOptions.SearchFilter}

#|
||Field | Description ||
|| date | **string**

Restrict by document date

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format. ||
|| lang | **string**

Restrict by document language. Use ISO 639-1 language codes.

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format. ||
|| format | **enum** (DocFormat)

Restrict by document format.

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format.

- `DOC_FORMAT_UNSPECIFIED`
- `DOC_FORMAT_PDF`
- `DOC_FORMAT_XLS`
- `DOC_FORMAT_ODS`
- `DOC_FORMAT_RTF`
- `DOC_FORMAT_PPT`
- `DOC_FORMAT_ODP`
- `DOC_FORMAT_SWF`
- `DOC_FORMAT_ODT`
- `DOC_FORMAT_ODG`
- `DOC_FORMAT_DOC` ||
|#

## ResponseFormat {#yandex.cloud.ai.assistants.v1.ResponseFormat}

Specifies the format of the model's response.

#|
||Field | Description ||
|| jsonObject | **boolean**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|| jsonSchema | **[JsonSchema](#yandex.cloud.ai.assistants.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|#

## JsonSchema {#yandex.cloud.ai.assistants.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.Assistant}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "expiresAt": "string",
  "labels": "object",
  "modelUri": "string",
  "instruction": "string",
  "promptTruncationOptions": {
    "maxPromptTokens": "string",
    // Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`
    "autoStrategy": "object",
    "lastMessagesStrategy": {
      "numMessages": "string"
    }
    // end of the list of possible fields
  },
  "completionOptions": {
    "maxTokens": "string",
    "temperature": "number"
  },
  "tools": [
    {
      // Includes only one of the fields `searchIndex`, `function`, `genSearch`
      "searchIndex": {
        "searchIndexIds": [
          "string"
        ],
        "maxNumResults": "string",
        "rephraserOptions": {
          "rephraserUri": "string"
        },
        "callStrategy": {
          // Includes only one of the fields `alwaysCall`, `autoCall`
          "alwaysCall": "object",
          "autoCall": {
            "name": "string",
            "instruction": "string"
          }
          // end of the list of possible fields
        }
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "object"
      },
      "genSearch": {
        "options": {
          // Includes only one of the fields `site`, `host`, `url`
          "site": {
            "site": [
              "string"
            ]
          },
          "host": {
            "host": [
              "string"
            ]
          },
          "url": {
            "url": [
              "string"
            ]
          },
          // end of the list of possible fields
          "enableNrfmDocs": "boolean",
          "searchFilters": [
            {
              // Includes only one of the fields `date`, `lang`, `format`
              "date": "string",
              "lang": "string",
              "format": "string"
              // end of the list of possible fields
            }
          ]
        },
        "description": "string"
      }
      // end of the list of possible fields
    }
  ],
  "responseFormat": {
    // Includes only one of the fields `jsonObject`, `jsonSchema`
    "jsonObject": "boolean",
    "jsonSchema": {
      "schema": "object"
    }
    // end of the list of possible fields
  }
}
```

Assistant represents an AI assistant configuration with various settings and metadata.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the assistant. ||
|| folderId | **string**

ID of the folder that the assistant belongs to. ||
|| name | **string**

Name of the assistant. ||
|| description | **string**

Description of the assistant. ||
|| createdBy | **string**

Identifier of the subject who created this assistant. ||
|| createdAt | **string** (date-time)

Timestamp representing when the assistant was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this assistant. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this assistant was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the assistant, defining when and how the assistant will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the assistant will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the assistant. ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| instruction | **string**

Instructions or guidelines that the assistant should follow when generating responses or performing tasks.
These instructions can help guide the assistant's behavior and responses. ||
|| promptTruncationOptions | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions2)**

Configuration options for truncating the prompt when the token count exceeds a specified limit. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions2)**

Configuration options for completion generation. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool2)**

List of tools that the assistant can use to perform additional tasks.
One example is the SearchIndexTool, which is used for Retrieval-Augmented Generation (RAG). ||
|| responseFormat | **[ResponseFormat](#yandex.cloud.ai.assistants.v1.ResponseFormat2)**

Specifies the format of the model's response. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions2}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| maxPromptTokens | **string** (int64)

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| autoStrategy | **object**

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| lastMessagesStrategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy2)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy2}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| numMessages | **string** (int64)

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions2}

Defines the options for completion generation.

#|
||Field | Description ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool2}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool2)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool2)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|| genSearch | **[GenSearchTool](#yandex.cloud.ai.assistants.v1.GenSearchTool2)**

Performs web retrieval and generative synthesis.

Includes only one of the fields `searchIndex`, `function`, `genSearch`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool2}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **string** (int64)

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|| rephraserOptions | **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions2)**

Options for rephrasing user queries.
Used to rewrite the last user message for search,
incorporating context from the previous conversation. ||
|| callStrategy | **[CallStrategy](#yandex.cloud.ai.assistants.v1.CallStrategy2)**

Defines the strategy for triggering search.
Controls whether search results are always included or returned only when
the model explicitly calls the tool. ||
|#

## RephraserOptions {#yandex.cloud.ai.assistants.v1.RephraserOptions2}

Options for configuring the rephrasing the last user message for search using context from previous conversation.

#|
||Field | Description ||
|| rephraserUri | **string**

Required field. The ID of the model used to rephrase the last user message for search. ||
|#

## CallStrategy {#yandex.cloud.ai.assistants.v1.CallStrategy2}

Defines when the assistant uses the search tool.

#|
||Field | Description ||
|| alwaysCall | **object**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|| autoCall | **[AutoCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall2)**

Includes only one of the fields `alwaysCall`, `autoCall`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|#

## AutoCall {#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall2}

Exposes the tool as a callable function.
The model decides when to trigger search based on the instruction.

#|
||Field | Description ||
|| name | **string**

The name of the tool as exposed to the model. ||
|| instruction | **string**

Required field. Required instruction that helps the model decide when to call the tool. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool2}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#

## GenSearchTool {#yandex.cloud.ai.assistants.v1.GenSearchTool2}

#|
||Field | Description ||
|| options | **[GenSearchOptions](#yandex.cloud.ai.assistants.v1.GenSearchOptions2)**

Scoping and filtering rules for the search query ||
|| description | **string**

Required field. description of the purpose ||
|#

## GenSearchOptions {#yandex.cloud.ai.assistants.v1.GenSearchOptions2}

#|
||Field | Description ||
|| site | **[SiteOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption2)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| host | **[HostOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption2)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| url | **[UrlOption](#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption2)**

Includes only one of the fields `site`, `host`, `url`.

Restricts the search to the specific websites, hosts or pages.
Includes only one of the fields site, host, url. ||
|| enableNrfmDocs | **boolean**

Use the documents inaccessible from the front page. ||
|| searchFilters[] | **[SearchFilter](#yandex.cloud.ai.assistants.v1.GenSearchOptions.SearchFilter2)**

Restricts the search by date, document formats or language. ||
|#

## SiteOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption2}

Restricts the search to the specific websites.

#|
||Field | Description ||
|| site[] | **string** ||
|#

## HostOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption2}

Restricts the search to the specific hosts.

#|
||Field | Description ||
|| host[] | **string** ||
|#

## UrlOption {#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption2}

Restricts the search to the specific pages.

#|
||Field | Description ||
|| url[] | **string** ||
|#

## SearchFilter {#yandex.cloud.ai.assistants.v1.GenSearchOptions.SearchFilter2}

#|
||Field | Description ||
|| date | **string**

Restrict by document date

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format. ||
|| lang | **string**

Restrict by document language. Use ISO 639-1 language codes.

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format. ||
|| format | **enum** (DocFormat)

Restrict by document format.

Includes only one of the fields `date`, `lang`, `format`.

Includes only one of the fields date, lang, format.

- `DOC_FORMAT_UNSPECIFIED`
- `DOC_FORMAT_PDF`
- `DOC_FORMAT_XLS`
- `DOC_FORMAT_ODS`
- `DOC_FORMAT_RTF`
- `DOC_FORMAT_PPT`
- `DOC_FORMAT_ODP`
- `DOC_FORMAT_SWF`
- `DOC_FORMAT_ODT`
- `DOC_FORMAT_ODG`
- `DOC_FORMAT_DOC` ||
|#

## ResponseFormat {#yandex.cloud.ai.assistants.v1.ResponseFormat2}

Specifies the format of the model's response.

#|
||Field | Description ||
|| jsonObject | **boolean**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|| jsonSchema | **[JsonSchema](#yandex.cloud.ai.assistants.v1.JsonSchema2)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`. ||
|#

## JsonSchema {#yandex.cloud.ai.assistants.v1.JsonSchema2}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#