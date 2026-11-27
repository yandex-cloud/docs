[Документация Yandex Cloud](../../../../index.md) > [Концепции API Yandex Cloud](../../../index.md) > Работа с рекомендациями > Справочник Adviser API (англ.) > [gRPC](../index.md) > [Issue](index.md) > List

# Adviser API, gRPC: IssueService.List

Retrieves the list of issues detected on the resources of the specified cloud,
folder or resource.

## gRPC request

**rpc List ([ListResourceIssuesRequest](#yandex.cloud.adviser.v1.ListResourceIssuesRequest)) returns ([ListResourceIssuesResponse](#yandex.cloud.adviser.v1.ListResourceIssuesResponse))**

## ListResourceIssuesRequest {#yandex.cloud.adviser.v1.ListResourceIssuesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "resource_id": "string",
  "folder_id": "string",
  "cloud_id": "string",
  "state_filter": [
    "IssueState"
  ],
  "severity_filter": [
    "IssueSeverity"
  ],
  "category_filter": [
    "IssueCategory"
  ],
  "lang": "string",
  "visibility_filter": [
    "IssueVisibility"
  ]
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available results
is larger than `page_size`, the service returns a [ListResourceIssuesResponse.next_page_token](#yandex.cloud.adviser.v1.ListResourceIssuesResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListResourceIssuesResponse.next_page_token](#yandex.cloud.adviser.v1.ListResourceIssuesResponse) returned by the previous list request.

The maximum string length in characters is 2000. ||
|| resource_id | **string**

ID of the resource to list issues for. If not specified, issues are listed
for all the resources of the specified folder or cloud.

The maximum string length in characters is 50. ||
|| folder_id | **string**

ID of the folder to list issues for. If not specified, issues are listed
for all the folders of the specified cloud.

The maximum string length in characters is 50. ||
|| cloud_id | **string**

Required field. ID of the cloud to list issues for.

The maximum string length in characters is 50. ||
|| state_filter[] | enum **IssueState**

States of the issues to return. By default, only issues in the
`ISSUE_STATE_ACTIVE` state are returned.

- `ISSUE_STATE_ACTIVE`: The issue is detected on the resource and is not fixed yet.
- `ISSUE_STATE_RESOLVED`: The issue is not detected on the resource anymore.
- `ISSUE_STATE_STALED`: The issue has not been confirmed for a long time, so it is considered outdated. ||
|| severity_filter[] | enum **IssueSeverity**

Severities of the issues to return. By default, issues of all severities are returned.

- `ISSUE_SEVERITY_INFO`: The issue is informational, no action is required.
- `ISSUE_SEVERITY_WARNING`: The issue should be fixed, but it does not affect the resource right now.
- `ISSUE_SEVERITY_CRITICAL`: The issue affects the resource and should be fixed as soon as possible. ||
|| category_filter[] | enum **IssueCategory**

Categories of the issues to return. By default, issues of all categories are returned.

- `ISSUE_CATEGORY_COST`: The issue is about the cost of the resource.
- `ISSUE_CATEGORY_PERFORMANCE`: The issue is about the performance of the resource.
- `ISSUE_CATEGORY_FAULT_TOLERANCE`: The issue is about the fault tolerance of the resource. ||
|| lang | **string**

Language of the issue title and descriptions, e.g. `ru` or `en`.

The maximum string length in characters is 3. ||
|| visibility_filter[] | enum **IssueVisibility**

Visibilities of the issues to return. By default, only issues in the
`ISSUE_VISIBILITY_VISIBLE` visibility are returned.

- `ISSUE_VISIBILITY_VISIBLE`: The issue is shown to the user.
- `ISSUE_VISIBILITY_DISMISSED`: The issue is dismissed by the user and is hidden until the dismissal expires. ||
|#

## ListResourceIssuesResponse {#yandex.cloud.adviser.v1.ListResourceIssuesResponse}

```json
{
  "issues": [
    {
      "id": "string",
      "resource": {
        "type": "ResourceType",
        "resource_id": "string",
        "folder_id": "string",
        "cloud_id": "string"
      },
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "resolved_at": "google.protobuf.Timestamp",
      "state": "IssueState",
      "severity": "IssueSeverity",
      "category": "IssueCategory",
      "visibility": "IssueVisibility",
      "service": "string",
      "slug": "string",
      "short_descr": "string",
      "full_descr": "string",
      "doc_url": "string",
      "dismissal_id": "int64",
      "title": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| issues[] | **[ResourceIssue](#yandex.cloud.adviser.v1.ResourceIssue)**

List of issues. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number
of results is larger than [ListResourceIssuesRequest.page_size](#yandex.cloud.adviser.v1.ListResourceIssuesRequest), use the `next_page_token`
as the value for the [ListResourceIssuesRequest.page_token](#yandex.cloud.adviser.v1.ListResourceIssuesRequest) parameter in the next list request. ||
|#

## ResourceIssue {#yandex.cloud.adviser.v1.ResourceIssue}

An issue detected on a cloud resource by one of the Advisor checks.

#|
||Field | Description ||
|| id | **string**

ID of the issue. ||
|| resource | **[CloudResource](#yandex.cloud.adviser.v1.CloudResource)**

Resource that the issue is detected for. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the issue was detected. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the issue was updated for the last time. ||
|| resolved_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the issue was resolved. Empty for the issues that are not resolved yet. ||
|| state | enum **IssueState**

State of the issue.

- `ISSUE_STATE_ACTIVE`: The issue is detected on the resource and is not fixed yet.
- `ISSUE_STATE_RESOLVED`: The issue is not detected on the resource anymore.
- `ISSUE_STATE_STALED`: The issue has not been confirmed for a long time, so it is considered outdated. ||
|| severity | enum **IssueSeverity**

Severity of the issue.

- `ISSUE_SEVERITY_INFO`: The issue is informational, no action is required.
- `ISSUE_SEVERITY_WARNING`: The issue should be fixed, but it does not affect the resource right now.
- `ISSUE_SEVERITY_CRITICAL`: The issue affects the resource and should be fixed as soon as possible. ||
|| category | enum **IssueCategory**

Category of the issue.

- `ISSUE_CATEGORY_COST`: The issue is about the cost of the resource.
- `ISSUE_CATEGORY_PERFORMANCE`: The issue is about the performance of the resource.
- `ISSUE_CATEGORY_FAULT_TOLERANCE`: The issue is about the fault tolerance of the resource. ||
|| visibility | enum **IssueVisibility**

Visibility of the issue.

- `ISSUE_VISIBILITY_VISIBLE`: The issue is shown to the user.
- `ISSUE_VISIBILITY_DISMISSED`: The issue is dismissed by the user and is hidden until the dismissal expires. ||
|| service | **string**

Name of the service that the check belongs to, e.g. `managed-postgresql`. ||
|| slug | **string**

ID of the check that detected the issue, e.g. `postgresql_ha_zone`. ||
|| short_descr | **string**

Short description of the issue. ||
|| full_descr | **string**

Full description of the issue with the recommendations on how to fix it. ||
|| doc_url | **string**

Link to the documentation about the issue. ||
|| dismissal_id | **int64**

ID of the active dismissal for this issue, if any.
Present only for time-based dismissals.
To get the details of the dismissal, use a [IssueService.GetDismissalInfo](../../../../adviser/api-ref/grpc/Issue/getDismissalInfo#GetDismissalInfo) request. ||
|| title | **string**

Title of the issue. ||
|#

## CloudResource {#yandex.cloud.adviser.v1.CloudResource}

Cloud resource that the issue is detected for.

#|
||Field | Description ||
|| type | enum **ResourceType**

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
|| resource_id | **string**

Required field. ID of the resource, e.g. ID of the Managed Service for PostgreSQL cluster.

The maximum string length in characters is 50. ||
|| folder_id | **string**

Required field. ID of the folder that the resource belongs to.

The maximum string length in characters is 50. ||
|| cloud_id | **string**

Required field. ID of the cloud that the resource belongs to.

The maximum string length in characters is 50. ||
|#