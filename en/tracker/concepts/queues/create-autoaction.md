---
sourcePath: en/tracker/api-ref/concepts/queues/create-autoaction.md
---
# Create an auto action

Use this request to create [auto actions](../../user/autoactions.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create an auto action, use the HTTP `POST` request method. Request parameters are passed in the request body in JSON format.

```json
POST /{{ ver }}/queues/<queue-id>/autoactions
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
{
    "name": "<auto action name>",
    "filter": [<filter conditions that trigger the auto action>],
    "actions": [<issue action parameters>]
    
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

Specify at least one of the parameters in the request body: `filter` or `query`.

{% endnote %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Auto action name. | String |
| [filter](#filter) | An array with filter conditions for issue fields that trigger the auto action. | Array of objects |
| query | The query line for issue filters that the auto action will apply to.<br/>Specified using the [query language](../../user/query-filter.md).<br/>For example: `"query": "\"Status\":\"In progress\""` | String |
| [actions](#actions) | An array of issue actions. | Array of objects |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| active | Auto action status. Acceptable values:<ul><li>`true`: Active.</li><li>`false`: Inactive.</li></ul> | Boolean |
| enableNotifications | Notification sending status. Possible values:<ul><li>`true`— send</li><li>`false`— don't send.</li></ul> | Boolean |
| intervalMillis | The auto action triggering frequency in milliseconds. The value is set to `3600000` by default (once per hour). | Number |
| calendar | The period when the auto action is active. Uses the `id` parameter: [work schedule ID](../../manager/schedule.md). | Object |

{% endcut %}

> Example: Create an auto action that will trigger for issues matching the filter conditions and change the issue status.
>
>- An HTTP POST method is used.
>- An auto action is created for the DESIGN queue.
>- Filter condition: Issues with the <q>In progress</q> status and the <q>Priority</q> set to <q>Critical</q>.
>- Issue action: Change status to <q>Need info</q>.
>- Trigger period: Work schedule with ID set to `2`.
>
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
    "self": "{{ host }}/v2/queues/DESIGN/autoactions/9",
    "queue": {
        "self": "{{ host }}/v2/queues/DESIGN",
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
                "self": "{{ host }}/v2/statuses/2",
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
   | id | Auto action ID. | String |
   | self | Auto action link. | String |
   | [queue](#queue) | Queue to create the auto action in. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |
   | name | Auto action name. | String |
   | version | Auto action version. Each change to the auto action increases the version number. | Number |
   | active | Auto action status. Acceptable values:<ul><li>`true`: Active.</li><li>`false`: Inactive.</li></ul> | Boolean |
   | created | Auto action creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | updated | Date and time of the auto action's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | [filter](#filter) | An array with filter conditions for issue fields that trigger the auto action. | Array of objects |
   | query | Query line for issue filters. | String |
   | [actions](#actions) | An array of issue actions. | Array of objects |
   | enableNotifications | Notification sending status. Possible values:<ul><li>`true`— send</li><li>`false`— don't send.</li></ul> | Boolean |
   | totalIssuesProcessed | The number of issues processed by the auto action during the last triggering phase. | Number |
   | intervalMillis | The auto action triggering frequency in milliseconds. The value is set to `3600000` by default (once per hour). | Number |
   | calendar | The period when the auto action is active. Uses the `id` parameter: [work schedule ID](../../manager/schedule.md). | Object |

   **Object fields** `queue` {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

    **Array object fields** `filter` {#filter}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | filter | An array with conditions for issue field filters.<br/>Use the request to receive an ID for a [global](../issues/get-global-fields.md) or [local](../queues/get-local-fields.md) field. | Array of objects |

   **Array object fields** `actions` {#actions}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | type | Action type. Possible values:<ul><li>`Transition`— change issue status.</li><li>`Update`— change field values.</li><li>`Event.comment-create`— add comment.</li><li>`Webhook`— send an HTTP request.</li><li>`CalculateFormula`— calculate value.</li></ul> | String |
   | id | Action ID. | String |
   | [status](#status) | Issue status. | String |

   **Array object fields** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   {% endcut %}

- Request failed

    If a request fails, the response message contains details of the errors encountered:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

