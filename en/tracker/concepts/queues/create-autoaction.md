---
sourcePath: en/tracker/api-ref/concepts/queues/create-autoaction.md
---
# Create auto action

Use this request to create [auto action](../../user/autoactions.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create an auto action, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```json
POST /{{ ver }}/queues/<queue-id>/autoactions
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
{
    "name": "<auto action name>",
    "filter": [<issue filtering conditions to trigger the auto action>],
    "actions": [<parameters of actions on issues>]

}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

{% note info %}

In the request body, specify at least one of the parameters: `filter` or `query`.

{% endnote %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Auto action name | String |
| [filter](#filter) | Array with the issue field filtering conditions that will trigger the auto action | Array of objects |
| query | The query string to filter the issues that will trigger the auto action.<br/>The [query language](../../user/query-filter.md) is used.<br/>For example: `"query": "\"Status\":\"In progress\""` | String |
| [actions](#actions) | Array of actions on issues | Array of objects |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| active | Auto action status. Acceptable values include:<ul><li>`true`: Active</li><li>`false`: Inactive</li></ul> | Logical |
| enableNotifications | Notification sending statuses. Acceptable values include:<ul><li>`true`: Send.</li><li>`false`: Do not send.</li></ul> | Logical |
| intervalMillis | Auto action start frequency in milliseconds. The default value is `3600000` (once an hour). | Number |
| calendar | Period for which the auto action is active. It has the `id` parameter specifying the [work schedule](../../manager/schedule.md) ID. | Object |

{% endcut %}

> Example: Create an auto action that triggers on issues that meet the filter criteria and changes the status of the issues.
>- An HTTP POST method is used.
>- Create an auto action for the DESIGN queue.
>- Filter criteria: issues in the "In progress" status that have the "Critical" "Priority".
>- Action on the issue: change the status to "Needs info".
>- Trigger period: work schedule with the ID of `2`.
>```json
>POST /v2/queues/DESIGN/autoactions
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>{
>  "name": "AutoactionName",
>  "filter": {
>          "priority": [
>              "critical"
>           ],
>           "status": [
>               "inProgress"
>            ]
>       },
>   "actions": [
>       {
>          "type": "Transition",
>          "status": {
>              "key": "needInfo"
>              }
>       }
>     ],
>    "calendar": {
>           "id": 2
>       }
>}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  The request body contains information about the created auto action in JSON format.

  ```json
  {
    "id": 9,
    "self": "https://{{ host }}/v2/queues/DESIGN/autoactions/9",
    "queue": {
        "self": "https://{{ host }}/v2/queues/DESIGN",
        "id": "26",
        "key": "DESIGN",
        "display": "Design"
    },
    "name": "autoaction_name",
    "version": 1,
    "active": true,
    "created": "2022-01-21T17:10:22.993+0000",
    "updated": "2022-01-21T17:10:22.993+0000",
    "filter": {
        "assignee": [
            "1134669290"
        ],
        "priority": [
            "critical"
        ]
    },
    "actions": [
        {
            "type": "Transition",
            "id": 1,
            "status": {
                "self": "https://{{ host }}/v2/statuses/2",
                "id": "2",
                "key": "needInfo",
                "display": "Need info"
            }
        }
    ],
    "enableNotifications": false,
    "totalIssuesProcessed": 0,
    "intervalMillis": 3600000,
    "calendar": {
            "id": 2
        }
  }
  ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | id | Auto action ID | String |
   | self | Link to the auto action | String |
   | [queue](#queue) | Queue to create the auto action. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is provided), or a number (if the queue ID is provided). |
   | name | Auto action name | String |
   | version | Auto action version. Each change to the auto action increases the version number. | Number |
   | active | Auto action status. Acceptable values include:<ul><li>`true`: Active</li><li>`false`: Inactive</li></ul> | Logical |
   | created | Auto action creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updated | Date and time of the auto action's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | [filter](#filter) | Array with the issue field filtering conditions that will trigger the auto action | Array of objects |
   | query | Query string for filtering issues | String |
   | [actions](#actions) | Array of actions on issues | Array of objects |
   | enableNotifications | Notification sending statuses. Acceptable values include:<ul><li>`true`: Send.</li><li>`false`: Do not send.</li></ul> | Logical |
   | totalIssuesProcessed | Number of issues checked by the auto action when triggered last time | Number |
   | intervalMillis | Auto action start frequency in milliseconds. The default value is `3600000` (once an hour). | Number |
   | calendar | Period for which the auto action is active. It has the `id` parameter specifying the [work schedule](../../manager/schedule.md) ID. | Object |

   `queue` **object fields** {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   `filter` **array object fields** {#filter}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | filter | Array with filtering conditions for issue fields.<br/>Use the request to get the ID of the [global](../issues/get-global-fields.md) or [local](../queues/get-local-fields.md) field. | Array of objects |

   `actions` **array object fields** {#actions}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | type | Action type. Acceptable values include:<ul><li>`Transition`: Change the issue status.</li><li>`Update`: Change a field value.</li><li>`Event.comment-create`: Add a comment.</li><li>`Webhook`: Send an HTTP request.</li><li>`CalculateFormula`: Calculate a value.</li></ul> | String |
   | id | Action ID | String |
   | [status](#status) | Issue status | String |

   **Fields array object actions** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}