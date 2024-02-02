---
sourcePath: en/tracker/api-ref/get-column.md
---
# Getting column parameters

Use this request to get the parameters of a board's column.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get the parameters of board columns, use an HTTP `GET` request.

```
GET /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<board-id\> | Board ID | Number |
| \<column-id\> | Column ID | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with column parameters.

    ```json
    {
        "self": "https://{{ host }}/v2/boards/73/columns/1",
        "id": 1,
        "name": "Open",
        "statuses":
          [
             {
                "self": "https://{{ host }}/v2/statuses/1",
                "id": "1",
                "key": "open",
                "display": "Open"
             },
              ...
          ]
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board column | String |
    | id | Column ID | Number |
    | name | Column name | String |
    | [statuses](#statuses) | The array contains the keys of possible statuses of issues to be output in the column.<br/>A list of all issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Array |

    `statuses` **object fields** {#statuses}

    {% include [status](../_includes/tracker/api/status.md) %}

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

