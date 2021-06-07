# Get required queue fields

Use this request to get information about required queue fields. The queue is selected when the ID or key is specified.

## Request format {#section_rnm_x4j_p1b}

To get required fields of a queue, use an HTTP `GET` request:

```json
GET /v2/queues/<queue-id>/fields
Host: {{ host }}
Authorization: OAuth <OAuth token>
X-Org-Id: <organization ID>
```

#### Request parameters {#req-get-params}

- **\<queue-id\>**

    Queue ID or key. The queue key is case-sensitive.

> Request for the <q>TEST</q> queue's versions:
>- Use the HTTP GET method.
>```
>GET /v2/queues/TEST/fields HTTP/1.1
>Host: {{ host }}
>Authorization: OAuth <OAuth token>
>X-Org-Id: <organization ID>
>Cache-Control: no-cache
>```

## Response format {#section_xc3_53j_p1b}

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

#### Response parameters {#answer-params}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| self | Link to the field object. | String |
| id | Field ID. | String |
| name | Field name. | String |
| version | Version number. | Number |
| [schema](#schema) | Object with information about the type of field content. | Object |
| readonly | Shows if the field is editable. Possible values:<br/>- `true`: The field is editable.<br/>- `false`: The field is non-editable. | Boolean |
| options | Shows if there are options for filling in the field. | Boolean |
| suggest | Shows if suggestions are available when filling in the field. | Boolean |
| optionsProvider | Block with information about a set of possible field values. | Object |
| queryProvider | Information about the type of field for quiery requests. | Object |
| order | Weight of the field when displayed in the interface. Fields with a lower weight are displayed above fields with a higher weight. | Number |

**Object fields** `schema` {#schema}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| type | Type of field content. Possible values:<br/>- `float`: Numeric field.<br/>- `string`: Text field. | String |
| required | Shows if the field is required. | Boolean |

**Object fields** `optionsProvider`

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| type | Information about the type of field for quiery requests. | String |
| values | Array with information about special values for queues. | Objects |
| defaults | Array of field values. | Array |

## Possible response codes {#section_otf_jrj_p1b}

200
:   Request executed successfully.

404
:   The requested object was not found. You may have specified an invalid object ID or key.

