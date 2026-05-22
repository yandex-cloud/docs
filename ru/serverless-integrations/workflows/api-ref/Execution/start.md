---
editable: false
apiPlayground:
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/start
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
        input:
          description: |-
            **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**
            Input for the Workflow execution
          $ref: '#/definitions/ExecutionInput'
      required:
        - workflowId
      additionalProperties: false
    definitions:
      object:
        type: object
        properties: {}
      ListValue:
        type: object
        properties:
          values:
            description: '**[Value](#google.protobuf.Value)**'
            type: array
            items:
              $ref: '#/definitions/Value'
      Value:
        type: object
        properties:
          nullValue:
            description: |
              **enum** (NullValue)
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
            enum:
              - NULL_VALUE
          numberValue:
            description: |-
              **string**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
          stringValue:
            description: |-
              **string**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
          boolValue:
            description: |-
              **boolean**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: boolean
          structValue:
            description: |-
              **object**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            $ref: '#/definitions/object'
          listValue:
            description: |-
              **[ListValue](#google.protobuf.ListValue)**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            $ref: '#/definitions/ListValue'
        oneOf:
          - required:
              - nullValue
          - required:
              - numberValue
          - required:
              - stringValue
          - required:
              - boolValue
          - required:
              - structValue
          - required:
              - listValue
      ExecutionInput:
        type: object
        properties:
          inputJson:
            description: |-
              **string**
              JSON input data for the Workflow execution.
              Includes only one of the fields `inputJson`, `inputValue`.
            type: string
          inputValue:
            description: |-
              **[Value](#google.protobuf.Value)**
              Input value for the Workflow execution.
              Includes only one of the fields `inputJson`, `inputValue`.
            $ref: '#/definitions/Value'
        oneOf:
          - required:
              - inputJson
          - required:
              - inputValue
  - url: https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{workflowId}/start
    method: post
    path:
      type: object
      properties:
        workflowId:
          description: |-
            **string**
            Required field. ID of the Workflow.
          type: string
      required:
        - workflowId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        input:
          description: |-
            **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**
            Input for the Workflow execution
          $ref: '#/definitions/ExecutionInput'
      additionalProperties: false
    definitions:
      object:
        type: object
        properties: {}
      ListValue:
        type: object
        properties:
          values:
            description: '**[Value](#google.protobuf.Value)**'
            type: array
            items:
              $ref: '#/definitions/Value'
      Value:
        type: object
        properties:
          nullValue:
            description: |
              **enum** (NullValue)
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
            enum:
              - NULL_VALUE
          numberValue:
            description: |-
              **string**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
          stringValue:
            description: |-
              **string**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: string
          boolValue:
            description: |-
              **boolean**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            type: boolean
          structValue:
            description: |-
              **object**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            $ref: '#/definitions/object'
          listValue:
            description: |-
              **[ListValue](#google.protobuf.ListValue)**
              Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.
            $ref: '#/definitions/ListValue'
        oneOf:
          - required:
              - nullValue
          - required:
              - numberValue
          - required:
              - stringValue
          - required:
              - boolValue
          - required:
              - structValue
          - required:
              - listValue
      ExecutionInput:
        type: object
        properties:
          inputJson:
            description: |-
              **string**
              JSON input data for the Workflow execution.
              Includes only one of the fields `inputJson`, `inputValue`.
            type: string
          inputValue:
            description: |-
              **[Value](#google.protobuf.Value)**
              Input value for the Workflow execution.
              Includes only one of the fields `inputJson`, `inputValue`.
            $ref: '#/definitions/Value'
        oneOf:
          - required:
              - inputJson
          - required:
              - inputValue
---

# Workflows Service, REST: Execution.Start

Starts new Workflow execution.

## HTTP request

```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/start
```

## Body parameters {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest}

```json
{
  "workflowId": "string",
  "input": {
    // Includes only one of the fields `inputJson`, `inputValue`
    "inputJson": "string",
    "inputValue": {
      // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
      "nullValue": "string",
      "numberValue": "string",
      "stringValue": "string",
      "boolValue": "boolean",
      "structValue": "object",
      "listValue": {
        "values": [
          "object"
        ]
      }
      // end of the list of possible fields
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`, `inputValue`. ||
|| inputValue | **[Value](#google.protobuf.Value)**

Input value for the Workflow execution.

Includes only one of the fields `inputJson`, `inputValue`. ||
|#

## Value {#google.protobuf.Value}

#|
||Field | Description ||
|| nullValue | **enum** (NullValue)

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.

 ||
|| numberValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| stringValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| boolValue | **boolean**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| structValue | **object**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| listValue | **[ListValue](#google.protobuf.ListValue)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|#

## ListValue {#google.protobuf.ListValue}

#|
||Field | Description ||
|| values[] | **[Value](#google.protobuf.Value)** ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse}

**HTTP Code: 200 - OK**

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

ID of the Workflow execution. ||
|#

## HTTP request

```
POST https://serverless-workflows.{{ api-host }}/workflows/v1/execution/{workflowId}/start
```

## Path parameters

#|
||Field | Description ||
|| workflowId | **string**

Required field. ID of the Workflow. ||
|#

## Body parameters {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest2}

```json
{
  "input": {
    // Includes only one of the fields `inputJson`, `inputValue`
    "inputJson": "string",
    "inputValue": {
      // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
      "nullValue": "string",
      "numberValue": "string",
      "stringValue": "string",
      "boolValue": "boolean",
      "structValue": "object",
      "listValue": {
        "values": [
          "object"
        ]
      }
      // end of the list of possible fields
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput2)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput2}

#|
||Field | Description ||
|| inputJson | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `inputJson`, `inputValue`. ||
|| inputValue | **[Value](#google.protobuf.Value2)**

Input value for the Workflow execution.

Includes only one of the fields `inputJson`, `inputValue`. ||
|#

## Value {#google.protobuf.Value2}

#|
||Field | Description ||
|| nullValue | **enum** (NullValue)

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.

 ||
|| numberValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| stringValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| boolValue | **boolean**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| structValue | **object**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| listValue | **[ListValue](#google.protobuf.ListValue2)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|#

## ListValue {#google.protobuf.ListValue2}

#|
||Field | Description ||
|| values[] | **[Value](#google.protobuf.Value2)** ||
|#

## Response {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse2}

**HTTP Code: 200 - OK**

```json
{
  "executionId": "string"
}
```

#|
||Field | Description ||
|| executionId | **string**

ID of the Workflow execution. ||
|#