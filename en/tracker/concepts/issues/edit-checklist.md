---
sourcePath: en/tracker/api-ref/concepts/issues/edit-checklist.md
---
# Edit a checklist

Use this request to edit the items of a [checklist](../../user/checklist.md).

## Request format {#query}

To edit checklist items, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/issues/<issue-id>/checklistItems
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

[
 {
  "id": "602c13a89fb583544a9528ae",
  "text": "Item text",
  "checked": true,
  "assignee": "1134669209",
  "deadline": {
        "date": "2021-05-25T00:00:00.000+0000",
        "deadlineType": "date"
      }
 },
 ...
]
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| --- | --- | --- |
| \<issues-id\> | Issue ID or key | String |

{% endcut %}

{% cut "Request body parameters" %}

The request body contains the checklist item parameters.
 It must list all the items.

**Required parameters**

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | id | [ID of the checklist item](get-checklist.md#answer). | String |
   | text | Text of the checklist item. | String |

**Additional parameters**

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | checked | Flag indicating that the checklist item is completed:<ul><li>`true`: The item is marked as completed.</li><li>`false`: The item is not marked as completed.</li></ul> | Boolean |
   | assignee | ID or username of the user that the checklist item is assigned to. | String |
   | [deadline](#deadline-checklist) | Deadline for the checklist item. | Object |

**Object fields** `deadline` {#deadline-checklist}

   | Parameter | Description | Data type |
   | ----- | ----- | ----- |
   | date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
   | deadlineType | The `deadline` parameter data type. | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  The response body contains a JSON object with the parameters of the checklist items and the issue that the checklist was edited in.

  ```json
  {
      "self": "{{ host }}/v2/issues/ORG-3",
      "id": "5f981c00b982f0755dbdc13d",
      "key": "ORG-3",
      "version": 184,
      "lastCommentUpdatedAt": "2021-02-06T17:14:22.965+0000",
      "pendingReplyFrom": [
          {
              "self": "{{ host }}/v2/users/1134669289",
              "id": "Employee ID",
              "display": "First and Last name"
          }
      ],
      "summary": "Issue name",
      "statusStartTime": "2020-11-03T11:19:24.733+0000",
      "updatedBy": {
          "self": "{{ host }}/v2/users/19904929",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "checklistDone": "2",
      "description": "Issue description",
      "type": {
          "self": "{{ host }}/v2/issuetypes/2",
          "id": "2",
          "key": "task",
          "display": "Issue"
      },
      "priority": {
          "self": "{{ host }}/v2/priorities/3",
          "id": "3",
          "key": "normal",
          "display": "Medium"
      },
      "previousStatusLastAssignee": {
          "self": "{{ host }}/v2/users/1134669289",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "createdAt": "2020-10-27T13:09:20.085+0000",
      "followers": [
          {
              "self": "{{ host }}/v2/users/19904929",
              "id": "Employee ID",
              "display": "First and Last name"
          }
      ],
      "createdBy": {
          "self": "{{ host }}/v2/users/1134669289",
          "id": "Employee ID",
          "display": "First and Last name"
      },
      "checklistItems": [
        {
              "id": "5fde5f0a1aee261dd3b62edb",
              "text": "Checklist item",
              "textHtml": "Item text in HTML format",
              "checked": false,
              "assignee": {
                 "id": 1134669209,
                 "display": "First and Last name",
                 "passportUid": 1134669209,
                 "login": "user_login",
                 "firstName": "First name",
                 "Lastname": "Last name",
                 "email": "user_login@example.com",
                 "trackerUid": 1134669209
                 },
              "deadline": {
                 "date": "2021-05-09T00:00:00.000+0000",
                 "deadlineType": "date",
                 "isExceeded": false
                 },
              "checklistItemType": "standard"  
        }, 
        ...
       ], 
      },
     "checklistTotal": 4,
     "votes": 0,
     "deadline": "2020-10-28",
     "queue": {
          "self": "{{ host }}/v2/queues/ORG",
          "id": "1",
          "key": "ORG",
          "display": "Startrack"
      },
     "updatedAt": "2021-02-16T08:28:41.095+0000",
     "status": {
          "self": "{{ host }}/v2/statuses/2",
          "id": "2",
          "key": "needInfo",
          "display": "Need info"
      },
      "previousStatus": {
          "self": "{{ host }}/v2/statuses/3",
          "id": "3",
          "key": "inProgress",
          "display": "In progress"
      },
      "favorite": false
  }
  ```

  {% cut "Response parameters" %}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | self | Address of the API resource with information about the issue. | String |
  | id | Issue ID. | String |
  | key | Issue key. | String |
  | version | Issue version. Each change of the parameters increases the version number. | Number |
  | lastCommentUpdatedAt | Last comment's update time. | String |
  | [pendingReplyFrom](#pending-reply-from) | Object with information about the employee whose response is awaited. | Object |
  | summary | Issue name. | String |
  | statusStartTime | Issue creation time. | String |
  | [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
  | checklistDone | Number of checklist items that are marked as done. | Number |
  | description | Issue description. | String |
  | [type](#type) | Object with information about the issue type. | Object |
  | [priority](#priority) | Object with information about the priority. | Object |
  | [previousStatusLastAssignee](#previous-status-last-assignee) | Object with information about the assignee of the issue in the previous status. | Object |
  | createdAt | Issue creation date and time. | String |
  | [followers](#followers) | Array of objects with information about issue followers. | Object |
  | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
  | [checklistItems](#checklist-items) | Array of objects with information about checklist items. | Object |
  | checklistTotal | Number of checklist items. | Number |
  | votes | Number of votes for the issue. | Number |
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

  **Object fields** `pendingReplyFrom` {#pending-reply-from}

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
  | [assignee](#assignee-checklist) | Assignee of the checklist item. | Object |
  | [deadline](#deadline-checklist) | Deadline for the checklist item. | Object |
  | checklistItemType | Type of the checklist item. | String |

  **Object fields** `assignee` {#assignee-checklist}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | id | User ID. | Number |
  | display | User's name displayed. | String |
  | passportUid | Unique ID of the user's Yandex account. | Number |
  | login | Username of the user. | String |
  | firstName | User's first name. | String |
  | lastName | Last name of the user. | String |
  | email | User's email address. | String |
  | trackerUid | Unique ID of the user's {{ tracker-name }} account. | Number |

  **Object fields** `deadline` {#deadline-checklist}

  | Parameter | Description | Data type |
  | ----- | ----- | ----- |
  | date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
  | deadlineType | The `deadline` parameter data type. | String |
  | isExceeded | Flag indicating if the deadline has passed: <ul><li>`true`: Passed.</li><li>`false`: Not passed.</li></ul> | Boolean |

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

  {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

