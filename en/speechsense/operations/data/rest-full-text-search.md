# Full-text search in REST API

You can use a full-text search to find dialogs containing a specified word or phrase. The query returns the dialog IDs. For details on how to get information about a dialog by its ID, see [this guide](rest-get-dialog-data.md).

To refine your search results, you can use [filtering by parameters](rest-search-filters.md) along with full-text search. In this case, the response will return only query IDs that satisfy both the full-text search criteria and additional filters.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/speechsense/data/rest-search-before-you-begin.md) %}

## Full-text search {#full-text-search}

1. Create a file named `search.json` and specify in it the required [IDs and parameters](#full-text-search-ref) for full-text search: 

    ```json
    {
      "organizationId": "<organization_ID>",
      "spaceId": "<space_ID>",
      "connectionId": "<connection_ID>",
      "projectId": "<project_ID>",
      "query": {
        "text": "<search_query>",
        "channelNumber": "<channel_number>"
      },
      "sortData": {
        "fields": [{  
          "field": "<dialog_feature_you_are_searching_by>",
          "order": "<sort_order:_ascending_or_descending>",
          "position": "<sort_field_priority>"
        }]
      },
      "pageSize": "<number_of_documents_per_page>",
      "pageToken": "<next_page_token_with_search_results>"
    }
    ```

    Where: 

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

    * `query`: Full-text search request body. Supports the following parameters: 

      * `text`: Search query text. You can specify a word or phrase. {{ speechsense-name }} will search for the specified string in the audio text transcript or chat text.

        {% include [key-phrases-restrictions](../../../_includes/speechsense/data/key-phrases-restrictions.md) %}

      * `channelNumber`: Channel number. If you specify this parameter, the search is performed only in the audio text transcript or chat text for the specified channel. 

        Channel numbering in chat connections: 

        * `0`: Agent channel. 
        * `1`: Customer channel. 
        * `2`: Bot channel. 

        Channel numbering for audio is preset at the connection level and is different from channel numbering for chats. 
    * `sortData`: Data sorting parameters in response to the request. 
      * `fields`: List of dialog features you are sorting by. Supports the following parameters: 
        * `field`: Dialog feature you are sorting by. 
        * `order`: Sort order: ascending or descending. 
        * `position`: Sorting field priority (when sorting by several dialog features at the same time). 
    * `pageSize`: Number of documents per page. 
    * `pageToken`: Token of the next page with search query results. 
      If the query results are split into multiple pages, each page has a token of its own. The response to each search query contains the `next_page_token` (if there is a next page). Paste it into the `pageToken` parameter of your search query to get the next page of search results. 

    For more information about search query parameters, see the [API reference](../../api-ref/Talk/search.md). 

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}
1. Send a search query to the {{ speechsense-name }} API using cURL: 

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/search \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @search.json
    ```

    Where `Api-Key` is the API key for authentication. If using an IAM token, specify `Bearer ${IAM_TOKEN}` instead of `Api-Key ${API_KEY}`. 

    Dialog IDs that meet the search criteria will be output to the terminal in JSON format. 

## Request examples {#query-examples}

### Request body example for full-text search {#full-text-search-example}

For example, you need to find all the dialogs with the provider's technical support where the agent proposed filing a ticket for a technician's visit. Your JSON file with the request parameters will look as follows: 

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "query": {
    "text": "technician's visit",
    "channelNumber": "0"
  },  
}
```

Query results: 

```json
{
  "talkIds": [
    "aud95sn63lra********"
  ],
  "talksCount":" 1",
  "nextPageToken": ""
}
```

Where: 

* `talkIds`: IDs of dialogs that meet the search criteria. 
* `talksCount`: Number of dialogs that meet the search criteria. 
* `nextPageToken`: Token of the next page with search results. If the search results are split into multiple pages, this token is used in the next query to get the next page. If this field is returned empty, the search results end on the current page. 

### Request body example for full-text search with filtering by parameters {#full-text-search-with-filters-example}

For example, you need to find all the dialogs with the provider's technical support between 11:00 and 12:00 on September 24, 2024 in which the agent proposed filing a ticket for a technician's visit. Your JSON file with the request parameters will look as follows: 

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "query": {
    "text": "technician's visit",
    "channelNumber": "0"
  },
  "filters": [
    {
      "key": "userMeta.date",
      "dateRange": {
        "fromValue": "2024-09-24T11:00:00Z",
        "toValue": "2024-09-24T12:00:00Z"
      }
    }
  ],  
}
```

Query results: 

```json
{
  "talkIds": [
    "aud95sn63lra********"
  ],
  "talksCount":" 1",
  "nextPageToken": ""
}
```

Where: 

* `talkIds`: IDs of dialogs that meet the search criteria. 
* `talksCount`: Number of dialogs that meet the search criteria. 
* `nextPageToken`: Token of the next page with search results. If the search results are split into multiple pages, this token is used in the next query to get the next page. If this field is returned empty, the search results end on the current page. 
