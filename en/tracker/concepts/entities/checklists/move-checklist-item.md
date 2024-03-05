---
sourcePath: en/tracker/api-ref/concepts/entities/checklists/move-checklist-item.md
---
# Moving a checklist item

The request allows you to move a [checklist](../../../user/checklist.md) item in an [entity](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To move a checklist item, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```json
POST /{{ ver }}/entities/<entity_type>/<entity_ID>/checklistItems/<checklist_item_ID>/_move
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "before": "<checklist_item_ID>"
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource-checklist](../../../../_includes/tracker/api/resource-checklist-id.md) %}

{% include [query-params](../../../../_includes/tracker/api/query-params-checklist.md) %}

{% cut "Request body parameters" %}

Request body contains the information required to move a checklist item:

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| before | ID of the checklist item to be preceded by the inserted one. | String |

{% endcut %}

> Example: Moving a checklist item
>
> - An HTTP POST method is used.
> - In the checklist, move **Сhecklist item 3** and insert it before the **Сhecklist item 2**.
> - The response displays information about all the checklist items (`fields=checklistItems`).
>
> ```
> POST /v2/entities/project/<project_ID>/checklistItems/<checklist_item_ID>/_move?fields=checklistItems
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>     "before": "6586d6fee2b9ef72********"
> }
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
           "self": "{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full Name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "createdAt": "2023-12-13T15:06:27.231Z",
       "updatedAt": "2023-12-13T15:06:27.231Z",
       "fields": {
           "checklistItems": [
              {
                  "id": "6586d6fee2b9ef71********",
                  "text": "Сhecklist item 1.",
                  "checked": false,
                  "checklistItemType": "standard"
              },
              {
                  "id": "6586d6fee2b9ef73********",
                  "text": "Сhecklist item 3.",
                  "checked": true,
                  "checklistItemType": "standard"
              },
              {
                  "id": "6586d6fee2b9ef72********",
                  "text": "Сhecklist item 2.",
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
   | fields | Additional fields. | Object |

   `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | User unique ID in {{ org-full-name }}. | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID. | String |

   `Fields` **object fields** {#fields}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | checklistItems | Information about checklist items. | Array of objects |

   `checklistItems` **object fields** {#checklist-items}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | id | Сhecklist item ID. | Number |
   | text | Text of the checklist item. | String |
   | checked | Item completion flag: <ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Logical |
   | checklistItemType | Checklist item type:<ul><li>Standard</li><li>Metric</li><li>Criterion</li><li>Filter</li></ul> | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
