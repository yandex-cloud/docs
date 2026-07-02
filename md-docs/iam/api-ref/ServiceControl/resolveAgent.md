[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [ServiceControl](index.md) > ResolveAgent

# Identity and Access Management API, REST: ServiceControl.ResolveAgent

Resolve agent service account for the service in the specified resource container.

## HTTP request

```
GET https://iam.api.cloud.yandex.net/iam/v1/service/{serviceId}/microservice/{microserviceId}
```

## Path parameters

#|
||Field | Description ||
|| serviceId | **string**

Required field. ID of the Service.

The maximum string length in characters is 50. ||
|| microserviceId | **string**

Required field. ID of the Microservice.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.iam.v1.ResolveServiceAgentRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](../../concepts/access-control/resources-with-access-control.md).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource.

The maximum string length in characters is 50. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.

The maximum string length in characters is 64. ||
|#

## Response {#yandex.cloud.iam.v1.ServiceAgent}

**HTTP Code: 200 - OK**

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