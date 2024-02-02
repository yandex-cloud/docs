---
title: "How to import files"
description: "This article describes how to import files."
sourcePath: en/tracker/api-ref/concepts/import/import-attachments.md
---

# Importing files

{% note warning %}

This request can only be executed if the user has permission to edit the issue that files are attached to.

{% endnote %}

Use it to import to {{ tracker-name }} files that are attached to issues and to their comments.

## Request format {#section_i14_lyb_p1b}

To import a file, use an HTTP `POST` request. Files are provided in the request body via `multipart/form-data` [RFC-7578]({{ link-rfc7578 }}) up to 1024 Mb.

{% list tabs %}

- Attach a file to an issue

    ```json
    POST /{{ ver }}/issues/<issue_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy}
    Host: {{ host }}
    Authorization: OAuth <token>
    {{ org-id }}
    Content-Type: multipart/form-data
    <file_data>
    ```
    {% include [headings-content-multi-data](../../../_includes/tracker/api/headings-content-multi-data.md) %}

    {% cut "Resource" %}

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | \<issues-id\> | Key of the issue to attach the file to. | String |
    | \<comment_id\> | ID of the comment to attach the file to. | String |

    {% endcut %}

    {% cut "Request parameters" %}

    **Required parameters**

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | filename | File name, no more than 255 characters. | String |
    | createdAt | Date and time when the file is attached, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the issue's creation time to its latest update. | String |
    | createdBy | Username or ID of the user who attached the file. | String |

    {% endcut %}

    {% cut "Request body parameters" %}

    **Required parameters**

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | file_data | Binary file up to 1024 Mb | String |

    {% endcut %}

- Attach a file to a comment

    ```json
    POST /{{ ver }}/issues/<issue_id>/comments/<comment_id>/attachments/_import?filename={filename}&createdAt={createdAt}&createdBy={createdBy}
    Host: {{ host }}
    Authorization: OAuth <token>
    {{ org-id }}
    Content-Type: multipart/form-data
    <file_data>
    ```

    {% include [headings-content-multi-data](../../../_includes/tracker/api/headings-content-multi-data.md) %}

    {% cut "Resource" %}

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | \<issues-id\> | Key of the issue to attach the file to. | String |
    | \<comment_id\> | ID of the comment to attach the file to. | String |

    {% endcut %}

    {% cut "Request parameters" %}

    **Required parameters**

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | filename | File name, no more than 255 characters. | String |
    | createdAt | Date and time when the file is attached, in `YYYY-MM-DDThh:mm:ss.sss±hhmm` format. You can specify any value in the interval from the issue's creation time to its latest update. | String |
    | createdBy | Username or ID of the user who attached the file. | String |

    {% endcut %}

    {% cut "Request body parameters" %}

    **Required parameters**

    | Parameter | Description | Data type |
    | --- | --- | --- |
    | \<file_data\> | Binary file up to 1024 Mb | String |

    {% endcut %}

{% endlist %}

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    The response body contains the parameters of the attached file in JSON format:

    ```json
    	{
          "self" : "https://{{ host }}/v2/issues/JUNE-2/attachments/123",
          "id" : "123",
          "name" : "pic.png",
          "content" : "{{ host }}/v2/issues/JUNE-2/attachments/123/pic.png",
          "thumbnail" : "{{ host }}/v2/issues/JUNE-2/thumbnails/123",
          "createdBy" : {
            "self" : "https://{{ host }}/v2/users/12314567890",
            "id" : "1234567890",
            "display" : "<displayed employee name>"
    	  },
          "createdAt" : "2017-06-11T05:16:01.339+0000",
          "mimetype" : "image/png",
          "size" : 5678
          "metadata" : {
            "size" : "128x128"
          }
    	}
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource corresponding to the attached file | String |
    | id | Unique ID of the file | String |
    | name | File name | String |
    | content | Address of the resource to download the file from | String |
    | thumbnail | Address of the resource to download the preview thumbnail from; available for image files only | String |
    | [createdBy](#createdBy) | Object with information about the user who attached the file | JSON object |
    | createdAt | Date and time when the file is uploaded, in <br/>`YYYY-MM-DDThh:mm:ss.sss±hhmm` format | String |
    | mimetype | File type, for example:<ul><li>`text/plain`: Text file</li><li>`image/png`: Image in PNG format</li></ul> | String |
    | size | File size in bytes | Integer |
    | [metadata](#metadata) | Object with file metadata | JSON object |

    `createdBy` **object fields** {#createdBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the resource corresponding to the user who uploaded the file. | String |
    | id | User's login. | String |
    | display | User's name (as in the interface). | String |

    `metadata` **object fields** {#metadata}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | size | Image size in pixels. | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a message with error details:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-413.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
