---
sourcePath: en/tracker/api-ref/concepts/entities/attachments/add-attachment.md
---
# Attaching a file to an entity

The request allows you to attach a file to an [entity](../about-entities.md). The **About project** or **About portfolio** tab will display the attached file.

## Request format {#query}

Before making the request, [get permission to access the API](../../access.md).

To attach a file, use an HTTP `POST` request:

```json
POST /{{ ver }}/entities/<entity_type>/<entity_ID>/attachments/<file_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<entity_type> | Entity type:<ul><li>Project for a project</li><li>Portfolio for a portfolio</li></ul> | String |
| \<entity_ID> | Entity ID. To get the ID, see the [entity list](../search-entities.md). | String |
| \<project_or_portfolio_ID> | Project or portfolio ID (the `shortId` value). You can use it instead of the entity ID in the request. | String |
| \<file_ID> | ID of a temporary file [preloaded](../../issues/temp-attachment.md) into {{ tracker-name }} | String |

{% note warning %}

Entity ID is not the same as project or portfolio ID.

{% endnote %}

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| notify | Notify the users specified in the **Author**, **Responsible**, **Participants**, **Customers**, and **Followers** fields. The default value is `true`. | Boolean |
| notifyAuthor | Notify the author of the changes. The default value is `false`. | Boolean |
| [fields](../about-entities.md#query-params) | Additional entity fields to include in the response | String |
| expand | Additional information to include in the response: <ul><li>`all`: All</li><li>`attachments`: Attached files</li></ul> | String |

{% endcut %}

> Example: Attaching a file to an entity
>
> - An HTTP POST method is used.
> - The response displays information about all the attached files.
>
> ```
> POST /v2/entities/project/<project_ID>/attachments/30?expand=attachments
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

   The response body contains information about the entity attachment.

   ```json
   {
       "self": "{{ host }}/v2/entities/project/6586d6fee2b9ef74********",
       "id": "6586d6fee2b9ef74********",
       "version": 78,
       "shortId": 4,
       "entityType": "project",
       "createdBy": {
           "self": "{{ host }}/v2/users/19********",
           "id": "19********",
           "display": "Full name",
           "cloudUid": "ajeppa7dgp53********",
           "passportUid": "15********"
       },
       "createdAt": "2023-12-23T12:47:58.405+0000",
       "updatedAt": "2024-01-13T14:06:29.747+0000",
       "attachments": [
           {
               "self": "{{ host }}/v2/attachments/4",
               "id": "4",
               "name": "newimage.jpg",
               "content": "{{ host }}/v2/attachments/4/newimage.jpg",
               "createdBy": {
                   "self": "{{ host }}/v2/users/19********",
                   "id": "19********",
                   "display": "Full name",
                   "cloudUid": "ajeppa7dgp53********",
                   "passportUid": "15********"
               },
               "createdAt": "2024-01-11T06:24:57.635+0000",
               "mimetype": "image/jpeg",
               "size": 20466
           }
       ]
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
   | [createdBy](#created-by) | Block with information about the entity creator | Object |
   | createdAt | Entity creation date in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | updatedAt | Date when the entity was last updated, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | [attachments](#attachments) | Array of objects with information about the attachment | Array of objects |

   `attachments` **object fields** {#attachments}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | API resource address that contains information about the entity's attachments. | String |
   | id | File ID. | String |
   | name | File name | String |
   | content | Address of the resource to download the file from | String |
   | thumbnail | Address of the resource to download the preview thumbnail from; available for image files only | String |
   | [createdBy](#createdBy) | Object with information about the user who attached the file | Object |
   | createdAt | File upload date and time in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
   | mimetype | File type, for example:<ul><li>`text/plain`: Text file</li><li>`image/png`: Image in PNG format</li></ul> | String |
   | size | File size in bytes | Integer |
   | [metadata](#metadata) | Object with file metadata | Object |

   `createdBy` **object fields** {#created-by}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource with information about the user | String |
   | id | User ID | Number |
   | display | Displayed user name | String |
   | cloudUid | Unique user ID in {{ org-full-name }} | String |
   | passportUid | Unique ID of the user account in the {{ ya-360 }} organization and Yandex ID | String |

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
