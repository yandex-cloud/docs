# Delete a comment

Use this request to delete issue comments.

## Request format {#section_rnm_x4j_p1b}

To delete a comment, use an HTTP `DELETE` request:

```
DELETE /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<issue-id> | ID or key of the current issue. | String |
| \<comment-id> | [Unique ID of the comment](get-comments.md#section_xc3_53j_p1b) in numeric (id) or string format (longId). | String or number |

{% endcut %}

> Request for deleting a comment added to the `JUNE-2` issue:
>
>- An HTTP DELETE method is used.
>
>```
>DELETE /v2/issues/JUNE-2/comments/53a170e8e4b07a4c3358d60a
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#section_xc3_53j_p1b}

{% list tabs %}

- Request executed successfully

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

    The response body is missing.

- Request failed

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

