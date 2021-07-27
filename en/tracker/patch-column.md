---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Edit a column

Use this request to edit column parameters.

## Request format {#section_fpk_2k4_qfb}

To edit column parameters, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
If-Match: "<version number>"

{
  "name": "Approve",
  "statuses": 
      [
        "needInfo", "adjustment",...
      ]
}
```

#### Resource {#req-resource}

- **\<board-id\>**

    Board ID.

- **\<column-id\>**

    Column ID.

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

- **If-Match**

    Number of the current board version. If you specify an obsolete version of the board, the HTTP request returns an error message saying `412 Precondition Failed`.

#### Request body {#req-body-params}

The request body contains the column parameters to be changed.

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Column name. | String |
| statuses | The array contains the keys of possible statuses of issues to be output in the column.<br/>A list of all issue statuses: [{{ link-admin-statuses }}]({{ link-admin-statuses }}) | Array |

## Response format {#section_rf4_nr4_qfb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 200. The response body contains a JSON object with all column parameters, including the updated ones.

    ```json
    {
        "self": "https://api.tracker.yandex.net/v2/boards/73/columns/5",
        "id": 5,
        "name": "Approve",
        "statuses":
         [
            {
               "self": "https://api.tracker.yandex.net/v2/statuses/2",
               "id": "2",
               "key": "needInfo",
               "display": "Need info"
            },
             ...
          ]
    }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board column. | String |
    | id | Column ID. | Number |
    | name | Column name. | String |
    | [statuses](#statuses) | Array with the statuses of the issues included in the column. | Array |

    **Object fields** `statuses` {#statuses}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the status. | String |
    | id | Status ID. | String |
    | key | Status key. | String |
    | display | Status name displayed. | String |

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP error code | Error description |
    | --------------- | --------------- |
    | 400 Bad Request | One of the request parameters has an invalid value or data format. |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 412 Precondition Failed | Invalid header value. |
    | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
    | 428 Precondition Required | A header is required. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

