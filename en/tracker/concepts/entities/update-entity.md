---
sourcePath: en/tracker/api-ref/concepts/entities/update-entity.md
---
# Updating an entity

Use this request to update information about an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request provides a unified method for updating project and portfolio information that extends the features of the [update project information](../projects/update-project.md) API.

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To update an entity, use an HTTP `PATCH` request. Request parameters are provided in the request body in JSON format.

```
PATCH /{{ ver }}/entities/<entityType>/<entityId>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
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
         "entity": "<ID_of_linked_entity>"
      }
   ]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<entityType> | Entity ID:<ul><li>Project for a project</li><li>Portfolio for a portfolio</li></ul> | String |
| \<entityId> | Entity ID | String |

{% note warning %}

The entity ID is not the same as the project or portfolio ID.

{% endnote %}

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| expand | Additional information to include in the response:<ul><li>`attachments`: Attached files</li></ul> | String |
| fields | Additional entity fields to be included into the response | String |

{% endcut %}

{% cut "Request body parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| fields | Object with entity settings | Object |
| comment | Comment | String |
| links | Array of objects with settings of links to other entities | Array of objects |

**Object fields** `fields`

| Parameter | Description | Data type |
-------- | -------- | ----------
| summary | New entity name | String |
| teamAccess | Access | Logical |

**Array object fields** `links`

| Parameter | Description | Data type |
-------- | -------- | ----------
| relationship | Link type. Here is an example:<ul><li>`relates`</li><li>`is dependent by`</li><li>`depends on`</li></ul>. | String |
| entity | Linked entity's ID | String |

{% endcut %}

> Example: Renaming a project and leaving a comment
>
> - An HTTP PATCH method is used.
> - The project is renamed to <q>Test 2</q>.
> - A <q>Project renamed</q> record is added to project comments.
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
      "self": "{{ host }}/{{ ver }}/entities/project/655f328da834c763********",
      "id": "655f328da834c763********",
      "version": 3,
      "shortId": 2,
      "entityType": "project",
      "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "First and Last Name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
      "createdAt": "2023-11-23T11:07:57.298+0000",
      "updatedAt": "2023-11-23T15:46:26.391+0000",
      "attachments": [
         {
            "self": "{{ host }}/{{ ver }}/attachments/8",
            "id": "8",
            "name": "file1.docx",
            "content": "{{ host }}/{{ ver }}/attachments/8/file1.docx",
            "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "First and Last Name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:20.617+0000",
            "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "size": 18585
         },
         {
            "self": "{{ host }}/{{ ver }}/attachments/9",
            "id": "9",
            "name": "file2.pdf",
            "content": "{{ host }}/{{ ver }}/attachments/9/file2.pdf",
            "createdBy": { "self": "{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "First and Last Name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
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
   | self | Address of the API resource with information about the project | String |
   | id | Entity ID | String |
   | version | Project version. Each change of the parameters increases the version number. | Number |
   | shortId | Project or portfolio ID | String |
   | entityType | Entity type | String |
   | createdBy | Block with information about the user who created the entity | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | attachments | Array of objects with information about the attachment | Array of objects |

   **Object fields** `createdBy`

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the user who created the entity | String |
   | id | User ID | Number |
   | display | Displayed user name | String |
   | cloudUid | User unique ID in {{ org-full-name }} | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-412](../../../_includes/tracker/api/answer-error-412.md) %}

   {% include [answer-error-428](../../../_includes/tracker/api/answer-error-428.md) %}


{% endlist %}