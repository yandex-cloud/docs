---
sourcePath: en/tracker/api-ref/concepts/queues/get-trigger.md
---
# Getting trigger parameters

Use this request to get information about a queue [trigger](../../user/trigger.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get trigger parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/queues/<queue_ID_or_key>/triggers/<trigger_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
----- | ----- | -----
| \<queue_ID_or_key\> | Queue ID or key. The queue key is case-sensitive. | String or number |
| \<trigger_id\> | Trigger ID | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The request body contains information about the trigger in JSON format.

   ```json
   {
   "id": 16,
   "self": "https://{{ host }}/v2/queues/DESIGN/triggers/16",
   "queue": {
       "self": "https://{{ host }}/v2/queues/DESIGN",
       "id": "26",
       "key": "DESIGN",
       "display": "Desing"
   },
   "name": "trigger_name",
   "order": "0.0002",
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
   ----- | ----- | -----
   | id | Trigger ID | String |
   | self | Links to trigger | String |
   | [queue](#queue) | Queue where the trigger was created. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is provided), or a number (if the queue ID is provided). |
   | name | Trigger name | String |
   | order | Trigger weight. This parameter affects the order of trigger display in the interface. | String |
   | [actions](#actions) | Array with trigger actions | Array of objects |
   | [conditions](#conditions) | Array with trigger conditions | Array of objects |
   | version | Trigger version. Each trigger update increases the version number. | Number |
   | active | Trigger status Acceptable values include:<ul><li>`true`: Active</li><li>`false`: Inactive</li></ul> | Logical |

   `queue` **object fields** {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   `actions` **array object fields** {#actions}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | type | Action type. Acceptable values include:<ul><li>`Transition`: Change the issue status.</li><li>`Update`: Change a field value.</li><li>`Move`: Move issue.</li><li>`Event.comment-create`: Add a comment.</li><li>`CreateChecklist`: Create a checklist.</li><li>`Webhook`: Send an HTTP request.</li><li>`CalculateFormula`: Calculate a value.</li><li>`Event.create`: Create an issue.</li></ul> | String |
   | id | Action ID | String |
   | [status](#status) | Issue status | String |

   `conditions` **array object fields** {#conditions}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | type | Condition type. Acceptable values:<ul><li>`or`: Logical OR;</li><li>`and`: Logical AND.</li></ul> | String |
   | conditions | Array with trigger conditions.<br/>For every condition, you can specify its `type`. Acceptable values:<ul><li>`CommentNoneMatchCondition`: The comment does not contain any of the fragments.</li><li>`CommentStringNotMatchCondition`: The comment does not contain the fragment.</li><li>`CommentFullyMatchCondition`: The comment fully matches the fragment.</li><li>`CommentAnyMatchCondition`: The comment includes any of the fragments.</li><li>`CommentStringMatchCondition`: The comment includes the fragment.</li><li>`CommentAuthorNot`: The comment author does not match the fragment.</li><li>`CommentAuthor`: The comment author matches the fragment.</li><li>`CommentMessageExternal`: The comment type is `Email`.</li><li>`CommentMessageInternal`: The comment type is `Common comment`.</li></ul> | Array of objects |

   `status` **array object fields** {#status}

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