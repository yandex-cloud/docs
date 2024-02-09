```json
[
    {
    "self": "https://{{ host }}/v2/issues/TREK-9844",
    "id": "593cd211ef7e8a332414f2a7",
    "key": "TREK-9844",
    "version": 7,
    "lastCommentUpdatedAt": "2017-07-18T13:33:44.291+0000",
    "summary": "subtask",
    "parent": {
        "self": "https://{{ host }}/v2/issues/JUNE-2",
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2",
        "display": "Task"
        },
    "aliases": [
            "JUNE-3"
        ],

    "updatedBy": {
        "self": "https://{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<displayed employee name>"
        },
    "description": "<#<html><head></head><body><div>test</div><div>&nbsp;</div><div>&nbsp;</div> </body></html>#>",
    "sprint": [
            {
        "self": "https://{{ host }}/v2/sprints/5317",
        "id": "5317",
        "display": "sprint1"
            }
        ],
    "type": {
        "self": "https://{{ host }}/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Issue"
        },
    "priority": {
        "self": "https://{{ host }}/v2/priorities/2",
        "id": "2",
        "key": "normal",
        "display": "Normal"
        },

    "createdAt": "2017-06-11T05:16:01.339+0000",
    "followers": [
        {
        "self": "https://{{ host }}/v2/users/1120000000016876",
        "id": "<employee ID>",
        "display": "<displayed employee name>"
        }
        ],
    "createdBy": {
        "self": "https://{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<displayed employee name>"
        },
    "votes": 0,
    "assignee": {
        "self": "https://{{ host }}/v2/users/1120000000049224",
        "id": "<employee ID>",
        "display": "<displayed employee name>"
        },
    "project": {
        "display": "Startrek project",
        "id": "1",
        "self": "https://{{ host }}/v2/projects/1"
    },
    "queue": {
        "self": "https://{{ host }}/v2/queues/TREK",
        "id": "111",
        "key": "TREK",
        "display": "Startrek"
        },
    "updatedAt": "2017-07-18T13:33:44.291+0000",
    "status": {
        "self": "https://{{ host }}/v2/statuses/1",
        "id": "1",
        "key": "open",
        "display": "Open"
        },
    "previousStatus": {
        "self": "https://{{ host }}/v2/statuses/2",
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
   | favorite | Favorite issue flag:<ul><li>`true`: Issue added to favorites by the user.</li><li>`false`: Issue not added to favorites.</li></ul> | Boolean |

   `parent` **object fields** {#parent}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | display | Issue name displayed. | String |

   `updatedBy` **object fields** {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% include [sprint](../../../_includes/tracker/api/sprint.md) %}

   {% include [type](../../../_includes/tracker/api/type.md) %}

   {% include [priority](../../../_includes/tracker/api/priority.md) %}

   `followers` **array object fields** {#followers}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `createdBy` **object fields** {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `assignee` **object fields** {#assignee}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   `queue` **object fields** {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   `status` **object fields** {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   `previousStatus` **object fields** {#previous-status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

{% endcut %}

