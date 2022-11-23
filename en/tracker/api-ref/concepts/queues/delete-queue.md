# Delete a queue using API

Use this request to delete queues.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a queue, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/queues/<queue-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

  The response body is missing.

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

