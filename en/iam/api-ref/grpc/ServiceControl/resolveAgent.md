---
editable: false
---

# Identity and Access Management API, gRPC: ServiceControlService.ResolveAgent

Resolve agent service account for the service in the specified resource container.

## gRPC request

**rpc ResolveAgent ([ResolveServiceAgentRequest](#yandex.cloud.iam.v1.ResolveServiceAgentRequest)) returns ([ServiceAgent](#yandex.cloud.iam.v1.ServiceAgent))**

## ResolveServiceAgentRequest {#yandex.cloud.iam.v1.ResolveServiceAgentRequest}

```json
{
  "service_id": "string",
  "microservice_id": "string",
  "resource": {
    "id": "string",
    "type": "string"
  }
}
```

#|
||Field | Description ||
|| service_id | **string**

Required field. ID of the Service.

The maximum string length in characters is 50. ||
|| microservice_id | **string**

ID of the Microservice.

The maximum string length in characters is 50. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource.

The maximum string length in characters is 50. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.

The maximum string length in characters is 64. ||
|#

## ServiceAgent {#yandex.cloud.iam.v1.ServiceAgent}

```json
{
  "service_account_id": "string",
  "service_id": "string",
  "microservice_id": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

ID of the agent service account. ||
|| service_id | **string**

ID of the service. ||
|| microservice_id | **string**

ID of the microservice. ||
|#