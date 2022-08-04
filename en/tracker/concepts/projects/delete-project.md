---
sourcePath: en/tracker/api-ref/concepts/projects/delete-project.md
---
# Delete a project

Use this request to delete [projects](../../manager/projects.md).

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a project, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/projects/<project-id>
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<project-id> | Project ID | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

