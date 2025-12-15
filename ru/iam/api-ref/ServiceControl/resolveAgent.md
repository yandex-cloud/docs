---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/service/{serviceId}/microservice/{microserviceId}
    method: get
    path:
      type: object
      properties:
        serviceId:
          description: |-
            **string**
            Required field. ID of the Service.
            The maximum string length in characters is 50.
          type: string
        microserviceId:
          description: |-
            **string**
            ID of the Microservice.
            The maximum string length in characters is 50.
          type: string
      required:
        - serviceId
      additionalProperties: false
    query:
      type: object
      properties:
        resource:
          description: |-
            **[Resource](#yandex.cloud.iam.v1.Resource)**
            Required field. Resource container.
          $ref: '#/definitions/Resource'
      required:
        - resource
      additionalProperties: false
    body: null
    definitions:
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the resource.
              The maximum string length in characters is 50.
            type: string
          type:
            description: |-
              **string**
              Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.
              The maximum string length in characters is 64.
            type: string
        required:
          - id
          - type
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/resolveAgent.md
---

# Identity and Access Management API, REST: ServiceControl.ResolveAgent

Resolve agent service account for the service in the specified resource container.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/service/{serviceId}/microservice/{microserviceId}
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