[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > Справочник API Workflows > [gRPC (англ.)](../index.md) > [Execution](index.md) > Terminate

# Workflows Service, gRPC: ExecutionService.Terminate

Terminates specified Workflow execution.

## gRPC request

**rpc Terminate ([TerminateExecutionRequest](#yandex.cloud.serverless.workflows.v1.TerminateExecutionRequest)) returns ([TerminateExecutionResponse](#yandex.cloud.serverless.workflows.v1.TerminateExecutionResponse))**

## TerminateExecutionRequest {#yandex.cloud.serverless.workflows.v1.TerminateExecutionRequest}

```json
{
  "execution_id": "string"
}
```

#|
||Field | Description ||
|| execution_id | **string**

Required field. ID of the Workflow execution. ||
|#

## TerminateExecutionResponse {#yandex.cloud.serverless.workflows.v1.TerminateExecutionResponse}

```json
{
  "execution_id": "string"
}
```

#|
||Field | Description ||
|| execution_id | **string**

Required field. ID of the Workflow execution. ||
|#