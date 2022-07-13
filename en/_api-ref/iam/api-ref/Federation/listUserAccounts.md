---
editable: false
---

# Method listUserAccounts
Lists users for the specified federation.
 

 
## HTTP request {#https-request}
```
GET https://iam.{{ api-host }}/iam/v1/saml/federations/{federationId}:listUserAccounts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
federationId | <p>Required. ID of the federation to list user accounts for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/iam/api-ref/Federation/listUserAccounts#query_params">pageSize</a>, the service returns a <a href="/docs/iam/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/iam/api-ref/Federation/listUserAccounts#query_params">pageToken</a> to the <a href="/docs/iam/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "userAccounts": [
    {
      "id": "string",

      // `userAccounts[]` includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`
      "yandexPassportUserAccount": {
        "login": "string",
        "defaultEmail": "string"
      },
      "samlUserAccount": {
        "federationId": "string",
        "nameId": "string",
        "attributes": "object"
      },
      // end of the list of possible fields`userAccounts[]`

    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
userAccounts[] | **object**<br><p>List of user accounts for the specified federation.</p> 
userAccounts[].<br>id | **string**<br><p>ID of the user account.</p> 
userAccounts[].<br>yandexPassportUserAccount | **object**<br>A YandexPassportUserAccount resource. <br>`userAccounts[]` includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br>
userAccounts[].<br>yandexPassportUserAccount.<br>login | **string**<br><p>Login of the Yandex user account.</p> 
userAccounts[].<br>yandexPassportUserAccount.<br>defaultEmail | **string**<br><p>Default email of the Yandex user account.</p> 
userAccounts[].<br>samlUserAccount | **object**<br>A SAML federated user. <br>`userAccounts[]` includes only one of the fields `yandexPassportUserAccount`, `samlUserAccount`<br>
userAccounts[].<br>samlUserAccount.<br>federationId | **string**<br><p>Required. ID of the federation that the federation belongs to.</p> <p>The maximum string length in characters is 50.</p> 
userAccounts[].<br>samlUserAccount.<br>nameId | **string**<br><p>Required. Name Id of the SAML federated user. The name is unique within the federation. 1-256 characters long.</p> <p>The string length in characters must be 1-256.</p> 
userAccounts[].<br>samlUserAccount.<br>attributes | **object**<br><p>Additional attributes of the SAML federated user.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/iam/api-ref/Federation/listUserAccounts#query_params">pageSize</a>, use the <a href="/docs/iam/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> as the value for the <a href="/docs/iam/api-ref/Federation/listUserAccounts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/iam/api-ref/Federation/listUserAccounts#responses">nextPageToken</a> to continue paging through the results.</p> 