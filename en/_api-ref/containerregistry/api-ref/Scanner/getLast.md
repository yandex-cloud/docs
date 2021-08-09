---
editable: false
---

# Method getLast
Returns the last finished ScanResult for the specified Image.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/images/{imageId}:lastScanResult
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
imageId | ID of the Image to get last finished ScanResult.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
A ScanResult resource.
 
Field | Description
--- | ---
id | **string**<br><p>Output only. ID of the ScanResult.</p> 
imageId | **string**<br><p>Output only. ID of the Image that the ScanResult belongs to.</p> 
scannedAt | **string** (date-time)<br><p>Output only. The timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format when the scan been finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
status | **string**<br><p>Output only. The status of the ScanResult.</p> <ul> <li>RUNNING: Image scan is in progress.</li> <li>READY: Image has been scanned and result is ready.</li> <li>ERROR: Image scan is failed.</li> </ul> 
vulnerabilities | **object**<br><p>Output only. Summary information about vulnerabilities found.</p> <p>A VulnerabilityStats resource.</p> 
vulnerabilities.<br>critical | **string** (int64)<br><p>Count of CRITICAL vulnerabilities.</p> 
vulnerabilities.<br>high | **string** (int64)<br><p>Count of HIGH vulnerabilities.</p> 
vulnerabilities.<br>medium | **string** (int64)<br><p>Count of MEDIUM vulnerabilities.</p> 
vulnerabilities.<br>low | **string** (int64)<br><p>Count of LOW vulnerabilities.</p> 
vulnerabilities.<br>negligible | **string** (int64)<br><p>Count of NEGLIGIBLE vulnerabilities.</p> 
vulnerabilities.<br>undefined | **string** (int64)<br><p>Count of other vulnerabilities.</p> 