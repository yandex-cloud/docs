---
sourcePath: en/tracker/api-ref/concepts/issues/delete-attachment.md
---
# Delete a file

Use this request to delete attached files.

## Request format {#section_rnm_x4j_p1b}

To delete a file, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue-id>/attachments/<attachment-id>/
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#resource}

- **\<issue-id\>**

    Issue ID or key.

- **\<attachment-id\>**

    Unique ID of the file.

> Request for deleting a file attached to the `JUNE-2` issue:
> 
> - An HTTP DELETE method is used.
> 
> ```
> DELETE /v2/issues/JUNE-2/attachments/4159/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 204.

## Possible response codes {#section_otf_jrj_p1b}

204
:  The DELETE request is executed, the object was deleted.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

