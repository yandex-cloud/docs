---
sourcePath: en/tracker/api-ref/concepts/entities/attachments/delete-attachment.md
---
# Deleting a file

Use this request to delete attached files.

## Request format {#query}

Before making the request, [get permission to access the API](../../access.md).

To delete a file, use an HTTP `DELETE` request.

```json
DELETE /{{ ver }}/entities/<entity_type>/<entity_ID>/attachments/<file_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-attach.md) %}

> Example: Delete the file attached to the entity (project).
>
> - An HTTP DELETE method is used.
>
> ```
> DELETE /v2/entities/project/<project_ID>/attachments/123
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-204](../../../../_includes/tracker/api/answer-204.md) %}

- Request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}

   {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
