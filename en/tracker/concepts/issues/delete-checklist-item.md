---
sourcePath: en/tracker/api-ref/concepts/issues/delete-checklist-item.md
---
# Deleting a checklist item

Use this request to delete a checklist item from an issue.

## Request format {#query}

To delete a checklist item from an issue, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue-id>/checklistItems/<checklistItem-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
--- | --- | ---
| \<issue-id\> | Issue ID or key. | String |
| \<checklistItem-id\> | ID of the checklist item. To get the ID, run a [request](get-checklist.md#answer). | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with the parameters of the checklist items and the issue the checklist item was deleted from.

   ```json
   {
       "self": "https://{{ host }}/v2/issues/ORG-3",
       "id": "5f981c00b982f0755dbdc13d",
       "key": "ORG-3",
       "version": 151,
       "lastCommentUpdatedAt": "2020-12-13T13:18:22.965+0000",
       "pendingReplyFrom": [
           {
               "self": "https://{{ host }}/v2/users/1134669289",
               "id": "employee ID",
               "display": "Full Name"
           }
       ],
       "summary": "Issue name",
       "statusStartTime": "2020-11-03T11:19:24.733+0000",
       "updatedBy": {
           "self": "https://{{ host }}/v2/users/19904929",
           "id": "employee ID",
           "display": "Full Name"
       },
       "checklistDone": "0",
       "project": {
         "self": "https://{{ host }}/v2/projects/7",
         "id": "7",
         "display": "Project name"
       },
       "description": "Issue description",
       "boards": [
               {
                 "id": 14
               }
           ],
       "type": {
           "self": "https://{{ host }}/v2/issuetypes/2",
           "id": "2",
           "key": "task",
           "display": "Issue"
       },
       "priority": {
           "self": "https://{{ host }}/v2/priorities/3",
           "id": "3",
           "key": "normal",
           "display": "Normal"
       },
       "previousStatusLastAssignee": {
           "self": "https://{{ host }}/v2/users/1134669289",
           "id": "employee ID",
           "display": "Full Name"
       },
       "createdAt": "2020-10-27T13:09:20.085+0000",
       "followers": [
           {
               "self": "https://{{ host }}/v2/users/19904929",
               "id": "employee ID",
               "display": "Full Name"
           }
       ],
       "createdBy": {
           "self": "https://{{ host }}/v2/users/1134669289",
           "id": "employee ID",
           "display": "Full Name"
       },
       "checklistItems": [
            {
                  "id": "5fde5f0a1aee261dd3b62edb",
                  "text": "checklist item",
                  "textHtml": "Item text in HTML format",
                  "checked": false,
                  "assignee": {
                     "id": 1134669209,
                     "display": "Full Name",
                     "passportUid": 1134669209,
                     "login": "user_login",
                     "firstName": "First name",
                     "lastName": "Last Name",
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
      "checklistTotal": 4,
      "votes": 0,
      "assignee": {
           "self": "https://{{ host }}/v2/users/1134669289",
           "id": "employee ID",
           "display": "Full Name"
       },
      "deadline": "2020-10-28",
      "queue": {
           "self": "https://{{ host }}/v2/queues/ORG",
           "id": "1",
           "key": "ORG",
           "display": "Startrek"
       },
      "updatedAt": "2021-02-16T08:28:41.095+0000",
      "status": {
           "self": "https://{{ host }}/v2/statuses/2",
           "id": "2",
           "key": "needInfo",
           "display": "Need info"
       },
       "previousStatus": {
           "self": "https://{{ host }}/v2/statuses/3",
           "id": "3",
           "key": "inProgress",
           "display": "In progress"
       },
       "favorite": false
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | Number |
   | key | Issue key. | String |
   | version | Issue version. Each change of the parameters increases the version number. | Number |
   | lastCommentUpdatedAt | Last comment's update time. | String |
   | [pendingReplyFrom](#pending-reply-from) | Object with information about the employee whose response is awaited. | Object |
   | summary | Issue name. | String |
   | statusStartTime | Issue creation time. | String |
   | [updatedBy](#updated-by) | Object with information about the employee who edited the issue last. | Object |
   | checklistDone | Number of checklist items that are marked as done. | Number |
   | [project](#project) | Object with information about the [project](../../manager/project-new.md) the issue belongs to. | Object |
   | description | Issue description. | String |
   | [boards](#boards) | Array of objects with information about the issue [boards](../../manager/agile-new.md). | Object |
   | [type](#type) | Object with information about the issue type. | Object |
   | [priority](#priority) | Object with information about the priority. | Object |
   | [previousStatusLastAssignee](#previous-status-last-assignee) | Object with information about the assignee of the issue in the previous status. | Object |
   | createdAt | Issue creation date and time. | String |
   | [followers](#followers) | Array of objects with information about issue followers. | Object |
   | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
   | [checklistItems](#checklist-items) | Array of objects with information about checklist items. | Object |
   | checklistTotal | Number of checklist items. | Number |
   | votes | Number of votes for the issue. | Number |
   | [assignee](#assignee) | Object with information about the issue's assignee. | Object |
   | deadline | Deadline for completing the issue. | String |
   | [queue](#queue) | Object with information about the issue queue. | Object |
   | updatedAt | Date and time when the issue was last updated. | String |
   | [status](#status) | Object with information about the issue status. | Object |
   | [previousStatus](#previous-status) | Object with information about the previous status of the issue. | Object |
   | favorite | Favorite issue flag:<ul><li>`true`: Issue added to favorites by the user.</li><li>`false`: Issue not added to favorites.</li></ul> | Number |

   `updatedBy` **object fields** {#updated-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `project` **object fields** {#project}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the project | String |
   | id | Project ID | String |
   | display | Project display name | String |

   `boards` **object fields** {#boards}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | Board ID | Number |

   `pendingReplyFrom` **object fields** {#pending-reply-from}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `type` **object fields** {#type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type | String |
   | id | Issue type ID | String |
   | key | Issue type key | String |
   | display | Issue type name displayed | String |

   `priority` **object fields** {#priority}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the priority type | String |
   | id | Priority ID | String |
   | key | Priority key | String |
   | display | Priority name displayed | String |

   `previousStatusLastAssignee` **object fields** {#previous-status-last-assignee}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `followers` **object fields** {#followers}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `createdBy` **object fields**  {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `checklistItems` **object fields** {#checklist-items}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | ID of the checklist item. | String |
   | text | Text of the checklist item. | String |
   | textHtml | Text of the checklist item in HTML format. | String |
   | checked | Checklist item completion flag:<ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Logical |
   | [assignee](#assignee-checklist) | Assignee of the checklist item. | Object |
   | [deadline](#deadline-checklist) | Deadline for the checklist item. | Object |
   | checklistItemType | Type of the checklist item. | String |

   `assignee` **object fields** {#assignee-checklist}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | User ID | Number |
   | display | Displayed user name | String |
   | passportUid | Unique ID of the user's Yandex account. | Number |
   | login | User's login. | String |
   | firstName | User's first name. | String |
   | lastName | User's last name. | String |
   | email | User's email address. | String |
   | trackerUid | Unique ID of the user {{ tracker-name }} account | Number |

   `deadline` **object fields** {#deadline-checklist}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
   | deadlineType | The `deadline` parameter data type. | String |
   | isExceeded | Flag indicating if the deadline has passed: <ul><li>`true`: Passed.</li><li>`false`: Not passed.</li></ul> | Logical |

   `assignee` **object fields** {#assignee}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |

   `queue` **object fields** {#queue}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Queue link | String |
   | id | Queue ID | Number |
   | key | Queue key | String |
   | display | Queue name displayed. | String |

   `status` **object fields** {#status}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Status link. | String |
   | id | Status ID. | String |
   | key | Status key. | String |
   | display | Status name displayed. | String |

   `previousStatus` **object fields** {#previous-status}

   | Parameter | Description | Data type |
   ----- | ----- | -----
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