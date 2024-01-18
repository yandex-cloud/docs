---
sourcePath: en/tracker/api-ref/concepts/queues/get-autoaction.md
---
# Getting auto action parameters

Use this request to get information about an [auto action](../../user/autoactions.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get auto action parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue-id>/autoactions/<autoaction-id>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
----- | ----- | -----
| \&lt;queue-id\&gt; | Queue ID or key. The queue key is case-sensitive. | String or number |
| \&lt;autoaction-id\&gt; | Auto action ID | Number |

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
                 "display": "Needs info"
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
   ----- | ----- | -----
   | id | Auto action ID | String |
   | self | Link to the auto action | String |
   | [queue](#queue) | Queue where the auto action was created. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |
   | name | Auto action name | String |
   | version | Auto action version. Each change to the auto action increases the version number. | Number |
   | active | Auto action status. Acceptable values include:<ul><li>`true`: Active</li><li>`false`: Inactive</li></ul> | Boolean |
   | created | Auto action creation date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updated | Date and time of the auto action's last update in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | [filter](#filter) | Array with the issue field filtering conditions that will trigger the auto action | Array of objects |
   | query | Query string for filtering issues | String |
   | [actions](#actions) | Array of actions on issues | Array of objects |
   | enableNotifications | Notification sending statuses. Acceptable values include:<ul><li>`true`: Send.</li><li>`false`: Do not send.</li></ul> | Boolean |
   | lastLaunch | Date and time when the auto action was last triggered, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | totalIssuesProcessed | Number of issues checked by the auto action when triggered last time | Number |
   | intervalMillis | Auto action start frequency in milliseconds. The default value is `3600000` (once an hour). | Number |
   | calendar | Period for which the auto action is active. It has the `id` parameter specifying the [work schedule](../../manager/schedule.md) ID. | Object |

   **Object fields** `queue` {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

    **Array object fields** `filter` {#filter}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | filter | Array with filtering conditions for issue fields.<br/>Use the request to get the ID of the [global](../issues/get-global-fields.md) or [local](../queues/get-local-fields.md) field. | Array of objects |

   **Array object fields** `actions` {#actions}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | type | Action type. Acceptable values include:<ul><li>`Transition`: Change the issue status.</li><li>`Update`: Change a field value.</li><li>`Event.comment-create`: Add a comment.</li><li>`Webhook`: Send an HTTP request.</li><li>`CalculateFormula`: Calculate a value.</li></ul> | String |
   | id | Action ID | String |
   | [status](#status) | Issue status | String |

   **Array object fields** `status` {#status}

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