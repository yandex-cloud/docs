# Create a checklist or add items to it

Use this request to create a [checklist](../../user/checklist.md) and add new items to it.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a new checklist or add items to an existing one, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```json
POST /{{ ver }}/issues/<issue-id>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "text: "<Item text>",
    "checked": "<true|false>"
}
```

#### Request body parameters {#req-body-params}

The request body contains the information required to create a checklist or add an item to a checklist:

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| text | Text of the item. | String |
| checked | A mark of item completion. | Boolean |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code `200 OK`.

  The response body contains information in JSON format about the checklist and items added to it.

  ```json
  {
      "self": "https://api.tracker.yandex.net/v2/issues/ORG-3",
      "id": "5f981c00b982f0755dbdc13d",
      "key": "ORG-3",
      "version": 133,
      "lastCommentUpdatedAt": "2020-12-13T13:18:22.965+0000",
      "pendingReplayFrom": [
          {
              "self": "https://api.tracker.yandex.net/v2/users/1134669289",
              "id": "Employee ID",
              "display": "First and Last name"
          }
      ],
      "summary": "Issue name",
      "statusStartTime": "2020-11-03T11:19:24.733+0000",
      "updatedBy": {
          "self": "https://api.tracker.yandex.net/v2/users/19904929",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "description": "Issue description",
      "type": {
          "self": "https://api.tracker.yandex.net/v2/issuetypes/2",
          "id": "2",
          "key": "task",
          "display": "Issue"
      },
      "priority": {
          "self": "https://api.tracker.yandex.net/v2/priorities/3",
          "id": "3",
          "key": "normal",
          "display": "Medium"
      },
      "previousStatusLastAssignee": {
          "self": "https://api.tracker.yandex.net/v2/users/1134669289",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "createdAt": "2020-10-27T13:09:20.085+0000",
      "followers": [
          {
              "self": "https://api.tracker.yandex.net/v2/users/19904929",
              "id": "Employee ID",
              "display": "First and Last name"
          }
      ],
      "createdBy": {
          "self": "https://api.tracker.yandex.net/v2/users/1134669289",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "checklistItems": [
          {
              "id": "5fde5f0a1aee261dd3b62edb",
              "text": "Checklist item",
              "textHtml": "Item text in HTML format",
              "checked": false,
              "checklistItemType": "standard"
          }
      ],
      "votes": 0,
      "assignee": {
          "self": "https://api.tracker.yandex.net/v2/users/1134669289",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "deadline": "2020-10-28",
      "queue": {
          "self": "https://api.tracker.yandex.net/v2/queues/ORG",
          "id": "1",
          "key": "ORG",
          "display": "Startrack"
      },
      "updatedAt": "2020-12-19T20:14:02.648+0000",
      "status": {
          "self": "https://api.tracker.yandex.net/v2/statuses/2",
          "id": "2",
          "key": "needInfo",
          "display": "Need info"
      },
      "previousStatus": {
          "self": "https://api.tracker.yandex.net/v2/statuses/3",
          "id": "3",
          "key": "inProgress",
          "display": "In progress"
      },
      "favorite": false
  }
  ```

  #### Response parameters {#answer-params}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the issue. | String |
  | id | Issue ID. | String |
  | version | Issue version. Each change of the parameters increases the version number. | Number |
  | key | Issue key. | String |
  | [pendingReplayFrom](#pending-replay-from) | Object with information about the employee whose response is awaited. | Object |
  | lastCommentUpdatedAt | Last comment's update time. | String |
  | summary | Issue name. | String |
  | statusStartTime | Issue creation time. | String |
  | [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
  | description | Issue description. | String |
  | [type](#type) | Object with information about the issue type. | Object |
  | [priority](#priority) | Object with information about the priority. | Object |
  | [previousStatusLastAssignee](#previous-status-last-assignee) | Object with information about the assignee of the issue in the previous status. | Object |
  | createdAt | Issue creation date and time. | String |
  | [followers](#followers) | Array of objects with information about issue followers. | Object |
  | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
  | [checklistItems](#checklist-items) | Array of objects with information about checklist items. | Object |
  | votes | Number of votes for the issue. | Number |
  | [assignee](#assignee) | Object with information about the issue's assignee. | Object |
  | deadline | Deadline for completing the issue. | String |
  | updatedAt | Date and time when the issue was last updated. | String |
  | [queue](#queue) | Object with information about the issue queue. | Object |
  | [status](#status) | Object with information about the issue status. | Object |
  | [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object |
  | favorite | Flag indicating a favorite issue:<ul><li>`true`: The user added the issue to favorites.</li><li>`false`: The issue is not added to favorites.</li></ul> | Number |

  **Object fields** `updatedBy` {#updated-by}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

  **Object fields** `pendingReplayFrom` {#pending-replay-from}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

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

  **Object fields** `previousStatusLastAssignee` {#previous-status-last-assignee}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

  **Object fields** `followers` {#followers}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

  **Object fields** `createdBy` {#created-by}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

  **Object fields** `checklistItems` {#checklist-items}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | id | ID of the checklist item. | String |
  | text | Text of the checklist item. | String |
  | textHtml | Text of the checklist item in HTML format. | String |
  | checked | Flag indicating that the checklist item is completed:<ul><li>`true`: The item is marked as completed.</li><li>`false`: The item is not marked as completed.</li></ul> | Boolean |
  | checklistItemType | Type of the checklist item. | String |

  **Object fields** `assignee` {#assignee}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the user. | String |
  | id | User ID. | Number |
  | display | User's name displayed. | String |

  **Object fields** `queue` {#queue}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Queue link. | String |
  | id | Queue ID. | Number |
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

  400
  :   One or more request parameters have an invalid value.

  404
  :   The requested object was not found. You may have specified an invalid object ID or key.

  422
  :  Validation error. The request body may contain an invalid or non-existent parameter.

{% endlist %}

