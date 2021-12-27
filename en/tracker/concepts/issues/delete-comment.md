---
sourcePath: en/tracker/api-ref/concepts/issues/delete-comment.md
---
# Delete a comment

Use this request to delete issue comments.

## Request format {#section_rnm_x4j_p1b}

To delete a comment, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#resource}

- **\<issue-id\>**
Issue ID or key.

- **\<comment-id\>**
[Unique ID of the comment](get-comments.md#section_xc3_53j_p1b) in numeric (id) or string format (longId).

> Request for deleting a comment added to the `JUNE-2` issue:
> 
> - An HTTP DELETE method is used.
> 
> ```
> DELETE /v2/issues/JUNE-2/comments/53a170e8e4b07a4c3358d60a
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 204. The response body is missing.

## Possible response codes {#section_otf_jrj_p1b}

204
:  The DELETE request is executed, the object was deleted.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

