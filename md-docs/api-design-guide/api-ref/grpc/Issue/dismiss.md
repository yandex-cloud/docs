[Документация Yandex Cloud](../../../../index.md) > [Концепции API Yandex Cloud](../../../index.md) > Работа с рекомендациями > Справочник Adviser API (англ.) > [gRPC](../index.md) > [Issue](index.md) > Dismiss

# Adviser API, gRPC: IssueService.Dismiss


Dismisses the specified issue for the specified period of time.
While the dismissal is active, the issue is not shown by default,
use [ListResourceIssuesRequest.visibility_filter](../../../../adviser/api-ref/grpc/Issue/list#yandex.cloud.adviser.v1.ListResourceIssuesRequest) to get dismissed issues.

## gRPC request

**rpc Dismiss ([DismissIssueRequest](#yandex.cloud.adviser.v1.DismissIssueRequest)) returns ([DismissIssueResponse](#yandex.cloud.adviser.v1.DismissIssueResponse))**

## DismissIssueRequest {#yandex.cloud.adviser.v1.DismissIssueRequest}

```json
{
  "id": "string",
  "reason": "DismissIssueReason",
  "duration": "google.protobuf.Duration",
  "comment": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required field. ID of the issue to dismiss.

To get the issue ID, use a [IssueService.List](../../../../adviser/api-ref/grpc/Issue/list#List) request.

The maximum string length in characters is 50. ||
|| reason | enum **DismissIssueReason**

Required field. Reason of the dismissal.

- `DISMISS_ISSUE_REASON_INCORRECT`: The issue is not relevant for the resource.
- `DISMISS_ISSUE_REASON_WONT_FIX`: The issue is relevant, but it is not going to be fixed.
- `DISMISS_ISSUE_REASON_ACCEPTED`: The issue is relevant and the risks it brings are accepted.
- `DISMISS_ISSUE_REASON_OTHER`: Other reason, see the comment of the dismissal. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Required field. Period of time to dismiss the issue for. The maximum value is one year. ||
|| comment | **string**

Comment of the dismissal.

The maximum string length in characters is 10000. ||
|#

## DismissIssueResponse {#yandex.cloud.adviser.v1.DismissIssueResponse}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#