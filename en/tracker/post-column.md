---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create a column

Use this request to create a column on an issue board.

## Request format {#section_e4q_ptd_pfb}

To create a column on a board, use an HTTP `POST` request:

```json
POST /{{ ver }}/boards/<board-id>/columns/
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

The request body contains the required column parameters.

| Parameter | Description | Data type |
| -------- | -------- | ----- |
| name | Column name.<br/>Required parameter. | String |
| statuses | The array contains the keys of possible statuses of issues to be output in the column.<br/>Required parameter.<br/>A list of all issue statuses: [{{ link-admin-statuses }}]({{ link-admin-statuses }}) | Array |

## Response format {#section_chg_hj2_pfb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 200. The response body contains a JSON object with the created column's parameters.

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
    | [statuses](#statuses) | The array contains the keys of possible statuses of issues to be output in the column.<br/>A list of all issue statuses: [{{ link-admin-statuses }}]({{ link-admin-statuses }}) | Array |

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
    | 409 Conflict | The request can't be executed due to a name conflict. |
    | 412 Precondition Failed | Invalid header value. |
    | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
    | 428 Precondition Required | A header is required. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

