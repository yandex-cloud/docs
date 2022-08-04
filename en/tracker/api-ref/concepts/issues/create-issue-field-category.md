# Create an issue field category

Use this request to create a category for an issue field.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create an issue field category, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/fields/categories
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}

{
    "name": {
        "en": "Name in English",
        "ru": "Name in Russian"
        },
        "description": "Text description", 
    "order": 400
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Category name:<ul><li>`en`: In English.</li><li>`ru`: In Russian.</li></ul> | String |
| order | Weight of the field when displayed in the interface. Fields with a lower weight are displayed above fields with a higher weight. | Number |

**Additional parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| description | Category description. | String |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    The response body contains information about the updated project in JSON format.

    ```json
    {
        "id" : "604f9920d23cd5e1697ee3",
        "name" : "category_name",
        "self" : "{{ host }}/v2/fields/categories/604f9920d23cd5e1697ee3",
        "version" : 1
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | id | Unique ID of the category. | String |
    | name | Category name in Russian. | String |
    | self | Address of the API resource with information about the category. | String |
    | version | Category version. Each change to the field increases the version number. | Number |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

