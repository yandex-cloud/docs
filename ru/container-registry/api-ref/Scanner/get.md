---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/scans/{scanResultId}
    method: get
    path:
      type: object
      properties:
        scanResultId:
          description: |-
            **string**
            Required field. ID of the ScanResult to return.
          type: string
      required:
        - scanResultId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Scanner/get.md
---

# Container Registry API, REST: Scanner.Get

Returns the specified ScanResult resource.

To get the list of ScanResults for specified Image, make a [List](/docs/container-registry/api-ref/Scanner/list#List) request.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/scans/{scanResultId}
```

## Path parameters

#|
||Field | Description ||
|| scanResultId | **string**

Required field. ID of the ScanResult to return. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ScanResult}

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

#|
||Field | Description ||
|| id | **string**

Output only. ID of the ScanResult. ||
|| imageId | **string**

Output only. ID of the Image that the ScanResult belongs to. ||
|| scannedAt | **string** (date-time)

Output only. The timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format when the scan been finished.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Output only. The status of the ScanResult.

- `STATUS_UNSPECIFIED`
- `RUNNING`: Image scan is in progress.
- `READY`: Image has been scanned and result is ready.
- `ERROR`: Image scan is failed. ||
|| vulnerabilities | **[VulnerabilityStats](#yandex.cloud.containerregistry.v1.VulnerabilityStats)**

Output only. Summary information about vulnerabilities found. ||
|#

## VulnerabilityStats {#yandex.cloud.containerregistry.v1.VulnerabilityStats}

A VulnerabilityStats resource.

#|
||Field | Description ||
|| critical | **string** (int64)

Count of CRITICAL vulnerabilities. ||
|| high | **string** (int64)

Count of HIGH vulnerabilities. ||
|| medium | **string** (int64)

Count of MEDIUM vulnerabilities. ||
|| low | **string** (int64)

Count of LOW vulnerabilities. ||
|| negligible | **string** (int64)

Count of NEGLIGIBLE vulnerabilities. ||
|| undefined | **string** (int64)

Count of other vulnerabilities. ||
|#