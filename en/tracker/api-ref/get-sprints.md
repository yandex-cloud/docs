# Get all sprints of a board

Use this request to get the parameters of a board's sprints.

## Request format {#section_ths_h2z_pfb}

To get the parameters of all sprints for a board, use an HTTP `GET` request:

```json
GET /{{ ver }}/boards/<board-id>/sprints
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<board-id\> | Board ID. | String |

{% endcut %}

## Response format {#section_tns_n3z_pfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with board sprint parameters.

    ```json
    [ 
      {
      "self" : "{{ host }}/v2/sprints/4469",
      "id" : 4469,
      "version" : 1435288720018,
      "name" : "sprint1",
      "board" : {
        "self" : "{{ host }}/v2/boards/3",
        "id" : "3",
        "display" : "Testing"
      },
      "status" : "in_progress",
      "archived" : false,
      "createdBy" : {
        "self" : "{{ host }}/v2/users/1120000000014425",
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

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with sprint parameters. | String |
    | id | Sprint ID. | Number |
    | version | Sprint version. Each change to the sprint increases its version number. | Number |
    | name | Sprint name. | String |
    | [board](#ans-board) | Object with information about the board whose issues the sprint refers to. | String |
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

    {% endcut %}

- Request failed

    If a request fails, the response message contains details of the errors encountered:

    {% include [error](../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

