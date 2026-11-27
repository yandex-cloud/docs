[Документация Yandex Cloud](../../../index.md) > [Концепции API Yandex Cloud](../../index.md) > Работа с рекомендациями > Справочник Adviser API (англ.) > [REST](../index.md) > [Issue](index.md) > List

# Adviser API, REST: Issue.List

Retrieves the list of issues detected on the resources of the specified cloud,
folder or resource.

## HTTP request

```
GET https://adviser.api.cloud.yandex.net/adviser/v1/resourceIssues
```

## Query parameters {#yandex.cloud.adviser.v1.ListResourceIssuesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available results
is larger than `pageSize`, the service returns a [ListResourceIssuesResponse.nextPageToken](#yandex.cloud.adviser.v1.ListResourceIssuesResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListResourceIssuesResponse.nextPageToken](#yandex.cloud.adviser.v1.ListResourceIssuesResponse) returned by the previous list request.

The maximum string length in characters is 2000. ||
|| resourceId | **string**

ID of the resource to list issues for. If not specified, issues are listed
for all the resources of the specified folder or cloud.

The maximum string length in characters is 50. ||
|| folderId | **string**

ID of the folder to list issues for. If not specified, issues are listed
for all the folders of the specified cloud.

The maximum string length in characters is 50. ||
|| cloudId | **string**

Required field. ID of the cloud to list issues for.

The maximum string length in characters is 50. ||
|| stateFilter[] | **enum** (IssueState)

States of the issues to return. By default, only issues in the
`ISSUE_STATE_ACTIVE` state are returned.

- `ISSUE_STATE_ACTIVE`: The issue is detected on the resource and is not fixed yet.
- `ISSUE_STATE_RESOLVED`: The issue is not detected on the resource anymore.
- `ISSUE_STATE_STALED`: The issue has not been confirmed for a long time, so it is considered outdated. ||
|| severityFilter[] | **enum** (IssueSeverity)

Severities of the issues to return. By default, issues of all severities are returned.

- `ISSUE_SEVERITY_INFO`: The issue is informational, no action is required.
- `ISSUE_SEVERITY_WARNING`: The issue should be fixed, but it does not affect the resource right now.
- `ISSUE_SEVERITY_CRITICAL`: The issue affects the resource and should be fixed as soon as possible. ||
|| categoryFilter[] | **enum** (IssueCategory)

Categories of the issues to return. By default, issues of all categories are returned.

- `ISSUE_CATEGORY_COST`: The issue is about the cost of the resource.
- `ISSUE_CATEGORY_PERFORMANCE`: The issue is about the performance of the resource.
- `ISSUE_CATEGORY_FAULT_TOLERANCE`: The issue is about the fault tolerance of the resource. ||
|| lang | **string**

Language of the issue title and descriptions, e.g. `ru` or `en`.

The maximum string length in characters is 3. ||
|| visibilityFilter[] | **enum** (IssueVisibility)

Visibilities of the issues to return. By default, only issues in the
`ISSUE_VISIBILITY_VISIBLE` visibility are returned.

- `ISSUE_VISIBILITY_VISIBLE`: The issue is shown to the user.
- `ISSUE_VISIBILITY_DISMISSED`: The issue is dismissed by the user and is hidden until the dismissal expires. ||
|#

## Response {#yandex.cloud.adviser.v1.ListResourceIssuesResponse}

**HTTP Code: 200 - OK**

```json
{
  "issues": [
    {
      "id": "string",
      "resource": {
        "type": "string",
        "resourceId": "string",
        "folderId": "string",
        "cloudId": "string"
      },
      "createdAt": "string",
      "updatedAt": "string",
      "resolvedAt": "string",
      "state": "string",
      "severity": "string",
      "category": "string",
      "visibility": "string",
      "service": "string",
      "slug": "string",
      "shortDescr": "string",
      "fullDescr": "string",
      "docUrl": "string",
      "dismissalId": "string",
      "title": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| issues[] | **[ResourceIssue](#yandex.cloud.adviser.v1.ResourceIssue)**

List of issues. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is larger than [ListResourceIssuesRequest.pageSize](#yandex.cloud.adviser.v1.ListResourceIssuesRequest), use the `nextPageToken`
as the value for the [ListResourceIssuesRequest.pageToken](#yandex.cloud.adviser.v1.ListResourceIssuesRequest) parameter in the next list request. ||
|#

## ResourceIssue {#yandex.cloud.adviser.v1.ResourceIssue}

An issue detected on a cloud resource by one of the Advisor checks.

#|
||Field | Description ||
|| id | **string**

ID of the issue. ||
|| resource | **[CloudResource](#yandex.cloud.adviser.v1.CloudResource)**

Resource that the issue is detected for. ||
|| createdAt | **string** (date-time)

Time when the issue was detected.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time when the issue was updated for the last time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| resolvedAt | **string** (date-time)

Time when the issue was resolved. Empty for the issues that are not resolved yet.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| state | **enum** (IssueState)

State of the issue.

- `ISSUE_STATE_ACTIVE`: The issue is detected on the resource and is not fixed yet.
- `ISSUE_STATE_RESOLVED`: The issue is not detected on the resource anymore.
- `ISSUE_STATE_STALED`: The issue has not been confirmed for a long time, so it is considered outdated. ||
|| severity | **enum** (IssueSeverity)

Severity of the issue.

- `ISSUE_SEVERITY_INFO`: The issue is informational, no action is required.
- `ISSUE_SEVERITY_WARNING`: The issue should be fixed, but it does not affect the resource right now.
- `ISSUE_SEVERITY_CRITICAL`: The issue affects the resource and should be fixed as soon as possible. ||
|| category | **enum** (IssueCategory)

Category of the issue.

- `ISSUE_CATEGORY_COST`: The issue is about the cost of the resource.
- `ISSUE_CATEGORY_PERFORMANCE`: The issue is about the performance of the resource.
- `ISSUE_CATEGORY_FAULT_TOLERANCE`: The issue is about the fault tolerance of the resource. ||
|| visibility | **enum** (IssueVisibility)

Visibility of the issue.

- `ISSUE_VISIBILITY_VISIBLE`: The issue is shown to the user.
- `ISSUE_VISIBILITY_DISMISSED`: The issue is dismissed by the user and is hidden until the dismissal expires. ||
|| service | **string**

Name of the service that the check belongs to, e.g. `managed-postgresql`. ||
|| slug | **string**

ID of the check that detected the issue, e.g. `postgresql_ha_zone`. ||
|| shortDescr | **string**

Short description of the issue. ||
|| fullDescr | **string**

Full description of the issue with the recommendations on how to fix it. ||
|| docUrl | **string**

Link to the documentation about the issue. ||
|| dismissalId | **string** (int64)

ID of the active dismissal for this issue, if any.
Present only for time-based dismissals.
To get the details of the dismissal, use a [IssueService.GetDismissalInfo](../../../adviser/api-ref/Issue/getDismissalInfo#GetDismissalInfo) request. ||
|| title | **string**

Title of the issue. ||
|#

## CloudResource {#yandex.cloud.adviser.v1.CloudResource}

Cloud resource that the issue is detected for.

#|
||Field | Description ||
|| type | **enum** (ResourceType)

Required field. Type of the resource.

- `RESOURCE_TYPE_MANAGED_POSTGRESQL`: Managed Service for PostgreSQL cluster.
- `RESOURCE_TYPE_MANAGED_MYSQL`: Managed Service for MySQL cluster.
- `RESOURCE_TYPE_MANAGED_REDIS`: Managed Service for Redis cluster.
- `RESOURCE_TYPE_MANAGED_MONGODB`: Managed Service for MongoDB cluster.
- `RESOURCE_TYPE_MANAGED_CLICKHOUSE`: Managed Service for ClickHouse cluster.
- `RESOURCE_TYPE_MANAGED_GREENPLUM`: Managed Service for Greenplum cluster.
- `RESOURCE_TYPE_MANAGED_OPENSEARCH`: Managed Service for OpenSearch cluster.
- `RESOURCE_TYPE_MANAGED_SPQR`: Managed Service for SPQR cluster.
- `RESOURCE_TYPE_MANAGED_KAFKA`: Managed Service for Apache Kafka cluster. ||
|| resourceId | **string**

Required field. ID of the resource, e.g. ID of the Managed Service for PostgreSQL cluster.

The maximum string length in characters is 50. ||
|| folderId | **string**

Required field. ID of the folder that the resource belongs to.

The maximum string length in characters is 50. ||
|| cloudId | **string**

Required field. ID of the cloud that the resource belongs to.

The maximum string length in characters is 50. ||
|#