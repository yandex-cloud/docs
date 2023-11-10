1. Add the static access key information to the {{ ES }} [keystore]({{ links.es.docs }}/elasticsearch/reference/current/elasticsearch-keystore.html) (keystore).

   {% note info %}

   Run the procedure on all hosts of the source cluster.

   {% endnote %}

   Add the following:

   * **Key ID**:

      ```bash
      $ES_PATH/bin/elasticsearch-keystore add s3.client.default.access_key
      ```

   * **Secret key**:

      ```bash
      $ES_PATH/bin/elasticsearch-keystore add s3.client.default.secret_key
      ```

   {% note info %}

   The path to {{ ES }} (`$ES_PATH`) depends on the selected installation method. To find a path to your {{ ES }} installation, see the [installation documentation]({{ links.es.docs }}/elasticsearch/reference/current/install-elasticsearch.html) (for example, for [DEB]({{ links.es.docs }}/elasticsearch/reference/current/deb.html#deb-layout), [RPM]({{ links.es.docs }}/elasticsearch/reference/current/rpm.html#rpm-layout)).

   {% endnote %}

1. Upload the data from the keystore:

   ```bash
   curl --request POST "https://<IP_or_FQDN_of_source_cluster_DATA_host>:{{ port-mes }}/_nodes/reload_secure_settings"
   ```

1. Register the repository:

   ```bash
   curl --request PUT \
        "https://<IP_or_FQDN_of_source_cluster_DATA_host>:{{ port-mes }}/_snapshot/<repository_name>" \
        --header 'Content-Type: application/json' \
        --data '{
          "type": "s3",
          "settings": {
            "bucket": "<bucket_name>",
            "endpoint": "{{ s3-storage-host }}"
          }
        }'
   ```
