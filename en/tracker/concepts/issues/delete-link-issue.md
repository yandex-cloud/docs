---
sourcePath: en/tracker/api-ref/concepts/issues/delete-link-issue.md
---
# Remove issue links

Use this request to remove links between issues.

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To unlink your issue from another issue, use the HTTP `DELETE` request method.

```
DELETE /{{ ver }}/issues/<issue-id>/links/<link-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<issue-id> | ID or key of the current issue. | String |
| \<link-id> | [Link ID to another issue](get-links.md). | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

  The response body is missing.

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

