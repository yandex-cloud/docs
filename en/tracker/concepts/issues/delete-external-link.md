---
sourcePath: en/tracker/api-ref/concepts/issues/delete-external-link.md
---
# Deleting an external link

Use this request to delete an issue's link to an [external application object](../../external-links.md).

## Request format {#rec-format}

Before making the request, [get permission to access the API](../access.md).

To delete an external link, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/issues/<issue_ID_or_key>/remotelinks/<external_link_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}


{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<issue_key_or_ID\> | ID or key of the current issue. | String |
| \<external_link_ID> | [External link ID](get-external-links.md). | String |

{% endcut %}


## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

   The response body is missing.

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

