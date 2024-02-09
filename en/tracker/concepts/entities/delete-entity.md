---
sourcePath: en/tracker/api-ref/concepts/entities/delete-entity.md
---
# Deleting an entity

Use this request to delete an entity: a [project](../../manager/project-new.md) or [project portfolio](../../manager/portfolio.md).

The request is a unified method for deleting projects and portfolios, more flexible and functional than the [delete project](../projects/delete-project.md) API.

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

{% include [resource](../../../_includes/tracker/api/resource-entity.md) %}

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
> DELETE /v2/entities/project/655f328da834c763********?withBoard=true HTTP/1.1
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