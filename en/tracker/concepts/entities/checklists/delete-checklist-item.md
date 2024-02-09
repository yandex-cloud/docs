---
sourcePath: en/tracker/api-ref/concepts/entities/checklists/delete-checklist-item.md
---
# Deleting a checklist item

The request allows you to remove the [checklist](../../../user/checklist.md) item from the [entity](../about-entities.md). The action cannot be undone.

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To delete a checklist item, use an HTTP `DELETE` request. Request parameters are provided in the request body in JSON format.

```json
DELETE /{{ ver }}/entities/<entityType>/<id>/checklistItems/<checklistItemId>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource-checklist](../../../../_includes/tracker/api/resource-checklist-id.md) %}

{% include [query-params](../../../../_includes/tracker/api/query-params-checklist.md) %}

> Example: Delete a checklist item
>
> - An HTTP DELETE method is used.
> - The item with the `6586d6fee2b9ef72********` ID is deleted from the checklist (<q>Second checklist item</q>).
> - The response displays information about all the checklist items (`fields=checklistItems`).
>
> ```
> DELETE /v2/entities/project/6586d6fee2b9ef74********/checklistItems/6586d6fee2b9ef72********?fields=checklistItems
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity and the checklist in JSON format.

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
                  "id": "6586d6fee2b9ef71********",
                  "text": "Checklist item 1.",
                  "checked": false,
                  "checklistItemType": "standard"
              },
              {
                  "id": "6586d6fee2b9ef73********",
                  "text": "Checklist item 3.",
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
   | checked | Item completion flag:<ul><li>`true`: Item marked as completed.</li><li>`false`: Item not marked as completed.</li></ul> | Boolean |
   | checklistItemType | Checklist item type:<ul><li>Standard</li><li>Metric</li><li>Criterion</li><li>Filter</li></ul> | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
