---
sourcePath: en/tracker/api-ref/post-sprint.md
---
# Creating a sprint

Use this request to create sprints.

## Request format {#section_zs1_wjg_qfb}

To create a sprint, use an HTTP `POST` request:

```json
POST /{{ ver }}/sprints
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
  "name": "New Sprint",
  "board":
    {
      "id": "1"
    },
  "startDate": "2018-10-21",
  "endDate": "2018-10-24"
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Sprint name. | String |
| [board](#req-board) | Object with information about the board whose issues the sprint refers to. | String |
| startDate | Sprint start date in ```YYYY-MM-DD``` format. | String |
| endDate | Sprint end date in ```YYYY-MM-DD``` format. | String |

`board` **object field** {#req-board}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | Board ID | String |

{% endcut %}

## Response format {#section_rqk_pvh_qfb}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with the parameters of the created sprint.

    ```json
    {
      "self" : "https://{{ host }}/v2/sprints/4469",
      "id" : 4469,
      "version" : 1,
      "name" : "New Sprint",
      "board" : {
        "self" : "https://{{ host }}/v2/boards/3",
        "id" : "1",
        "display" : "Testing"
      },
      "status" : "draft",
      "archived" : false,
      "createdBy" : {
        "self" : "https://{{ host }}/v2/users/1120000000014425",
        "id"  "1120000000014425",
        "display" : "Victor Buldakov"
      },
      "createdAt" : "2015-06-23T17:03:24.799+0000",
      "startDate" : "2015-06-01",
      "endDate" : "2015-06-14",
      "startDateTime" : "2015-06-01T07:00:00.000+0000",
      "endDateTime" : "2015-06-14T07:00:00.000+0000"
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with sprint parameters. | String |
    | id | Sprint ID. | Number |
    | version | Sprint version. Each change to the sprint increases its version number. | Number |
    | name | Sprint name. | String |
    | [board](#ans-board) | Object with information about the board whose issues the sprint refers to. | String |
    | status | Sprint status. <br/>The following statuses are possible:<ul><li>`draft`: Open.</li><li>`in_progress`: In progress.</li><li>`released`: Resolved.</li><li>`archived`: Archived.</li></ul> | String |
    | archived | Shows whether the sprint is archived:<ul><li>`true`: The sprint is archived.</li><li>`false`: The sprint is not archived.</li></ul> | Logical |
    | [createdBy](#ans-createdBy) | Object with information about the user who created the sprint. | Object |
    | createdAt | Sprint creation date and time in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |
    | startDate | Sprint start date in ```YYYY-MM-DD``` format. | String |
    | endDate | Sprint end date in ```YYYY-MM-DD``` format. | String |
    | startDateTime | Date and time of the sprint's actual start in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |
    | endDateTime | Date and time of the sprint's actual end in ```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format. | String |

    `board` **object fields** {#ans-board}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board | String |
    | id | Board ID | String |
    | display | Displayed board name | String |

    `createdBy` **object fields** {#ans-createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the user | String |
    | id | User ID | String |
    | display | Displayed user name | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [error](../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
