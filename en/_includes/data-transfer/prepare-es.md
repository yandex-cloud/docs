* Make sure the number of columns in the source does not exceed the maximum number of fields in {{ ES }} indexes. The maximum number of fields is provided in the `index.mapping.total_fields.limit` [parameter](https://www.elastic.co/guide/en/elasticsearch/reference/current/mapping-settings-limit.html#mapping-settings-limit); the default value is `1000`.

   To increase the parameter value, [set up a template](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template) that makes the maximum number of fields in new indexes equal to the specified value.

   {% cut "Sample template setup request" %}

   ```bash
   curl \
       --user <{{ ES }} username>:<password> \
       --header 'Content-Type: application/json' \
       --request PUT "https://<{{ ES }} cluster FQDN>:9200/_template/index_defaults" \
       --data '
           {
               "index_patterns": "cdc*",
               "settings": {
                   "index": {
                       "mapping": {
                           "total_fields": {
                               "limit": "2000"
                           }
                       }
                   }
               }
           }'
   ```

   With this template setup, all new indexes with the `cdc*` mask may contain up to `2000` fields.

   {% endcut %}

   You can also set up templates using the [Kibana interface](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).

   To check the current `index.mapping.total_fields.limit` parameter value, use the [Kibana interface](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#view-edit-indices) or execute the following request:

   ```bash
   curl \
       --user <{{ ES }} username>:<password> \
       --header 'Content-Type: application/json' \
       --request GET 'https://<{{ ES }} cluster FQDN>:9200/<index name>/_settings/*total_fields.limit?include_defaults=true'
   ```

* By default, when transferring data to a single index, only one host is used. To distribute the load across hosts when transferring large amounts of data, [set up a template](https://www.elastic.co/guide/en/elasticsearch/reference/current/indices-put-template.html#indices-put-template) to split new indexes into shards in advance.

   {% cut "Sample template setup request" %}

   ```bash
   curl \
       --user <{{ ES }} username>:<password> \
       --header 'Content-Type: application/json' \
       --request PUT 'https://<{{ ES }} cluster FQDN>:9200/_template/index_defaults' \
       --data '
           {
               "index_patterns": "cdc*",
               "settings" : {
                   "index" : {
                       "number_of_shards" : 15,
                       "number_of_replicas" : 1
                   }
               }
           }'
   ```

   {% endcut %}

   With this template setup, all new indexes with the `cdc*` mask will be split into `15` shards.

   You can also set up templates using the [Kibana interface](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-mgmt.html#manage-index-templates).
