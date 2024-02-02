---
sourcePath: en/tracker/api-ref/concepts/entities/create-entity.md
---
# Creating an entity

Use this request to create a new entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request provides a unified method for creating projects and portfolios that extends the features of the [project creation](../projects/create-project.md) API.


## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To create a new entity, use an HTTP `POST` request. Request parameters are provided in the request body in JSON format.

```json
POST /{{ ver }}/entities/{entityType}
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
   "fields":
   {
      "summary": "<name>",
      "teamAccess": true
   }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

**Resource**

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<entityType> | New entity's type:<ul><li>Project if creating a project</li><li>Portfolio if creating a portfolio</li></ul> | String |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| fields | Additional entity fields to be included into the response | String |

{% endcut %}

{% cut "Request body parameters" %}

The request body contains information required to create a new entity:

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| fields | Object with entity settings | Object |

`fields` **object fields** 

| Parameter | Description | Data type |
-------- | -------- | ----------
| summary | Project name (required field) | String |
| queues | Queue (required for projects if the `teamAccess` field is not set) | String |
| teamAccess | Access (required for projects if the `queues` field is not set) | Logical |

{% endcut %}

> Example: Creating a project
>
> - An HTTP POST method is used.
> - A project named "Test Project" is created.
> - A queue with the [TREK](../../manager/create-queue.md#key) "key" is linked to the project.
>
> ```
> POST /v2/entities/project/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>     "fields":
>     {
>        "summary":"Test Project",
>        "queues":"TREK"
>     }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

   The response body contains information about the new entity in JSON format.
   ```json
   {
      "self": "https://{{ host }}/{{ ver }}/entities/project/655f3be523db2132********",
      "id": "655f3be523db2132********",
      "version": 1,
      "shortId": 6,
      "entityType": "project",
      "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/111111117", "id": "111111117", "display": "Full name", "cloudUid": "ajevuhegoggfk*******", "passportUid": 111111117 },
      "createdAt": "2023-11-23T11:47:49.743+0000",
      "updatedAt": "2023-11-23T11:47:49.743+0000"
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the entity | String |
   | id | Entity ID | String |
   | version | Entity version. Each change of the parameters increases the version number. | Number |
   | shortId | Project or portfolio ID | String |
   | entityType | Entity type | String |
   | createdBy | Block with information about the user who created the entity | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |

   `createdBy` **object fields**

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

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

{% endlist %}