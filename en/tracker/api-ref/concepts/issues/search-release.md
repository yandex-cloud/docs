# Release scroll view resources

Use this request to release the resources after viewing a search snapshot in the [{#T}](search-issues.md) request.

## Request format {#section_rnm_x4j_p1b}

Before making the request, [get permission to access the API](../access.md).

To release scroll results, use an HTTP `POST` request:

```json
POST /v2/system/search/scroll/_clear
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "srollId": "scrollToken"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| scrollId | ID of the page with scroll results. The ID value is taken from the `X-Scroll-Id` header of the response to the [{#T}](search-issues.md) request. | String |
| scrollToken | Token that certifies that the request belongs to the current user. The ID value is taken from the `X-Scroll-Token` header of the response to the [{#T}](search-issues.md) request. | String |

Make sure to pass all `"srollId": "scrollToken"` pairs in your request. Their number is equal to the number of pages with search results.

{% endcut %}

> Example: Releasing scroll results
>
>- An HTTP POST method is used.
>
>```
>POST /v2/system/search/scroll/_clear HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>
>{
>  "cXVlcnlUaGVuRmV0Y2g7NjsyNDU5MzpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzI0NTkyOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ1OTU6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTsyNDU5NDpmQ0gwd0JOM1RvQ2NPM3ZJRkpfTnFBOzIwMzg2OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjAzODE6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzswOw==": "c44356850f446b88e5b5cd65a34a1409aaaa0ec1b93f8925d6b1c91da0fe3804:1450339762515",
>  "cXVlcnlUaGVuRmV0Y2g7NjsyMDQ0MzpTdGp6Wm9JZlNiZUVfZVlhZEFxeXNnOzIwNDQ1OkNfVnFZdHZCU3Y2VUowT0N6dGVGdFE7MjA0NDI6U3RqelpvSWZTYmVFX2VZYWRBcXlzZzsyMDQ0NDpDX1ZxWXR2QlN2NlVKME9DenRlRnRROzI0NjcxOmZDSDB3Qk4zVG9DY08zdklGSl9OcUE7MjQ2NzI6ZkNIMHdCTjNUb0NjTzN2SUZKX05xQTswOw==": "b8e1c56966f037d9c4e241af40d31dc80af186fa079d75022822b2be88f785dc:1450344216969"
>}
>```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

{% endlist %}

