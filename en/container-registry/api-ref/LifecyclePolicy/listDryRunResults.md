---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/LifecyclePolicy/listDryRunResults.md
---

# Container Registry API, REST: LifecyclePolicy.listDryRunResults
Retrieves the list of the dry run results.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/dryRunLifecyclePolicyResults
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
lifecyclePolicyId | <p>Required. ID of the lifecycle policy.</p> <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters dry run results listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/container-registry/api-ref/LifecyclePolicy#representation">LifecyclePolicy.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>Sorting the list by ``runAt`` and ``affectedImagesCount`` fields. The default sorting order is ascending.</p> <p>The maximum string length in characters is 100.</p> 
 
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
dryRunLifecyclePolicyResults[].<br>runAt | **string** (date-time)<br><p>Time of the getting result.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
dryRunLifecyclePolicyResults[].<br>affectedImagesCount | **string** (int64)<br><p>Count of affected images.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#query_params">pageSize</a> use ``next_page_token`` as the value for the <a href="/docs/container-registry/api-ref/LifecyclePolicy/listDryRunResults#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 