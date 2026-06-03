---
editable: false
---

# Yandex Cloud Registry API, gRPC: ScannerService.ListVulnerabilities

Retrieves the list of vulnerabilities found in particular scan.

## gRPC request

**rpc ListVulnerabilities ([ListVulnerabilitiesRequest](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesRequest)) returns ([ListVulnerabilitiesResponse](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesResponse))**

## ListVulnerabilitiesRequest {#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesRequest}

```json
{
  "scan_result_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": {
    "severity": "Severity",
    "name": "string"
  },
  "order_by": "string"
}
```

#|
||Field | Description ||
|| scan_result_id | **string**

Required field. ID of the ScanResult to get list of vulnerabilities for.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListVulnerabilitiesResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 10.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVulnerabilitiesResponse.next_page_token](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesResponse) returned by a previous list request.

The maximum string length in characters is 100. ||
|| filter | **[ListVulnerabilitiesFilter](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesFilter)**

Filter the list by [Vulnerability.severity](#yandex.cloud.cloudregistry.v1.Vulnerability) and [Vulnerability.name](#yandex.cloud.cloudregistry.v1.Vulnerability). ||
|| order_by | **string**

An order expression that orders resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Vulnerability.severity](#yandex.cloud.cloudregistry.v1.Vulnerability) and [Vulnerability.name](#yandex.cloud.cloudregistry.v1.Vulnerability) fields.
2. Order selector. Currently you can use ordering only on `Vulnerability.severity` field (recent first).

The maximum string length in characters is 100. ||
|#

## ListVulnerabilitiesFilter {#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesFilter}

#|
||Field | Description ||
|| severity | enum **Severity**

Filter by the `Vulnerability.severity` value.

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
|| name | **string**

Filter by the `Vulnerability.name` value.

The maximum string length in characters is 100. ||
|#

## ListVulnerabilitiesResponse {#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesResponse}

```json
{
  "vulnerabilities": [
    {
      "severity": "Severity",
      "name": "string",
      "package_name": "string",
      "package_type": "string",
      "package_version": "string",
      "package_fixed_version": "string",
      "link": "string",
      "source": "string",
      "origin": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| vulnerabilities[] | **[Vulnerability](#yandex.cloud.cloudregistry.v1.Vulnerability)**

List of Vulnerability resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListVulnerabilitiesRequest.page_size](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesRequest), use
the `next_page_token` as the value
for the [ListVulnerabilitiesRequest.page_token](#yandex.cloud.cloudregistry.v1.ListVulnerabilitiesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Vulnerability {#yandex.cloud.cloudregistry.v1.Vulnerability}

A Vulnerability resource.

#|
||Field | Description ||
|| severity | enum **Severity**

Output only. Severity of the Vulnerability.

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
|| name | **string**

Name of vulnerability in CVE database. ||
|| package_name | **string**

The package name where vulnerability has been found. ||
|| package_type | **string**

The type of vulnerability origin - name of OS if origin="os" or package type (jar, gobinary, etc.) if origin="lang" ||
|| package_version | **string**

The version of the package where vulnerability has been found. ||
|| package_fixed_version | **string**

The version of the package where vulnerability has been fixed. ||
|| link | **string**

URL to the page with description of vulnerability. ||
|| source | **string**

The package manager name. Ex.: yum, rpm, dpkg. ||
|| origin | **string**

The place where vulnerability is originated (OS, lang package, etc.) ||
|#