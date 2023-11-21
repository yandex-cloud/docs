---
sourcePath: en/tracker/api-ref/concepts/queues/get-autoaction.md
---
# Get auto action parameters

Use this request to get information about an [auto action](../../user/autoactions.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get auto action parameters, use the HTTP `GET` request method.

```json
POST /{{ ver }}/queues/<queue-id>/autoactions/<autoaction-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |
| \<autoaction-id\> | Auto action ID. | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  The request body contains information about the auto action in JSON format.

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
    "version": 4,
    "active": true,
    "created": "2021-04-15T04:49:44.802+0000",
    "updated": "2022-01-26T16:29:05.356+0000", 
    "filter": {
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
    "lastLaunch": "2022-02-01T14:09:48.216+0000",
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
   | [queue](#queue) | The queue where the auto action was created. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |
   | name | Auto action name. | String |
   | version | Auto action version. Each change to the auto action increases the version number. | Number |
   | active | Auto action status. Acceptable values:<ul><li>`true`: Active.</li><li>`false`: Inactive.</li></ul> | Boolean |
   | created | Auto action creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | updated | Date and time of the auto action's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | [filter](#filter) | An array with filter conditions for issue fields that trigger the auto action. | Array of objects |
   | query | Query line for issue filters. | String |
   | [actions](#actions) | An array of issue actions. | Array of objects |
   | enableNotifications | Notification sending status. Possible values:<ul><li>`true`— send</li><li>`false`— don't send.</li></ul> | Boolean |
   | lastLaunch | Date and time when the auto action was last triggered in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
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

