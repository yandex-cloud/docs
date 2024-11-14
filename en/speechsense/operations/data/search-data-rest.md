# Data search via the REST API

With the REST API, you can use the following data search methods:

* [Full-text search](#full-text-search): Allows you to search for words, phrases, and whole sentences in audio text transcripts and chat text messages.
* [Filtering by parameters](#filter-by-parameters): Allows you to filter dialogs by user metadata, classifiers, dialog summary, statistics.

To get complete information on a particular dialog, use [Get request](#get-dialog-data).

## Getting started {#before-you-begin}

To search data via the {{ yandex-cloud }} REST API:

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. [Add the service account to the namespace](../../../speechsense/operations/space/add-user-to-space.md) with the `{{ roles-speechsense-data-viewer }}` role. This will allow your service account to work with data in {{ speechsense-name }}.
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. [Upload voice call recordings](upload-data.md) or [chat transcripts](upload-chat-text.md) to {{ speechsense-name }}.

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
        "channel_number": "<channel_number>"
      }
    }
    ```

    Where:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}
    * `text`: Search query text. You can specify a word, phrase or a whole sentence. {{ speechsense-name }} will search for the specified string in the audio text transcript or chat text.
    * `channelNumber`: Channel number. If you specify this parameter, the search will be performed only in the audio text transcript or chat text for the specified channel.

      Channel numbering in chat connections:

      * `0`: Agent channel.
      * `1`: Customer channel.
      * `2`: Bot channel.

      Channel numbering for audio is preset at the connection level and is different from channel numbering for chats.

    You can also use [filters by parameters](#filter-by-parameters-ref) along with full-text search. In this case, the response will return only query IDs that satisfy both the full-text search criteria and additional filters.

    In your query, you can set parameters for sorting the results and the number of results per page. For more information about sorting results and pagination, see [Query parameters](#full-text-search-ref).

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}
1. Send a Search query to the {{ speechsense-name }} API using cURL:

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/search \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @search.json
    ```

    Where `Api-Key` is the API key for authentication. If using an IAM token, specify `Bearer ${IAM_TOKEN}` instead of `Api-Key ${API_KEY}`.

    Dialog IDs that meet the search criteria will be output to the terminal in JSON format.

### Request body example for full-text search {#full-text-search-example}

For example, you need to find all the dialogs with the provider's technical support in which the agent proposed filing a ticket for a technician's visit. Your JSON file with the request parameters will look as follows:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "query": {
    "text": "technician's visit",
    "channel_number": "0"
  },  
}
```

Query results:

```json
{
  "talk_ids": [
    "aud95sn63lra********"
  ],
  "talks_count":" 1",
  "next_page_token": ""
}
```

Where:

* `talk_ids`: IDs of dialogs that meet the search criteria.
* `talks_count`: Number of dialogs that meet the search criteria.
* `next_page_token`: Token of the next page with search results. If the search results are split into multiple pages, this token is used in the next query to request the next page. If this field is returned empty, the search results end on the current page.

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
    "channel_number": "0"
  },
  "filters": [
    {
      "key": "userMeta.date",
      "date_range": {
        "from_value": "2024-09-24T11:00:00Z",
        "to_value": "2024-09-24T12:00:00Z"
      }
    }
  ],  
}
```

Query results:

```json
{
  "talk_ids": [
    "aud95sn63lra********"
  ],
  "talks_count":" 1",
  "next_page_token": ""
}
```

Where:

* `talk_ids`: IDs of dialogs that meet the search criteria.
* `talks_count`: Number of dialogs that meet the search criteria.
* `next_page_token`: Token of the next page with search results. If the search results are split into multiple pages, this token is used in the next query to request the next page. If this field is returned empty, the search results end on the current page.

## Filtering by parameters {#filter-by-parameters}

