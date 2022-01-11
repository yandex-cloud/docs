---
sourcePath: en/tracker/api-ref/get-sprints.md
---
# Get all sprints of a board

Use this request to get the parameters of a board's sprints.

## Request format {#section_ths_h2z_pfb}

To get the parameters of all sprints for a board, use an HTTP `GET` request:

```json
GET /{{ ver }}/boards/<board-id>/sprints
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

## Response format {#section_tns_n3z_pfb}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 200. The response body contains a JSON array with board sprint parameters.

    #### Response body {#answer-body}

    ```json
    [ 
      {
      "self" : "http://api.tracker.yandex.net/v2/sprints/4469",
      "id" : 4469,
      "version" : 1435288720018,
      "name" : "sprint1",
      "board" : {
        "self" : "http://api.tracker.yandex.net/v2/boards/3",
        "id" : "3",
        "display" : "Testing"
      },
      "status" : "in_progress",
      "archived" : false,
      "createdBy" : {
        "self" : "http://api.tracker.yandex.net/v2/users/1120000000014425",
        "id" : "1120000000014425",
        "display" : "Victor Buldakov"
      },
      "createdAt" : "2015-06-23T17:03:24.799+0000",
      "startDate" : "2015-06-01",
      "endDate" : "2015-06-14",
      "startDateTime": "2015-06-01T07:00:00.000+0000",
      "endDateTime": "2015-06-14T07:00:00.000+0000"
      },
       ...
    ]
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with sprint parameters. | String |
    | id | Sprint ID. | Number |
    | version | Sprint version. Each change to the sprint increases its version number. | Number |
    | name | Sprint name. | String |
    | [board](#board) | Object with information about the board whose issues the sprint refers to. | String |
    | status | Sprint status. <br/>Possible statuses:<ul><li>`draft`: Open.</li><li>`in_progress`: In progress.</li><li>`released`: Resolved.</li><li>`archived`: Archived.</li></ul> | String |
    | archived | Shows whether the sprint is archived:<ul><li>`true`: The sprint is archived.</li><li>`false`: The sprint is not archived.</li></ul> | Boolean |
    | [createdBy](#createdBy) | Object with information about the user who created the sprint. | Object |
    | createdAt | Sprint creation date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
    | startDate | Sprint start date in ```YYYY-MM-DD``` format | String |
    | endDate | Sprint end date in ```YYYY-MM-DD``` format | String |
    | startDateTime | Date and time of the sprint's actual start in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
    | endDateTime | Date and time of the sprint's actual end in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |

    **Object fields** `board` {#board}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board. | String |
    | id | Board ID. | String |
    | display | Board name displayed. | String |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user. | String |
    | id | User ID. | String |
    | display | User's name displayed. | String |

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

