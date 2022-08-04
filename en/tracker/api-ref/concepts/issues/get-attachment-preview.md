# Download a thumbnail

Use this request to get thumbnails of image files attached to issues.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get a thumbnail, use an HTTP `GET` request.

```
GET /{{ ver }}/issues/<issue-id>/thumbnails/<attachment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<issue-id\> | Issue ID or key | String |
| \<attachment-id\> | Unique ID of the file attached | String or number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains a thumbnail of the image file.

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

