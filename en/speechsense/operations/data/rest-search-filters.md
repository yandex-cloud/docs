# Filtering by parameters in REST API

Filtering by parameters allows you to find dialogs matching the specified conditions. The query returns IDs of matching dialogs. For details on how to get information about a dialog by its ID, see [this guide](rest-get-dialog-data.md).

You can use filtering separately or as an addition to [full-text search](rest-full-text-search.md). When used with full-text search, the response will return only query IDs satisfying both the full-text search criteria and additional filters.

## Getting started {#before-you-begin}

{% include [before-you-begin](../../../_includes/speechsense/data/rest-search-before-you-begin.md) %}

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
          "key": "<dialog_feature_used_for_filtering>",
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
      "sortData": {
        "fields": [{  
          "field": "<dialog_feature_used_for_sorting>",
          "order": "<sort_order:_ascending_or_descending>",
          "position": "<sort_field_priority>"
        }]
      },
      "pageSize": "<number_of_documents_per_page>",
      "pageToken": "<next_page_token_with_filtering_results>"
    }
    ```

    Where:

    {% include [id-parameters](../../../_includes/speechsense/data/api-id-parameters.md) %}

    * `filters`: Request body for filtering by individual parameters. Supports the following parameters:

      * `key`: Dialog feature you are filtering by. The possible values are:

        * `userMeta.<field_name>`: Filtering by metadata. Here `<field_name>` is the metadata field specified when uploading the dialog. Example: `userMeta.date`.
        * `talk.classifiers.<classifier_name>.count`: Filtering by classifiers. It takes into account the number of times a certain classifier has been triggered in a dialog.
        * `talk.summarization.points.<question_ID>`: Filtering by dialog summary. You can get question IDs from the dialog summary [together with the dialog data](rest-get-dialog-data.md).
        * `talk.statistics.<statistics_name>`: Filtering by statistics (for audio only):

          * `talk.statistics.duration_seconds`: Dialog duration in seconds.
          * `talk.statistics.simultaneous_silence.duration_seconds`: Simultaneous silence duration in seconds.
          * `talk.statistics.simultaneous_silence.ratio`: Ratio of simultaneous silence to total dialog duration.
          * `talk.statistics.simultaneous_speech.duration_seconds`: Simultaneous speech duration in seconds.
          * `talk.statistics.simultaneous_speech.ratio`: Ratio of simultaneous speech to total dialog duration.
          * `talk.statistics.interrupts.count`: Number of dialog partner interruptions.
          * `talk.statistics.phrases.count`: Number of phrases in a dialog.
          * `talk.statistics.words.count`: Number of words in a dialog.
          * `talk.statistics.letters.count`: Number of characters in a dialog.
          * `talk.statistics.words.count_per_second`: Number of words per second in the channel specified in the `channelNumber` parameter.
          * `talk.statistics.letters.count_per_second`: Number of characters per second in the channel specified in the `channelNumber` parameter.
          * `talk.statistics.interrupts.duration_seconds`: Duration of speaker interruptions by another speaker, in seconds. The channel of the interrupting speaker is specified in the `channelNumber` parameter.

      * `channelNumber`: Channel number. If you specify this number, filtering is applied to metadata, classifier positives, or statistics related to this channel.

        Channel numbering in chat connections:

        * `0`: Agent channel.
        * `1`: Customer channel.
        * `2`: Bot channel.

        Channel numbering for audio is preset at the connection level and is different from channel numbering for chats.

      The following filters are available:

        * `anyMatch`: Specifies whether the metadata, classifier, statistics, or dialog summary fields contain the value from the filter. For example, a filter with the `key = userMeta.ticket_id` and `values = [123, 345]` parameters will return dialogs with `123` or `345` in the `ticket_id` metadata field.
        * `intRange`: Checks that the given integer value falls within the range specified in the filter. Suitable for filtering by classifiers, integer metadata fields, and statistics with integer values.
        * `doubleRange`: Checks that the given floating-point number falls within the range specified in the filter. Suitable for filtering by classifiers, metadata fields, and statistics with floating-point values.
        * `dateRange`: Checks that the given date value falls within the range specified in the filter.
        * `durationRange`: Checks that the given duration falls within the range specified in the filter. Suitable for filtering by dialog duration, interruptions, simultaneous speech or silence.
        * `booleanMatch`: Checks that the given value of `boolean` type matches the value in the filter, `True` or `False`. Suitable for filtering by dialog summary and `boolean` metadata fields.

      You can set the `boundsInclusive` parameter for each filter. It indicates whether to include range limits in the filter:

        * `fromInclusive`: Lower limit.
        * `toInclusive`: Upper limit.

    * `sortData`: Data sorting parameters in response to the request.
      * `fields`: List of dialog features you are sorting by. Supports the following parameters:
        * `field`: Dialog feature you are sorting by.
        * `order`: Sort order: ascending or descending.
        * `position`: Sorting field priority (when sorting by several dialog features at the same time).
    * `pageSize`: Number of documents per page.
    * `pageToken`: Token of the next page with query results.
      If the query results are split into multiple pages, each page has a token of its own. The response to each query contains the `nextPageToken` (if there is a next page). Paste it into the `pageToken` parameter of your query to get the next page of results.

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

    Dialog IDs that meet the filtering criteria will be output to the terminal in JSON format.

## Request body example for filtering by individual parameters {#filter-by-parameters-example}

For example, you need to find all the dialogs with the provider's support between 11:00 and 12:00 on September 24, 2024. Your JSON file with the request parameters will look as follows:

```json
{
  "organizationId": "yc.organization****************",
  "spaceId": "f3fuclf1kufs********",
  "connectionId": "eag0u346n4hn********",
  "projectId": "eag9t3rm3o43********",
  "filters": [
    {
      "key": "userMeta.date",
      "dateRange": {
        "fromValue": "2024-09-24T11:00:00Z",
        "toValue": "2024-09-24T12:00:00Z"
      }
    }
  ]
}
```

Query results:

```json
{
  "talkIds": [
    "aud95sn63lra********"
  ],
  "talksCount": "1",
  "nextPageToken": ""
}
```

Where:

* `talkIds`: IDs of dialogs that meet the filtering criteria.
* `talksCount`: Number of dialogs that meet the filtering criteria.
* `nextPageToken`: Token of the next page with results. If the results are split into multiple pages, this token is used in the next query to get the next page. If this field is returned empty, the results end on the current page.
