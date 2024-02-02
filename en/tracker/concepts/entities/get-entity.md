---
sourcePath: en/tracker/api-ref/concepts/entities/get-entity.md
---
# Getting entity parameters

Use this request to get information about an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request provides a unified method for getting project and portfolio information that extends the features of the [get project information](../projects/get-project.md) API.

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To get entity parameters, use an HTTP `GET` request.

```
GET /{{ ver }}/entities/<entityType>/<entityId>?expand=attachments&fields=summary,teamAccess
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

**Resource**

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

> Example: Getting information about a portfolio
>
> - An HTTP GET method is used.
> - The response will display attachments.
> - The response will include the `teamAccess` field.
>
> ```
> GET /v2/entities/portfolio/655f328da834c763********?expand=attachments,fields=teamAccess HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity in JSON format.

   ```json
   {
      "self": "https://{{ host }}/{{ ver }}/entities/project/655f328da834c763********",
      "id": "655f328da834c763********",
      "version": 3,
      "shortId": 2,
      "entityType": "project",
      "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Full name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
      "createdAt": "2023-11-23T11:07:57.298+0000",
      "updatedAt": "2023-11-23T15:46:26.391+0000",
      "attachments": [
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/8",
            "id": "8",
            "name": "file1.docx",
            "content": "{{ host }}/{{ ver }}/attachments/8/file1.docx",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Full name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:20.617+0000",
            "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "size": 18585
         },
         {
            "self": "https://{{ host }}/{{ ver }}/attachments/9",
            "id": "9",
            "name": "file2.pdf",
            "content": "{{ host }}/{{ ver }}/attachments/9/file2.pdf",
            "createdBy": { "self": "https://{{ host }}/{{ ver }}/users/1111111117", "id": "1111111117", "display": "Full name", "cloudUid": "ajevuhegoggf********", "passportUid": 1111111117 },
            "createdAt": "2023-11-23T15:46:25.932+0000",
            "mimetype": "application/pdf",
            "size": 175656
         }
      ],
      "fields":
      {
         "teamAccess":null
      }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the project | String |
   | id | Entity ID | String |
   | version | Entity version. Each change of the parameters increases the version number. | Number |
   | shortId | Project or portfolio ID | String |
   | entityType | Entity type | String |
   | createdBy | Block with information about the user who created the entity | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | attachments | Array of objects with information about the attachment | Array of objects |

   **Object fields** `createBy`

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

{% endlist %}