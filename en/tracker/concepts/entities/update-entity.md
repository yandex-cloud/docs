---
sourcePath: en/tracker/api-ref/concepts/entities/update-entity.md
---
# Updating an entity

Use this request to update information about an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request is a unified method for updating project and portfolio information – more flexible and functional than the [updating project information](../projects/update-project.md) API.

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To update an entity, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format.

```json
PATCH /{{ ver }}/entities/<entity_type>/<entity_ID>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
   "fields":
   {
      "summary": "<new_name>",
      "teamAcceess": true
	},
   "comment":"<comment>",
   "links":
   [
      {
         "relationship": "<link>",
         "entity": "<linked_entity_ID>"
      }
   ]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| [fields](./about-entities.md#query-params) | Additional entity fields to be included into the response. | String |
| expand | Additional information to be included into the response:<ul><li>`attachments`: Attached files</li></ul> | String |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| [fields](./about-entities.md#query-body-params) | Object with entity settings. | Object |
| comment | Comment. | String |
| links | Array of objects with settings of links to other entities. | Array of objects |

`Fields` **object fields**

| Parameter | Description | Data type |
-------- | -------- | ----------
| summary | Name (required field). | String |
| queues | Queue (required for projects if the `teamAccess` field is not set). | String |
| teamAccess | Access (required for projects if the `queues` field is not set). | Logical |
| description | Description. | String |
| author | Author (user ID). | Number |
| lead | Responsible person (user ID). | Number |
| teamUsers | Members (array of user IDs). | Array of numbers |
| clients | Clients (array of user IDs). | Array of numbers |
| followers | Followers (array of user IDs). | Array of numbers |
| start | Start date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
| end | Deadline in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | Date |
| tags | Tags. | Array of strings |
| parentEntity | Parent entity (portfolio) ID. | Number |
| entityStatus | Status:<ul><li>draft: Draft</li><li>in_progress: In progress</li><li>launched: New</li><li>postponed: Postponed</li><li>at_risk: At risk</li><li>blocked: Blocked</li><li>according_to_plan: According to plan</li></ul> | String |

**links** `array object fields`

| Parameter | Description | Data type |
-------- | -------- | ----------
| relationship | Link type. e.g.:<ul><li>`relates`</li><li>`is dependent by`</li><li>`depends on`</li></ul>. | String |
| entity | Linked entity's ID. | String |

{% endcut %}

> Example: Renaming a project and leaving a comment
>
> - An HTTP PATCH method is used.
> - The project is renamed to **Test 2**.
> - A **Project renamed** record is added to project comments.
> - The response will display attachments.
>
> ```
> PATCH /v2/entities/project/655f8cc523db213********?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>     "fields":
>     {
>        "summary":"Test 2",
>     },
>     "comment":"Project renamed"
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the updated entity in JSON format.

   ```json
   {
      "self": "https://{{ host }}/{{ ver }}/entities/project/655f328da834c763********",
      "id": "655f328da834c763********",
      "version": 3,
      "shortId": 2,
      "entityType": "project",
      "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/11********", "id": "11********", "display": "Full Name", "cloudUid": "ajevuhegoggf********", "passportUid": 11******** },
      "createdAt": "2023-11-23T11:07:57.298+0000",
      "updatedAt": "2023-11-23T15:46:26.391+0000",
      "attachments": [
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/8",
            "id": "8",
            "name": "file1.docx",
            "content": "{{ host }}/{{ ver }}/attachments/8/file1.docx",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/11********", "id": "11********", "display": "Full Name", "cloudUid": "ajevuhegoggf********", "passportUid": 11******** },
            "createdAt": "2023-11-23T15:46:20.617+0000",
            "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "size": 18585
         },
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/9",
            "id": "9",
            "name": "file2.pdf",
            "content": "{{ host }}/{{ ver }}/attachments/9/file2.pdf",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/11********", "id": "11********", "display": "Full Name", "cloudUid": "ajevuhegoggf********", "passportUid": 11******** },
            "createdAt": "2023-11-23T15:46:25.932+0000",
            "mimetype": "application/pdf",
            "size": 175656
         }
      ]
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the project. | String |
   | id | Entity ID. | String |
   | version | Project version. Each change of the parameters increases the version number. | Number |
   | shortId | Project or portfolio ID | String |
   | entityType | Entity type. | String |
   | createdBy | Block with information about the user who created the entity. | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | attachments | Array of objects with information about the attachment. | Array of objects |

   `createdBy` **object fields**

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user who created the entity. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | User unique ID in {{ org-full-name }}. | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-412](../../../_includes/tracker/api/answer-error-412.md) %}

   {% include [answer-error-428](../../../_includes/tracker/api/answer-error-428.md) %}


{% endlist %}
