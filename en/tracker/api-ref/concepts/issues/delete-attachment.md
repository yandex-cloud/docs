# Delete a file

Use this request to delete attached files.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a file, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/issues/<issue-id>/attachments/<attachment-id>/
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<issue-id\> | Issue ID or key | String |
| \<attachment-id\> | Unique file ID | String or number |

{% endcut %}

> Example: Delete a file attached to the `JUNE-2` issue.
>
>- An HTTP `DELETE` method is used.
>
>```
>DELETE /v2/issues/JUNE-2/attachments/4159/ HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

    The response body is missing.

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

