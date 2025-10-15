# Copying data from {{ mos-full-name }} to {{ mgp-full-name }} using {{ data-transfer-full-name }}

With {{ data-transfer-name }}, you can transfer data from a {{ mos-name }} source cluster to a {{ mgp-name }} target cluster.

To transfer data:

1. [Get your cloud ready](#prepare-cloud).
1. [Set up your infrastructure](#prepare-infrastructure).
1. [Prepare the test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for {{ mos-name }} cluster computing resources and storage volume (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Fee for {{ mgp-name }} cluster computing resources, storage volume, and backups (see [{{ mgp-name }} pricing](../../../managed-greenplum/pricing/index.md)).


## Set up the infrastructure {#prepare-infrastructure}

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a {{ mos-name }}](../../../managed-opensearch/operations/cluster-create.md#create-cluster) source cluster with your preferred configuration, ensuring its hosts are publicly accessible.
    1. In the same [availability zone](../../../overview/concepts/geo-scope.md), [create a {{ mgp-name }}](../../../managed-greenplum/operations/cluster-create.md#create-cluster) target cluster in any suitable configuration. When creating a cluster:
        * Enable public access for the hosts.
        * Enable **Data Transfer access**.
    1. [Obtain an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) for secure access to the {{ mos-name }} cluster.
    1. Make sure [{{ mos-name }}](../../../managed-opensearch/operations/connect.md#security-groups) and [{{ mgp-name }}](../../../managed-greenplum/operations/connect.md#configuring-security-groups) cluster security groups allow inbound internet traffic.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [opensearch-to-greenplum.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-greenplum/blob/main/opensearch-to-greenplum.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) and rules allowing inbound connections to the {{ mos-name }} and {{ mgp-name }} clusters.
        * {{ mos-name }} source cluster and its `admin` account.
        * {{ mgp-name }} target cluster.
        * Transfer.

    1. In the `opensearch-to-greenplum.tf` file, specify the following settings:

        * `mos_cluster_name`: {{ mos-name }} cluster name.
        * `source_admin_password`: {{ mos-name }} cluster `admin` password.
        * `mgp_cluster_name`: {{ mgp-name }} cluster name.
        * `mgp_username`: {{ mgp-name }} cluster username.
        * `mgp_user_password`: {{ mgp-name }} cluster user password.
        * `transfer_name`: {{ data-transfer-name }} transfer name.
        * `profile_name`: Your YC CLI profile name.

           {% include [cli-install](../../../_includes/cli-install.md) %}

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare the test data {#prepare-data}

1. In the source cluster, create a test index named `people` and define its mapping:

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

## Set up and activate the transfer {#prepare-transfer}

1. [Create a source endpoint](../../../data-transfer/operations/endpoint/index.md#create) for your [pre-configured](#before-you-begin) {{ mos-name }} cluster using the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `OpenSearch`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchSource.connection.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}**: Select your {{ mos-name }} cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: `admin`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: `admin` password.

1. [Create a target endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the {{ mgp-name }} cluster you [created earlier](#before-you-begin), with the following settings:

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}**: `Greenplum`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumTarget.title }}**:
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.connection_type.title }}**: Select `{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnectionType.mdb_cluster_id.title }}**: Select your {{ mgp-name }} cluster from the list.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.database.title }}**: `postgres`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.user.title }}**: Enter the {{ mgp-name }} cluster username.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.greenplum.console.form.greenplum.GreenplumConnection.password.title }}**: Enter the {{ mgp-name }} cluster user password.

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. Create a **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}**-type [transfer](../../../data-transfer/operations/transfer.md#create) and configure it to use the previously created endpoints.
        1. [Activate](../../../data-transfer/operations/transfer.md#activate) the transfer.

    - {{ TF }} {#tf}

        1. In the `opensearch-to-greenplum.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            The transfer will activate automatically upon creation.

    {% endlist %}

## Test your transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Make sure the data from the source {{ mos-name }} cluster has been migrated to the {{ mgp-name }} cluster:

   1. [Obtain an SSL certificate](../../../managed-greenplum/operations/connect.md#get-ssl-cert) for secure access to the {{ mgp-name }} cluster.
   1. Install the dependencies:

      ```bash
      sudo apt update && sudo apt install --yes postgresql-client
      ```

   1. Connect to the database in the {{ mgp-name }} cluster.
   1. Verify that the database contains the `people` table populated with test data:

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
