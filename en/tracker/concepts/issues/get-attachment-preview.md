---
sourcePath: en/tracker/api-ref/concepts/issues/get-attachment-preview.md
---
# Download a thumbnail

Use this request to get thumbnails of image files attached to issues.

## Request format {#section_rnm_x4j_p1b}

To get a thumbnail, use an HTTP `GET` request:

```
GET /{{ ver }}/issues/<issue-id>/thumbnails/<attachment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#resource}

- **\<issue-id\>**

    Issue ID or key.

- **\<attachment-id\>**

    Unique ID of the file attached.

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 200. The response body contains a thumbnail of the image file.

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

