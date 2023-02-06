---
editable: false
---

# Compute Cloud Instance Groups API, REST: InstanceGroup.listAccessBindings
Lists existing access bindings for the specified instance group.
 

 
## HTTP request {#https-request}
```
GET https://compute.{{ api-host }}/compute/v1/instanceGroups/{resourceId}:listAccessBindings
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
resourceId | <p>Required. ID of the resource to list access bindings for.</p> <p>To get the resource ID, use a corresponding List request. For example, use the <a href="/docs/resource-manager/api-ref/Cloud/list">list</a> request to get the Cloud resource ID.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page that should be returned. If the number of available results is larger than [page_size], the service returns a nextPageToken that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. Set [page_token] to the nextPageToken returned by a previous list request to get the next page of results.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "accessBindings": [
    {
      "roleId": "string",
      "subject": {
        "id": "string",
        "type": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
accessBindings[] | **object**<br><p>List of access bindings for the specified resource.</p> 
accessBindings[].<br>roleId | **string**<br><p>Required. ID of the <a href="/docs/iam/api-ref/Role#representation">Role</a> that is assigned to the ``subject``.</p> <p>The maximum string length in characters is 50.</p> 
accessBindings[].<br>subject | **object**<br><p>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier.</p> 
accessBindings[].<br>subject.<br>id | **string**<br><p>Required. ID of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li>``allAuthenticatedUsers``: A special system identifier that represents anyone who is authenticated. It can be used only if the ``type`` is ``system``.</li> <li>``allUsers``: A special system identifier that represents anyone. No authentication is required. For example, you don't need to specify the IAM token in an API query.</li> <li>``<cloud generated id>``: An identifier that represents a user account. It can be used only if the ``type`` is ``userAccount``, ``federatedUser`` or ``serviceAccount``.</li> </ul> <p>The maximum string length in characters is 50.</p> 
accessBindings[].<br>subject.<br>type | **string**<br><p>Required. Type of the subject.</p> <p>It can contain one of the following values:</p> <ul> <li>``userAccount``: An account on Yandex or Yandex Connect, added to Yandex Cloud.</li> <li>``serviceAccount``: A service account. This type represents the <a href="/docs/iam/api-ref/ServiceAccount#representation">ServiceAccount</a> resource.</li> <li>``federatedUser``: A federated account. This type represents a user from an identity federation, like Active Directory.</li> <li>``system``: System group. This type represents several accounts with a common system identifier.</li> </ul> <p>For more information, see <a href="/docs/iam/concepts/access-control/#subject">Subject to which the role is assigned</a>.</p> <p>The maximum string length in characters is 100.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size], use the nextPageToken as the value for the [ListAccessBindingsRequest.page_token] query parameter in the next list request. Each subsequent list request will have its own nextPageToken to continue paging through the results.</p> 