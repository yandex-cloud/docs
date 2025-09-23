---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/assistants/v1/threads
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
        messages:
          description: |-
            **[MessageData](/docs/assistants/api-ref/Thread/create#yandex.cloud.ai.assistants.v1.threads.MessageData)**
            List of messages to initialize the thread.
          type: array
          items:
            $ref: '#/definitions/MessageData'
        name:
          description: |-
            **string**
            Name of the thread.
          type: string
        description:
          description: |-
            **string**
            Description of the thread.
          type: string
        defaultMessageAuthorId:
          description: |-
            **string**
            Default user ID that will be used as the author for thread messages if no other author is specified.
          type: string
        expirationConfig:
          description: |-
            **`ExpirationConfig`**
            Expiration configuration for the thread.
          $ref: '#/definitions/ExpirationConfig'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Set of key-value pairs to label the thread.
          type: string
        tools:
          description: |-
            **[Tool](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.Tool)**
            List of tools that are available for assistants to use in this thread.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  searchIndex:
                    description: |-
                      **[SearchIndexTool](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.SearchIndexTool)**
                      SearchIndexTool tool that performs search across specified indexes.
                      Includes only one of the fields `searchIndex`, `function`, `genSearch`.
                    $ref: '#/definitions/SearchIndexTool'
                  function:
                    description: |-
                      **[FunctionTool](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.FunctionTool)**
                      Function tool that can be invoked by the assistant.
                      Includes only one of the fields `searchIndex`, `function`, `genSearch`.
                    $ref: '#/definitions/FunctionTool'
                  genSearch:
                    description: |-
                      **[GenSearchTool](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.GenSearchTool)**
                      Performs web retrieval and generative synthesis.
                      Includes only one of the fields `searchIndex`, `function`, `genSearch`.
                    $ref: '#/definitions/GenSearchTool'
      required:
        - folderId
      additionalProperties: false
    definitions:
      Author:
        type: object
        properties:
          id:
            description: |-
              **string**
              Unique identifier of the author. This could be either the user's ID or the assistant's ID, depending on the role.
            type: string
          role:
            description: |-
              **string**
              Role of the author, indicating whether the message was created by a "user" or an "assistant".
            type: string
      Text:
        type: object
        properties:
          content:
            description: |-
              **string**
              Text content of the message.
            type: string
      MessageContent:
        type: object
        properties:
          content:
            description: |-
              **[ContentPart](/docs/assistants/api-ref/Message/create#yandex.cloud.ai.assistants.v1.threads.ContentPart)**
              A list of content parts that make up the message.
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    text:
                      description: |-
                        **[Text](/docs/assistants/api-ref/Message/create#yandex.cloud.ai.assistants.v1.threads.Text)**
                        Text content of the message part.
                        Includes only one of the fields `text`.
                        Specifies the type of content that the part contains.
                      $ref: '#/definitions/Text'
      MessageData:
        type: object
        properties:
          author:
            description: |-
              **[Author](/docs/assistants/api-ref/Message/create#yandex.cloud.ai.assistants.v1.threads.Author)**
              Author of the message, containing details about the message's creator.
            $ref: '#/definitions/Author'
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Set of key-value pairs that can be used to organize and categorize the message.
            type: string
          content:
            description: |-
              **[MessageContent](/docs/assistants/api-ref/Message/create#yandex.cloud.ai.assistants.v1.threads.MessageContent)**
              Content of the message.
            $ref: '#/definitions/MessageContent'
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
              **[RephraserOptions](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.RephraserOptions)**
              Options for rephrasing user queries.
              Used to rewrite the last user message for search,
              incorporating context from the previous conversation.
            $ref: '#/definitions/RephraserOptions'
          callStrategy:
            description: |-
              **[CallStrategy](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.CallStrategy)**
              Defines the strategy for triggering search.
              Controls whether search results are always included or returned only when
              the model explicitly calls the tool.
            oneOf:
              - type: object
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
                      **[AutoCall](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall)**
                      Includes only one of the fields `alwaysCall`, `autoCall`.
                      One of `always_call` or `auto_call`.
                      always_call is used if no strategy is explicitly set
                    $ref: '#/definitions/AutoCall'
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
      GenSearchTool:
        type: object
        properties:
          options:
            description: |-
              **[GenSearchOptions](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.GenSearchOptions)**
              Scoping and filtering rules for the search query
            oneOf:
              - type: object
                properties:
                  site:
                    description: |-
                      **[SiteOption](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.GenSearchOptions.SiteOption)**
                      Includes only one of the fields `site`, `host`, `url`.
                      Restricts the search to the specific websites, hosts or pages.
                      Includes only one of the fields site, host, url.
                    $ref: '#/definitions/SiteOption'
                  host:
                    description: |-
                      **[HostOption](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.GenSearchOptions.HostOption)**
                      Includes only one of the fields `site`, `host`, `url`.
                      Restricts the search to the specific websites, hosts or pages.
                      Includes only one of the fields site, host, url.
                    $ref: '#/definitions/HostOption'
                  url:
                    description: |-
                      **[UrlOption](/docs/assistants/api-ref/Assistant/create#yandex.cloud.ai.assistants.v1.GenSearchOptions.UrlOption)**
                      Includes only one of the fields `site`, `host`, `url`.
                      Restricts the search to the specific websites, hosts or pages.
                      Includes only one of the fields site, host, url.
                    $ref: '#/definitions/UrlOption'
          description:
            description: |-
              **string**
              Required field. description of the purpose
            type: string
        required:
          - description
sourcePath: en/_api-ref/ai/assistants/v1/threads/api-ref/Thread/create.md
---

# Threads, REST: Thread.Create

Create a new thread.

## HTTP request

```
POST https://rest-assistant.{{ api-host }}/assistants/v1/threads
```

## Body parameters {#yandex.cloud.ai.assistants.v1.threads.CreateThreadRequest}

```json
{
  "folderId": "string",
  "messages": [
    {
      "author": {
        "id": "string",
        "role": "string"
      },
      "labels": "object",
      "content": {
        "content": [
          {
            // Includes only one of the fields `text`
            "text": {
              "content": "string"
            }
            // end of the list of possible fields
          }
        ]
      }
    }
  ],
  "name": "string",
  "description": "string",
  "defaultMessageAuthorId": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "labels": "object",
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
  ]
}
```

Request message for creating a new thread.

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| messages[] | **[MessageData](#yandex.cloud.ai.assistants.v1.threads.MessageData)**

List of messages to initialize the thread. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| defaultMessageAuthorId | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the thread. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs to label the thread. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that are available for assistants to use in this thread. ||
|#

## MessageData {#yandex.cloud.ai.assistants.v1.threads.MessageData}

Represents the data required to create or initialize a message in a thread.
This message is used, for example, to initialize a thread with some messages upon its creation.

#|
||Field | Description ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the message. ||
|| content | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Content of the message. ||
|#

## Author {#yandex.cloud.ai.assistants.v1.threads.Author}

Author of the message, containing details about the message's creator.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the author. This could be either the user's ID or the assistant's ID, depending on the role. ||
|| role | **string**

Role of the author, indicating whether the message was created by a "user" or an "assistant". ||
|#

## MessageContent {#yandex.cloud.ai.assistants.v1.threads.MessageContent}

Represents the content of a message, which can consist of multiple parts.

#|
||Field | Description ||
|| content[] | **[ContentPart](#yandex.cloud.ai.assistants.v1.threads.ContentPart)**

A list of content parts that make up the message. ||
|#

## ContentPart {#yandex.cloud.ai.assistants.v1.threads.ContentPart}

ContentPart represents an individual part of the message content, which can be of various types.

#|
||Field | Description ||
|| text | **[Text](#yandex.cloud.ai.assistants.v1.threads.Text)**

Text content of the message part.

Includes only one of the fields `text`.

Specifies the type of content that the part contains. ||
|#

## Text {#yandex.cloud.ai.assistants.v1.threads.Text}

Text represents a textual content part of a message.

#|
||Field | Description ||
|| content | **string**

Text content of the message. ||
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

## Response {#yandex.cloud.ai.assistants.v1.threads.Thread}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "defaultMessageAuthorId": "string",
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
  ]
}
```

#|
||Field | Description ||
|| id | **string**

Unique identifier of the thread. ||
|| folderId | **string**

ID of the folder that the thread belongs to. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| defaultMessageAuthorId | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| createdBy | **string**

Identifier of the subject who created this thread. ||
|| createdAt | **string** (date-time)

Timestamp representing when the thread was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this thread. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this thread was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the thread will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the thread. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool2)**

List of tools that are available for assistants to use in this thread. ||
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