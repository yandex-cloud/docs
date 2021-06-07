# Get parameters of all columns

Use this request to get parameters of all columns of a board.

## Request format {#section_hqv_p3x_4fb}

To get the parameters of all columns for a board, use an HTTP `GET` request:

```json
GET /{{ ver }}/boards/<board-id>/columns
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
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

## Response format {#section_dlg_jlx_4fb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 200. The response body contains a JSON array with the parameters of all board columns.

    ```json
    [
        {
          "self": "https://api.tracker.yandex.net/v2/boards/73/columns/1",
          "id": 1,
          "name": "Open",
          "statuses":
           [
              {
                  "self": "https://api.tracker.yandex.net/v2/statuses/1",
                  "id": "1",
                  "key": "open",
                  "display": "Open"
              },
               ...
           ]
        },
         ...
    ]
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
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

