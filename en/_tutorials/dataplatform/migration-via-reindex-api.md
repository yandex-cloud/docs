# Migrating to {{ mes-full-name }} using the Reindex API

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

{{ mes-name }} clusters support _reindexing_ via the [Reindex API]({{ links.es.reindex-api }}). You can specify another {{ ES }} cluster as your data reindexing source. This type of reindexing is referred to as _remote_. It can be used to move existing indexes, aliases, or data streams from a third party _source_ to a {{ mes-name }} _target cluster_.

To migrate data from the source cluster in {{ ES }} to the target cluster in {{ mes-name }}:

1. [Configure the target cluster](#configure-target).
1. [Start reindexing](#reindex).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Create a [{{ mes-name }} target cluster](../../managed-elasticsearch/operations/cluster-create.md) with any suitable [configuration](../../managed-elasticsearch/concepts/instance-types.md).

   Enable cluster host access via public IPs.

   {% note warning %}

   The {{ ES }} version on the target cluster must be the same as or higher than on the source cluster.

   {% endnote %}

1. Make sure you can [connect to the {{ mes-name }} target cluster](../../managed-elasticsearch/operations/cluster-connect.md) using the {{ ES }} API and Kibana.

1. Make sure the {{ ES }} source cluster can access the internet.

1. If a source cluster is using a self-signed certificate to encrypt the connection, [add it as an extension](../../managed-elasticsearch/operations/cluster-extensions.md#add) to the target cluster.

1. Create a user with the `monitoring_user` and the `viewer` roles in the target cluster.

## Configure the target cluster {#configure-target}

1. [Create a role](https://www.elastic.co/guide/en/kibana/current/xpack-security.html#_roles_2) with the `create_index` and `write` privileges for all indexes (`*`).

1. [Create a user](../../managed-elasticsearch/operations/cluster-users.md) and assign the user this role.

   {% note tip %}

   In {{ mes-name }} clusters, you can use the Reindex API as the `admin` user with the `superuser` role, but it is more secure to create separate users with limited privileges for each task. For more information, see [{#T}](../../managed-elasticsearch/operations/cluster-users.md).

   {% endnote %}

1. [Update DBMS settings](../../managed-elasticsearch/operations/cluster-update.md#change-elasticsearch-config):

   * **Reindex remote whitelist**: Specify the source cluster IP or FQDN, such as:

      ```ini
      192.168.0.1:9200, example.com:9200
      ```

   * (Optional) **Reindex SSL CA path**: Specify the local path to the imported certificate as `/etc/elasticsearch/extensions/<extension_name>/<certificate_name>`.

## Start reindexing {#reindex}

1. [Retrieve the list of hosts](../../managed-elasticsearch/operations/cluster-hosts.md#list-hosts) in the target cluster.

1. To start reindexing, run a request against the target cluster's host with the _Master node_ role:

   ```bash
   curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
        --request POST "https://<IP_or_FQDN_of_target_cluster_Master_Node_host>:9200/_reindex?pretty" \
        --header 'Content-Type: application/json' \
        --data '{
          "source": {
            "remote": {
              "host": "https://<IP_or_FQDN_of_source_cluster_Master_Node_host>:9200",
              "username": "<username_in_the_source_cluster>",
              "password": "<user_password_in_the_source_cluster>"
            },
            "index": "<source_cluster_index_alias_or_data_stream_name>"
          },
          "dest": {
            "index": "<target_cluster_index_alias_or_data_stream_name>"
          }
        }'
   ```

   To transfer several indexes, use a `for` loop:

   ```bash
   for index in <space-separated_list_of_index_alias_or_data_stream_names>; do
     curl --user <username_in_the_target_cluster>:<user_password_in_the_target_cluster> \
          --request POST "https://<target_cluster_Mater_Node_IP_or_FQDN>:9200/_reindex?pretty" \
          --header 'Content-Type: application/json' \
          --data '{
            "source": {
              "remote": {
                "host": "https://<source_cluster_Mater_Node_IP_or_FQDN>:9200",
                "username": "<username_in_the_source_cluster>",
                "password": "<user_password_in_the_source_cluster>"
              },
              "index": "'$index'"
            },
            "dest": {
              "index": "'$index'"
            }
          }'
   done
   ```

## Delete the resources you no longer need {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* If you reserved public static IPs for cluster access, release and [delete them](../../vpc/operations/address-delete.md).
* If you used a {{ objstorage-full-name }} bucket to import a self-signed certificate, [clear](../../storage/operations/objects/delete-all.md) and [delete](../../storage/operations/buckets/delete.md) it.
