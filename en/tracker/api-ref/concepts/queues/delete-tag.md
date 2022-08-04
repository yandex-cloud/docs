# Remove a tag from a queue

Use this request to remove a tag from a queue.

{% note warning %}

You can't remove a tag if it is used in at least one issue of the queue.

{% endnote %}

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To remove a tag, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```
POST /{{ ver }}/queues/<queue-id>/tags/_remove
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "tag": "<tag name>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Value | Data type |
| ----- | ----- | ----- |
| tag | Tag name | String |

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

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}

