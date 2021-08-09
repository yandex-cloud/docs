---
editable: false
---

# Method listVulnerabilities
Retrieves the list of vulnerabilities found in particular scan.
 

 
## HTTP request {#https-request}
```
GET https://container-registry.api.cloud.yandex.net/container-registry/v1/scans/{scanResultId}:listVulnerabilities
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
scanResultId | Required. ID of the ScanResult to get list of vulnerabilities for.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/container-registry/api-ref/Scanner/listVulnerabilities#query_params), the service returns a [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/container-registry/api-ref/Scanner/listVulnerabilities#query_params) to the [nextPageToken](/docs/container-registry/api-ref/Registry/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on `severity` and `name` fields. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. Value or a list of values to compare against the values of the field.  The maximum string length in characters is 1000.
orderBy | An order expression that orders resources listed in the response. The expression must specify: 1. The field name. Currently you can use filtering only on `severity` and `name` fields. 2. Order selector. Currently you can use ordering only on `Vulnerability.severity` field (recent first).  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "vulnerabilities": [
    {
      "severity": "string",
      "package": {
        "name": "string",
        "link": "string",
        "package": "string",
        "source": "string",
        "version": "string",
        "fixedBy": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
vulnerabilities[] | **object**<br><p>A Vulnerability resource.</p> 
vulnerabilities[].<br>severity | **string**<br>Output only. Severity of the Vulnerability.<br><ul> <li>CRITICAL: Critical severity is a world-burning problem, exploitable for nearly all users. Includes remote root privilege escalations, or massive data loss.</li> <li>HIGH: High severity is a real problem, exploitable for many users in a default installation. Includes serious remote denial of services, local root privilege escalations, or data loss.</li> <li>MEDIUM: Medium severity is a real security problem, and is exploitable for many users. Includes network daemon denial of service attacks, cross-site scripting, and gaining user privileges. Updates should be made soon for this priority of issue.</li> <li>LOW: Low severity is a security problem, but is hard to exploit due to environment, requires a user-assisted attack, a small install base, or does very little damage. These tend to be included in security updates only when higher priority issues require an update, or if many low priority issues have built up.</li> <li>NEGLIGIBLE: Negligible severity is technically a security problem, but is only theoretical in nature, requires a very special situation, has almost no install base, or does no real damage. These tend not to get backport from upstream, and will likely not be included in security updates unless there is an easy fix and some other issue causes an update.</li> <li>UNDEFINED: Unknown severity is either a security problem that has not been assigned to a priority yet or a priority that our system did not recognize.</li> </ul> 
vulnerabilities[].<br>package | **object**<br><p>A PackageVulnerability resource.</p> 
vulnerabilities[].<br>package.<br>name | **string**<br><p>Name of vulnerability in CVE database.</p> 
vulnerabilities[].<br>package.<br>link | **string**<br><p>URL to the page with description of vulnerability.</p> 
vulnerabilities[].<br>package.<br>package | **string**<br><p>The package name where vulnerability has been found.</p> 
vulnerabilities[].<br>package.<br>source | **string**<br><p>The package manager name. Ex.: yum, rpm, dpkg.</p> 
vulnerabilities[].<br>package.<br>version | **string**<br><p>The version of the package where vulnerability has been found.</p> 
vulnerabilities[].<br>package.<br>fixedBy | **string**<br><p>The version of the package where vulnerability has been fixed.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/container-registry/api-ref/Image/list#query_params">pageSize</a>, use the <a href="/docs/container-registry/api-ref/Scanner/listVulnerabilities#responses">nextPageToken</a> as the value for the <a href="/docs/container-registry/api-ref/Image/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/container-registry/api-ref/Scanner/listVulnerabilities#responses">nextPageToken</a> to continue paging through the results.</p> 