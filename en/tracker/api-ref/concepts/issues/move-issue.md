# Move an issue to another queue

Use this request to move an issue to a different queue.

Before executing the request, make sure the user has permission to edit the issues to be moved and is allowed to create them in the new queue.

{% note warning %}

If an issue you want to move has a type and status that are missing in the target queue, no transfer will be made. To reset the issue status to the initial value when moving it, use the `InitialStatus` parameter.

By default, when an issue is moved, the values of its components, versions, and projects are cleared. If the new queue has the same values of the fields specified, use the `MoveAllFields` parameter to move the components, versions, and projects.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

To move issues, use an HTTP `POST` request:

```json
POST /{{ ver }}/issues/<issue-id>/_move?queue=<queue-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-get-params}

**Resource**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<issue-id\> | Required parameter. ID of the issue being moved. | String. |

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Required parameter. Key of the queue to move the issue to. | String. |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| notify | Flag notifying users about changes to the issue:<ul><li>`true` (by default): The users specified in the issue fields are notified.</li><li>`false`: No users are notified.</li></ul> | Logical. |
| notifyAuthor | Flag notifying the issue reporter:<ul><li>`true`: The reporter is notified.</li><li>`false` (by default): The reporter is not notified.</li></ul> | Logical. |
| moveAllFields | Shows whether to move the issue's versions, components, and projects to the new queue:<ul><li>`true`: Move them if the new queue has similar versions, components, and projects.</li><li>`false` (by default): Clear the versions, components, and projects.</li></ul> | Logical. |
| initialStatus | Resetting the issue status. The status is reset if the issue is moved to another queue with a different [workflow](../../manager/add-workflow.md):<ul><li>`true`: Reset the status.</li><li>`false` (by default): Retain the status as is.</li></ul> | Logical. |
| expand | Additional fields to be included in the response:<ul><li>`attachments`: Attachments.</li><li>`comments`: Comments.</li><li>`workflow`: Issue workflow.</li><li>`transitions`: Workflow transitions between statuses.</li></ul> | String. |

#### Request body {#req-body-params}

You can use the request body if you need to change the parameters of the issue being moved. The request body has the same format as when [editing issues](patch-issue.md#req-body-params).

> Moving an issue:
> 
> - An HTTP POST method is used.
> - We're moving the <q>TEST-1</q> issue to the <q>NEW</q> queue.
> 
> ```
> POST /v2/issues/TEST-1/_move?queue=NEW
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> ```

## Response format {#section_xpm_q1y_51b}

```json
{
    "self": "{{ host }}/v2/issues/NEW-1",
    "id": "1a2345678b",
    "key": "NEW-1",
    "version": 2,
    "aliases": [
        "TEST-1"
    ],
    "previousQueue": {
        "self": "https://api.tracker.yandex.net/v2/queues/TEST",
        "id": "3",
        "key": "TEST",
        "display": "TEST"
    },
    "description": "<issue description>",
    "type": {
        "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Issue"
    },
    "createdAt": "2020-09-04T14:18:56.776+0000",
    "updatedAt": "2020-11-12T12:38:19.040+0000",
    "lastCommentUpdatedAt": "2020-10-18T13:33:44.291+0000",
    },
    "summary": "Test",
    "updatedBy": {
        "self": "https://api.tracker.yandex.net/v2/users/1234567890",
        "id": "1234567890",
        "display": "First and Last name"
    },
    "priority": {
        "self": "https://api.tracker.yandex.net/v2/priorities/3",
        "id": "3",
        "key": "normal",
        "display": "Medium"
    },
    "followers": [
        {
            "self": "https://api.tracker.yandex.net/v2/users/1234567890",
            "id": "1234567890",
            "display": "First and Last name"
        }
    ],
    "createdBy": {
        "self": "https://api.tracker.yandex.net/v2/users/1234567890",
        "id": "1234567890",
        "display": "First and Last name"
    },
    "assignee": {
        "self": "https://api.tracker.yandex.net/v2/users/1234567890",
        "id": "1234567890",
        "display": "First and Last name"
    },
    "queue": {
        "self": "https://api.tracker.yandex.net/v2/queues/NEW",
        "id": "5",
        "key": "NEW",
        "display": "Queue"
    },
    "status": {
        "self": "https://api.tracker.yandex.net/v2/statuses/8",
        "id": "1",
        "key": "open",
        "display": "Open"
    },
    "previousStatus": {
        "self": "https://api.tracker.yandex.net/v2/statuses/1",
        "id": "1",
        "key": "open",
        "display": "Open"
    },
    "favorite": false
}
```

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the issue. | String. |
| id | Issue ID. | String. |
| key | Issue key. | String. |
| version | Issue version. Each change to the issue parameters increases its version number. | Number. |
| aliases | Array with information about alternative issue keys. | Array of strings. |
| [previousQueue](#previous-queue) | Object with information about the issue's previous queue. | Object. |
| description | Issue description. | String. |
| [type](#type) | Object with information about the issue type. | Object. |
| createdAt | Issue creation date and time. | String. |
| updatedAt | Issue update date and time. | String. |
| lastCommentUpdatedAt | Date and time when the last comment was added. | String. |
| summary | Issue name. | String. |
| [updatedBy](#updated-by) | Object with information about the user who edited the issue last. | Object. |
| [priority](#priority) | Object with information about the priority. | Object. |
| [followers](#followers) | Array of objects with information about issue followers. | Array of strings. |
| [createdBy](#created-by) | Object with information about the user who created the issue. | Object. |
| [assignee](#assignee) | Object with information about the issue's assignee. | Object. |
| [queue](#queue) | Object with information about the issue queue. | Object. |
| [status](#status) | Object with information about the issue status. | Object. |
| [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object. |
| favorite | Flag indicating a favorite issue:<ul><li>`true`: Notifications are disabled.</li><li>`false`: Notifications are enabled.</li></ul> | Logical. |

**Object fields** `previousQueue` {#previous-queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the queue. | String. |
| id | Queue ID. | Number. |
| key | Queue key. | String. |
| display | Queue name displayed. | String. |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the issue type. | String. |
| id | ID of the issue type. | Number. |
| key | Key of the issue type. | String. |
| display | Issue type name displayed. | String. |

**Object fields** `updatedBy` {#updated-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the user. | String. |
| id | User ID. | Number. |
| display | User's name displayed. | String. |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the priority. | String. |
| id | Priority type ID. | Number. |
| key | Priority type key. | String. |
| display | Priority type name displayed. | String. |

**Object array fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the user. | String. |
| id | User ID. | Number. |
| display | User's name displayed. | String. |

**Object fields** `createdBy` {#created-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the user. | String. |
| id | User ID. | Number. |
| display | User's name displayed. | String. |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the user. | String. |
| id | User ID. | Number. |
| display | User's name displayed. | String. |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the queue. | String. |
| id | Queue ID. | Number. |
| key | Queue key. | String. |
| display | Queue name displayed. | String. |

**Object fields** `status` {#status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the status. | String. |
| id | Status ID. | Number. |
| key | Status type key. | String. |
| display | Status type name displayed. | String. |

**Object fields** `previousStatus` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Address of the API resource with information about the status. | String. |
| id | Status ID. | Number. |
| key | Status type key. | String. |
| display | Status type name displayed. | String. |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Successful execution of the request.

401
:  The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

403
:  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

