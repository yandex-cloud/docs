---
sourcePath: en/tracker/api-ref/get-board.md
---
# Getting board parameters

Use this request to get the parameters of an issue board.

## Request format {#query}

Before making the request, [get permission to access the API](concepts/access.md).

To get the parameters of a specific issue board, use an HTTP `GET` request.

```
GET /{{ ver }}/boards/<board-id>
Host: {{ host }}
Authorization: OAuth <token>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Resource" %}

| Parameter | Description | Data type |
| ----- | ----- | ----- |
| \<board-id\> | Board ID | Number |

{% endcut %}

## Response format {#answer}

{% list tabs %}

- Request executed successfully

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    The response body contains a JSON object with board parameters.

    ```json
    {
      "self": "https://{{ host }}/v2/boards/1",
      "id": 1,
      "version": 1412806202302,
      "name": "Testing",
      "columns":
      [
       {
        "self": "https://{{ host }}/v2/boards/1/columns/1387461731452",
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
       "estimateBy": {
          "self": "https://{{ host }}/v2/fields/storyPoints",
          "id": "storyPoints",
          "display": "Story Points"
        },
       "country": {
          "self": "https://{{ host }}/v2/countries/1",
          "id": "1",
          "display": "Russia"
        },
       "defaultQueue": {
          "self": "https://{{ host }}/v2/queues/DOC",
          "id": "3",
          "key": "DOC",
          "display": "Documenting"
        },
        "calendar": {
           "id": 6
          }
       }
    ```

    {% cut "Response parameters" %}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with board parameters | String |
    | id | Board ID | Number |
    | version | Board version; each change to the board increases its version number | Number |
    | name | Board name. | String |
    | [columns](#columns) | Object with information about board columns | Object |
    | [filter](#filter) | Object with information about filter conditions used for selecting issues for the board.<br/>Issue parameters are made up of fields and values | Object |
    | orderBy | Field key.<br/>The field is used as a parameter for sorting board issues.<br/>The full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
    | orderAsc | Sort direction:<ul><li>`true`: Ascending</li><li>`false`: Descending</li></ul> | Logical |
    | query | Parameters of the filter used to select issues for the board.<br/>The parameters are specified in the [query language](user/query-filter.md) | String |
    | useRanking | Shows if you can change the order of issues on the board:<ul><li>`true`: Yes</li><li>`false`: No.</li></ul> | Object |
    | [estimateBy](#estimateBy) | Object with information about the parameter that issues on the board are estimated by. <br/>Defaults to `Story Points`. | Object |
    | [country](#country) | Object with information about the country. Data of a country's business calendar is used in the [Burn down chart](manager/burndown.md).<br/>To get a list of countries, use the HTTP `GET /v2/countries` request. | Object |
    | [defaultQueue](#defaultQueue) | Object with information about the default queue for creating issues. | Object |
    | [calendar](#calendar) | Object with information about the business calendar used for the board. The calendar is used to count working and non-working days in the [Burndown chart](manager/burndown.md). | Number |

    `columns` **object fields** {#columns}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the board column | String |
    | id | Column ID | String |
    | display | Column name displayed | String |

    `filter` **object fields** {#filter}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | \<key of parameter 1\> | Key of the field that is used as a parameter for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | String |
    | \<key of parameter 2\> | Array with the keys of the fields that are used as parameters for selecting issues for the board.<br/>Full list of fields: [{{ link-admin-fields }}]({{ link-admin-fields }}) | Array |

    `estimateBy` **object fields** {#estimateBy}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the issue estimation parameter. | String |
    | id | ID of the issue estimation parameter. | String |
    | display | Issue estimation parameter name displayed. | String |

    `country` **object fields** {#country}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with the country name | String |
    | id | Country ID | String |
    | display | Country name displayed | String |

    `defaultQueue` **object fields** {#defaultQueue}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | self | Address of the API resource with information about the queue | String |
    | id | Queue ID | String |
    | key | Queue key | String |
    | display | Queue name displayed | String |

    `calendar` **object fields** {#calendar}

    | Parameter | Description | Data type |
    | -------- | -------- | ---------- |
    | id | Calendar ID | Number |

    {% endcut %}

- Request failed

    If the request is processed incorrectly, the API returns a response with an error code:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}

