---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/LifecyclePolicy/listDryRunResults.md
---

# Method listDryRunResults
Retrieves the list of the dry run results.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
lifecyclePolicyId | Required. ID of the lifecycle policy.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns  a [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#responses) that can be used to get  the next page of results in subsequent list requests.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters dry run results listed in the response.  The expression must specify: 1. The field name. Currently you can use filtering only on [LifecyclePolicy.name](/docs/container-registry/api-ref/LifecyclePolicy#representation) field. 2. An `=` operator. 3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.  The maximum string length in characters is 1000.
orderBy | Sorting the list by `runAt` and `affectedImagesCount` fields. The default sorting order is ascending.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "dryRunLifecyclePolicyResults": [
    {
      "dryRunLifecyclePolicyResultId": "string",
      "lifecyclePolicyId": "string",
      "runAt": "string",
      "affectedImagesCount": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
dryRunLifecyclePolicyResults[] | **object**<br><p>List of results of dry runs of a lifecycle policy.</p> 
dryRunLifecyclePolicyResults[].<br>dryRunLifecyclePolicyResultId | **string**<br><p>ID of the dry run result of the lifecycle policy.</p> 
dryRunLifecyclePolicyResults[].<br>lifecyclePolicyId | **string**<br><p>ID of the lifecycle policy.</p> 
dryRunLifecyclePolicyResults[].<br>runAt | **string** (date-time)<br><p>Time of the getting result.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
dryRunLifecyclePolicyResults[].<br>affectedImagesCount | **string** (int64)<br><p>Count of affected images.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#query_params">pageSize</a> use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 