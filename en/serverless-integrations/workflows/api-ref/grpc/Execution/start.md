---
editable: false
---

# Workflows Service, gRPC: ExecutionService.Start

Starts new Workflow execution.

## gRPC request

**rpc Start ([StartExecutionRequest](#yandex.cloud.serverless.workflows.v1.StartExecutionRequest)) returns ([StartExecutionResponse](#yandex.cloud.serverless.workflows.v1.StartExecutionResponse))**

## StartExecutionRequest {#yandex.cloud.serverless.workflows.v1.StartExecutionRequest}

```json
{
  "workflow_id": "string",
  "input": {
    // Includes only one of the fields `input_json`, `input_value`
    "input_json": "string",
    "input_value": {
      // Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`
      "nullValue": "NullValue",
      "numberValue": "double",
      "stringValue": "string",
      "boolValue": "bool",
      "structValue": "google.protobuf.Struct",
      "listValue": {
        "values": [
          "Value"
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
|| workflow_id | **string**

Required field. ID of the Workflow. ||
|| input | **[ExecutionInput](#yandex.cloud.serverless.workflows.v1.ExecutionInput)**

Input for the Workflow execution ||
|#

## ExecutionInput {#yandex.cloud.serverless.workflows.v1.ExecutionInput}

#|
||Field | Description ||
|| input_json | **string**

JSON input data for the Workflow execution.

Includes only one of the fields `input_json`, `input_value`. ||
|| input_value | **[Value](#google.protobuf.Value)**

Input value for the Workflow execution.

Includes only one of the fields `input_json`, `input_value`. ||
|#

## Value {#google.protobuf.Value}

#|
||Field | Description ||
|| nullValue | enum **NullValue**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`.

 ||
|| numberValue | **double**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| stringValue | **string**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| boolValue | **bool**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| structValue | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|| listValue | **[ListValue](#google.protobuf.ListValue)**

Includes only one of the fields `nullValue`, `numberValue`, `stringValue`, `boolValue`, `structValue`, `listValue`. ||
|#

## ListValue {#google.protobuf.ListValue}

#|
||Field | Description ||
|| values[] | **[Value](#google.protobuf.Value)** ||
|#

## StartExecutionResponse {#yandex.cloud.serverless.workflows.v1.StartExecutionResponse}

```json
{
  "execution_id": "string"
}
```

#|
||Field | Description ||
|| execution_id | **string**

ID of the Workflow execution. ||
|#