---
sourcePath: en/tracker/api-ref/concepts/issues/post-attachment.md
---
# Attaching a file to an issue using an API request

Use this request to attach a file to an [issue](../../about-tracker.md#task). The **Attachments** tab will display the attached file.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To attach a file, use an HTTP `POST` request:

```
POST /{{ ver }}/issues/<issue_ID_or_key>/attachments/
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
Content-Type: multipart/form-data

<file>
```

{% cut "Headers" %}

- **Host**
   Address of the node that provides the API:

   ```
   {{ host }}
   ```

- **Authorization**

   OAuth token in `OAuth <OAuth_token>` format, e.g.:

   ```
   OAuth 0c4181a7c2cf4521964a72ff********
   ```


- **X-Org-ID** or **X-Cloud-Org-ID**

   Organization ID. If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.


- **Content-Type**

   Request body format. The required value is `multipart/form-data`.

{% endcut %}

{% cut "Resource" %}

| Parameter | Description | Data type |
----- | ----- | -----
| \<issue_ID_or_key\> | Issue ID or key | String |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| \<new_file_name\> | New name that a file will be stored on the server as | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
----- | ----- | -----
| \<file\> | Binary file up to 1024 Mb | File |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

   The response body contains the parameters of the attached file in JSON format.

   ```json
   {
     "self": "<file_address>",
     "id": "<file_ID>",
     "name": "<file_name>",
     "content": "<file_download_address>",
     "thumbnail": "<preview_download_address>",
     "createdBy": {
       "self": "<creator_address>",
       "id": "<creator_username>",
       "display": "<creator_name>"
     },
     "createdAt": "<file_upload_date_and_time>",
     "mimetype": "<file_type>",
     "size": <file_size>,
     "metadata": {
       "size": "<image_dimensions>"
     }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the API resource corresponding to the attached file | String |
   | id | File's unique ID. | String |
   | name | File name. | String |
   | content | Address of the resource to download the file from. | String |
   | thumbnail | Address of the resource to download the preview thumbnail from; available for image files only. | String |
   | [createdBy](#createdBy) | Object with information about the user who attached the file | Object |
   | createdAt | Date and time when the file is uploaded, in <br/>```YYYY-MM-DDThh:mm:ss.sss±hhmm``` format | String |
   | mimetype | File type, for example:<ul><li>`text/plain`: Text file</li><li>`image/png`: Image in PNG format</li></ul> | String |
   | size | File size in bytes. | Integer |
   | [metadata](#metadata) | Object with file metadata | Object |

   `createdBy` **object fields** {#createdBy}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | self | Address of the resource corresponding to the user who uploaded the file | String |
   | id | Username of the user | String |
   | display | User's name (as in the interface) | String |

   `metadata` **object fields** {#metadata}

   | Parameter | Description | Data type |
   ----- | ----- | -----
   | size | Image size in pixels | String |

   {% endcut %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}
