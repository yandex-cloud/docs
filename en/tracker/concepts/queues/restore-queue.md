---
sourcePath: en/tracker/api-ref/concepts/queues/restore-queue.md
---
# Restore a queue

{% note warning %}

This request can only be made on behalf of the [administrator](../../role-model.md).

{% endnote %}

Use this request to restore a deleted queue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To restore a deleted queue, use an HTTP `POST` request.

```
POST /v2/queues/<queue-id>/_restore
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   ```json
   {
       "self": "{{ host }}/v2/queues/TEST",
       "id": 3,
       "key": "TEST",
       "version": 5,
       "name": "Test",
       "lead": {
              "self": "{{ host }}/v2/users/1120000000016876",
              "id": "<employee ID>",
              "display": "<employee name displayed>"
       },
       "assignAuto": false,
       "defaultType": {
              "self": "{{ host }}/v2/issuetypes/1",
              "id": "1",
              "key": "bug",
              "display": "Error"
       },
       "defaultPriority": {
              "self": "{{ host }}/v2/priorities/3",
              "id": "3",
              "key": "normal",
              "display": "Medium"
       },
       "denyVoting": false
   }
   ```

   {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Queue link | String |
    | id | Queue ID | Number |
    | key | Queue key | String |
    | version | Queue version. Each change to the queue increases its version number. | Number |
    | name | Queue name | String |
    | [lead](#lead) | Block with information about the queue owner | Objects |
    | assignAuto | Automatically assign new issues in the queue:<ul><li>`true`: Assign</li><li>`false`: Do not assign</li></ul> | Logical |
    | [defaultType](#default-type) | Block with information about the default issue type | Objects |
    | [defaultPriority](#default-priority) | Block with information about the default issue priority | Objects |
    | denyVoting | Flag that shows whether voting for issues is enabled | Logical |

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Object fields** `defaultType` {#default-type}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Link to the issue type | String |
    | id | ID of the issue type | String |
    | key | Key of the issue type | String |
    | display | Issue type name displayed | String |

    **Object fields** `defaultPriority` {#default-priority}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Link to the priority type | String |
    | id | Priority ID | String |
    | key | Priority key | String |
    | display | Priority name displayed | String |

    {% endcut %}

- The request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
