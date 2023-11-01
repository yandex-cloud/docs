---
sourcePath: en/tracker/api-ref/concepts/queues/get-fields.md
---
# Get required fields for the queue

Use this request to get information about required queue fields. The queue is selected when the ID or key is specified.

## Request format {#query}

Before making the request, [get permission to access the API](../access.md).

To get required fields of a queue, use an HTTP `GET` request.

```
GET /v2/queues/<queue-id>/fields
Host: {{ host }}
Authorization: OAuth <OAuth token>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<queue-id\> | Queue ID or key. The queue key is case-sensitive. | String or number |

{% endcut %}

> Example: Get required `TEST` queue fields.
>
>- An HTTP `GET` method is used.
>
>```
>GET /v2/queues/TEST/fields HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>{{ org-id }}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    ```json
    [
        {
            "self": "{{ host }}/v2/fields/stand",
            "id": "stand",
            "name": "Bench",
            "version": 1361890459119,
            "schema": {
                "type": "string",
                "required": false
            },
            "readonly": false,
            "options": true,
            "suggest": false,
            "optionsProvider": {
                "type": "QueueFixedListOptionsProvider",
                "values": {
                    "DIRECT": [
                        "Not specified",
                        "Test",
                        "Development",
                        "Beta",
                        "Production",
                        "Trunk"
                    ]
                },
                "defaults": [
                    "Not specified",
                    "Test",
                    "Development",
                    "Beta",
                    "Production"
                ]
            },
            "queryProvider": {
                "type": "StringOptionalQueryProvider"
            },
            "order": 222
        },
        ....
    ]
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | self | Link to the field object. | String |
    | id | Field ID. | String |
    | name | Field name. | String |
    | version | Version number. | Number |
    | [schema](#schema) | Object with information about the type of field content. | Object |
    | readonly | Shows if the field is editable. Possible values:<ul><li>`true`: Editable.</li><li>`false`: Non-editable.</li></ul> | Boolean |
    | options | Shows if there are options for filling in the field. | Boolean |
    | suggest | Shows if suggestions are available when filling in the field. | Boolean |
    | optionsProvider | Block with information about a set of possible field values. | Object |
    | queryProvider | Information about the type of field for quiery requests. | Object |
    | order | Weight of the field when displayed in the interface. Fields with a lower weight are displayed above fields with a higher weight. | Number |

    **Object fields** `schema` {#schema}

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | type | Type of field content. Possible values:<ul><li>`float`: Numeric field.</li><li>`string`: Text field.</li></ul> | String |
    | required | Shows if the field is required. | Boolean |

    **Object fields** `optionsProvider`

    | Parameter | Description | Data type |
    | ----- | ----- | ----- |
    | type | Information about the type of field for query requests | String |
    | values | Array with information about special values for queues | Object |
    | defaults | Array of field values | Array |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

