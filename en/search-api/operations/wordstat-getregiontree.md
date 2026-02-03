# Getting a list of codes for all regions

The GetRegionsTree [REST method](../api-ref/Wordstat/getRegionsTree.md) and [gRPC call](../api-ref/grpc/Wordstat/getRegionsTree.md) allow you to get all the codes Yandex uses to denote the search region. A list of the most commonly used countries and regions can be found in [{#T}](../reference/regions.md).

{% include [preview-stage](../../_includes/preview-pp.md) %}

To complete the steps from this example, [create](../../ai-studio/operations/get-api-key.md#run-client) a service account with the `search-api.webSearch.user` [role](../security/index.md#search-api-webSearch-user) and get an API key with the `yc.search-api.execute` scope. You can also use an [IAM token](../../iam/concepts/authorization/iam-token.md) as a more secure method. [Learn more about authentication in {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- REST API {#rest-api}

   The GetRegionsTree call does not require a key phrase for the search.

   Make an HTTP request by specifying the API key or IAM token you got earlier and your service account's [folder ID](../../resource-manager/operations/folder/get-id.md):
     
     * Authentication with an IAM token:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Bearer <IAM_token>" \
         "https://searchapi.{{ api-host }}/v2/wordstat/getRegionsTree" \
         > regions_tree.json
       ```

     * Authentication with an API key:
     
       ```bash
       curl \
         --request POST \
         --header "Authorization: Api-key <API_key>" \
         "https://searchapi.{{ api-host }}/v2/wordstat/getRegionsTree" \
         > regions_tree.json
       ```

   The result will be saved to the `regions_tree.json` file. 

   {% cut "Response fragment" %}

   ```json
   {
     "regions": [
       {
         "id": "225",
         "name": "Russia",
         "children": [
           {
             "id": "1",
             "name": "Moscow and Moscow Oblast",
             "children": [
               { "id": "213", "name": "Moscow" },
               { "id": "1", "name": "Moscow Oblast" }
             ]
           },
           {
             "id": "2",
             "name": "Saint Petersburg and Leningrad Oblast",
             "children": [
               { "id": "2", "name": "Saint Petersburg" }
             ]
           }
         ]
       }
     ]
   }
   ```

   {% endcut %}

- gRPC API {#grpc-api}
  
   The GetRegionsTree call does not require a key phrase for the search.

   Make a gRPC call by specifying the API key or IAM token you got earlier and your service account's [folder ID](../../resource-manager/operations/folder/get-id.md):
     
   * Authentication with an IAM token:
  
      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM_token>" \
        -d '{"folderId": "<folder_ID>"}' \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsTree \
        > regions_tree.json
      ```

   * Authentication with an API key:
  
      ```bash
      grpcurl \
        -rpc-header "Authorization: Api-Key <API_key>" \
        -d '{"folderId": "<folder_ID>"}' \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsTree \
        > regions_tree.json
      ```

   The result will be saved to the `regions_tree.json` file. 

   {% cut "Response fragment" %}

   ```json
   {
     "regions": [
       {
         "id": "225",
         "name": "Russia",
         "children": [
           {
             "id": "1",
             "name": "Moscow and Moscow Oblast",
             "children": [
               { "id": "213", "name": "Moscow" },
               { "id": "1", "name": "Moscow Oblast" }
             ]
           },
           {
             "id": "2",
             "name": "Saint Petersburg and Leningrad Oblast",
             "children": [
               { "id": "2", "name": "Saint Petersburg" }
             ]
           }
         ]
       }
     ]
   }
   ```

   {% endcut %}

{% endlist %}