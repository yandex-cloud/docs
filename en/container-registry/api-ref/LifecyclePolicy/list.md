---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/LifecyclePolicy/list.md
---

# Container Registry API, REST: LifecyclePolicy.list
Retrieves the list of lifecycle policies in the specified repository.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/lifecyclePolicies
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
registryId | <p>ID of the lifecycle policy.</p> <p>The maximum string length in characters is 50.</p> 
repositoryId | <p>Repository of the lifecycle policy.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters lifecycle policy resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>Sorting the list by <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.name</a>, <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.createdAt</a> and <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.status</a> fields. The default sorting order is ascending.</p> <p>The maximum string length in characters is 100.</p> 
 
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
lifecyclePolicies[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
lifecyclePolicies[].<br>rules[] | **object**<br><p>The rules of lifecycle policy.</p> 
lifecyclePolicies[].<br>rules[].<br>description | **string**<br><p>Description of the lifecycle policy rule.</p> <p>The maximum string length in characters is 256.</p> 
lifecyclePolicies[].<br>rules[].<br>expirePeriod | **string**<br><p>Period of time for automatic deletion. Period must be a multiple of 24 hours.</p> <p>The minimum value is 86400 seconds.</p> 
lifecyclePolicies[].<br>rules[].<br>tagRegexp | **string**<br><p>Tag for specifying a filter in the form of a regular expression.</p> <p>The maximum string length in characters is 256.</p> 
lifecyclePolicies[].<br>rules[].<br>untagged | **boolean** (boolean)<br><p>Tag for applying the rule to Docker images without tags.</p> 
lifecyclePolicies[].<br>rules[].<br>retainedTop | **string** (int64)<br><p>Number of Docker images (falling under the specified filter by tags) that must be left, even if the expire_period has already expired.</p> <p>The minimum value is 0.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 