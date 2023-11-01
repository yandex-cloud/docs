---
sourcePath: en/tracker/api-ref/concepts/queues/get-trigger.md
---
# Get trigger parameters

Use this request to get information about [triggers](../../user/trigger.md) in the queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get trigger parameters, use an HTTP `GET` request.

```json
GET /{{ ver }}/queues/<queue-id>/triggers/<trigger-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |
| \<trigger-id\> | Trigger ID. | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  The request body contains information about the trigger in JSON format.

    ```json
    {
    "id": 16,
    "self": "{{ host }}/v2/queues/DESIGN/triggers/16",
    "queue": {
        "self": "{{ host }}/v2/queues/DESIGN",
        "id": "26",
        "key": "DESIGN",
        "display": "Design"
    },
    "name": "trigger_name",
    "order": "0.0002",
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
    "conditions": [
        {
            "type": "Or",
            "conditions": [
                {
                    "type": "Event.comment-create"
                }
            ]
        }
    ],
    "version": 1,
    "active": true
    }
    ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | id | Trigger ID. | String |
   | self | Link to the trigger. | String |
   | [queue](#queue) | The queue where the trigger was created. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |
   | name | Trigger name. | String |
   | order | Trigger weight. This parameter affects the order in which the trigger is displayed in the interface. | String |
   | [actions](#actions) | An array with trigger actions. | Array of objects |
   | [conditions](#conditions) | An array with trigger conditions. | Array of objects |
   | version | Trigger version. Each change to the trigger increases the version number. | Number |
   | active | Trigger status. Acceptable values:<ul><li>`true`: Active.</li><li>`false`: Inactive.</li></ul> | Boolean |

   **Object fields** `queue` {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   **Array object fields** `actions` {#actions}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | type | Action type. Acceptable values:<ul><li>`Transition`: Change issue status.</li><li>`Update`: Update field values.</li><li>`Move`: Move the issue.</li><li>`Event.comment-create`: Add a comment.</li><li>`CreateChecklist`: Create a checklist.</li><li>`Webhook`: Send an HTTP request.</li><li>`CalculateFormula`: Calculate a value.</li><li>`Event.create`: Create an issue.</li></ul> | String |
   | id | Action ID. | String |
   | [status](#status) | Issue status. | String |

   **Array object fields** `conditions` {#conditions}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | type | Condition type. Acceptable values:<ul><li>`or`: Boolean OR.</li><li>`and`: Boolean AND.</li></ul> | String |
   | conditions | An array with trigger conditions.<br/>The condition has the `type` parameter, which denotes the condition type. Acceptable values:<ul><li>`CommentNoneMatchCondition`: The comment doesn't contain any of the fragments.</li><li>`CommentStringNotMatchCondition`: The comment doesn't contain the fragment.</li><li>`CommentFullyMatchCondition`: The comment matches fully.</li><li>`CommentAnyMatchCondition`: The comment contains any of the fragments.</li><li>`CommentStringMatchCondition`: The comment contains the fragment.</li><li>`CommentAuthorNot`: Not the comment poster.</li><li>`CommentAuthor`: The comment poster.</li><li>`CommentMessageExternal`: Comment type `E-mail comment`.</li><li>`CommentMessageInternal`: Comment type `Tracker comment`.</li></ul> | Array of objects |

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

