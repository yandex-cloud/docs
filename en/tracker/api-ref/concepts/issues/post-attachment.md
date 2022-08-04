# Attach a file

Use this request to attach a file to an issue.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To attach a file, use an HTTP `POST` request.

```
POST /{{ ver }}/issues/<issue-id>/attachments/
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
Content-Type: multipart/form-data

<file_data>
```

{% cut "Headers" %}

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

{% if audience == "external" %}

- **X-Org-ID**

    Organization ID.

{% endif %}

- **Content-Type**

    Request body format. Must be `multipart/form-data`.

{% endcut %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<issue-id\> | Issue ID or key | String |

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<filename\> | New name that a file will be stored on the server as | String |

{% endcut %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<file_data\> | Binary file. The file size may not exceed 1024 Mb. | File |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    The response body contains the parameters of the attached file in JSON format.

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
      "size" : <file size>,
      "metadata" : {
        "size" : "<dimensions (for images)>"
      }
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the API resource corresponding to the attached file. | String |
    | id | Unique ID of the file. | String |
    | name | File name. | String |
    | content | Address of the resource to download the file from. | String |
    | thumbnail | Address of the resource to download the preview thumbnail from. Available for image files only. | String |
    | [createdBy](#createdBy) | Object with information about the user who attached the file. | Object |
    | createdAt | Date and time when the file is uploaded, in <br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` format | String |
    | mimetype | File type, for example:<ul><li>`text/plain`: Text file.</li><li>`image/png`: Image in PNG format.</li></ul> | String |
    | size | File size in bytes. | Integer |
    | [metadata](#metadata) | Object with file metadata. | Object |

    **Object fields** `createdBy` {#createdBy}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Address of the resource corresponding to the user who uploaded the file | String |
    | id | Username of the user | String |
    | display | User's name (as in the interface) | String |

    **Object fields** `metadata` {#metadata}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | size | Image size in pixels | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

