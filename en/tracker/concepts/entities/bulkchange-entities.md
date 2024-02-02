---
sourcePath: en/tracker/api-ref/concepts/entities/bulkchange-entities.md
---
# Bulk changes to entities

Use this request to make bulk updates to entities: [projects](../../manager/project-new.md) or [project portfolios](../../manager/portfolio.md).

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

Use an HTTP `POST` request for bulk changes of multiple entities. Request parameters are provided in the request body in JSON format.

```
POST /{{ ver }}/entities/<entityType>/bulkchange/_update
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

{
   "metaEntities":[ "<ID_of_entity_1>","<ID_of_entity_2>", ...],
   "values":
   {
      "fields":
      {
         "<field_key>":"<value>",
         ...
      },
      "comment":"<comment>"
   }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<entityType> | Entity ID:<ul><li>Project for a project</li><li>Portfolio for a portfolio</li></ul> | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| metaEntities | List of entity IDs | Array of strings |
| values | Object with settings for bulk entity changes | Object |

**Object fields** `values`

| Parameter | Description | Data type |
-------- | -------- | ----------
| fields | Object with key-value pairs | Object |
| comment | Comment | String |
| links | Array of objects with settings of links to other entities | Array of objects |

**Array object fields** `links`

| Parameter | Description | Data type |
-------- | -------- | ----------
| relationship | Link type. Here is an example:<ul><li>`relates`</li><li>`is dependent by`</li><li>`depends on`</li></ul>. | String |
| entity | Linked entity's ID | String |

{% endcut %}

> Example: Updating a status, assigning a follower, leaving a comment for multiple projects
>
> - An HTTP POST method is used.
> - The project status changes to `At risk`.
> - A follower is assigned.
> - A new record is added to project comments.
>
> ```
> POST /v2/entities/project/bulkchange/_update HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> {
>    "metaEntities":[ "655f3be523db2132********","655f383923db2132********"],
>    "values":
>    {
>       "fields":
>       {
>          "entityStatus":"at_risk",
>          "followers":"agent007",
>       },
>       "comment":"The project is at risk"
>    }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the bulk request in JSON format.

   ```json
   {
      "id": "6560c6f59b0b1e76********",
      "self": "https://{{ host }}/{{ ver }}/bulkchange/6560c6f59b0b1e76********",
      "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Full name", "cloudUid": "ajevuhegoggfk3fmgnqd", "passportUid": 1111111117 },
      "createdAt": "2023-11-24T15:53:25.122+0000",
      "status": "CREATED",
      "statusText": "Bulk change task created.",
      "executionChunkPercent": 0,
      "executionIssuePercent": 0
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | id | Bulk request ID | String |
   | self | Address of the API resource with information about the bulk request | String |
   | createdBy | Block with information about the user who created the bulk request | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | status | Bulk request status | String |
   | statusText | Interpretation of the bulk request status | String |

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