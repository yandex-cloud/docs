---
sourcePath: en/tracker/api-ref/concepts/import/import-attachments.md
---
# Import files

{% note warning %}

This request can only be executed if the user has permission to edit the issue that files are attached to.

{% endnote %}

Use it to import files that are attached to issues and their comments to {{ tracker-name }}.

## Request format {#section_i14_lyb_p1b}

To import a file, use an HTTP `POST` request. Files are passed in the request body via `multipart/form-data`[RFC-7578]({{ link-rfc7578 }}). The file size may not exceed 1024 Mb.

{% list tabs %}

- Attach a file to an issue

    ```json
    POST /{{ ver }}/issues/<issue_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy} 
    Host: {{ host }}
    Authorization: OAuth <token>
    X-Org-ID: <organization ID>
    Content-Type: multipart/form-data
    <file_data>
    ```

    #### Resource {#resource}

    - **<issue_id>**

        Key of the issue to attach the file to.

    - **<comment_id>**

        ID of the comment to attach the file to.

    #### Request parameters {#request-parametres}

    - **filename**

       File name, no more than 255 characters.

    - **createdAt**

       Date and time when the file is attached, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the issue's creation time to its latest update.

    - **createdBy**

       Username or ID of the user who attached the file.

    {% include [headings](../../../_includes/tracker/api/headings.md) %}

    - **Content-Type**

        Request body format. Must be `multipart/form-data`.

    #### Request body {#request-body}

    - **<file_data>**

        Binary file. The file size may not exceed 1024 Mb.

- Attach a file to a comment

    ```json
    POST /{{ ver }}/issues/<issue_id>/comments/<comment_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy} 
    Host: {{ host }}
    Authorization: OAuth <token>
    X-Org-ID: <organization ID>
    Content-Type: multipart/form-data
    <file_data>
    ```

    #### Resource {#resource}

    - **<issue_id>**

        Key of the issue to attach the file to.

    - **<comment_id>**

        ID of the comment to attach the file to.

    #### Request parameters {#request-parametres}

    - **filename**

       File name, no more than 255 characters.

    - **createdAt**

       Date and time when the file is attached, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the issue's creation time to its latest update.

    - **createdBy**

       Username or ID of the user who attached the file.

    #### Request headers {#request-headers}

    - **Host**

        Address of the node that provides the API:

        ```
        {{ host }}
        ```

    - **Authorization**

        OAuth token in `OAuth <token value>` format. For example:

        ```
        OAuth 0c4181a7c2cf4521964a72ff57a34a07
        ```

    - **X-Org-ID**

        Organization ID.

    - **Content-Type**

        Request body format. Must be `multipart/form-data`.

    #### Request body {#request-body}

    - **<file_data>**

        Binary file. The file size may not exceed 1024 Mb.

{% endlist %}

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    If the request is successful, the API returns a response with code 201. The response body contains the parameters of the attached file in JSON format:

    ```json
    {
      "self" : "<address of the API resource corresponding to the file attached>",
      "id" : "<file ID>",
      "name" : "<file name>",
      "content" : "<address to download the file from>",
      "thumbnail" : "<address to download the preview from>",
      "createdBy" : {
        "self" : "<resource corresponding to the file author>",
        "id" : "<username of the file author>",
        "display" : "<name of the file author>"
      },
      "createdAt" : "<date and time when the file is added>",
      "mimetype" : "<file data type>",
      "size" : <file size>
      "metadata" : {
        "size" : "<dimensions (for images)>"
      }
    }
    ```

    #### Response parameters {#answer-parametres}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource corresponding to the attached file. | String |
    | id | Unique ID of the file. | String |
    | name | File name. | String |
    | content | Address of the resource to download the file from. | String |
    | thumbnail | Address of the resource to download the preview thumbnail from. Available for image files only. | String |
    | [createdBy](#createdBy) | Object with information about the user who attached the file. | JSON object |
    | createdAt | Date and time when the file is uploaded, in <br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` format | String |
    | mimetype | File type, for example:<ul><li>`text/plain`: Text file.</li><li>`image/png`: Image in PNG format.</li></ul> | String |
    | size | File size in bytes. | Integer |
    | [metadata](#metadata) | Object with file metadata. | JSON object |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the resource corresponding to the user who uploaded the file. | String |
    | id | Username of the user. | String |
    | display | User's name (as in the interface). | String |

    **Object fields** `metadata` {#metadata}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | size | Image size in pixels. | String |

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP error code | Error description |
    | --------------- | --------------- |
    | 400 Bad Request | One of the request parameters has an invalid value or data format. |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 413 Request Entity Too Large | The file size exceeds 1024 Mb. |
    | 422 Unprocessable Entity | Validation error, the request is rejected. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

