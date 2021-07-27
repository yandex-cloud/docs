---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Create an issue field category

Use this request to create an issue field category.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To create a category for an issue field, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format:

```json
POST /{{ ver }}/fields/categories
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>

{
    "name": {
        "en": "Name in English",
        "ru": "Name in Russian"
        },
        "description": "Text description", 
    "order": 400
}
```

#### Request parameters {#req-params}

{% include [headings](../../../_includes/tracker/api/headings.md) %}

#### Request body parameters {#req-body-params}

The request body contains the information needed to create a field category:

**Required parameters**

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| name | Category name:<ul><li>`en`: In English.</li><li>`ru`: In Russian.</li></ul> | String |
| description | Category description. | String |
| order | Weight of the field when displayed in the interface. Fields with a lower weight are displayed above fields with a higher weight. | Number |

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    If a request is successful, the API returns a `201` response code.

    The response body contains information about the updated project in JSON format.

    ```json
    {
        "id" : "604f9920d23cd5e1697ee3",
        "name" : "category_name",
        "self" : "https://api.tracker.yandex.net/v2/fields/categories/604f9920d23cd5e1697ee3",
        "version" : 1
    }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | id | Unique category ID. | String |
    | name | Category name in Russian. | String |
    | self | Address of the API resource with information about the category. | String |
    | version | Category version. Each change to the field increases the version number. | Number |

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    400
    : One or more request parameters have an invalid value.

    401
    : The user isn't authorized. Make sure that actions described in the [API access](../access.md) section are performed.

    403
    : The user or application doesn't have permission to access the resource, the request is rejected.

    404
    : The requested object is not found. You may have specified an invalid object ID or key.

    422
    : JSON validation error, the request is rejected.

    500
    : Internal service error. Try resending your request in a few minutes.

    503
    : The API service is temporarily unavailable.

{% endlist %}

