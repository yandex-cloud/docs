---
editable: false
sourcePath: en/_api-ref/lockbox/v1/api-ref/Secret/listVersions.md
---

# Lockbox API, REST: Secret.listVersions
Retrieves the list of versions of the specified secret.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-lockbox }}/lockbox/v1/secrets/{secretId}/versions
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
secretId | <p>Required. ID of the secret to list versions for.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``page_size``, the service returns a [ListVersionsRequest.next_page_token] that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the [ListVersionsRequest.next_page_token] returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
    {
      "id": "string",
      "secretId": "string",
      "createdAt": "string",
      "destroyAt": "string",
      "description": "string",
      "status": "string",
      "payloadEntryKeys": [
        "string"
      ],
      "passwordPayloadSpecification": {
        "passwordKey": "string",
        "length": "string",
        "includeUppercase": true,
        "includeLowercase": true,
        "includeDigits": true,
        "includePunctuation": true,
        "includedPunctuation": "string",
        "excludedPunctuation": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
versions[] | **object**<br>Current (i.e. the `latest`) version of the secret.
versions[].<br>id | **string**<br><p>ID of the version.</p> 
versions[].<br>secretId | **string**<br><p>ID of the secret that the version belongs to.</p> 
versions[].<br>createdAt | **string** (date-time)<br><p>Time when the version was created.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
versions[].<br>destroyAt | **string** (date-time)<br><p>Time when the version is going to be destroyed. Empty unless the status is ``SCHEDULED_FOR_DESTRUCTION``.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
versions[].<br>description | **string**<br><p>Description of the version.</p> 
versions[].<br>status | **string**<br>Status of the secret.<br><ul> <li>ACTIVE: The version is active and the secret payload can be accessed.</li> <li>SCHEDULED_FOR_DESTRUCTION: The version is scheduled for destruction, the time when it will be destroyed is specified in the ``destroyAt`` field.</li> <li>DESTROYED: The version is destroyed and cannot be recovered.</li> </ul> 
versions[].<br>payloadEntryKeys[] | **string**<br><p>Keys of the entries contained in the version payload.</p> 
versions[].<br>passwordPayloadSpecification | **object**
versions[].<br>passwordPayloadSpecification.<br>passwordKey | **string**<br><p>Required. key of the entry to store generated password value</p> <p>The maximum string length in characters is 256. Value must match the regular expression ``[-_./\\@0-9a-zA-Z]+``.</p> 
versions[].<br>passwordPayloadSpecification.<br>length | **string** (int64)<br><p>password length; by default, a reasonable length will be decided</p> <p>The maximum value is 256.</p> 
versions[].<br>passwordPayloadSpecification.<br>includeUppercase | **boolean** (boolean)<br><p>whether at least one A..Z character is included in the password, true by default</p> 
versions[].<br>passwordPayloadSpecification.<br>includeLowercase | **boolean** (boolean)<br><p>whether at least one a..z character is included in the password, true by default</p> 
versions[].<br>passwordPayloadSpecification.<br>includeDigits | **boolean** (boolean)<br><p>whether at least one 0..9 character is included in the password, true by default</p> 
versions[].<br>passwordPayloadSpecification.<br>includePunctuation | **boolean** (boolean)<br><p>whether at least one punctuation character is included in the password, true by default punctuation characters by default (there are 32): !"#$%&amp;'()*+,-./:;&lt;=&gt;?@[]^_`{\|}~ to customize the punctuation characters, see included_punctuation and excluded_punctuation below</p> 
versions[].<br>passwordPayloadSpecification.<br>includedPunctuation | **string**<br><p>If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation: a string of specific punctuation characters to use (at most, all the 32)</p> <p>The maximum string length in characters is 32.</p> 
versions[].<br>passwordPayloadSpecification.<br>excludedPunctuation | **string**<br><p>a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32)</p> <p>The maximum string length in characters is 31.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/lockbox/api-ref/Secret/listVersions#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 