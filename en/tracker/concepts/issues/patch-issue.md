---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Edit an issue

Use this request to make changes to issues.

{% note warning %}

You can only change an issue's status using the [<q>Make a status transition</q>](new-transition.md) request.

{% endnote %}

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To edit an issue, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format.

```json
PATCH /{{ ver }}/issues/<issue-id>Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
{
   Request body in JSON format
}
```

#### Request parameters {#req-get-params}

**Resource**

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | \<issue-id\> | Issue ID or key. | Number/String |

**Additional parameters**

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | version | Issue version. Changes are only made to the current version of the issue. | Number |

#### Request body parameters {#req-body-params}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| summary | Issue name. | String |
| [parent](#req-parent) | Parent issue. | Object or string |
| description | Issue description. | String |
| [sprint](#req-sprint) | Block with information about sprints. | Array of objects or strings |
| [type](#req-type) | Issue type. | Object, string (if the issue type key is passed), or number (if the issue type ID is passed). |
| [priority](#req-priority) | Issue priority. | Object, string (if the priority key is passed), or number (if the priority ID is passed). |
| [followers](#req-followers) | IDs or usernames of issue followers. | Array of objects or strings |

**Object fields** `parent` {#req-parent}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the parent issue. | String |
| key | Key of the parent issue. | String |

**Object fields** `sprint` {#req-sprint}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Sprint ID. You can get sprint information using the [request](../../get-sprints.md). | Number |

**Object fields** `type` {#req-type}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | ID of the issue type. | String |
| key | Key of the issue type. | String |

**Object fields** `priority` {#req-priority}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Priority ID. | String |
| key | Priority key. | String |

**Object fields** `followers` {#req-followers}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| id | Employee ID. | String |

#### Request body format {#req-body-format}

The request body passes a JSON object with the IDs of updated fields and their values.

- To add or remove an array value, use the `add` or `remove` command:

  - ```json
       {
          "followers": { "add": ["<user1 ID>", "<user2 ID>"] }
       }
    ```

{% note info %}

The `add` command adds new values to the array. To overwrite the array (delete the old values and add new ones), use the `set` command.

{% endnote %}

- To reset the field value, set it to `null`. To reset the array, use an empty array `[]`. You can change individual values in the array using the `target` and `replacement` commands:
  - `{"followers": null}`
  - ```json
      {
        "followers": {
          "replace": [
              {"target": "<ID1>", "replacement": "<ID2>"},
              {"target": "<ID3>", "replacement": "<ID4>"}]
        }
      }
      ```

- For example, to change the issue type to <q>Bug</q>, use one of these methods:
  - `{"type": 1}`
  - `{"type": "bug"}`
  - ```json
      {
          "type": { "id": "1" }
      }
      ```
  - ```json
      {
          "type": { "name": "bug" }
      }
      ```
  - ```json
      {
          "type": {"set": "bug"}
      }
      ```

> Example 1: Change the name, description, type, and priority of an issue.
>
> - An HTTP PATCH method is used.
> - We're editing the TEST-1 issue.
> - New issue type: <q>Bug</q>.
> - New issue priority: <q>Low</q>.
> 
> ```
> PATCH /v2/issues/TEST-1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> 
> {
>     "summary": "New issue name",
>     "description": "New issue description",
>     "type": {
>         "id": "1",
>         "key": "bug"
>         },
>     "priority": {
>         "id": "2",
>         "key": "minor"
>         }
> }
> ```

> Example 2: Change the parent issue, add it to sprints, and add followers.
> 
> - An HTTP PATCH method is used.
> - We're editing the TEST-1 issue.
> - New parent issue: TEST-2.
> - The issue is added to sprints with ID 3 and ID 2. The sprints must be on different boards.
> - Followers added: `userlogin-1` and `userlogin-2`.
> 
> ```
> PATCH /v2/issues/TEST-1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> 
> {
>     "parent": {
>         "key": "TEST-2"},
>     "sprint": [{"id": "3"}, {"id": "2"}],
>     "followers": {
>         "add": ["userlogin-1", "userlogin-2"]
>         }
> }
> ```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code `200 OK`.

  The response body contains information about the edited issue in JSON format.

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
            "display": "Track"
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

- Request failed

  If the request is processed incorrectly, the API returns a response with an error code:

  401
  :  The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

  403
  :  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

  404
  :   The requested object was not found. You may have specified an invalid object ID or key.

  412
  :   There was a conflict when editing the object. The error may be due to an invalid update version.

{% endlist %}

