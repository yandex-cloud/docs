---
sourcePath: en/tracker/api-ref/concepts/issues/get-checklist.md
---
# Getting checklist parameters

Use this request to get the parameters of a [checklist](../../user/checklist.md) in issue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get checklist parameters, use an HTTP `GET` request:

```json
GET /{{ ver }}/issues/<issue_ID_or_key>/checklistItems
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

   The response body contains information about the checklist items in JSON format.
   ```json
   {
       "id": "5fde5f0a1aee261d********",
       "text": "checklist item",
       "textHtml": "item text in HTML format",
       "checked": false,
       "assignee": {
           "id": 11********,
           "display": "Full Name",
           "passportUid": 11********,
           "login": "user_login",
           "firstName": "First name",
           "lastName": "Last name",
           "email": "user_login@example.com",
           "trackerUid": 11********
       },
       "deadline": {
           "date": "2021-05-09T00:00:00.000+0000",
           "deadlineType": "date",
           "isExceeded": false
       },
       "checklistItemType": "standard"
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | id | Сhecklist item ID. | String |
   | text | Text of the checklist item. | String |
   | textHtml | Text of the checklist item in HTML format. | String |
   | checked | Checklist item completion flag:<ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Logical |
   | [assignee](#assignee) | Assignee of the checklist item. | Object |
   | [deadline](#deadline) | Deadline for the checklist item. | Object |
   | checklistItemType | Type of the checklist item. | String |

    **Object fields** `assignee` {#assignee}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | passportUid | Unique ID of the user's Yandex account. | Number |
   | login | User's login. | String |
   | firstName | Username. | String |
   | lastName | User's last name. | String |
   | email | User's email address. | String |
   | trackerUid | Unique ID of the user {{ tracker-name }} account. | Number |


   `deadline` **object fields** {#deadline}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
   | deadlineType | The `deadline` parameter data type. | String |
   | isExceeded | Flag indicating if the deadline has passed: <ul><li>`true`: Passed.</li><li>`false`: Not passed.</li></ul> | Logical |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}