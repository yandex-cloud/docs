# Delete a column

Use this request to delete columns.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To delete a column, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
If-Match: "<version number>"
```

{% cut "Headers" %}

- **Host**

    API host address:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

{% if audience == "external" %}

- **X-Org-ID**

    Organization ID.

    {% endif %}

- **If-Match**

    Number of the current board version.

{% endcut %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<board-id\> | Board ID | Number |
| \<column-id\> | Column ID | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-204](../_includes/tracker/api/answer-204.md) %}

    The response body is missing.

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

