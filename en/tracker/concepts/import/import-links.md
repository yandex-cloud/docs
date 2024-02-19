---
title: "How to import links"
description: "This article describes how to import links."
sourcePath: en/tracker/api-ref/concepts/import/import-links.md
---

# Importing links

{% note warning %}

This request can only be executed if the user has permission to edit the issue whose links are to be imported.

{% endnote %}

Use it to import to {{ tracker-name }} links to other issues.

## Request format {#section_i14_lyb_p1b}

To import links, use an HTTP `POST` request. Link parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/issues/<issue_ID_or_key>/links/_import
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
  "relationship": "relates",
  "issue": "TEST-2",
  "createdAt": "2017-08-29T12:34:41.740+0000",
  "createdBy": 11********,
  "updatedAt": "2017-09-07T11:24:31.140+0000",
  "updatedBy": 11********
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
--- | --- | ---
| \<issue_ID_or_key\> | Key of the issue to attach the file to. | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| relationship | Type of links between issues:<ul><li>`relates`: Simple link.</li><li>`is dependent by`: The current issue blocks the linked one.</li><li>`depends on`: The current issue depends on the linked one.</li><li>`is subtask for`: The current issue is a sub-issue of the linked one.</li><li>`is parent task for`: The current issue is a parent issue of the linked one.</li><li>`duplicates`: The current issue duplicates the linked one.</li><li>`is duplicated by`: The linked issue duplicates the current one.</li><li>`is epic of`: The current issue is an epic of the linked one. You can only set this type of link for Epic-type issues.</li><li>`has epic`: The linked issue is an epic of the current one. You can only set this type of link for Epic-type issues.</li><li>`clone`: The linked issue is a clone of the current one.</li><li>`original`: The current issue is a clone of the linked one.</li></ul> | String |
| issue | ID or key of the issue being linked. | String |
| createdAt | Link creation date and time. `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify a value in the interval from the time of creation to the time the issue being linked was last updated. | String |
| createdBy | Username or ID of the user who created the link. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| updatedAt | Date and time when the link was last updated. `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify a value in the interval from the time of creation to the time the issues being linked were last updated.<br/><br/>The parameter is only used together with the `updatedBy` parameter. | String |
| updatedBy | Username or ID of the user who edited the link last.<br/><br/>The parameter is only used together with the `updatedAt` parameter. | <ul><li>String for the username</li><li>Number for the ID</li></ul> |

{% endcut %}

## Response format {#section_isd_myb_p1b}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains the parameters of the attached file in JSON format:

   ```json
   {
           "self": "https://{{ host }}/v2/issues/JUNE-2/links/47*****",
           "id": 47*****,
           "type": {
               "self": "https://{{ host }}/v2/linktypes/subtask",
               "id": "subtask",
               "inward": "Sub-issue",
               "outward": "Parent issue"
           },
           "direction": "outward",
           "object": {
               "self": "https://{{ host }}/v2/issues/TREK-9844",
               "id": "593cd211ef7e8a33********",
               "key": "TREK-9844"
               "display": "subtask"
           },
           "createdBy": {
               "self": "https://{{ host }}/v2/users/11********",
               "id": "11********",
               "display": "Ivan Ivanov"
           },
           "updatedBy": {
               "self": "https://{{ host }}/v2/users/11********",
               "id": "11********",
               "display": "Ivan Ivanov"
           },
           "createdAt": "2017-06-11T05:16:01.421+0000",
           "updatedAt": "2017-06-11T05:16:01.421+0000",
           "assignee": {
               "self": "https://{{ host }}/v2/users/11********",
               "id": "11********",
               "display": "Ivan Ivanov"
           },
           "status": {
               "self": "https://{{ host }}/v2/statuses/1",
               "id": "1",
               "key": "open",
               "display": "Open"
           }
       }
   ```
   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the link. | String |
   | id | Link ID. | Number |
   | [type](#type) | Block with information about the link type. | Object |
   | sdirection | Link type of the issue specified in the request in relation to the issue specified in the [object](#resp-object-param) field. Possible values:<ul><li>`outward`: The issue specified in the request is the main one for the issue in the [object](#resp-object-param) field.</li><li>`inward`: The issue specified in the [object](#resp-object-param) field is the main one for the issue in the request.</li></ul> | String |
   | [object](#object) | Block with information about the linked issue. | Object |
   | [createdBy](#createdBy) | Block with information about the user who created the link. | Object |
   | [updatedBy](#updatedBy) | Block with information about the user who edited the linked issue last. | Object |
   | createdAt | Link creation date and time. | String |
   | updatedAt | Link update date and time. | String |
   | [assignee](#assignee) | Assignee of the linked issue. | Object |
   | [status](#status) | Status of the linked issue. | Object |

    `type` **object fields** {#type}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Link to the link type. | String |
   | id | ID of the link type. | String |
   | inward | Name of the link type of the issue specified in the [object](#resp-object-param) field in relation to the issue specified in the request. | String |
   | outward | Name of the link type of the issue specified in the request in relation to the issue specified in the [object](#resp-object-param) field. | String |

   `object` **object fields** {#object}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the issue. | String |
   | id | Issue ID. | String |
   | key | Issue key. | String |
   | display | Issue name displayed. | String |

   `createdBy` **object fields** {#createBy}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Link to the user. | String |
   | id | User ID. | String |
   | display | Displayed user name. | String |

   `updatedBy` **object fields** {#updatedBy}

   | Parameter | Description | Data type |
   -------- | -------- | ----------   
   | self | Link to the user. | String |
   | id | User ID. | String |
   | display | Displayed user name. | String |

   `assignee` **object fields** {#asignee}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Link to the user. | String |
   | id | User ID. | String |
   | display | Displayed user name. | String |

   `status` **object fields** {#status}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Status link. | String |
   | id | Status ID. | String |
   | key | Status key. | String |
   | display | Status name displayed. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a message with error details:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}