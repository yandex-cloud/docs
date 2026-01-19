# Получить список кодов всех регионов

Вызов [GetRegionsTree](../api-ref/grpc/Wordstat/getRegionsTree.md) позволяет получить все коды, которые использует Яндекс для определения региона поиска. Список наиболее часто используемых стран и регионов доступен в разделе [{#T}](../reference/regions.md).

{% include [preview-stage](../../_includes/preview-pp.md) %}

Чтобы воспользоваться примером, [создайте](../../ai-studio/operations/get-api-key.md#run-client) сервисный аккаунт с [ролью](../security/index.md#search-api-webSearch-user) `search-api.webSearch.user` и получите для него API-ключ с областью действия `yc.search-api.execute`. Также вы можете использовать [IAM-токен](../../iam/concepts/authorization/iam-token.md) как более безопасный способ. [Подробнее об аутентификации в {{ search-api-name }}](../api-ref/authentication.md).

{% list tabs group=instructions %}

- gRPC API {#grpc-api}
  
   Вызов GetRegionsTree не требует указания ключевой фразы для поиска.

   Выполните gRPC-вызов, указав полученный ранее API-ключ или IAM-токен и [идентификатор каталога](../../resource-manager/operations/folder/get-id.md) вашего сервисного аккаунта:
     
   * Аутентификация с IAM-токеном:
  
      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{"folderId": "<идентификатор_каталога>"}' \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsTree \
        > regions_tree.json
      ```

   * Аутентификация с API-ключом:
  
      ```bash
      grpcurl \
        -rpc-header "Authorization: Api-Key <API-ключ>" \
        -d '{"folderId": "<идентификатор_каталога>"}' \
        searchapi.{{ api-host }}:443 yandex.cloud.searchapi.v2.WordstatService/GetRegionsTree \
        > regions_tree.json
      ```

   Результат будет сохранен в файл `regions_tree.json`. 

   {% cut "Фрагмент ответа" %}

   ```json
   {
     "regions": [
       {
         "id": "225",
         "name": "Россия",
         "children": [
           {
             "id": "1",
             "name": "Москва и Московская область",
             "children": [
               { "id": "213", "name": "Москва" },
               { "id": "1", "name": "Московская область" }
             ]
           },
           {
             "id": "2",
             "name": "Санкт-Петербург и Ленинградская область",
             "children": [
               { "id": "2", "name": "Санкт-Петербург" }
             ]
           }
         ]
       }
     ]
   }
   ```

   {% endcut %}

{% endlist %}