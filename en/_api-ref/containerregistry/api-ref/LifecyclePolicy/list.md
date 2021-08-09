---
editable: false
---

# Method list
Retrieves the list of lifecycle policies in the specified repository.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/lifecyclePolicies
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | ID of the lifecycle policy.  The maximum string length in characters is 50.
repositoryId | Repository of the lifecycle policy.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns  a [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters lifecycle policy resources listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
orderBy | Sorting the list by [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy#representation), [LifecyclePolicy.createdAt](/docs/container-registry/api-ref/LifecyclePolicy#representation) and [LifecyclePolicy.status](/docs/container-registry/api-ref/LifecyclePolicy#representation) fields. The default sorting order is ascending.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "lifecyclePolicies": [
    {
      "id": "string",
      "name": "string",
      "repositoryId": "string",
      "description": "string",
      "status": "string",
      "createdAt": "string",
      "rules": [
        {
          "description": "string",
          "expirePeriod": "string",
          "tagRegexp": "string",
          "untagged": true,
          "retainedTop": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
lifecyclePolicies[] | **object**<br><p>List of lifecycle policies.</p> 
lifecyclePolicies[].<br>id | **string**<br><p>ID of the lifecycle policy.</p> 
lifecyclePolicies[].<br>name | **string**<br><p>Name of the lifecycle policy.</p> 
lifecyclePolicies[].<br>repositoryId | **string**<br><p>ID of the repository that the lifecycle policy belongs to. Required. The maximum string length in characters is 50.</p> 
lifecyclePolicies[].<br>description | **string**<br><p>Description of the lifecycle policy. The maximum string length in characters is 256.</p> 
lifecyclePolicies[].<br>status | **string**<br><p>Status of lifecycle policy.</p> <ul> <li>ACTIVE: Policy is active and regularly deletes Docker images according to the established rules.</li> <li>DISABLED: Policy is disabled and does not delete Docker images in the repository. Policies in this status can be used for preparing and testing rules.</li> </ul> 
lifecyclePolicies[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
lifecyclePolicies[].<br>rules[] | **object**<br><p>The rules of lifecycle policy.</p> 
lifecyclePolicies[].<br>rules[].<br>description | **string**<br><p>Description of the lifecycle policy rule.</p> <p>The maximum string length in characters is 256.</p> 
lifecyclePolicies[].<br>rules[].<br>expirePeriod | **string**<br><p>Period of time for automatic deletion. Period must be a multiple of 24 hours.</p> <p>The minimum value is 86400 seconds.</p> 
lifecyclePolicies[].<br>rules[].<br>tagRegexp | **string**<br><p>Tag for specifying a filter in the form of a regular expression.</p> <p>The maximum string length in characters is 256.</p> 
lifecyclePolicies[].<br>rules[].<br>untagged | **boolean** (boolean)<br><p>Tag for applying the rule to Docker images without tags.</p> 
lifecyclePolicies[].<br>rules[].<br>retainedTop | **string** (int64)<br><p>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.</p> <p>The minimum value is 0.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 