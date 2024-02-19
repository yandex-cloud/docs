---
sourcePath: en/tracker/api-ref/concepts/entities/attachments/get-attachment.md
---
# Getting information about an attached file

The request allows you to obtain information about the file attached to the [entity](../about-entities.md).

## Request format {#query}

Before making a request, [get permission to access the API](../../access.md).

To get information about an attached file, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entity_type>/<entity_ID>/attachments/<file_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-attach.md) %}

> Example: Get information about the attached file
>
> - An HTTP GET method is used.
> - The response displays information about the attached entity file.
>
> ```
> GET /v2/entities/project/<project_ID>/attachments/5
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the attached entity file in JSON format.

   ```json
   {
       "self": "{{ host }}/v2/attachments/5",
       "id": "5",
       "name": "flowers.jpg",
       "content": "{{ host }}/v2/attachments/5/flowers.jpg",
       "createdBy": {
           "self": "{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "createdAt": "2024-01-11T06:24:57.635+0000",
       "mimetype": "image/jpeg",
       "size": 20466,
       "metadata": {
           "size": "236x295"
       }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | API resource address that contains information about the entity's attachments. | String |
   | id | File ID. | String |
   | name | File name. | String |
   | content | Address of the resource to download the file from. | String |
   | thumbnail | Address of the resource to download the preview thumbnail from; available for image files only. | String |
   | [createdBy](#created-by) | Object with information about the user who attached the file. | Object |
   | createdAt | File upload date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. | String |
   | mimetype | File type, for example:<ul><li>`text/plain`: Text file</li><li>`image/png`: Image in PNG format</li></ul> | String |
   | size | File size in bytes. | Integer |
   | [metadata](#metadata) | Object with file metadata. | Object |

   `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user. | String |
   | id | User ID. | Number |
   | display | Displayed user name. | String |
   | cloudUid | User unique ID in {{ org-full-name }}. | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID. | String |

   `metadata` **object fields** {#metadata}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | size | Image size in pixels. | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
