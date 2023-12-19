---
sourcePath: en/tracker/api-ref/concepts/entities/delete-entity.md
---
# Deleting an entity

Use this request to delete an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request provides a unified method for deleting projects and portfolios that extends the features of the [project deletion](../projects/delete-project.md) API.

## Request format {#query}

Before making a request, [get permission to access the API](../access.md).

To delete an entity, use an HTTP `DELETE` request.

```
DELETE /{{ ver }}//entities/<entityType>/<entityId>?withBoard=true
Host: {{ host }}
Authorization: OAuth <OAuth_token>
{{ org-id }}

```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<entityType> | Entity ID:<ul><li>Project for a project</li><li>Portfolio for a portfolio</li></ul> | String |
| \<entityId> | Entity ID | String |

{% note warning %}

The entity ID is not the same as the project or portfolio ID.

{% endnote %}

{% endcut %}

{% cut "Request parameters" %}

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| withBoard | Delete together with the board | Logical |

{% endcut %}

> Example: Deleting a project
>
> - An HTTP DELETE method is used.
> - The project is deleted together with the board.
>
> ```
> GET /v2/entities/project/655f328da834c763********?withBoard=true HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> {{ org-id }}
>
> ```

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