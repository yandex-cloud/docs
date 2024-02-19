---
sourcePath: en/tracker/api-ref/concepts/projects/delete-project.md
---
# Delete a project

Use this request to delete a [project](../../manager/project-new.md).

You can also use the new, more flexible and functional [entity deletion](../entities/delete-entity.md) API that provides a unified method for deleting projects and portfolios.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To delete a project, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}/projects/<project_ID>
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<project_ID> | Project ID | Number |

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