# Getting the number of queries with a key phrase distributed by region

In {{ wordstat-name }}, you can get the number of queries containing a certain phrase by world regions for the last 30 days using a [REST method](../api-ref/Wordstat/getRegionsDistribution.md) or the GetRegionsDistribution [gRPC call](../api-ref/grpc/Wordstat/getRegionsDistribution.md). 

{% include [preview-stage](../../_includes/preview-pp.md) %}

To complete the steps from this example, [create](../../ai-studio/operations/get-api-key.md#run-client) a service account with the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) and get an API key with the `yc.search-api.execute` scope. You can also use an [IAM token](../../iam/concepts/authorization/iam-token.md) as a more secure method. [Learn more about authentication in {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Create a file with the request body, e.g., `body.json`:
     
     ```json
	  {
        "phrase": "<key_phrase>",
        "region": "REGION_CITIES",
        "devices": ["DEVICE_PHONE"],
        "folderId": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
     * `region`: Level of detail. The possible values are:
        * `REGION_CITIES`: Details by cities only.
        * `REGION_CITIES`: Details by regions only.
        * `REGION_ALL`: Everywhere. This is the default value.
     * `devices`: List of device types used to send the query. The possible values are:
        * `DEVICE_ALL`: All devices.
        * `DEVICE_DESKTOP`: PCs.
        * `DEVICE_PHONE`: Mobile phones.
        * `DEVICE_TABLET`: Tablets.
     * `folderId`: Your service account’s [folder ID](../../resource-manager/operations/folder/get-id.md).

  1. Send an HTTP request specifying the API key or IAM token you got earlier and a path to the request body file:

     * Authentication with an IAM token:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer <IAM_token>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/regions" \
         > result.json
       ```

     * Authentication with an API key:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API_key>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/regions" \
         > result.json
       ```

     The result will be saved to the `result.json` file.

      {% cut "Response fragment" %}

      ```json
      {
       "results": [
        {
         "region": "2",
         "count": "117527",
         "share": 0.033340221022570879,
         "affinityIndex": 48.87239354882464
        },
        {
         "region": "213",
         "count": "286666",
         "share": 0.03751625685705634,
         "affinityIndex": 54.99391465808182
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
        "region": "REGION_CITIES",
        "devices": ["DEVICE_PHONE"],
        "folder_id": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
     * `region`: Level of detail. The possible values are:
        * `REGION_CITIES`: Details by cities only.
        * `REGION_CITIES`: Details by regions only.
        * `REGION_ALL`: Everywhere. This is the default value.
     * `devices`: List of device types used to send the query. The possible values are:
        * `DEVICE_ALL`: All devices.
        * `DEVICE_DESKTOP`: PCs.
        * `DEVICE_PHONE`: Mobile phones.
        * `DEVICE_TABLET`: Tablets.
     * `folder_id`: Your service account’s [folder ID](../../resource-manager/operations/folder/get-id.md).

  1. Make a gRPC call specifying the API key or IAM token you got earlier and a path to the request body file:
     
      * Authentication with an IAM token:
     
         ```bash
         grpcurl \
           -rpc-header "Authorization: Bearer <IAM_token>" \
           -d @ < body.json \
           searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsDistribution \
           > result.json
         ```

      * Authentication with an API key:
     
         ```bash
         grpcurl \
           -rpc-header "Authorization: Api-Key <API_key>" \
           -d @ < body.json \
           searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsDistribution \
           > result.json
         ```

      The result will be saved to the `result.json` file. 

      The response contains an array of objects with the following parameters:

      * `region`: [Region](../reference/regions.md) ID.
      * `count`: Number of queries containing the specified phrase in the region.
      * `share`: Percentage of queries with the phrase from the total queries in the region.
      * `affinityIndex`: Affinity index, i.e., ratio of queries in the region to their share across the country.

      {% cut "Response fragment" %}

      ```json
      {
       "results": [
        {
         "region": "2",
         "count": "117527",
         "share": 0.033340221022570879,
         "affinityIndex": 48.87239354882464
        },
        {
         "region": "213",
         "count": "286666",
         "share": 0.03751625685705634,
         "affinityIndex": 54.99391465808182
        }
       ]
      }
      ```

      {% endcut %}

{% endlist %}