1. Create a file named `search.json` and specify in it the required `filters` [IDs and filters](#filter-by-parameters-ref):

    ```json
    {
      "organizationId": "<organization_ID>",
      "spaceId": "<space_ID>",
      "connectionId": "<connection_ID>",
      "projectId": "<project_ID>",
      "filters": [
        {
          "key": "<dialog_feature_you_are_searching_by>",
          "channelNumber": "<channel_number>",

          // Specify one or more filters
          "anyMatch": {
            "values": [
              "<search_query>"
            ]
          },
          "intRange": {
            "fromValue": "<lower_limit>",
            "toValue": "<upper_limit>",
            "boundsInclusive": {
              "fromInclusive": "<enable_lower_limit:_true_or_false>",
              "toInclusive": "<enable_upper_limit:_true_or_false>"
            }
          },
          "doubleRange": {
            "fromValue": "<lower_limit>",
            "toValue": "<upper_limit>",
            "boundsInclusive": {
              "fromInclusive": "<enable_lower_limit:_true_or_false>",
              "toInclusive": "<enable_upper_limit:_true_or_false>"
            }
          },
          "dateRange": {
            "fromValue": "<lower_limit>",
            "toValue": "<upper_limit>",
            "boundsInclusive": {
              "fromInclusive": "<enable_lower_limit:_true_or_false>",
              "toInclusive": "<enable_upper_limit:_true_or_false>"
            }
          },
          "durationRange": {
            "fromValue": "<lower_limit>",
            "toValue": "<upper_limit>",
            "boundsInclusive": {
              "fromInclusive": "<enable_lower_limit:_true_or_false>",
              "toInclusive": "<enable_upper_limit:_true_or_false>"
            }
          },
          "booleanMatch": {
            "value": "<filter_by_true_or_false>"
          }
        }
      ]
    }
    ```

    Where:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}
    * `key`: Dialog feature you are searching by. The possible values are:

      * `userMeta.<field_name>`: Searching by user metadata. Where `<field_name>` is the user metadata field that was specified when uploading the conversation, e.g., `userMeta.date`. The filter type must match the metadata field type, which you selected when creating the connection.
      * `talk.classifiers.<classifier_name>.count`: Searching by classifiers.
      * `talk.summarization.points.<question_ID>`: Searching by conversation summary. You can view IDs of the questions from the conversation summary in the response of the GET request.
      * `talk.statistics.<statistics_name>`: Searching by statistics (only for audio):

        * `talk.statistics.duration_seconds`: Duration of the conversation.
        * `talk.statistics.simultaneous_silence.duration_seconds`, `talk.statistics.simultaneous_silence.ratio`: Simultaneous silence in seconds or as a percentage.
        * `talk.statistics.simultaneous_speech.duration_seconds`, `talk.statistics.simultaneous_speech.ratio`: Simultaneous speech in seconds or as a percentage.
        * `talk.statistics.interrupts.count`: Number of conversation partner interruptions.
        * `talk.statistics.phrases.count`, `talk.statistics.words.count`, `talk.statistics.letters.count`: Number of phrases, words, or characters in the conversation.
        * `talk.statistics.words.count_per_second`, `talk.statistics.letters.count_per_second`: Number of words or characters per second in the specified channel (the channel should be specified in the filter).
        * `talk.statistics.interrupts.duration_seconds`: Duration of interruption by the specified conversation channel (the channel should be specified in the filter), in seconds.

    * `channelNumber`: Channel number. If you specify this parameter, filtering is performed based on metadata, classifier positives, or statistics related to this channel.

      Channel numbering in chat connections:

      * `0`: Agent channel.
      * `1`: Customer channel.
      * `2`: Bot channel.

      Channel numbering for audio is preset at the connection level and is different from channel numbering for chats.

    * `anyMatch`: Specifies whether the metadata, classifier, statistics, or conversation summary fields contain the value from the filter. For example, a filter with the `key = userMeta.ticket_id` and `values = [123, 345]` parameters will find conversations with `123` or `345` in the `ticket_id` metadata field.
    * `intRange`: Checks that the integer value in the field you are searching by is within the range specified in the filter. Suitable for searching by classifiers, integer metadata fields, and statistics with integer values.
    * `doubleRange`: Same as `intRange` but used for floating-point numbers.
    * `intRange`: Checks that the date value in the field you are searching by is within the range specified in the filter.
    * `durationRange`: Checks that the duration in the field you are searching by is within the range specified in the filter.
    * `booleanMatch`: Checks that the `boolean` type field you are searching by has the value specified in the filter (`True` or `False`). Suitable for searching by conversation summary and `boolean` metadata fields.

    You can set the `boundsInclusive` parameter for each filter. Decides whether to include range limits in the search:

      * `fromInclusive`: Lower limit.
      * `toInclusive`: Upper limit.

    In your query, you can also set parameters for sorting the results and the number of results per page. For more information about sorting results and pagination, see [Query parameters](#filter-by-parameters-ref).  

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}
1. Send a Search query to the {{ speechsense-name }} API using cURL:

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/search \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @search.json
    ```

    Where `Api-Key` is the API key for authentication. If using an IAM token, specify `Bearer ${IAM_TOKEN}` instead of `Api-Key ${API_KEY}`.

    Dialog IDs that meet the search criteria will be output to the terminal in JSON format.

### Request body example for filtering by individual parameters {#filter-by-parameters-example}

For example, you need to find all the dialogs with the provider's technical support between 11:00 and 12:00 on September 24, 2024. Your JSON file with the request parameters will look as follows:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "filters": [
    {
      "key": "userMeta.date",
      "date_range": {
        "from_value": "2024-09-24T11:00:00Z",
        "to_value": "2024-09-24T12:00:00Z"
      }
    }
  ]
}
```

