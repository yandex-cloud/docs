---
editable: false
sourcePath: en/_api-ref/containerregistry/api-ref/Scanner/get.md
---

# Container Registry API, REST: Scanner.get
Returns the specified ScanResult resource.
 
To get the list of ScanResults for specified Image, make a [list](/docs/container-registry/api-ref/Scanner/list) request.
 
## HTTP request {#https-request}
```
GET https://container-registry.{{ api-host }}/container-registry/v1/scans/{scanResultId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
scanResultId | <p>Required. ID of the ScanResult to return.</p> <p>The maximum string length in characters is 50.</p> 
 
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
scannedAt | **string** (date-time)<br><p>Output only. The timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format when the scan been finished.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
status | **string**<br><p>Output only. The status of the ScanResult.</p> <ul> <li>RUNNING: Image scan is in progress.</li> <li>READY: Image has been scanned and result is ready.</li> <li>ERROR: Image scan is failed.</li> </ul> 
vulnerabilities | **object**<br><p>Output only. Summary information about vulnerabilities found.</p> <p>A VulnerabilityStats resource.</p> 
vulnerabilities.<br>critical | **string** (int64)<br><p>Count of CRITICAL vulnerabilities.</p> 
vulnerabilities.<br>high | **string** (int64)<br><p>Count of HIGH vulnerabilities.</p> 
vulnerabilities.<br>medium | **string** (int64)<br><p>Count of MEDIUM vulnerabilities.</p> 
vulnerabilities.<br>low | **string** (int64)<br><p>Count of LOW vulnerabilities.</p> 
vulnerabilities.<br>negligible | **string** (int64)<br><p>Count of NEGLIGIBLE vulnerabilities.</p> 
vulnerabilities.<br>undefined | **string** (int64)<br><p>Count of other vulnerabilities.</p> 