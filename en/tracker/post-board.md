---
sourcePath: en/tracker/api-ref/post-board.md
---
# Create a board

Use this request to create boards.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To create a board, use an HTTP `POST` request. Request parameters are passed in the request body in JSON format.

```
POST /{{ ver }}/boards/
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}

{
 "name" : "Testing",
 "defaultQueue": {
        "id": 111,
        "key": "test"
        }
}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Request body parameters" %}

The request body contains the parameters of a new board.

**Required parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Board name | String |
| [defaultQueue](#req-defaultQueue) | Queue | Can be set as an object, a string (if the queue key is passed), or a number (if the queue ID is passed). |

**Additional parameters**

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| boardType | Board type.<br/>Possible board types:<ul><li>`default`: Basic.</li><li>`scrum`: Scrum.</li><li>`kanban`: Kanban.</li></ul> | String |
| [filter](#req-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values.<br/>The `filter`, `orderBy`, and `orderAsc` parameter group is incompatible with the `query` parameter that also describes filter conditions. | Object |
| orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
| orderAsc | Field value sorting order:<ul><li>`true`: Ascending.</li><li>`false`: Descending.</li></ul> | Boolean |
| query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md).<br/>The `query` parameter is incompatible with the group of parameters that also describe filter criteria, including `filter`, `orderBy`, and `orderAsc`. | String |
| useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> | Boolean |
| [country](#req-country) | Object with information about the country. Data of a country's business calendar is used in the Burn down chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries` request. | Object |

**Object fields** `defaultQueue` {#req-defaultQueue}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | Queue ID | String |
| key | Queue key | String |

**Object fields** `filter` {#req-filter}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
| \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array |

**Object fields** `country` {#req-country}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | Country ID | String |

{% endcut %}

> Example 1: Create a board named `Testing`. Set a filter using the `filter` object.
>
>- An HTTP `POST` method is used.
>
>```
>POST /v2/boards/
>Host: {{ host }}
>Authorization: OAuth <token>
>X-Org-ID: <organization ID>
>
>{
> "name" : "Testing",
> "boardType": "default",
> "defaultQueue": {
>        "id": "111",
>        "key": "test"
>        },
> "filter": {
>      "assignee": "user1",
>      "priority": [
>          "normal",
>          "critical"
>          ]
>      },
> "orderBy": "updated",
> "orderAsc": false,
> "useRanking": false,
> "country": {
>     "id": "1"
>     }
>}
>```

> Example 2: Create a board named `Testing`. Set a filter using the query language.
>
>- An HTTP `POST` method is used.
>
>```
>POST /v2/boards/
>Host: {{ host }}
>Authorization: OAuth <token>
>X-Org-ID: <organization ID>
>
>{
> "name" : "Testing",
> "boardType": "default",
> "defaultQueue": {
>        "id": "111",
>        "key": "test"
>        },
> "query": "assignee: user1 AND (priority: normal OR priority: critical)",
> "useRanking": false,
> "country": {
>     "id": "1"
>     }
>}
>```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with new board parameters.

    ```json
    {
      "self" : "{{ host }}/v2/boards/1",
      "id" : 1,
      "version" : 1,
      "name" : "Testing", 
      "columns" : 
      [ 
       {
        "self" : "{{ host }}/v2/boards/1/columns/1387461731452",
        "id" : "1387461731452",
        "display": "Open"
       },
        ...
      ],
      "filter": {
         "<key of parameter 1>": "<value 1>",
         "<key of parameter 2>": [
              "<value 2>", 
                             ...
            ],
             ...
         },
      "orderBy": "updated",
      "orderAsc": false,
      "query": "<Parameter 1>: <Value 1> AND <Parameter 2>: <Value 2> OR <Parameter 3>: <Value 3>...",
      "useRanking": false,
    
      "country": {
           "self": "{{ host }}/v2/countries/1",
           "id": "1",
           "display": "Russia"
            }
    }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with board parameters. | String |
    | id | Board ID. | Number |
    | version | Board version. Each change to the board increases its version number. | Number |
    | name | Board name. | String |
    | [columns](#ans-columns) | Object with information about board columns. | Object |
    | [filter](#ans-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values. | Object |
    | orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
    | orderAsc | Field value sorting order:<ul><li>`true`: Ascending.</li><li>`false`: Descending.</li></ul> | Boolean |
    | query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md). | String |
    | useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> | Boolean |
    | [country](#ans-country) | Object with information about the country. Data of a country's business calendar is used in the Burn down chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries` request. | Object |

    **Object fields** `columns` {#ans-columns}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board column | String |
    | id | Column ID | String |
    | display | Column name displayed | String |

    **Object fields** `filter` {#ans-filter}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
    | \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array |

    **Object fields** `country` {#ans-country}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with the country name | String |
    | id | Country ID | String |
    | display | Country name displayed | String |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

