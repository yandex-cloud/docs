---
sourcePath: en/tracker/api-ref/concepts/issues/delete-checklist.md
---
# Deleting a checklist

Use this request to delete a checklist from an issue.

## Request format {#query}

To delete a checklist from an issue, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue_ID_or_key>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
--- | --- | ---
| \<issue_ID_or_key\> | Issue ID or key | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with the parameters of the issue to delete the checklist from.

   ```json
   {
       "self": "https://{{ host }}/v2/issues/ORG-3",
       "id": "5f981c00b982f075********",
       "key": "ORG-3",
       "version": 147,
       "lastCommentUpdatedAt": "2020-12-13T13:18:22.965+0000",
       "pendingReplyFrom": [
           {
               "self": "https://{{ host }}/v2/users/12********",
               "id": "12********",
               "display": "Full Name"
           }
       ],
       "summary": "Issue name",
       "statusStartTime": "2020-11-03T11:19:24.733+0000",
       "updatedBy": {
           "self": "https://{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full Name"
       },
       "checklistDone": "0",
       "description": "Issue description",
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
           "self": "https://{{ host }}/v2/users/12********",
           "id": "12********",
           "display": "Full Name"
       },
       "createdAt": "2020-10-27T13:09:20.085+0000",
       "followers": [
           {
               "self": "https://{{ host }}/v2/users/19********",
               "id": "19********",
               "display": "Full Name"
           }
       ],
       "createdBy": {
           "self": "https://{{ host }}/v2/users/12********",
           "id": "12********",
           "display": "Full Name"
       },
      "checklistTotal": 4,
      "votes": 0,
      "assignee": {
           "self": "https://{{ host }}/v2/users/12********",
           "id": "12********",
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
   | description | Issue description. | String |
   | [type](#type) | Object with information about the issue type. | Object |
   | [priority](#priority) | Object with information about the priority. | Object |
   | [previousStatusLastAssignee](#previous-status-last-assignee) | Object with information about the assignee of the issue in the previous status. | Object |
   | createdAt | Issue creation date and time. | String |
   | [followers](#followers) | Array of objects with information about issue followers. | Object |
   | [createdBy](#created-by) | Object with information about the user who created the issue. | Object |
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
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

   `pendingReplyFrom` **object fields** {#pending-reply-from}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

  `type` **object fields** {#type}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the issue type. | String |
   | id | Issue type ID | String |
   | key | Issue type key. | String |
   | display | Issue type name displayed. | String |

   `priority` **object fields** {#priority}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Link to the priority type. | String |
   | id | Priority ID | String |
   | key | Priority key. | String |
   | display | Priority name displayed. | String |

   `previousStatusLastAssignee` **object fields** {#previous-status-last-assignee}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

   `followers` **object fields** {#followers}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

  `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

  `assignee` **object fields** {#assignee}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |

  `queue` **object fields** {#queue}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Queue link. | String |
   | id | Queue ID. | Number |
   | key | Queue key. | String |
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