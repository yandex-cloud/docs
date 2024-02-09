---
sourcePath: en/tracker/api-ref/concepts/entities/get-entity.md
---
# Getting entity parameters

Use this request to get information about an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request is a unified method for getting project and portfolio information, more flexible and functional than the [get project information](../projects/get-project.md) API.

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

{% include [resource](../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| [fields](./about-entities.md#query-params) | Additional entity fields to be included into the response. | String |
| expand | Additional information to include in the response:<ul><li>`attachments`: Attached files</li></ul> | String |

{% endcut %}

> Example: Getting information about a portfolio
>
> - An HTTP GET method is used.
> - The response will display attachments.
> - The response will include the `teamAccess` field.
>
> ```
> GET /v2/entities/portfolio/655f328da834c763********?expand=attachments&fields=teamAccess HTTP/1.1
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
   | createdBy | Block with information about the entity creator | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | attachments | Array of objects with information about the attachment | Array of objects |

   `createBy` **object fields**

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the entity creator | String |
   | id | User ID | Number |
   | display | Displayed user name | String |
   | cloudUid | Unique user ID in {{ org-full-name }} | String |
   | passportUid | Unique {{ ya-360 }} organization user account ID and Yandex ID | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
