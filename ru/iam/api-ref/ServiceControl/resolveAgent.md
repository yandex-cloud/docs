---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/ServiceControl/resolveAgent.md
---

# Identity and Access Management API, REST: ServiceControl.resolveAgent
Resolve agent service account for the service in the specified resource container.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/service/{serviceId}/microservice/{microserviceId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
serviceId | <p>Required. ID of the Service.</p> <p>The maximum string length in characters is 50.</p> 
microserviceId | <p>ID of the Microservice.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
resource.id | <p>Required. ID of the resource.</p> <p>The maximum string length in characters is 50.</p> 
resource.type | <p>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc.</p> <p>The maximum string length in characters is 64.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "serviceAccountId": "string",
  "serviceId": "string",
  "microserviceId": "string"
}
```

 
Field | Description
--- | ---
serviceAccountId | **string**<br><p>ID of the agent service account.</p> 
serviceId | **string**<br><p>ID of the service.</p> 
microserviceId | **string**<br><p>ID of the microservice.</p> 