---
editable: false
---

# Method list
Retrieves the list of ScanResults for specified Image.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/scans
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
imageId | <p>The maximum string length in characters is 50.</p> 
repositoryId | <p>The maximum string length in characters is 50.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/container-registry/api-ref/Scanner/list#query_params">pageSize</a>, the service returns a <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/container-registry/api-ref/Scanner/list#query_params">pageToken</a> to the <a href="/docs/container-registry/api-ref/Registry/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on ``status`` field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``).</li> </ol> <p>The maximum string length in characters is 1000.</p> 
orderBy | <p>An order expression that orders resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on ``status`` field.</li> <li>Order selector. Currently you can use ordering only on ``ScanResult.status`` field (critical first).</li> </ol> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "scanResults": [
    {
      "id": "string",
      "imageId": "string",
      "scannedAt": "string",
      "status": "string",
      "vulnerabilities": {
        "critical": "string",
        "high": "string",
        "medium": "string",
        "low": "string",
        "negligible": "string",
        "undefined": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
scanResults[] | **object**<br><p>List of ScanResult resources.</p> 
scanResults[].<br>id | **string**<br><p>Output only. ID of the ScanResult.</p> 
scanResults[].<br>imageId | **string**<br><p>Output only. ID of the Image that the ScanResult belongs to.</p> 
scanResults[].<br>scannedAt | **string** (date-time)<br><p>Output only. The timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format when the scan been finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
scanResults[].<br>status | **string**<br><p>Output only. The status of the ScanResult.</p> <ul> <li>RUNNING: Image scan is in progress.</li> <li>READY: Image has been scanned and result is ready.</li> <li>ERROR: Image scan is failed.</li> </ul> 
scanResults[].<br>vulnerabilities | **object**<br><p>Output only. Summary information about vulnerabilities found.</p> <p>A VulnerabilityStats resource.</p> 
scanResults[].<br>vulnerabilities.<br>critical | **string** (int64)<br><p>Count of CRITICAL vulnerabilities.</p> 
scanResults[].<br>vulnerabilities.<br>high | **string** (int64)<br><p>Count of HIGH vulnerabilities.</p> 
scanResults[].<br>vulnerabilities.<br>medium | **string** (int64)<br><p>Count of MEDIUM vulnerabilities.</p> 
scanResults[].<br>vulnerabilities.<br>low | **string** (int64)<br><p>Count of LOW vulnerabilities.</p> 
scanResults[].<br>vulnerabilities.<br>negligible | **string** (int64)<br><p>Count of NEGLIGIBLE vulnerabilities.</p> 
scanResults[].<br>vulnerabilities.<br>undefined | **string** (int64)<br><p>Count of other vulnerabilities.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Scanner/list#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Scanner/list#responses">nextPageToken</a> to continue paging through the results.</p> 