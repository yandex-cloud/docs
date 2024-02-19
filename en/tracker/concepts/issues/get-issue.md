---
sourcePath: en/tracker/api-ref/concepts/issues/get-issue.md
---
# Getting issue parameters

Use this request to get information about an issue.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To get issues, use an HTTP `GET` request:

```json
GET /v2/issues/<issue_ID_or_key>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| expand | Additional fields to include in the response: <ul><li>`transitions`: Workflow transitions between statuses</li><li>`attachments`: Attached files</li></ul> | String |

{% endcut %}

> Request for a single issue with the required fields specified:
>
> - An HTTP GET method is used.
> - The response will display attachments.
>
> ```
> GET /v2/issues/JUNE-3?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains the results in JSON format.

   {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}