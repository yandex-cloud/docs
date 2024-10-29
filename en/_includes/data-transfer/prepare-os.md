* Make sure the number of columns in the source does not exceed the maximum number of fields in {{ OS }} indexes. The maximum number of fields is provided in the `index.mapping.total_fields.limit` parameter. Its default value is `1,000`.

   {% note warning %}

   Exceeding the limit will result in the `Limit of total fields [1000] has been exceeded` error and the transfer will be stopped.

   {% endnote %}

   To increase the parameter value, [set up a template](https://opensearch.org/docs/latest/im-plugin/index-templates/) that makes the maximum number of fields in new indexes equal to the specified value.

   {% cut "Sample template setup request" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request PUT "https://<URL_of_{{ OS }}_host_with_DATA_role>:9200/_template/index_defaults" \
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

   With this template setup, all new indexes with the `cdc*` mask will be able to contain up to `2,000` fields.

   {% endcut %}

   You can also set up templates using the [OpenSearch Dashboards interface](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).

   To check the current `index.mapping.total_fields.limit` parameter value, execute the following request:

   ```bash
   curl \
       --user <{{ OS }}_username>:<password> \
       --header 'Content-Type: application/json' \
       --request GET 'https://<URL_of_{{ OS }}_host_with_DATA_role>:9200/<index name>/_settings/*total_fields.limit?include_defaults=true'
   ```

* By default, when transferring data to a single index, only one host is used. To distribute the load across hosts when transferring large amounts of data, [set up a template](https://opensearch.org/docs/latest/im-plugin/index-templates/) to split new indexes into shards in advance.

   {% cut "Sample template setup request" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request PUT 'https://<URL_of_{{ OS }}_host_with_DATA_role>:9200/_template/index_defaults' \
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

   You can also set up templates using the [OpenSearch Dashboards interface](https://opensearch.org/docs/latest/dashboards/im-dashboards/component-templates/).

* To enhance data security and availability, set up a policy that will create a new index if at least one of the following conditions is met (recommended values):

   * Index is over 50 GB in size.
   * Index is over 30 days old.

   You can create and enable a policy using requests. For more information about policies, see the [{{ OS }} documentation]({{ os.docs }}/im-plugin/ism/policies/).

   {% cut "Example of a policy creation request" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_plugins/_ism/policies/rollover_policy' \
   --data '
       {
           "policy": {
               "description": "Example rollover policy",
               "default_state": "rollover",
               "schema_version": 1,
               "states": [
                   {
                       "name": "rollover",
                       "actions": [
                           {
                               "rollover": {
                                   "min_index_age": "30d",
                                   "min_primary_shard_size": "50gb"
                               }
                           }
                       ],
                       "transitions": []
                   }
               ],
               "ism_template": {
                   "index_patterns": ["log*"],
                   "priority": 100
               }
           }
       }'
   ```

   {% endcut %}

   {% cut "Example of a request to assign an alias to a policy" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_index_template/ism_rollover' \
   --data '
       {
           "index_patterns": ["log*"],
           "template": {
               "settings": {
                   "plugins.index_state_management.rollover_alias": "log"
               }
           }
       }'
   ```

   {% endcut %}

   {% cut "Example of a request to create an index with a policy alias" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/log-000001' \
   --data '
       {
           "aliases": {
               "log": {
                   "is_write_index": true
               }
           }
       }'
   ```

   {% endcut %}

   {% cut "Example of a request to check if a policy is attached to an index" %}

   ```bash
   curl \
   --user <{{ OS }}_username>:<password> \
   --header 'Content-Type: application/json' \
   --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_plugins/_ism/explain/log-000001?pretty'
   ```

   {% endcut %}
