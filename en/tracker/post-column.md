---
sourcePath: en/tracker/api-ref/post-column.md
---
# Creating a column

Use this request to create a column on an issue board.

## Request format {#query}

Before making a request, [get permission to access the API](concepts/access.md).

To create a column on a board, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```
POST /{{ ver }}/boards/<board_ID>/columns/
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
If-Match: "<version_number>"

{
  "name": "Approve",
  "statuses":
      [
        "needInfo", "adjustment",...
      ]
}
```

{% cut "Headers" %}

- **Host**

   Address of the node that provides the API:

   ```
   {{ host }}
   ```

- **Authorization**

   OAuth token in `OAuth <OAuth_token>` format, e.g.:

   ```
   OAuth 0c4181a7c2cf4521964a72ff********
   ```


- **X-Org-ID** or **X-Cloud-Org-ID**

   Organization ID. If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.


- **If-Match**

   Number of the current board version. If you specify an obsolete version of the board, the HTTP request returns an error message saying `412 Precondition Failed`.

{% endcut %}

{% cut "Resource" %}

| Parameter | Description | Data type |
----- | ----- | -----
| \<board_ID\> | Board ID | Number |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | -----
| name | Column name | String |
| statuses | The array contains the keys of possible statuses of issues to be included in the column.<br/>The list of all issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Array |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with the created column parameters.

   ```json
   {
       "self": "https://{{ host }}/v2/boards/73/columns/5",
       "id": 5,
       "name": "Approve",
       "statuses":
        [
           {
              "self": "https://{{ host }}/v2/statuses/2",
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
   -------- | -------- | ----------
   | self | Address of the API resource with information about the board column | String |
   | id | Column ID | Number |
   | name | Column name | String |
   | [statuses](#statuses) | The array contains the keys of possible statuses of issues to be included in the column.<br/>The list of all issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Array |

   `statuses` **object fields** {#statuses}

   {% include [status](../_includes/tracker/api/status.md) %}

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-409](../_includes/tracker/api/answer-error-409.md) %}

   {% include [answer-error-412](../_includes/tracker/api/answer-error-412.md) %}

   {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

   {% include [answer-error-428](../_includes/tracker/api/answer-error-428.md) %}

   {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