Query results:

```json
{
  "talk_ids": [
    "aud95sn63lra********"
  ],
  "talks_count": "1",
  "next_page_token": ""
}
```

Where:

* `talk_ids`: IDs of dialogs that meet the search criteria.
* `talks_count`: Number of dialogs that meet the search criteria.
* `next_page_token`: Token of the next page with search results. If the search results are split into multiple pages, this token is used in the next query to request the next page. If this field is returned empty, the search results end on the current page.

## Getting information about a dialog {#get-dialog-data}

1. In the folder, create a file named `get.json` with the following [parameters](#get-query-ref) to get the dialog you need:

    ```json
    {
      "organizationId": "<organization_ID>",
      "spaceId": "<space_ID>",
      "connectionId": "<connection_ID>",
      "projectId": "<project_ID>",
      "talk_ids": [
        "<dialog_ID>"
      ],
      "results_mask": {
        "paths": [
          "<requested_field_keys>"
        ]
      }
    }
    ```
    Where:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

    * `paths`: List of fields you want to get.

1. Make a Get request to the {{ speechsense-name }} API using cURL:

    ```bash
    curl -X POST https://rest-api.speechsense.yandexcloud.net/speechsense/v1/talks/get \
       -H "Content-Type: application/json" \
       -H "authorization: Api-Key ${API_KEY}" \
       -d @get.json
    ```

    Where `Api-Key` is the API key for authentication. If using an IAM token, specify `Bearer ${IAM_TOKEN}` instead of `Api-Key ${API_KEY}`.

    The search results will be output to the terminal in JSON format.

### Request body example for getting information about a dialog {#get-chat-info-example}

For example, you need to get a summary of a dialog with technical support, where the agent proposed filing a ticket for a technician's visit. You got the ID of such a dialog in the [example above](#full-text-search-example).

Your JSON file with the request parameters will look as follows:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "talk_ids": ["aud95sn63lra********"],
  "results_mask": {
    "paths": ["points"]
  }
}
```

{% cut "Query execution results" %}

```json
{
  "talk": [
    {
      "id": "aud95sn63lra********",
      "organization_id": "yc.organization****************",
      "space_id": "f3fuclf1kufs********",
      "connection_id": "eag0u346n4hn********",
      "project_ids": [
        "eag9t3rm3o43********"
      ],
      "created_by": "ajeugoqa16o5********",
      "created_at": "2024-09-24T08:53:09.932Z",
      "modified_by": "CLASSIFIER",
      "modified_at": "2024-09-24T18:06:08.299Z",
      "talk_fields": [
        {
          "name": "operator_name",
          "value": "Agent",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "operator_id",
          "value": "operator_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_name",
          "value": "Customer",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "client_id",
          "value": "customer_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_name",
          "value": "Bot",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "bot_id",
          "value": "bot_id",
          "type": "FIELD_TYPE_STRING"
        },
        {
          "name": "date",
          "value": "2024-09-24T11:11:11.111Z",
          "type": "FIELD_TYPE_DATE"
        },
        {
          "name": "direction_outgoing",
          "value": "true",
          "type": "FIELD_TYPE_BOOLEAN"
        },
        {
          "name": "language",
          "value": "Russian",
          "type": "FIELD_TYPE_STRING"
        }
      ],
      "transcription": null,
      "speech_statistics": null,
      "silence_statistics": null,
      "interrupts_statistics": null,
      "conversation_statistics": null,
      "points": {
        "quiz": [
          {
            "request": "1. Was the agent polite?",
            "response": "1. Yes",
            "id": "1"
          },
          {
            "request": "2. Was the agent annoyed?",
            "response": "2. No",
            "id": "2"
          },
          {
            "request": "3. Was the agent engaged in the dialog?",
            "response": "3. No",
            "id": "3"
          },
          {
            "request": "4. Was the agent empathic?",
            "response": "4. Yes",
            "id": "4"
          },
          {
            "request": "5. Was the agent rude?",
            "response": "5. No",
            "id": "5"
          },
          {
            "request": "6. Did the agent solve the customer's problem?",
            "response": "6. No",
            "id": "6"
          },
          {
            "request": "7. Was the agent confident?",
            "response": "7. Yes",
            "id": "7"
          },
          {
            "request": "8. Did the customer leave annoyed?",
            "response": "8. No",
            "id": "8"
          },
          {
            "request": "9. Was the customer satisfied?",
            "response": "9. Yes",
            "id": "9"
          },
          {
            "request": "10. Was the customer rude?",
            "response": "10. No",
            "id": "10"
          }
        ]
      },
      "text_classifiers": null
    }
  ]
}
```

{% endcut %}

## Query parameters {#query-parameters}

### Search query {#search-query}

##### **Full-text search** {#full-text-search-ref}

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
  "sort_data": {
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

  * `text`: Search query text. You can specify a word, phrase or a whole sentence. {{ speechsense-name }} will search for the specified string in the audio text transcript or chat text.
  * `channelNumber`: Channel number. If you specify this parameter, the search will be performed only in the audio text transcript or chat text for the specified channel.

    Channel numbering in chat connections:

    * `0`: Agent channel.
    * `1`: Customer channel.
    * `2`: Bot channel.

    Channel numbering for audio is preset at the connection level and is different from channel numbering for chats.
* `sort_data`: Data sorting parameters in response to the request
  * `fields`: List of dialog features you are sorting by. Supports the following parameters:
    * `field`: Dialog feature you are searching by.
    * `order`: Sort order: ascending or descending.
    * `position`: Sorting field priority (when sorting by several dialog features at the same time).
* `pageSize`: Number of documents per page.
* `pageToken`: Token of the next page with search query results. 
  If the query results are split into multiple pages, each page has a token of its own. The response to each search query contains the `next_page_token` (if there is a next page). Paste it into the `pageToken` parameter of your search query to get the next page of search results.

You can also use [filters by parameters](#filter-by-parameters-ref) along with full-text search. In this case, the response will return only query IDs that satisfy both the full-text search criteria and additional filters.

##### **Filtering by parameters** {#filter-by-parameters-ref}

```json
{
  "organizationId": "<organization_ID>",
  "spaceId": "<space_ID>",
  "connectionId": "<connection_ID>",
  "projectId": "<project_ID>",
  "filters": [
    {
      "key": "<dialog_feature_you_are_searching_by>",
      "channelNumber": "<channel_number>",

      // Specify one or more filters
      "anyMatch": {
        "values": [
          "<search_query>"
        ]
      },
      "intRange": {
        "fromValue": "<lower_limit>",
        "toValue": "<upper_limit>",
        "boundsInclusive": {
          "fromInclusive": "<enable_lower_limit:_true_or_false>",
          "toInclusive": "<enable_upper_limit:_true_or_false>"
        }
      },
      "doubleRange": {
        "fromValue": "<lower_limit>",
        "toValue": "<upper_limit>",
        "boundsInclusive": {
          "fromInclusive": "<enable_lower_limit:_true_or_false>",
          "toInclusive": "<enable_upper_limit:_true_or_false>"
        }
      },
      "dateRange": {
        "fromValue": "<lower_limit>",
        "toValue": "<upper_limit>",
        "boundsInclusive": {
          "fromInclusive": "<enable_lower_limit:_true_or_false>",
          "toInclusive": "<enable_upper_limit:_true_or_false>"
        }
      },
      "durationRange": {
        "fromValue": "<lower_limit>",
        "toValue": "<upper_limit>",
        "boundsInclusive": {
          "fromInclusive": "<enable_lower_limit:_true_or_false>",
          "toInclusive": "<enable_upper_limit:_true_or_false>"
        }
      },
      "booleanMatch": {
        "value": "<filter_by_true_or_false>"
      }
    }
  ],
  "sort_data": {
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

{% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

* `filters`: Request body for filtering by individual parameters. Supports the following parameters:

  * `key`: Dialog feature you are searching by. The possible values are:

    * `userMeta.<field_name>`: Searching by user metadata. Where `<field_name>` is the user metadata field that was specified when uploading the conversation, e.g., `userMeta.date`. The filter type must match the metadata field type, which you selected when creating the connection.
    * `talk.classifiers.<classifier_name>.count`: Searching by classifiers.
    * `talk.summarization.points.<question_ID>`: Searching by conversation summary. You can view IDs of the questions from the conversation summary in the response of the GET request.
    * `talk.statistics.<statistics_name>`: Searching by statistics (only for audio):

      * `talk.statistics.duration_seconds`: Duration of the conversation.
      * `talk.statistics.simultaneous_silence.duration_seconds`, `talk.statistics.simultaneous_silence.ratio`: Simultaneous silence in seconds or as a percentage.
      * `talk.statistics.simultaneous_speech.duration_seconds`, `talk.statistics.simultaneous_speech.ratio`: Simultaneous speech in seconds or as a percentage.
      * `talk.statistics.interrupts.count`: Number of conversation partner interruptions.
      * `talk.statistics.phrases.count`, `talk.statistics.words.count`, `talk.statistics.letters.count`: Number of phrases, words, or characters in the conversation.
      * `talk.statistics.words.count_per_second`, `talk.statistics.letters.count_per_second`: Number of words or characters per second in the specified channel (the channel should be specified in the filter).
      * `talk.statistics.interrupts.duration_seconds`: Duration of interruption by the specified conversation channel (the channel should be specified in the filter), in seconds.

  * `channelNumber`: Channel number. If you specify this parameter, filtering is performed based on metadata, classifier positives, or statistics related to this channel.

    Channel numbering in chat connections:

    * `0`: Agent channel.
    * `1`: Customer channel.
    * `2`: Bot channel.

    Channel numbering for audio is preset at the connection level and is different from channel numbering for chats.

  The following filters are available:

    * `anyMatch`: Specifies whether the metadata, classifier, statistics, or conversation summary fields contain the value from the filter. For example, a filter with the `key = userMeta.ticket_id` and `values = [123, 345]` parameters will find conversations with `123` or `345` in the `ticket_id` metadata field.
    * `intRange`: Checks that the integer value in the field you are searching by is within the range specified in the filter. Suitable for searching by classifiers, integer metadata fields, and statistics with integer values.
    * `doubleRange`: Same as `intRange` but used for floating-point numbers.
    * `intRange`: Checks that the date value in the field you are searching by is within the range specified in the filter.
    * `durationRange`: Checks that the duration in the field you are searching by is within the range specified in the filter.
    * `booleanMatch`: Checks that the `boolean` type field you are searching by has the value specified in the filter (`True` or `False`). Suitable for searching by conversation summary and `boolean` metadata fields.

  You can set the `boundsInclusive` parameter for each filter. Decides whether to include range limits in the search:

    * `fromInclusive`: Lower limit.
    * `toInclusive`: Upper limit.

* `sort_data`: Data sorting parameters in response to the request.
  * `fields`: List of dialog features you are sorting by. Supports the following parameters:
    * `field`: Dialog feature you are searching by.
    * `order`: Sort order: ascending or descending.
    * `position`: Sorting field priority (when sorting by several dialog features at the same time).
* `pageSize`: Number of documents per page.
* `pageToken`: Token of the next page with search query results. 
  If the query results are split into multiple pages, each page has a token of its own. The response to each search query contains the `next_page_token` (if there is a next page). Paste it into the `pageToken` parameter of your search query to get the next page of search results.

For more information about Search query parameters, see the [relevant API reference](../../api-ref/Talk/search.md).

### GET request {#get-query-ref}

```json
{
  "organizationId": "<organization_ID>",
  "spaceId": "<space_ID>",
  "connectionId": "<connection_ID>",
  "projectId": "<project_ID>",
  "talk_ids": [
    "<dialog_ID>"
  ],
  "results_mask": {
    "paths": [
      "<requested_field_keys>"
    ]
  }
}
```
Where:

{% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

* `talk_ids`: IDs of the dialogs you want to get information about. To find out the dialog IDs, use [Search query](#search-query).
* `results_mask`: Result mask. If this parameter is not provided, you will get the full information about the dialog, whereas if the parameter is provided with an empty `paths` list, you will get only the basic information about the dialog, such as the IDs of the project, connection, and space, information about when and by whom the dialog was created or modified, and the metadata added when uploading the dialog. To unload individual fields with data, provide the keys of the required fields in the `paths` list to the mask:

  * `transcription`: Audio text transcript or chat text messages.
  * `speech_statistics`: Speech statistics.
  * `silence_statistics`: Statistics of pauses in the conversation.
  * `interrupts_statistics`: Statistics of conversation partner interruptions.
  * `conversation_statistics`: Conversation statistics.
  * `points`: Conversation summary.
  * `text_classifiers`: Statistics for classifiers (tags).

For more information about Get request parameters, see the [relevant API reference](../../api-ref/Talk/get.md).
