```json
[
    {
    "self": "{{ host }}/v2/issues/TREK-9844",
    "id": "593cd211ef7e8a332414f2a7",
    "key": "TREK-9844",
    "version": 7,
    "lastCommentUpdatedAt": "2017-07-18T13:33:44.291+0000",
    "summary": "subtask",
    "parent": {
        "self": "{{ host }}/v2/issues/JUNE-2",
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2",
        "display": "Task"
        },
    "aliases": [
            "JUNE-3"
        ],

    "updatedBy": {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "description": "<#<html><head></head><body><div>test</div><div>&nbsp;</div><div>&nbsp;</div> </body></html>#>",
    "sprint": [
            {
        "self": "{{ host }}/v2/sprints/5317",
        "id": "5317",
        "display": "sprint1"
            }
        ],
    "type": {
        "self": "{{ host }}/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Issue"
        },
    "priority": {
        "self": "{{ host }}/v2/priorities/2",
        "id": "2",
        "key": "normal",
        "display": "Medium"
        },

    "createdAt": "2017-06-11T05:16:01.339+0000",
    "followers": [
        {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        }
        ],
    "createdBy": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "votes": 0,
    "assignee": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<employee name displayed>"
        },
    "queue": {
        "self": "{{ host }}/v2/queues/TREK",
        "id": "111",
        "key": "TREK",
        "display": "Startrack"
        },
    "updatedAt": "2017-07-18T13:33:44.291+0000",
    "status": {
        "self": "{{ host }}/v2/statuses/1",
        "id": "1",
        "key": "open",
        "display": "Open"
        },
    "previousStatus": {
        "self": "{{ host }}/v2/statuses/2",
        "id": "2",
        "key": "resolved",
        "display": "Resolved"
        },
    "favorite": false
    },
    {...}
]
```

{% cut "Response parameters" %}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | version | Issue version. Each change to the issue parameters increases its version number. | Number |
   | lastCommentUpdatedAt | Date and time when the last comment was added. | String |
   | summary | Issue name. | String |
   | [parent](#parent) | Object with information about the parent issue. | Object |
   | aliases | Array with information about alternative issue keys. | Array of strings |
   | [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
   | description | Issue description. | String |
   | [sprint](#sprint) | Array of objects with information about the sprint. | Array of objects |
   | [type](#type) | Object with information about the issue type. | Object |
   | [priority](#priority) | Object with information about the priority. | Object |
   | createdAt | Issue creation date and time. | String |
   | [followers](#followers) | Array of objects with information about issue followers. | Array of objects |
   | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
   | votes | Number of votes for the issue. | Number |
   | [assignee](#assignee) | Object with information about the issue's assignee. | Object |
   | [queue](#queue) | Object with information about the issue queue. | Object |
   | updatedAt | Date and time when the issue was last updated. | String |
   | [status](#status) | Object with information about the issue status. | Object |
   | [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object |
   | favorite | Flag indicating a favorite issue:<ul><li>`true`: The user added the issue to favorites.</li><li>`false`: The issue is not added to favorites.</li></ul> | Boolean |

   **Object fields** `parent`{#parent}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | display | Issue name displayed. | String |

   **Object fields** `updatedBy` {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% include [sprint](../../../_includes/tracker/api/sprint.md) %}

   {% include [type](../../../_includes/tracker/api/type.md) %}

   {% include [priority](../../../_includes/tracker/api/priority.md) %}

   **Array object fields** `followers` {#followers}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Object fields** `createdBy` {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Object fields** `assignee` {#assignee}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Object fields** `queue` {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   **Object fields** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   **Object fields** `previousStatus` {#previous-status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

{% endcut %}

