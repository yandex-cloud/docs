---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceControl/resolveAgent.md
---

# Identity and Access Management API, gRPC: ServiceControlService.ResolveAgent {#ResolveAgent}

Resolve agent service account for the service in the specified resource container.

## gRPC request

**rpc ResolveAgent ([ResolveServiceAgentRequest](#yandex.cloud.iam.v1.ResolveServiceAgentRequest)) returns ([ServiceAgent](#yandex.cloud.iam.v1.ServiceAgent))**

## ResolveServiceAgentRequest {#yandex.cloud.iam.v1.ResolveServiceAgentRequest}

```json
{
  "serviceId": "string",
  "microserviceId": "string",
  "resource": {
    "id": "string",
    "type": "string"
  }
}
```

#|
||Field | Description ||
|| serviceId | **string**

Required field. ID of the Service. ||
|| microserviceId | **string**

ID of the Microservice. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
|#

## ServiceAgent {#yandex.cloud.iam.v1.ServiceAgent}

```json
{
  "serviceAccountId": "string",
  "serviceId": "string",
  "microserviceId": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the agent service account. ||
|| serviceId | **string**

ID of the service. ||
|| microserviceId | **string**

ID of the microservice. ||
|#