---
sourcePath: en/tracker/api-ref/post-board.md
---
# Creating a board

Use this request to create boards.

## Request format {#query}

Before making a request, [get permission to access the API](concepts/access.md).

To create a board, use an HTTP `POST` request: Request parameters are provided in the request body in JSON format.

```
POST /{{ ver }}/boards/
Host: {{ host }}
Authorization: OAuth <OAuth_token>
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
-------- | -------- | ----------
| name | Board name | String |
| [defaultQueue](#req-defaultQueue) | Queue | Can be set as an object, a string (if the queue key is provided), or a number (if the queue ID is provided) |

**Additional parameters**

| Parameter | Description | Data type |
-------- | -------- | ----------
| boardType | Board type.<br/>Possible board types:<ul><li>`default`: Basic</li><li>`scrum`: Scrum</li><li>`kanban`: Kanban</li></ul> | String |
| [filter](#req-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values.<br/>The `filter`, `orderBy`, and `orderAsc` parameter group is incompatible with the `query` parameter that also describes filter conditions | Object |
| orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
| orderAsc | Sort direction:<ul><li>`true`: Ascending</li><li>`false`: Descending</li></ul> | Logical |
| query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md).<br/>The `query` parameter is incompatible with the group of parameters that also describe filter conditions, including `filter`, `orderBy`, and `orderAsc` | String |
| useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes</li><li>`false`: No</li></ul> | Logical |
| [country](#req-country) | Object with information about the country. Data of a country-specific business calendar is used in the burndown chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries request` | Object |

`defaultQueue` **object fields** {#req-defaultQueue}

| Parameter | Description | Data type |
-------- | -------- | ----------
| id | Queue ID | String |
| key | Queue key | String |

`filter` **object fields** {#req-filter}

| Parameter | Description | Data type |
-------- | -------- | ----------
| \<parameter_1_key\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
| \<parameter_2_key\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>The full list of fields:[{{ link-admin-fields }}] ({{ link-admin-fields }}) | Array |

`country` **object fields** {#req-country}

| Parameter | Description | Data type |
-------- | -------- | ----------
| id | Country ID | String |

{% endcut %}

> Example 1: Create a board named `Testing`. Set a filter using the `filter` object.
>
> - An HTTP `POST` method is used.
>
> ```
> POST /v2/boards/
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> X-Org-ID or X-Cloud-Org-ID: <organization_ID>
>
> {
>  "name": "Testing",
>  "boardType": "default",
>  "defaultQueue": {
>         "id": "111",
>         "key": "test"
>         },
>  "filter": {
>       "assignee": "user1",
>       "priority": [
>           "normal",
>           "critical"
>           ]
>       },
>  "orderBy": "updated",
>  "orderAsc": false,
>  "useRanking": false,
>  "country": {
>      "id": "1"
>      }
> }
> ```
> {% note info %}
>
> If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.
>
> {% endnote %}

> Example 2: Create a board named `Testing`. Set a filter using the query language.
>
> - An HTTP `POST` method is used.
>
> ```
> POST /v2/boards/
> Host: {{ host }}
> Authorization: OAuth <OAuth_token>
> X-Org-ID or X-Cloud-Org-ID: <organization_ID>
>
> {
>  "name": "Testing",
>  "boardType": "default",
>  "defaultQueue": {
>         "id": "111",
>         "key": "test"
>         },
>  "query": "assignee: user1 AND (priority: normal OR priority: critical)",
>  "useRanking": false,
>  "country": {
>      "id": "1"
>      }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Request executed successfully

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with new board parameters.

   ```json
   {
     "self": "https://{{ host }}/v2/boards/1",
     "id": 1,
     "version": 1,
     "name": "Testing",
     "columns":
     [
      {
       "self": "https://{{ host }}/v2/boards/1/columns/13874********",
       "id": "13874********",
       "display": "Open"
      },
       ...
     ],
     "filter": {
        "<parameter_1_key>": "<value_1>",
        "<parameter_2_key>": [
             "<value_2>",
                            ...
           ],
            ...
        },
     "orderBy": "updated",
     "orderAsc": false,
     "query": "<parameter_1>: <value_1> AND <parameter_2>: <value_2> OR <parameter_3>: <value_3>...",
     "useRanking": false,

     "country": {
          "self": "https://{{ host }}/v2/countries/1",
          "id": "1",
          "display": "Russia"
           }
   }
   ```

   {% cut "Response parameters" %}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with board parameters | String |
   | id | Board ID | Number |
   | version | Board version; each change to the board increases its version number | Number |
   | name | Board name. | String |
   | [columns](#ans-columns) | Object with information about board columns | Object |
   | [filter](#ans-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values | Object |
   | orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
   | orderAsc | Sort direction:<ul><li>`true`: Ascending</li><li>`false`: Descending</li></ul> | Logical |
   | query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md) | String |
   | useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes</li><li>`false`: No</li></ul> | Logical |
   | [country](#ans-country) | Object with information about the country. Data of a country-specific business calendar is used in the burndown chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries` request | Object |

   `columns` **object fields** {#ans-columns}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | self | Address of the API resource with information about the board column | String |
   | id | Column ID | String |
   | display | Column name displayed | String |

   `filter` **object fields** {#ans-filter}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
   | \<parameter_1_key\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
   | \<parameter_2_key\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>The full list of fields:[{{ link-admin-fields }}] ({{ link-admin-fields }}) | Array |

   `country` **object fields** {#ans-country}

   | Parameter | Description | Data type |
   -------- | -------- | ----------
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
