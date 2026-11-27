[Документация Yandex Cloud](../../../index.md) > [Концепции API Yandex Cloud](../../index.md) > Работа с рекомендациями > Справочник Adviser API (англ.) > [REST](../index.md) > [Issue](index.md) > GetDismissalInfo

# Adviser API, REST: Issue.GetDismissalInfo

Returns the specified dismissal.

To get the dismissal ID, use a [IssueService.List](../../../adviser/api-ref/Issue/list#List) request
and take the value of [ResourceIssue.dismissalId](../../../adviser/api-ref/Issue/list#yandex.cloud.adviser.v1.ResourceIssue).

## HTTP request

```
GET https://adviser.api.cloud.yandex.net/adviser/v1/dismissals/{dismissalId}
```

## Path parameters

#|
||Field | Description ||
|| dismissalId | **string** (int64)

Required field. ID of the dismissal to return.

To get the dismissal ID, use a [IssueService.List](../../../adviser/api-ref/Issue/list#List) request
and take the value of [ResourceIssue.dismissalId](../../../adviser/api-ref/Issue/list#yandex.cloud.adviser.v1.ResourceIssue).

Value must be greater than 0. ||
|#

## Response {#yandex.cloud.adviser.v1.GetDismissalInfoResponse}

**HTTP Code: 200 - OK**

```json
{
  "dismissal": {
    "id": "string",
    "subjectId": "string",
    "reason": "string",
    "comment": "string",
    "dismissedAt": "string",
    "expiresAt": "string"
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
|| id | **string** (int64)

ID of the dismissal. ||
|| subjectId | **string**

ID of the user or the service account that created the dismissal. ||
|| reason | **enum** (DismissIssueReason)

Reason of the dismissal.

- `DISMISS_ISSUE_REASON_INCORRECT`: The issue is not relevant for the resource.
- `DISMISS_ISSUE_REASON_WONT_FIX`: The issue is relevant, but it is not going to be fixed.
- `DISMISS_ISSUE_REASON_ACCEPTED`: The issue is relevant and the risks it brings are accepted.
- `DISMISS_ISSUE_REASON_OTHER`: Other reason, see the comment of the dismissal. ||
|| comment | **string**

Comment of the dismissal. ||
|| dismissedAt | **string** (date-time)

Time when the issue was dismissed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expiresAt | **string** (date-time)

Time when the dismissal expires. After this time the issue becomes visible again.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#