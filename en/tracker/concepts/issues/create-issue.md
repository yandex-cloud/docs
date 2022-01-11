---
sourcePath: en/tracker/api-ref/concepts/issues/create-issue.md
---
# Create an issue

Use this request to create issues.

## Request format {#section_rnm_x4j_p1b}

To create an issue, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "summary": "issue name",
    "queue": {
        "id": "111",
        "key": "test"
        },
    "parent": {
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2"
        }, 
    "description": "text description", 
    "sprint": [
            {
                "id": "5317"
            }
        ],
    "type": {
        "id": "2",
        "key": "task"
        },
    "priority": {
        "id": "2",
        "key": "normal"
        },
    "followers": ["login", {"id": "19904929"}],
    "assignee": ["login", {"id": "19904929"}],
    "unique": "123qwe",
    "attachmentIds": [<comma-separated IDs of attached files>] 
}
```

#### Request body {#req-body-params}

The request body contains the information required to create a new issue:

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| summary | Issue name. Required field. | String |
| [queue](#queue) | Queue to create the issue in. Required field. | Can be set as an object, a string (if the [queue key](../../manager/create-queue.md#key) is passed), or a number (if the queue ID is passed). |
| [parent](#parent) | Parent issue. | Object or string |
| description | Issue description. | String |
| sprint | Block with information about sprints. | Array of objects or strings |
| [type](#type) | Issue type. | Can be set as an object, a string (if the issue type key is passed), or a number (if the issue type ID is passed). |
| [priority](#priority) | Issue priority. | Can be set as an object, a string (if the priority key is passed), or a number (if the priority ID is passed). |
| [followers](#followers) | IDs or usernames of issue followers. | Array of objects or strings |
| [assignee](#assignee) | ID or username of the issue assignee. | Array of objects or strings |
| unique | Field with a unique value that disables creation of duplicate issues. If you try to create an issue with the same value of this parameter again, no duplicate will be created and the response will contain an error with code 409. | String |
| attachmentIds | List of [attachment IDs](temp-attachment.md). | Array of strings |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Queue ID. | String |
| key | Queue key. | String |

**Object fields** `parent` {#parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the parent issue. | String |
| key | Key of the parent issue. | String |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Priority ID. | String |
| key | Priority key. | String |

**Object fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

> Create an issue:
>
> - An HTTP POST method is used.
> - We're creating an issue named <q>Test Issue</q> in the queue with the [key](../../manager/create-queue.md#key) <q>TREK</q>.
> - The new issue is a sub-issue of <q>JUNE-2</q>.
> - Type of the new issue: <q>Bug</q>.
> - Assignee: <user_login>
>
>```
> POST /v2/issues/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> 
> {
>     "queue": "TREK",
>     "summary": "Test Issue",
>     "parent":"JUNE-2",
>     "type": "bug",
>     "assignee": "<user_login>",
>     "attachmentIds": [55, 56]
> }
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 201. The request body contains information about the created issue in JSON format.

```json
{
    "self": "{{ host }}/v2/issues/TREK-9944",
    "id": "593cd211ef7e8a332414f2a7",
    "key": "TREK-9944",
    "version": 7,
    "lastCommentUpdatedAt": "2017-07-18T13:33:44.291+0000",
    "summary": "Test Issue",
    "parent": {
        "self": "{{ host }}/v2/issues/JUNE-2",
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2",
        "display": "Task"
        },
    "aliases": [
            "JUNE-3"
        ],
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
    "status": {
        "self": "{{ host }}/v2/statuses/1",
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

**Object fields** `parent` {#parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Issue link. | String |
| id | Issue ID. | String |
| key | Issue key. | String |
| display | Issue name displayed. | String |

**Object fields** `updatedBy` {#updated-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Array object fields** `sprint` {#sprint}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Sprint link. | String |
| id | Sprint ID. | String |
| display | Sprint name displayed. | String |

**Object fields** `type` {#type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the issue type. | String |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |
| display | Issue type name displayed. | String |

**Object fields** `priority` {#priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the priority type. | String |
| id | Priority ID. | String |
| key | Priority key. | String |
| display | Priority name displayed. | String |

**Array object fields** `followers` {#followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `createdBy` {#created-by}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `assignee` {#assignee}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the user. | String |
| id | User ID. | String |
| display | User's name displayed. | String |

**Object fields** `queue` {#queue}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Queue link. | String |
| id | Queue ID. | String |
| key | Queue key. | String |
| display | Queue name displayed. | String |

**Object fields** `status` {#status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String |
| id | Status ID. | String |
| key | Status key. | String |
| display | Status name displayed. | String |

**Object fields** `previousStatus` {#previous-status}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Status link. | String |
| id | Status ID. | String |
| key | Status key. | String |
| display | Status name displayed. | String |

## Possible response codes {#section_otf_jrj_p1b}

201
:  The request resulted in creating a new object.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

409
:  There was a conflict when creating an issue: the issue with the same value of the `unique` parameter already exists.

