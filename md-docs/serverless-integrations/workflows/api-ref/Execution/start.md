[Документация Yandex Cloud](../../../../index.md) > [Yandex Serverless Integrations](../../../index.md) > Справочник API Workflows > [REST (англ.)](../index.md) > [Execution](index.md) > Start

# Workflows Service, REST: Execution.Start

Starts new Workflow execution.

## HTTP request

```
POST https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/start
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

Required field. ID of the Workflow execution. ||
|#

## HTTP request

```
POST https://serverless-workflows.api.cloud.yandex.net/workflows/v1/execution/{workflowId}/start
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

Required field. ID of the Workflow execution. ||
|#