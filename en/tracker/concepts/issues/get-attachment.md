---
sourcePath: en/tracker/api-ref/concepts/issues/get-attachment.md
---
# Download a file

Use this request to download files attached to issues.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To download a file, use an HTTP `GET` request.

```
GET /{{ ver }}/issues/<issue-id>/attachments/<attachment-id>/<filename>
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
| \<filename\> | File name | String |

{% endcut %}

> Example: Download a file attached to the `JUNE-2` issue.
>
>- An HTTP `GET` method is used.
>
>```
>GET /v2/issues/JUNE-2/attachments/4159/attachment.txt HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

