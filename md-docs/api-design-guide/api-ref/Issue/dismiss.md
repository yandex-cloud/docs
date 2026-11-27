[Документация Yandex Cloud](../../../index.md) > [Концепции API Yandex Cloud](../../index.md) > Работа с рекомендациями > Справочник Adviser API (англ.) > [REST](../index.md) > [Issue](index.md) > Dismiss

# Adviser API, REST: Issue.Dismiss


Dismisses the specified issue for the specified period of time.
While the dismissal is active, the issue is not shown by default,
use [ListResourceIssuesRequest.visibilityFilter](../../../adviser/api-ref/Issue/list#yandex.cloud.adviser.v1.ListResourceIssuesRequest) to get dismissed issues.

## HTTP request

```
POST https://adviser.api.cloud.yandex.net/adviser/v1/resourceIssues/{id}:dismiss
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. ID of the issue to dismiss.

To get the issue ID, use a [IssueService.List](../../../adviser/api-ref/Issue/list#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.adviser.v1.DismissIssueRequest}

```json
{
  "reason": "string",
  "duration": "string",
  "comment": "string"
}
```

#|
||Field | Description ||
|| reason | **enum** (DismissIssueReason)

Required field. Reason of the dismissal.

- `DISMISS_ISSUE_REASON_INCORRECT`: The issue is not relevant for the resource.
- `DISMISS_ISSUE_REASON_WONT_FIX`: The issue is relevant, but it is not going to be fixed.
- `DISMISS_ISSUE_REASON_ACCEPTED`: The issue is relevant and the risks it brings are accepted.
- `DISMISS_ISSUE_REASON_OTHER`: Other reason, see the comment of the dismissal. ||
|| duration | **string** (duration)

Required field. Period of time to dismiss the issue for. The maximum value is one year. ||
|| comment | **string**

Comment of the dismissal.

The maximum string length in characters is 10000. ||
|#

## Response {#yandex.cloud.adviser.v1.DismissIssueResponse}

**HTTP Code: 200 - OK**