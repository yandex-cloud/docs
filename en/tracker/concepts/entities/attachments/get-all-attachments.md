---
sourcePath: en/tracker/api-ref/concepts/entities/attachments/get-all-attachments.md
---
# Getting a list of attached files

The request allows you to get a list of files attached to the [entity](../about-entities.md).

## Request format {#query}

Before making the request, [get permission to access the API](../../access.md).

To get a list of attachments, use an HTTP `GET` request.

```json
GET /{{ ver }}/entities/<entityType>/<id>/attachments
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

> Example: Get a list of attachments
>
> - An HTTP GET method is used.
> - The response displays information about all the files attached to the entity.
>
> ```
> GET /v2/entities/project/6586d6fee2b9ef74********/attachments
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about all the files attached to the entity in JSON format.

   ```json
   [
       {
           "self": "{{ host }}/v2/attachments/3",
           "id": "3",
           "name": "Shops.csv",
           "content": "{{ host }}/v2/attachments/3/Shops.csv",
           "createdBy": {
               "self": "{{ host }}/v2/users/1990********",
               "id": "employee_ID",
               "display": "Full_name",
               "cloudUid": "ajeppa7dgp53********",
               "passportUid": "15********"
           },
           "createdAt": "2023-12-25T07:21:36.722+0000",
           "mimetype": "text/csv",
           "size": 559
       },
       {
           "self": "{{ host }}/v2/attachments/5",
           "id": "5",
           "name": "flowers.jpg",
           "content": "{{ host }}/v2/attachments/5/flowers.jpg",
           "createdBy": {
               "self": "{{ host }}/v2/users/1990********",
               "id": "employee_ID",
               "display": "Full_name",
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
   ]
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
   | cloudUid | Unique user ID in {{ org-full-name }}. | String |
   | passportUid | Unique {{ ya-360 }} organization user account ID and Yandex ID. | String |

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
