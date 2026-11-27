---
editable: false
alternate:
  - href: ru/api-design-guide/api-ref/grpc/Issue/getDismissalInfo.md
    type: text/markdown
    title: Markdown version
---

# Adviser API, gRPC: IssueService.GetDismissalInfo

Returns the specified dismissal.

To get the dismissal ID, use a [IssueService.List](/docs/adviser/api-ref/grpc/Issue/list#List) request
and take the value of [ResourceIssue.dismissal_id](/docs/adviser/api-ref/grpc/Issue/list#yandex.cloud.adviser.v1.ResourceIssue).

## gRPC request

**rpc GetDismissalInfo ([GetDismissalInfoRequest](#yandex.cloud.adviser.v1.GetDismissalInfoRequest)) returns ([GetDismissalInfoResponse](#yandex.cloud.adviser.v1.GetDismissalInfoResponse))**

## GetDismissalInfoRequest {#yandex.cloud.adviser.v1.GetDismissalInfoRequest}

```json
{
  "dismissal_id": "int64"
}
```

#|
||Field | Description ||
|| dismissal_id | **int64**

ID of the dismissal to return.

To get the dismissal ID, use a [IssueService.List](/docs/adviser/api-ref/grpc/Issue/list#List) request
and take the value of [ResourceIssue.dismissal_id](/docs/adviser/api-ref/grpc/Issue/list#yandex.cloud.adviser.v1.ResourceIssue).

Value must be greater than 0. ||
|#

## GetDismissalInfoResponse {#yandex.cloud.adviser.v1.GetDismissalInfoResponse}

```json
{
  "dismissal": {
    "id": "int64",
    "subject_id": "string",
    "reason": "DismissIssueReason",
    "comment": "string",
    "dismissed_at": "google.protobuf.Timestamp",
    "expires_at": "google.protobuf.Timestamp"
  }
}
```

#|
||Field | Description ||
|| dismissal | **[DismissalInfo](#yandex.cloud.adviser.v1.DismissalInfo)**

Requested dismissal. ||
|#

## DismissalInfo {#yandex.cloud.adviser.v1.DismissalInfo}

Information about a dismissal of an issue.

#|
||Field | Description ||
|| id | **int64**

ID of the dismissal. ||
|| subject_id | **string**

ID of the user or the service account that created the dismissal. ||
|| reason | enum **DismissIssueReason**

Reason of the dismissal.

- `DISMISS_ISSUE_REASON_INCORRECT`: The issue is not relevant for the resource.
- `DISMISS_ISSUE_REASON_WONT_FIX`: The issue is relevant, but it is not going to be fixed.
- `DISMISS_ISSUE_REASON_ACCEPTED`: The issue is relevant and the risks it brings are accepted.
- `DISMISS_ISSUE_REASON_OTHER`: Other reason, see the comment of the dismissal. ||
|| comment | **string**

Comment of the dismissal. ||
|| dismissed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the issue was dismissed. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the dismissal expires. After this time the issue becomes visible again. ||
|#