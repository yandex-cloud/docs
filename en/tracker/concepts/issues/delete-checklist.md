---
sourcePath: en/tracker/api-ref/concepts/issues/delete-checklist.md
---
# Delete a checklist

Use this request to delete a checklist from an issue.

## Request format {#query}

To delete a checklist from an issue, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue-id>/checklistItems
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID> 
```

#### Resource

- **\<issue-id\>**
 
   Issue ID or key.

{% include [headings](../../../_includes/tracker/api/headings.md) %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  If the request is successful, the API returns a response with code `200 OK`. The response body contains a JSON object with the parameters of the issue the checklist was deleted from.

  ```json
  {
      "self": "https://api.tracker.yandex.net/v2/issues/ORG-3",
      "id": "5f981c00b982f0755dbdc13d",
      "key": "ORG-3",
      "version": 147,
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
      "checklistDone": "0",
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
     "checklistTotal": 4,
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
     "updatedAt": "2021-02-16T08:28:41.095+0000",
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
  | id | Issue ID. | Number |
  | key | Issue key. | String |
  | version | Issue version. Each change of the parameters increases the version number. | Number |
  | lastCommentUpdatedAt | Last comment's update time. | String |
  | [pendingReplayFrom](#pending-replay-from) | Object with information about the employee whose response is awaited. | Object |
  | summary | Issue name. | String |
  | statusStartTime | Issue creation time. | String |
  | [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
  | checklistDone | Number of items in the checklist that are marked as completed. | Number |
  | description | Issue description. | String |
  | [type](#type) | Object with information about the issue type. | Object |
  | [priority](#priority) | Object with information about the priority. | Object |
  | [previousStatusLastAssignee](#previous-status-last-assignee) | Object with information about the assignee of the issue in the previous status. | Object |
  | createdAt | Issue creation date and time. | String |
  | [followers](#followers) | Array of objects with information about issue followers. | Object |
  | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
  | checklistTotal | Number of items in the checklist. | Number |
  | votes | Number of votes for the issue. | Number |
  | [assignee](#assignee) | Object with information about the issue's assignee. | Object |
  | deadline | Deadline for completing the issue. | String |
  | [queue](#queue) | Object with information about the issue queue. | Object |
  | updatedAt | Date and time when the issue was last updated. | String |
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
    : One or more request parameters have an invalid value.

    401
    : The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

    403
    : Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

    404
    : The requested object was not found. You may have specified an invalid object ID or key.

{% endlist %}

