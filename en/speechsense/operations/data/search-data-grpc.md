---
title: Data search via the gRPC API
description: Follow this guide to learn how to search for data via the gRPC API.
---

# Data search via the gRPC API

## Getting started {#before-you-begin}

{% include [software](../../../_includes/speechsense/data/software.md) %}

To search data using the {{ yandex-cloud }} gRPC API:

1. {% include [create-sa](../../../_includes/speechsense/data/create-sa.md) %}
1. {% include [role-sa](../../../_includes/speechsense/data/role-sa.md) %}
1. {% include [create-api-key](../../../_includes/speechsense/data/create-api-key.md) %}
1. {% include [clone-cloudapi](../../../_includes/speechsense/data/clone-cloudapi.md) %}
1. {% include [install-grpcio-tools](../../../_includes/speechsense/data/install-grpcio-tools.md) %}
1. [Upload voice call recordings](upload-data.md) or [chat transcripts](upload-chat-text.md) to {{ speechsense-name }}.

## Finding data {#grpc-api-search}

1. Go to the directory hosting the {{ yandex-cloud }} API repository, create a directory named `search_data`, and generate the client interface code in it. Then, go to the `search_data` directory:

    {% list tabs group=programming_language %}

    - Bash {#bash}

        ```bash
        cd <path_to_cloudapi_folder> && \
        mkdir search_data && \
        python3 -m grpc_tools.protoc -I . -I third_party/googleapis \
            --python_out=./search_data/ \
            --grpc_python_out=./search_data/ \
            google/api/http.proto \
            google/api/annotations.proto \
            yandex/cloud/api/operation.proto \
            google/rpc/status.proto \
            yandex/cloud/operation/operation.proto \
            yandex/cloud/validation.proto \
            yandex/cloud/speechsense/v1/*.proto \
            yandex/cloud/speechsense/v1/*/*.proto
        cd search_data
        ```

    {% endlist %}

1. In the `search_data` directory, create the `search_data.py` Python script that will search for dialogs in {{ speechsense-name }}.

    {% cut "Example of the `search_data.py` script with filtering and full-text search" %}

    ```python
    import argparse
    import re
    from datetime import datetime
    from typing import NamedTuple

    import grpc
    from google.protobuf.field_mask_pb2 import FieldMask
    from google.protobuf.json_format import MessageToJson

    from yandex.cloud.speechsense.v1 import search_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2
    from yandex.cloud.speechsense.v1 import talk_service_pb2_grpc

    class IntRangeFilter(NamedTuple):
        key: str
        lower_bound: int
        lb_inclusive: bool
        upper_bound: int
        ub_inclusive: bool

    def parse_int_range(s: str) -> IntRangeFilter:
        pattern = r'(-?\d+)(<=|<)(\w+)(<=|<)(-?\d+)'

        match = re.match(pattern, s)

        if not match:
            raise ValueError(f"Could not parse int range from: '{s}'")

        lower_bound = int(match.group(1))
        lower_bound_inclusive = match.group(2) == "<="
        key = match.group(3)
        upper_bound_inclusive = match.group(4) == "<="
        upper_bound = int(match.group(5))

        return IntRangeFilter(
            key=key,
            lower_bound=lower_bound,
            lb_inclusive=lower_bound_inclusive,
            upper_bound=upper_bound,
            ub_inclusive=upper_bound_inclusive
        )

    def build_search_request(
            organization_id: str,
            space_id: str,
            connection_id: str,
            project_id: str,
            query=None,
            from_date=None,
            to_date=None,
            match_filter=None,
            classifier_filter=None,
            page_size=100,
            page_token='') -> talk_service_pb2.SearchTalkRequest:
        request = talk_service_pb2.SearchTalkRequest(
            organization_id=organization_id,
            space_id=space_id,
            connection_id=connection_id,
            project_id=project_id,
            page_size=page_size,
            page_token=page_token
        )

        # Adding a full-text search request
        if query:
            request.query.text = query

        # Adding a filter by date
        if from_date:
            date_filter = search_pb2.DateRangeFilter()
            date_filter.from_value.FromDatetime(datetime.fromisoformat(from_date))
            request.filters.append(search_pb2.Filter(key="userMeta.date", date_range=date_filter))

        if to_date:
            date_filter = search_pb2.DateRangeFilter()
            date_filter.to_value.FromDatetime(datetime.fromisoformat(to_date))
            request.filters.append(search_pb2.Filter(key="userMeta.date", date_range=date_filter))

        # Adding a match filter
        if match_filter:
            key, value = match_filter.split(':')  # key/value
            any_match_filter = search_pb2.AnyMatchFilter()
            any_match_filter.values.append(value)
            request.filters.append(search_pb2.Filter(key=key, any_match=any_match_filter))

        # Adding a classifier filter
        if classifier_filter:
            filter_values = parse_int_range(classifier_filter)
            int_range_filter = search_pb2.IntRangeFilter()
            int_range_filter.from_value.value=filter_values.lower_bound
            int_range_filter.to_value.value=filter_values.upper_bound
            int_range_filter.bounds_inclusive.from_inclusive=filter_values.lb_inclusive
            int_range_filter.bounds_inclusive.to_inclusive=filter_values.ub_inclusive
            request.filters.append(
                    search_pb2.Filter(key='talk.classifiers.' + filter_values.key + '.count', int_range=int_range_filter))

        return request

    # For IAM token authentication, replace the `api_key` parameter with `iam_token`
    def print_talks(
            api_key: str,
            organization_id: str,
            space_id: str,
            connection_id: str,
            project_id: str,
            query=None,
            from_date=None,
            to_date=None,
            match_filter=None,
            classifier_filter=None
    ):
        credentials = grpc.ssl_channel_credentials()
        channel = grpc.secure_channel('api.speechsense.yandexcloud.net:443', credentials)
        talk_service_stub = talk_service_pb2_grpc.TalkServiceStub(channel)

        page_token = ''

        while True:
            search_request = build_search_request(
                organization_id=organization_id,
                space_id=space_id,
                connection_id=connection_id,
                project_id=project_id,
                query=query,
                from_date=from_date,
                to_date=to_date,
                match_filter=match_filter,
                classifier_filter=classifier_filter,
                page_token=page_token)

            # Searching for IDs of relevant dialogs
            search_response = talk_service_stub.Search(search_request, metadata=(
                ('authorization', f'Api-Key {api_key}'),
                # For IAM token authentication, provide the header
                # ('authorization', f'Bearer {iam_token}'),
            ))
            page_token = search_response.next_page_token
            # print(f'found falks {search_response.talks_count}')

            # By default, only the basic fields of the dialog will be returned.
            # To include the analysis results, add them to the request
            fields_to_include = FieldMask(
                paths=['transcription', 'speech_statistics', 'silence_statistics', 'interrupts_statistics',
                       'conversation_statistics', 'points', 'text_classifiers'])

            # Requesting full data on dialogs by ID
            get_request = talk_service_pb2.GetTalkRequest(
                organization_id=organization_id,
                space_id=space_id,
                connection_id=connection_id,
                project_id=project_id,
                talk_ids=search_response.talk_ids,
                results_mask=fields_to_include
            )

            get_response = talk_service_stub.Get(get_request, metadata=(
                ('authorization', f'Api-Key {api_key}'),
                # For IAM token authentication, provide the header
                # ('authorization', f'Bearer {iam_token}'),
            ))

            # Printing dialogs
            for talk in get_response.talk:
                print(MessageToJson(talk, ensure_ascii=False))

            # If the token is empty, we have reached the last result page
            if not page_token:
                break

    if __name__ == '__main__':
        parser = argparse.ArgumentParser()
        parser.add_argument('--key', required=True, help='API key or IAM token', type=str)
        parser.add_argument('--organization-id', required=True, help='Organization ID', type=str)
        parser.add_argument('--space-id', required=True, help='Space ID', type=str)
        parser.add_argument('--connection-id', required=True, help='Connection ID', type=str)
        parser.add_argument('--project-id', required=True, help='Project ID', type=str)
        parser.add_argument('--query', required=False, help='Full-text search query', type=str)
        parser.add_argument('--match-filter', required=False, help='Simple match filter in format key:value', type=str)
        parser.add_argument('--classifier-filter', required=False,
                            help='range for classifier X in format fromValue</<=X</<=toValue', type=str)
        parser.add_argument('--before', required=False, help='Search for talks before timestamp', type=str)
        parser.add_argument('--after', required=False, help='Search for talks after timestamp', type=str)

        args = parser.parse_args()

        print_talks(args.key, args.organization_id, args.space_id, args.connection_id, args.project_id, query=args.query,
                    from_date=args.after, to_date=args.before, match_filter=args.match_filter,
                    classifier_filter=args.classifier_filter)
    ```

    {% endcut %}

1. {% include [api-key](../../../_includes/speechsense/data/api-key.md) %}

1. Run the `search_data.py` script with the parameters you need:

    ```bash
    python3 search_data.py \
       --organization-id <organization_ID> \
       --space-id <space_ID> \
       --connection-id <connection_ID> \
       --project-id <project_ID> \
       --key ${API_KEY}
    ```

    Where:

    * `--organization-id`: ID of the organization the request takes place in. To get the ID, go to [{{ cloud-center }}]({{ cloud-center-link }}) and click ![icon](../../../_assets/console-icons/copy.svg) under the organization name, in the ![icon](../../../_assets/console-icons/briefcase.svg) section.
    * `--space-id`: ID of the space the request takes place in. To get the ID, go to [{{ speechsense-name }}]({{ link-speechsense-main }}), open the page of the space you need and click **ID**.
    * `--connection-id`: ID of the connection the request takes place in. To get the ID, go to [{{ speechsense-name }}]({{ link-speechsense-main }}), open the page of the space you need. On the **{{ ui-key.yc-ui-talkanalytics.connections.connection }}** tab, open the page of the connection and click **ID**.
    * `--project-id`: ID of the project the request takes place in. To get an ID, go to [{{ speechsense-name }}]({{ link-speechsense-main }}), open the page of the space you need. On the **{{ ui-key.yc-ui-talkanalytics.projects.projects }}** tab, open the page of the project and click **ID**.
    * `--key`: API key for authentication. If using an IAM token, specify the `IAM_TOKEN` environment variable instead of `API_KEY`.

    As the result of running the script, data in JSON format will be displayed.

## Query parameters {#query-parameters}

### Search query {#search-query}

* `Query`: Full-text search that allows you to search through an audio text transcript or chat text messages.
* `Filter`: Allows you to search by user metadata, classifiers, dialog summary, or statistics.

  Under `Filter`, provide the dialog feature you are filtering by in the `key` field.

  * `userMeta.<field_name>`: Filtering by user metadata. Where `<field_name>` is the user metadata field that was specified when uploading the dialog, e.g., `userMeta.date`. The filter type must match the metadata field type, which you specified when creating the connection.
  * `talk.classifiers.<classifier_name>.count`: Filtering by classifiers.
  * `talk.summarization.points.<question_ID>`: Filtering by dialog summary. You can view IDs of the questions from the dialog summary in the response to the GET request.
  * Searching by statistics (only for audio):

    * `talk.statistics.duration_seconds`: Dialog duration in seconds.
    * `talk.statistics.simultaneous_silence.duration_seconds`: Simultaneous silence duration in seconds.
    * `talk.statistics.simultaneous_silence.ratio`: Simultaneous silence ratio.
    * `talk.statistics.simultaneous_speech.duration_seconds`: Simultaneous speech duration in seconds.
    * `talk.statistics.simultaneous_speech.ratio`: Simultaneous speech ratio.
    * `talk.statistics.interrupts.count`: Number of dialog partner interruptions.
    * `talk.statistics.phrases.count`, `talk.statistics.words.count`, `talk.statistics.letters.count`: Number of phrases, words, or characters in the dialog.
    * `talk.statistics.words.count_per_second`, `talk.statistics.letters.count_per_second`: Number of words or characters per second in the specified channel (the channel should be specified in the filter).
    * `talk.statistics.interrupts.duration_seconds`: Duration of speaker interruptions by another speaker, in seconds. The channel of the interrupting speaker is specified in the filter.

Under `Filter` and `Query`, you can provide a channel. For a full-text search, it means that the search will only be conducted in the audio text transcript for the specified channel. For filters, this means that filtering will be done only by metadata, classifier positives, or statistics related to this channel.

In connections for chats, the channels are numbered as follows:

* `0`: Agent channel.
* `1`: Customer channel.
* `2`: Bot channel.

In connections for audio recordings, the channels have a preset numeration.

Other types of filters in the search query:

* `AnyMatchFilter`: Specifies whether the metadata, classifier, statistics, or dialog summary fields contain the value from the filter. For example, a filter with the `key = userMeta.ticket_id` and `values = [123, 345]` parameters will return dialogs with `123` or `345` in the `ticket_id` metadata field.
* `IntRangeFilter`: Checks that the given integer value falls within the range specified in the filter. Suitable for filtering by classifiers, integer metadata fields, and statistics with integer values.
* `DoubleRangeFilter`: Checks that the given floating-point number falls within the range specified in the filter. Suitable for filtering by classifiers, metadata fields, and statistics with floating-point values.
* `BooleanFilter`: Checks if the keyed `boolean` has the suitable value (`True` or `False`). Suitable for searching by dialog summary and `boolean` metadata fields.

For more information about search query parameters, see the [API reference](../../api-ref/grpc/Talk/search.md).

### GET request {#get-query}

In the GET request, one important parameter is the result mask provided in the `fields_to_include` field. If the `fields_to_include` parameter is not provided, you will get only the basic information about the dialog, such as the IDs of the project, connection, and space, information about when and by whom the dialog was created or modified, and the metadata added when uploading the dialog.

To get additional information, provide the keys you need in the mask:

* `transcription`: Audio text transcript or chat text messages.
* `speech_statistics`: Speech statistics.
* `silence_statistics`: Statistics of pauses in the dialog.
* `interrupts_statistics`: Statistics of dialog partner interruptions.
* `conversation_statistics`: Dialog statistics.
* `points`: Dialog summary.
* `text_classifiers`: Statistics for classifiers (tags).

For more information about GET request parameters, see the [API reference](../../api-ref/grpc/Talk/get.md).
