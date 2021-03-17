# Edit a board

Use this request to edit board parameters.

## Request format {#section_lpf_t23_4fb}

To edit board parameters, use an HTTP `PATCH` request:

```json
PATCH /{{ ver }}/boards/<board-id>
Host: {{ host }}
Authorization: OAuth <token>
X-Org-ID: <organization ID>
If-Match: "<version number>"

{
 "name" : "Testing",
 "columns": 
    [
      {
        "id": "1",
        "name": "Open",
        "statuses": "open"
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
     "id": "1"
  }
}
```

#### Resource {#req-resource}

- **\<board-id\>**

    Board ID.

#### Headers {#req-headers}

- **Host**

    Address of the node that provides the API:

    ```
    {{ host }}
    ```

- **Authorization**

    OAuth token in `OAuth <token value>` format. For example:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Organization ID.

- **If-Match**

    Number of the current board version. If you specify an obsolete version of the board, the HTTP request returns an error message saying `412 Precondition Failed`.

#### Request body {#req-body-params}

The request body contains the board parameters to be changed.

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| name | Board name. | String. |
| [columns](#req-columns) | Object with information about new board columns. | Object. |
| [filter](#req-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values.<br/>The `filter`, `orderBy`, and `orderAsc` parameter group is incompatible with the `query` parameter that also describes filter conditions. | Object. |
| orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String. |
| orderAsc | Field value sorting order:<ul><li>`true`: Ascending.</li><li>`false`: Descending.</li></ul> | Logical. |
| query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md).<br/>The `query` parameter is incompatible with the group of parameters that also describe filter conditions, including `filter`, `orderBy`, and `orderAsc`. | String. |
| useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> | Logical. |
| [country](#req-country) | Object with information about the country. Data of a country's business calendar is used in the Burn down chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries` request. | Object. |

**Object fields** `columns` {#req-columns}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | Column ID. | String. |
| name | Column name. | String. |
| statuses | Keys of statuses of issues to be output in the column.<br/>A list of all issue statuses: [{{ link-admin-statuses }}]({{ link-admin-statuses }}) | String. |

**Object fields** `filter` {#req-filter}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String. |
| \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array. |

**Object fields** `country` {#req-country}

| Parameter | Description | Data type |
| -------- | -------- | ---------- |
| id | Country ID. | String. |

## Response format {#section_vx3_c3j_4fb}

{% list tabs %}

- Successful execution of the request

    If the request is successful, the API returns a response with code 200. The response body contains a JSON object with all board parameters, including the updated ones.

    #### Response body {#answer-body}

    ```json
    {
      "self" : "http://api.tracker.yandex.net/v2/boards/1",
      "id" : 1,
      "version" : 1412806202302,
      "name" : "Testing", 
      "columns" : 
      [ 
       {
         "self" : "http://api.tracker.yandex.net/v2/boards/1/columns/1387461731452",
         "id" : "1387461731452",
         "display" : "Open"
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
           "self": "https://api.tracker.yandex.net/v2/countries/1",
           "id": "1",
           "display": "Russia"
            }
       }
    ```

    #### Response parameters {#answer-params}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with board parameters. | String. |
    | id | Board ID. | Number. |
    | version | Board version. Each change to the board increases its version number. | Number. |
    | name | Board name. | String. |
    | [columns](#ans-columns) | Object with information about board columns. | Object. |
    | [filter](#ans-filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values. | Object. |
    | orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String. |
    | orderAsc | Field value sorting order:<ul><li>`true`: Ascending.</li><li>`false`: Descending.</li></ul> | Logical. |
    | query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md). | String. |
    | useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> | Logical. |
    | [country](#ans-country) | Object with information about the country. Data of a country's business calendar is used in the Burn down chart.<br/>To get a list of countries, use the HTTP `GET /v2/countries` request. | Object. |

    **Object fields** `columns` {#ans-columns}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board column. | String. |
    | id | Column ID. | String. |
    | display | Column name displayed. | String. |

    **Object fields** `filter` {#ans-filter}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String. |
    | \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array. |

    **Object fields** `country` {#ans-country}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with the country name. | String. |
    | id | Country ID. | String. |
    | display | Country name displayed. | String. |

- The request failed

    If the request is processed incorrectly, the API returns a message with error details:

    | HTTP code of the error | Error description |
    | --------------- | --------------- |
    | 400 Bad Request | One of the request parameters has an invalid value or data format. |
    | 403 Forbidden | The user or application has no access rights to the resource, the request is rejected. |
    | 404 Not Found | The requested resource not found. |
    | 412 Precondition Failed | Invalid header value. |
    | 422 Unprocessable Entity | JSON validation error, the request is rejected. |
    | 428 Precondition Required | A header is required. |
    | 500 Internal Server Error | Internal service error. Try again later. |
    | 503 Service Unavailable | The API service is temporarily unavailable. |

{% endlist %}

