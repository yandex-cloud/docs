# Edit a column

Use this request to edit column parameters.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To edit column parameters, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format.

```
PATCH /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
If-Match: "<version number>"

<new column parameters in JSON format>
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

    Number of the current board version. If you specify an obsolete version of the board, the HTTP request returns an error message saying `412 Precondition Failed`.

{% endcut %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<board-id\> | Board ID | Number |
| \<column-id\> | Column ID | Number |

{% endcut %}

{% cut "Request body parameters" %}

The request body contains the column parameters to be changed.

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Column name. | String |
| statuses | The array contains the keys of possible statuses of issues to be output in the column.<br/>A list of all issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Array |

{% endcut %}

> Example: Edit the parameters of the column with ID `1` on the board with ID `5`.

- An HTTP `POST` method is used.

```
PATCH /v2/boards/5/columns/1
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
If-Match: "<version number>"

{
  "name": "Approve",
  "statuses":
      [
        "needInfo", "needAcceptance"
      ]
}
```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with all column parameters, including the updated ones.

    ```json
    {
        "self": "{{ host }}/v2/boards/73/columns/5",
        "id": 5,
        "name": "Approve",
        "statuses":
         [
            {
               "self": "{{ host }}/v2/statuses/2",
               "id": "2",
               "key": "needInfo",
               "display": "Need info"
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
    | [statuses](#statuses) | Array with the statuses of the issues included in the column | Array |

    **Object fields** `statuses` {#statuses}

    {% include [status](../_includes/tracker/api/status.md) %}

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-412](../_includes/tracker/api/answer-error-412.md) %}

    {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-428](../_includes/tracker/api/answer-error-428.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

