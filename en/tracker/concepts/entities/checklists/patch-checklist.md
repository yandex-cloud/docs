---
sourcePath: en/tracker/api-ref/concepts/entities/checklists/patch-checklist.md
---
# Editing a checklist

The request allows you to edit [checklist](../../../user/checklist.md) items in an [entity](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To edit checklist items, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format.

```json
PATCH /{{ ver }}/entities/<entity_type>/<entity_ID>/checklistItems
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
  "id": "<item_ID>",
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

Request body contains the information needed to make changes to the checklist items:

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| id | Item ID. | String |
| text | Text of the checklist item. | String |

**Additional parameters**

{% note warning %}

* If the value of the additional parameter is not specified, it will be reset to the default value, depending on the field type (empty string, `0`, `null`, `false`). Repeat the values of the parameters you did not change.
* The number of items cannot change. You can separately [add](./add-checklist.md) or [delete](./delete-checklist-item.md) checklist items.

{% endnote %}

| Parameter | Description | Data type |
----- | ----- | -----
| checked | Item completion flag: <ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Logical |
| assignee | ID or username of the user that the checklist item is assigned to. | Number or string |
| deadline | Deadline for the checklist item. | Object |

`deadline` **object fields** {#deadline-checklist}

| Parameter | Description | Data type |
----- | ----- | -----
| date | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
| deadlineType | The `deadline` parameter data type. | String |

{% endcut %}

> Example: Modify two checklist items
>
> - An HTTP PATCH method is used.
> - The first checklist item name changes to **Modified checklist item 1**. Other field values are reset (assignee, deadline, completion flag, and item type).
> - The second item gets a different assignee and a completion flag. Other field values are reset (deadline and item type).
> - The response displays information about all the checklist items (`fields=checklistItems`).
>
> ```
> PATCH /v2/entities/project/<project_ID>/checklistItems?fields=checklistItems
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> [
>   {
>      "id": "658953a65c0f1b21********",
>      "text":"Modified checklist item 1."
>   },
>   {
>      "id": "658953a65c0f1b21********",
>      "text":"Сhecklist item 2.",
>      "assignee": 19*********,
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
                  "id": "6586d91f99a40477********",
                  "text": "Modified checklist item 1.",
                  "checked": false,
                  "assignee": {"assignee"},
                  "checklistItemType": "standard"
              },
              {
                  "id": "6586d91f99a40477********",
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
