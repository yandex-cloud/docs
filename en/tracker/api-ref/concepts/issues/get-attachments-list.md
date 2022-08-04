# Get a list of attached files

Use this request to get a list of files attached to an issue and to comments below it.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get a list of attachments, use an HTTP `GET` request.

```
GET /{{ ver }}/issues/<issue-id>/attachments
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<issue-id\> | Issue ID or key | String |

{% endcut %}

> Example: Request a list of files attached to the issue with the `JUNE-2` key.
>
>- An HTTP `GET` method is used.
>
>```
>GET /v2/issues/JUNE-2/attachments HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON array with a list of attached files.

    ```json
    [
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
    },
    ...
    ]
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

