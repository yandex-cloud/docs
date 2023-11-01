---
sourcePath: en/tracker/api-ref/patch-board.md
---
# Edit a board

Use this request to edit board parameters.

## Request format {#query}

Before making a request, [get permission to access the API](concepts/access.md).

To edit board parameters, use an HTTP `PATCH` request. Request parameters are passed in the request body in JSON format.

```
PATCH /{{ ver }}/boards/<board-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
If-Match: "<version number>"

<new board parameters in JSON format>
```

{% cut "Headers" %}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format, for example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```


- **X-Org-ID** or **X-Cloud-Org-ID**

    Organization ID. If you only have a {{ org-full-name }} organization, use the `X-Cloud-Org-ID` header; if only {{ ya-360 }} or both organization types, use `X-Org-ID`.


- **If-Match**

    Number of the current board version. If you specify an obsolete version of the board, the HTTP request returns an error message saying `412 Precondition Failed`.

{% endcut %}

{% cut "Resource" %}

Parameter | Description | Data type |
--------- | ----------- | -----------
\<board-id\> | Board ID | Number |

{% endcut %}

{% cut "Request body parameters" %}

The request body contains the board parameters to be changed.

**Additional parameters**

Parameter | Description | Data type
--------- | ----------- | ---------
name | Board name | String
[columns](#req-columns) | Object with information about new board columns | Objects
[filter](#req-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values.<br/>The `filter`, `orderBy`, and `orderAsc` parameter group is incompatible with the `query` parameter that also describes filter conditions | Objects
orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String
orderAsc | Sort direction:<ul><li>`true`: Ascending</li><li>`false`: Descending</li></ul> | Logical |
query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md).<br/>The `query` parameter is incompatible with the group of parameters that also describe filter conditions, including `filter`, `orderBy`, and `orderAsc` | String
useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes</li><li>`false`: No</li></ul> | Logical
[country](#req-country) | Object with information about the country. Data of a country-specific business calendar is used in the burndown chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries request` | Objects

**Object fields** `columns` {#req-columns}

Parameter | Description | Data type
--------- | ----------- | ---------
id | Column ID | String
name | Column name | String
statuses | Keys of statuses of issues to be output in the column.<br/>The list of all issue statuses: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | String

**Object fields** `filter` {#req-filter}

Parameter | Description | Data type
--------- | ----------- | ---------
\<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String
\<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>The full list of fields:[{{ link-admin-fields }}]({{ link-admin-fields }}) | Array

**Object fields** `country` {#req-country}

Parameter | Description | Data type
--------- | ----------- | ---------
id | Country ID | String

{% endcut %}

> Example: Edit the parameters of the board with ID `5`.
>
> - An HTTP `PATCH` method is used.
>
> ```
> PATCH /v2/boards/5
> Host: {{ host }}
> Authorization: OAuth <token>
> X-Org-ID: <organization ID>
> If-Match: "<version number>"
>
> {
>  "name": "Testing new",
>  "columns":
>     [
>       {
>         "id": "1",
>         "name": "Open",
>         "statuses": "open"
>        },
>        {
>         "id": "2",
>         "name": "Closed",
>         "statuses": "closed"
>        }
>      ],
>  "filter": {
>       "assignee": "user1",
>       "priority": [
>           "normal",
>           "blocker",
>           "critical"
>           ]
>       },
>  "orderBy": "created",
>  "orderAsc": true,
>  "useRanking": true,
>  "country": {
>       "id": "1"
>       }
> }
> ```

## Response format {#answer}

{% list tabs %}

- Successful execution of the request

   {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

   The response body contains a JSON object with all board parameters, including the updated ones.

   ```json
   {
     "self": "{{ host }}/v2/boards/1",
     "id": 1,
     "version": 1412806202302,
     "name": "Testing",
     "columns":
     [
      {
        "self": "{{ host }}/v2/boards/1/columns/1387461731452",
        "id": "1387461731452",
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

   Parameter | Description | Data type
   --------- | ----------- | ---------
   self | Address of the API resource with board parameters | String
   id | Board ID | Number
   version | Board version; each change to the board increases its version number | Number
   name | Board name | String
   [columns](#ans-columns) | Object with information about board columns | Objects
   [filter](#ans-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values | Objects
   orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String
   orderAsc | Sort direction:<ul><li>`true`: Ascending</li><li>`false`: Descending</li></ul> | Logical
   query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md) | String
   useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes</li><li>`false`: No</li></ul> | Logical
   [country](#ans-country) | Object with information about the country. Data of a country-specific business calendar is used in the burndown chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries request` | Objects

   **Object fields** `columns` {#ans-columns}

   Parameter | Description | Data type
   --------- | ----------- | ---------
   self | Address of the API resource with information about the board column | String
   id | Column ID | String
   display | Column name displayed | String

   **Object fields** `filter` {#ans-filter}

   Parameter | Description | Data type
   --------- | ----------- | ---------
   \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String
   \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array

   **Object fields** `country` {#ans-country}

   Parameter | Description | Data type
   --------- | ----------- | ---------
   self | Address of the API resource with the country name | String
   id | Country ID | String
   display | Country name displayed | String

   {% endcut %}

- The request failed

   If the request is processed incorrectly, the API returns a response with an error code:

   {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

   {% include [answer-error-412](../_includes/tracker/api/answer-error-412.md) %}

   {% include [answer-error-422](../_includes/tracker/api/answer-error-422.md) %}

   {% include [answer-error-428](../_includes/tracker/api/answer-error-428.md) %}

   {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

   {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
