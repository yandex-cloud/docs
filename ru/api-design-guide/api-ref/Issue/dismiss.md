---
editable: false
apiPlayground:
  - url: https://adviser.{{ api-host }}/adviser/v1/resourceIssues/{id}:dismiss
    method: post
    path:
      type: object
      properties:
        id:
          description: |-
            **string**
            Required field. ID of the issue to dismiss.
            To get the issue ID, use a [IssueService.List](/docs/adviser/api-ref/Issue/list#List) request.
            The maximum string length in characters is 50.
          type: string
      required:
        - id
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        reason:
          description: |-
            **enum** (DismissIssueReason)
            Required field. Reason of the dismissal.
            - `DISMISS_ISSUE_REASON_INCORRECT`: The issue is not relevant for the resource.
            - `DISMISS_ISSUE_REASON_WONT_FIX`: The issue is relevant, but it is not going to be fixed.
            - `DISMISS_ISSUE_REASON_ACCEPTED`: The issue is relevant and the risks it brings are accepted.
            - `DISMISS_ISSUE_REASON_OTHER`: Other reason, see the comment of the dismissal.
          type: string
          enum:
            - DISMISS_ISSUE_REASON_UNSPECIFIED
            - DISMISS_ISSUE_REASON_INCORRECT
            - DISMISS_ISSUE_REASON_WONT_FIX
            - DISMISS_ISSUE_REASON_ACCEPTED
            - DISMISS_ISSUE_REASON_OTHER
        duration:
          description: |-
            **string** (duration)
            Required field. Period of time to dismiss the issue for. The maximum value is one year.
          type: string
          format: duration
        comment:
          description: |-
            **string**
            Comment of the dismissal.
            The maximum string length in characters is 10000.
          type: string
      required:
        - reason
        - duration
      additionalProperties: false
    definitions: null
alternate:
  - href: ru/api-design-guide/api-ref/Issue/dismiss.md
    type: text/markdown
    title: Markdown version
---

# Adviser API, REST: Issue.Dismiss


Dismisses the specified issue for the specified period of time.
While the dismissal is active, the issue is not shown by default,
use [ListResourceIssuesRequest.visibilityFilter](/docs/adviser/api-ref/Issue/list#yandex.cloud.adviser.v1.ListResourceIssuesRequest) to get dismissed issues.

## HTTP request

```
POST https://adviser.{{ api-host }}/adviser/v1/resourceIssues/{id}:dismiss
```

## Path parameters

#|
||Field | Description ||
|| id | **string**

Required field. ID of the issue to dismiss.

To get the issue ID, use a [IssueService.List](/docs/adviser/api-ref/Issue/list#List) request.

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