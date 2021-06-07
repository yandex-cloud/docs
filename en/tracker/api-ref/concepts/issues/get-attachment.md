# Download a file

Use this request to download files attached to issues.

## Request format {#section_rnm_x4j_p1b}

To download a file, use an HTTP `GET` request:

```
GET /{{ ver }}/issues/<issue-id>/attachments/<attachment-id>/<filename>
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Resource {#resource}

- **\<issue-id\>**

    Issue ID or key.

- **\<attachment-id\>**

    Unique ID of the file.

- **\<filename\>**

    File name.

> Request to download a file attached to the `JUNE-2` issue:
> 
> - Use the HTTP GET method.
> 
> ```
> GET /v2/issues/JUNE-2/attachments/4159/attachment.txt HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns a response with code 200.

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

