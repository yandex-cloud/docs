# Copying data from {{ mos-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer data from a {{ mos-name }} source cluster to a {{ mgp-name }} target cluster.

To transfer data:

1. [Get your cloud ready](#prepare-cloud).
1. [Set up your infrastructure](#prepare-infrastructure).
1. [Prepare the test data](#prepare-data).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for {{ mos-name }} cluster computing resources and storage volume (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Fee for {{ mgp-name }} cluster computing resources, storage volume, and backups (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).


## Set up your infrastructure {#prepare-infrastructure}

{% list tabs group=instructions %}


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [opensearch-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-greenplum/blob/main/opensearch-to-greenplum.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network)
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) and rules required to connect to the {{ mos-name }} and {{ mgp-name }} clusters.
        * {{ mos-name }} source cluster with the `admin` user.
        * {{ mgp-name }} target cluster.
        * Transfer.

    1. In the `opensearch-to-greenplum.tf` file, specify the following settings:

        * `mos_cluster_name`: {{ mos-name }} cluster name.
        * `source_admin_password`: `admin` user password in {{ mos-name }} cluster.
        * `mgp_cluster_name`: {{ mgp-name }} cluster name.
        * `mgp_username`: Username in {{ mgp-name }} cluster.
        * `mgp_user_password`: User password in {{ mgp-name }} cluster.
        * `transfer_name`: {{ data-transfer-name }} transfer name.
        * `profile_name`: Your YC CLI profile name.

           {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. In the source cluster, create a test index named `people` and set its schema:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_mapping?pretty' -d'
         {
               "properties": {
                  "name": {"type": "text"},
                  "age": {"type": "integer"}
               }
         }
         '
    ```

1. Populate the test index with data:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' -d'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --cacert ~/.opensearch/root.crt \
         --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' -d'
         {
               "name": "Robert",
               "age": "32"
         }
         '
    ```

1. Make sure the data is saved in the test index:

    ```bash
    curl --cacert ~/.opensearch/root.crt \
         --user <username_in_target_cluster>:<user_password_in_target_cluster> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_search?pretty'
    ```
## Prepare and activate your transfer {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the {{ mos-name }} cluster you [created earlier](#before-you-begin) with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `OpenSearch`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.connection.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}**: Select a {{ mos-name }} cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: `admin`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: `admin` user password.

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the {{ mgp-name }} cluster you [created earlier](#before-you-begin), with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: Select a {{ mgp-name }} cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `postgres`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Enter a name for the {{ mgp-name }} cluster user.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter a password for the {{ mgp-name }} cluster user.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}** type that will use the created endpoints.
        1. [Activate](../../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `opensearch-to-greenplum.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            Once created, your transfer will be activated automatically.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data from the source {{ mos-name }} cluster has been migrated to the {{ mgp-name }} cluster:

   1. [Get an SSL certificate](../../../managed-greenplum/operations/connect.md#get-ssl-cert) to connect to the {{ mgp-name }} cluster.
   1. Install the dependencies:

      ```bash
      sudo apt update && sudo apt install --yes postgresql-client
      ```

   1. Connect to the database in the {{ mgp-name }} cluster.
   1. Make sure the database contains the `people` table with test data:

       ```sql
       SELECT * FROM people;
       ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

  - Manually {#manual}

      1. [Delete the {{ mos-name }}](../../../managed-opensearch/operations/cluster-delete.md) cluster.
      1. [Delete the {{ mgp-name }}](../../../managed-greenplum/operations/cluster-delete.md) cluster.
      
  - {{ TF }} {#tf}

      {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
