---
sourcePath: en/tracker/api-ref/concepts/issues/delete-link-issue.md
---
# Deleting a link with an issue

Use this request to unlink the issue from another issue.

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To unlink the current issue from another issue, use the HTTP `DELETE` request.

```
DELETE /{{ ver }}/issues/<issue_ID_or_key>/links/<link_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}


{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<issue_key_or_ID\> | ID or key of the current issue. | String |
| \<link_ID> | [ID of the link with another issue](get-links.md). | String |

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