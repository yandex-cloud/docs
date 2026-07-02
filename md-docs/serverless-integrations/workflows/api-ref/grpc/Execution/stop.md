[Документация Yandex Cloud](../../../../../index.md) > [Yandex Serverless Integrations](../../../../index.md) > Справочник API Workflows > [gRPC (англ.)](../index.md) > [Execution](index.md) > Stop

# Workflows Service, gRPC: ExecutionService.Stop

Stops specified Workflow execution.

## gRPC request

**rpc Stop ([StopExecutionRequest](#yandex.cloud.serverless.workflows.v1.StopExecutionRequest)) returns ([StopExecutionResponse](#yandex.cloud.serverless.workflows.v1.StopExecutionResponse))**

## StopExecutionRequest {#yandex.cloud.serverless.workflows.v1.StopExecutionRequest}

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

## StopExecutionResponse {#yandex.cloud.serverless.workflows.v1.StopExecutionResponse}

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