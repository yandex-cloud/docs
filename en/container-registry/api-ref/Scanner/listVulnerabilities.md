---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/scans/{scanResultId}:listVulnerabilities
    method: get
    path:
      type: object
      properties:
        scanResultId:
          description: |-
            **string**
            Required field. ID of the ScanResult to get list of vulnerabilities for.
          type: string
      required:
        - scanResultId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Vulnerability.severity](/docs/container-registry/api-ref/Scanner/listVulnerabilities#yandex.cloud.containerregistry.v1.Vulnerability) and [PackageVulnerability.name](/docs/container-registry/api-ref/Scanner/listVulnerabilities#yandex.cloud.containerregistry.v1.PackageVulnerability) fields.
            2. An `=` operator.
            3. The value in double quotes (`"`).
          type: string
        orderBy:
          description: |-
            **string**
            An order expression that orders resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Vulnerability.severity](/docs/container-registry/api-ref/Scanner/listVulnerabilities#yandex.cloud.containerregistry.v1.Vulnerability) and [PackageVulnerability.name](/docs/container-registry/api-ref/Scanner/listVulnerabilities#yandex.cloud.containerregistry.v1.PackageVulnerability) fields.
            2. Order selector. Currently you can use ordering only on `Vulnerability.severity` field (recent first).
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/Scanner/listVulnerabilities.md
---

# Container Registry API, REST: Scanner.ListVulnerabilities

Retrieves the list of vulnerabilities found in particular scan.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/scans/{scanResultId}:listVulnerabilities
```

## Path parameters

#|
||Field | Description ||
|| scanResultId | **string**

Required field. ID of the ScanResult to get list of vulnerabilities for. ||
|#

## Query parameters {#yandex.cloud.containerregistry.v1.ListVulnerabilitiesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListRegistriesResponse.nextPageToken](/docs/container-registry/api-ref/Registry/list#yandex.cloud.containerregistry.v1.ListRegistriesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Vulnerability.severity](#yandex.cloud.containerregistry.v1.Vulnerability) and [PackageVulnerability.name](#yandex.cloud.containerregistry.v1.PackageVulnerability) fields.
2. An `=` operator.
3. The value in double quotes (`"`). ||
|| orderBy | **string**

An order expression that orders resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Vulnerability.severity](#yandex.cloud.containerregistry.v1.Vulnerability) and [PackageVulnerability.name](#yandex.cloud.containerregistry.v1.PackageVulnerability) fields.
2. Order selector. Currently you can use ordering only on `Vulnerability.severity` field (recent first). ||
|#

## Response {#yandex.cloud.containerregistry.v1.ListVulnerabilitiesResponse}

**HTTP Code: 200 - OK**

```json
{
  "vulnerabilities": [
    {
      "severity": "string",
      // Includes only one of the fields `package`
      "package": {
        "name": "string",
        "link": "string",
        "package": "string",
        "source": "string",
        "version": "string",
        "fixedBy": "string",
        "origin": "string",
        "type": "string"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| vulnerabilities[] | **[Vulnerability](#yandex.cloud.containerregistry.v1.Vulnerability)**

List of Vulnerability resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListImagesRequest.pageSize](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest), use
the `nextPageToken` as the value
for the [ListImagesRequest.pageToken](/docs/container-registry/api-ref/Image/list#yandex.cloud.containerregistry.v1.ListImagesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Vulnerability {#yandex.cloud.containerregistry.v1.Vulnerability}

A Vulnerability resource.

#|
||Field | Description ||
|| severity | **enum** (Severity)

Output only. Severity of the Vulnerability.

- `SEVERITY_UNSPECIFIED`
- `CRITICAL`: Critical severity is a world-burning problem, exploitable for nearly all users.
Includes remote root privilege escalations, or massive data loss.
- `HIGH`: High severity is a real problem, exploitable for many users in a default installation.
Includes serious remote denial of services, local root privilege escalations, or data loss.
- `MEDIUM`: Medium severity is a real security problem, and is exploitable for many users.
Includes network daemon denial of service attacks, cross-site scripting, and gaining user privileges.
Updates should be made soon for this priority of issue.
- `LOW`: Low severity is a security problem, but is hard to exploit due to environment, requires a user-assisted attack,
a small install base, or does very little damage. These tend to be included in security updates only when
higher priority issues require an update, or if many low priority issues have built up.
- `NEGLIGIBLE`: Negligible severity is technically a security problem, but is only theoretical in nature, requires a very special situation,
has almost no install base, or does no real damage. These tend not to get backport from upstream,
and will likely not be included in security updates unless there is an easy fix and some other issue causes an update.
- `UNDEFINED`: Unknown severity is either a security problem that has not been assigned to a priority yet or
a priority that our system did not recognize. ||
|| package | **[PackageVulnerability](#yandex.cloud.containerregistry.v1.PackageVulnerability)**

Includes only one of the fields `package`.

Details of vulnerability depending on type. Only `package` vulnerability is supported at the moment. ||
|#

## PackageVulnerability {#yandex.cloud.containerregistry.v1.PackageVulnerability}

A PackageVulnerability resource.

#|
||Field | Description ||
|| name | **string**

Name of vulnerability in CVE database. ||
|| link | **string**

URL to the page with description of vulnerability. ||
|| package | **string**

The package name where vulnerability has been found. ||
|| source | **string**

The package manager name. Ex.: yum, rpm, dpkg. ||
|| version | **string**

The version of the package where vulnerability has been found. ||
|| fixedBy | **string**

The version of the package where vulnerability has been fixed. ||
|| origin | **string**

The place where vulnerability is originated (OS, lang package, etc.) ||
|| type | **string**

The type of vulnerability origin - name of OS if origin="os" or package type (jar, gobinary, etc.) if origin="lang" ||
|#