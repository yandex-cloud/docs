---
sourcePath: en/tracker/api-ref/concepts/issues/post-attachment.md
---
# Attach a file

Use this request to attach a file to an issue.

## Request format {#section_rnm_x4j_p1b}

To attach a file, Use an HTTP `POST` request:

```
POST /{{ ver }}/issues/<issue-id>/attachments/?filename=<new file name>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
Content-Type: multipart/form-data

<file_data>
```

#### Resource {#resource}

- **\<issue-id\>**

    Issue ID or key.

#### Request parameters {#req-params}

- **filename (optional)**

    New name that a file will be stored on the server with. Optional parameter.

#### Request headers {#req-headers}

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

#### Request body {#req-body}

- **\<file_data\>**

    Binary file. The file size may not exceed 1024 Mb.

## Response format {#section_xc3_53j_p1b}

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

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
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
| ----- | ----- | ----- |
| self | Address of the resource corresponding to the user who uploaded the file. | String |
| id | Username of the user. | String |
| display | User's name (as in the interface). | String |

**Object fields** `metadata` {#metadata}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| size | Image size in pixels. | String |

## Possible response codes {#section_otf_jrj_p1b}

201
:  The `POST` request resulted in creating a new object.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

