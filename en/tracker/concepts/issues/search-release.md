# Release scroll view resources

Use this request to release the resources after viewing a search snapshot in the [{#T}](search-issues.md) request.

## Request format {#section_rnm_x4j_p1b}

To release scroll results, use an HTTP `POST` request:

```json
POST /v2/system/search/scroll/_clear
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "srollId": "scrollToken"
}
```

#### Parameters passed in the request body {#req-body-params}

- **srollId**

    ID of the page with scroll results. The ID value is taken from the `X-Scroll-Id` header of the response to the [{#T}](search-issues.md) request.

- **scrollToken**

    Token that certifies that the request belongs to the current user. The ID value is taken from the `X-Scroll-Token` header of the response to the [{#T}](search-issues.md) request.

Make sure to pass all `"srollId": "scrollToken"` pairs in your request. Their number is equal to the number of pages with search results.

> Releasing scroll results:
> 
> - An HTTP POST method is used.
> 
> ```
> POST /v2/system/search/scroll/_clear HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth token>
> X-Org-Id: <organization ID>
> Cache-Control: no-cache
> 
> {
>   "cXVlcnlUaGVuRmV0Y2g7NjsyNDU5MzpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzI0NTkyOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ1OTU6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTsyNDU5NDpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzIwMzg2OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjAzODE6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzswOw==": "c44356850f446b88e5b5cd65a34a1409aaaa0ec1b93f8925d6b1c91da0fe3804:1450339762515",
>   "cXVlcnlUaGVuRmV0Y2g7NjsyMDQ0MzpTdGp6Wm9JZlNiZUVfZVlhZEFxeXNnOzIwNDQ1OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjA0NDI6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzsyMDQ0NDpDX1ZxWXR2QlN2NlVKME9DenRlRnRROzI0NjcxOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ2NzI6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTswOw==": "b8e1c56966f037d9c4e241af40d31dc80af186fa079d75022822b2be88f785dc:1450344216969"
> }
> ```

## Response format {#section_xc3_53j_p1b}

If the request is successful, the API returns an empty message with code 200.

## Possible response codes {#section_otf_jrj_p1b}

200
:   Successful execution of the request.

401
:  The user isn't authorized. Make sure that actions described in [{#T}](../access.md) are performed.

403
:  Insufficient rights to perform this action. You can check what rights you have in the {{ tracker-name }} interface. The same rights are required to perform an action via the API and interface.

