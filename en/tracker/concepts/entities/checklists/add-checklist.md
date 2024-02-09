---
sourcePath: en/tracker/api-ref/concepts/entities/checklists/add-checklist.md
---
# Creating a checklist or adding items to it

Use this request to create a [checklist](../../../user/checklist.md) and add new items to it. New items are added to the end of the list.

## Request format {#query}

Before making the request, [get permission to access the API](../../access.md).

To create a new checklist or add items to an existing one, use an HTTP `POST` request. Information about new items is transmitted in its body in JSON format.

```json
POST /{{ ver }}/entities/<entityType>/<id>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "text": "<item_text>",
  "checked": true,
  "assignee": "<assignee_ID_or_login>",
  "deadline": {
    "date": "2021-05-09T00:00:00.000+0000",
    "deadlineType": "date"
  },
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% include [query-params](../../../../_includes/tracker/api/query-params-checklist.md) %}

{% cut "Request body parameters" %}

The request body contains the information required to add items to the checklist:

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| text | Text of the checklist item. | String |

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| checked | Item completion flag: <ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Boolean |
| assignee | ID or username of the user that the checklist item is assigned to. | Number or string |
| deadline | Deadline for the checklist item. | Object |

`deadline` **object fields** {#deadline-checklist}

| Parameter | Description | Data type |
----- | ----- | -----
| date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
| deadlineType | `deadline` parameter data type. | String |

{% endcut %}

> Example: Adding two items to a checklist
>
> - An HTTP POST method is used.
> - Item added to the checklist: <q>Checklist item 1</q>.
> - Item added to the checklist: <q>Checklist item 2</q> marked as completed.
> - The response displays information about all the checklist items (`fields=checklistItems`).
>
> ```
> POST /v2/entities/project/6586d6fee2b9ef74********/checklistItems?fields=checklistItems
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> [
>   {
>      "text":"Checklist item 1."
>   },
>   {
>      "text":"Checklist item 2.",
>      "checked": true
>   }
> ]
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity, its attachments, and checklist items in JSON format.

   ```json
   {
       "self": "https://api.tracker.yandex.net/v2/entities/project/6586d6fee2b9ef74********",
       "id": "6586d6fee2b9ef74********",
       "version": 133,
       "shortId": 0,
       "entityType": "project",
       "createdBy": {
           "self": "{{ host }}/v2/users/1990********",
           "id": "employee_ID",
           "display": "Full_name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "createdAt": "2023-12-13T15:06:27.231Z",
       "updatedAt": "2023-12-13T15:06:27.231Z",
       "fields": {
           "checklistItems": [
              {
                  "id": "6586d91f99a40477********",
                  "text": "Checklist item 1.",
                  "checked": false,
                  "checklistItemType": "standard"
              },
              {
                  "id": "6586d91f99a40477********",
                  "text": "Checklist item 2.",
                  "checked": true,
                  "checklistItemType": "standard"
              }
           ]
       }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the entity. | String |
   | id | Entity ID. | String |
   | version | Entity version. Each change of the parameters increases the version number. | Number |
   | shortId | Project or portfolio ID. | Number |
   | entityType | Entity type:<ul><li>Project for a project</li><li>Portfolio for a portfolio</li></ul> | String |
   | createdBy | Object with information about the entity creator. | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | fields | Additional entity fields. | Object |

   `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | Unique user ID in {{ org-full-name }}. | String |
   | passportUid | Unique {{ ya-360 }} organization user account ID and Yandex ID. | String |

   `fields` **object fields** {#fields}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | checklistItems | Information about checklist items. | Array of objects |

   `checklistItems` **object fields** {#checklist-items}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | Checklist item ID. | Number |
   | text | Text of the checklist item. | String |
   | checked | Item completion flag: <ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Boolean |
   | checklistItemType | Checklist item type:<ul><li>Standard</li><li>Metric</li><li>Criterion</li><li>Filter</li></ul> | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
