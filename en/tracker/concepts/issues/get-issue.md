---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Get issue parameters

Use this request to get information about an issue.

## Request format {#section_rnm_x4j_p1b}

To get issues, use an HTTP `GET` request:

```json
GET /v2/issues/<issue-id>?
expand=<additional response fields>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#req-resource}

- **\<issue-id\>**

    Issue ID or key.

#### Request parameters {#req-get-params}

- **expand (optional)**

    Additional fields to include in the response:
    - `transitions`: Workflow transitions between statuses.
    - `attachments`: Attached files.

> Request for a single issue with the required fields specified:
> 
> - Use the HTTP GET method.
> - The response will display attachments.
> 
> ```
> GET /v2/issues/JUNE-3?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 200. The response body contains the results in JSON format.

```json
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

**Object fields** `parent`{#parent}

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

200
:   Request executed successfully.

401
:  The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

403
:  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

