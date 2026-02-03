# Getting query frequency dynamics for a key phrase

{{ wordstat-name }} shows how query frequency for a specific key phrase changes by using the `GetDynamics` [REST method](../api-ref/Wordstat/getDynamics.md) or [gRPC call](../api-ref/grpc/Wordstat/getDynamics.md).

{% include [preview-stage](../../_includes/preview-pp.md) %}

To complete the steps from this example, [create](../../ai-studio/operations/get-api-key.md#run-client) a service account with the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) and get an API key with the `yc.search-api.execute` scope. You can also use an [IAM token](../../iam/concepts/authorization/iam-token.md) as a more secure method. [Learn more about authentication in {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Create a file with the request body, e.g., `body.json`:
     
     ```json
	   {
      "phrase": "<key_phrase>",
      "period": "PERIOD_WEEKLY",
      "fromDate": "2025-12-01T00:00:00Z",
      "toDate": "2025-12-14T00:00:00Z",
      "regions": ["213"],
      "devices": ["DEVICE_DESKTOP"],
      "folderId": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
       
       {% note info %}

       The `GetDynamics` method supports all operators for daily breakdowns, while for weekly and monthly breakdowns, it only supports `+`.

       {% endnote %}

     * `period`: Period for aggregating queries by time. The possible values are:
       * `PERIOD_MONTHLY`: Monthly aggregation.
       * `PERIOD_WEEKLY`: Weekly aggregation.
       * `PERIOD_DAILY`: Daily aggregation.
     * `fromDate`: Start date and time of the data request period, provided as a string in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For weekly and monthly aggregation, set the start date to Sunday or the first day of the month, respectively.
     * `toDate`: End date and time of the data request period, provided as a string in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For weekly and monthly aggregation, set the end date to Saturday or the last day of the month, respectively.
     * `regions`: List of [region IDs](../reference/regions.md) showing where the query originated. For example, `213` stands for Moscow. By default, queries from all regions are taken into account.
     * `devices`: List of device types used to send the query. The possible values are:
        * `DEVICE_ALL`: All devices.
        * `DEVICE_DESKTOP`: Desktop computers.
        * `DEVICE_PHONE`: Mobile phones.
        * `DEVICE_TABLET`: Tablets.
     * `folderId`: Your service account’s [folder ID](../../resource-manager/operations/folder/get-id.md).  

  1. Send an HTTP request, specifying the API key or IAM token you got earlier and a path to the request body file:

     * Authentication with an IAM token:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer <IAM_token>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/dynamics" \
         > result.json
       ```

     * Authentication with an API key:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API_key>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/dynamics" \
         > result.json
       ```

     The result will be saved to the `result.json` file.

     {% cut "Response example" %}

     ```json
     {
       "results": [
         {
           "date": "2025-12-01T00:00:00Z",
           "count": "1999",
           "share": 0.002010327532236065
         },
         {
           "date": "2025-12-08T00:00:00Z",
           "count": "3095",
           "share": 0.0031681796592690848
         }
       ]
     }
     ```

     {% endcut %}

- gRPC API {#grpc-api}

  1. Create a file with the request body, e.g., `body.json`:
     
     ```json
	   {
      "phrase": "<key_phrase>",
      "period": "PERIOD_WEEKLY",
      "from_date": "2025-12-29T00:00:00Z",
      "to_date": "2026-01-18T00:00:00Z",
      "regions": ["213"],
      "devices": ["DEVICE_DESKTOP"],
      "folder_id": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
       
       {% note info %}

       The `GetDynamics` method supports all operators for daily breakdowns, while for weekly and monthly breakdowns, it only supports `+`.

       {% endnote %}

     * `period`: Period for aggregating queries by time. The possible values are:
       * `PERIOD_MONTHLY`: Monthly aggregation.
       * `PERIOD_WEEKLY`: Weekly aggregation.
       * `PERIOD_DAILY`: Daily aggregation.
     * `from_date`: Start date and time of the data request period, provided as a string in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For weekly and monthly aggregation, set the start date to Sunday or the first day of the month, respectively.
     * `to_date`: End date and time of the data request period, provided as a string in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) format. For weekly and monthly aggregation, set the end date to Saturday or the last day of the month, respectively.
     * `regions`: List of [region IDs](../reference/regions.md) showing where the query originated. For example, `213` stands for Moscow. By default, queries from all regions are taken into account.
     * `devices`: List of device types used to send the query. The possible values are:
        * `DEVICE_ALL`: All devices.
        * `DEVICE_DESKTOP`: Desktop computers.
        * `DEVICE_PHONE`: Mobile phones.
        * `DEVICE_TABLET`: Tablets.
     * `folder_id`: Your service account’s [folder ID](../../resource-manager/operations/folder/get-id.md).

  1. Make a gRPC call, specifying the API key or IAM token you got earlier and a path to the request body file:
     
     * Authentication with an IAM token:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Bearer <IAM_token>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetDynamics \
         > result.json
       ```

     * Authentication with an API key:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Api-Key <API_key>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetDynamics \
         > result.json
       ```

     The result will be saved to the `result.json` file. 

     {% cut "Response example" %}

     ```json
     {
       "results": [
         {
           "date": "2025-12-01T00:00:00Z",
           "count": "1999",
           "share": 0.002010327532236065
         },
         {
           "date": "2025-12-08T00:00:00Z",
           "count": "3095",
           "share": 0.0031681796592690848
         }
       ]
     }
     ```

     {% endcut %}

{% endlist %}