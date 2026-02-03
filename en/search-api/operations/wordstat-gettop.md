# Getting top results by key phrase

With {{ wordstat-name }}, you can get the most popular search results by key phrase using a [REST method](../api-ref/Wordstat/getTop.md) or the GetTop [gRPC call](../api-ref/grpc/Wordstat/getTop.md).

To complete the steps from this example, [create](../../ai-studio/operations/get-api-key.md#run-client) a service account with the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) and get an API key with the `yc.search-api.execute` scope. You can also use an [IAM token](../../iam/concepts/authorization/iam-token.md) as a more secure method. [Learn more about authentication in {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

  1. Create a file with the request body, e.g., `body.json`:
     
     ```json
	  {
       "phrase": "<key_phrase>",
       "numPhrases": 100,
       "regions": ["213"],
       "devices": ["DEVICE_ALL"],
       "folderId": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
     * `numPhrases`: Number of phrases in the response. The default value is 50. The maximum value is 2,000.
     * `regions`: List of [region IDs](../reference/regions.md) showing where the query originated. For example, `213` stands for Moscow. By default, queries from all regions are taken into account.
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
         "https://searchapi.{{ api-host }}/v2/wordstat/topRequests" \
         > result.json
       ```

     * Authentication with an API key:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API_key>" \
         --data "@body.json" \
         "https://searchapi.{{ api-host }}/v2/wordstat/topRequests" \
         > result.json
       ```

     The result will be saved to the `result.json` file.

     {% cut "Response fragment" %}

     ```json
     {
        "totalCount": "48885",
        "results": [
          {
            "phrase": "buy a dog",
            "count": "48885"
          },
       ],
        "associations": [
          {
            "phrase": "how much is a poodle",
            "count": "613"
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
       "num_phrases": 100,
       "regions": ["213"],
       "devices": ["DEVICE_ALL"],
       "folder_id": "<folder_ID>"
     }
     ```

     Where:

     * `phrase`: Query key phrase supporting [search operators](../concepts/search-operators.md).
     * `num_phrases`: Number of phrases in the response. The default value is 50. The maximum value is 2,000.
     * `regions`: List of [region IDs](../reference/regions.md) showing where the query originated. For example, `213` stands for Moscow. By default, queries from all regions are taken into account.
     * `devices`: List of device types used to send the query. The possible values are:
        * `DEVICE_ALL`: All devices.
        * `DEVICE_DESKTOP`: PCs.
        * `DEVICE_PHONE`: Mobile phones.
        * `DEVICE_TABLET`: Tablets.
     * `folder_id`: Your service account’s [folder ID](../../resource-manager/operations/folder/get-id.md).

  1. Make a [gRPC call](../api-ref/grpc/Wordstat/getTop.md) specifying the API key or IAM token you got earlier and a path to the request body file:

     * Authentication with an API key:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Api-Key <API_key>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetTop \
         > result.json
       ```

     * Authentication with an IAM token:
     
       ```bash
       grpcurl \
         -rpc-header "Authorization: Bearer <IAM_token>" \
         -d @ < body.json \
         searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetTop \
         > result.json
       ```

     The result will be saved to the `result.json` file. 

     {% cut "Response fragment" %}

     ```json
     {
        "totalCount": "48885",
        "results": [
          {
            "phrase": "buy a dog",
            "count": "48885"
          },
       ],
        "associations": [
          {
            "phrase": "how much is a poodle",
            "count": "613"
          }
       ]
     }
     ```

     {% endcut %}

{% endlist %}