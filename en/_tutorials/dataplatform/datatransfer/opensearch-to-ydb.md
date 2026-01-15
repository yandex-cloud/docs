# Migrating data from {{ mos-full-name }} to {{ ydb-full-name }} using {{ data-transfer-full-name }}


With {{ data-transfer-name }}, you can transfer data from a {{ mos-name }} cluster to a {{ ydb-name }} DB.

To transfer data:

1. [Prepare your test data](#prepare-data).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test your transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mos-name }} cluster: Use of computing resources and storage size (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).
* {{ ydb-name }} database (see [{{ ydb-name }} pricing](../../../ydb/pricing/index.md)). Its pricing is based on deployment mode:

    * In serverless mode, you pay for data operations and storage volume, including stored backups.
    * In dedicated instance mode, you pay for the use of computing resources allocated to the database, storage size, and backups.


## Getting started {#before-you-begin}

Set up the infrastructure:

{% list tabs group=instructions %}

* Manually {#manual}

    1. [Create a {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-create.md) in any suitable configuration with publicly available hosts.

    1. If using security groups, make sure they are configured correctly and allow connections to your [{{ mos-name }} cluster](../../../managed-opensearch/operations/connect.md#configuring-security-groups).

    1. [Get an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) to connect to the {{ mos-name }} cluster.

    1. [Create a {{ ydb-name }} database](../../../ydb/operations/manage-databases.md) named `ydb1` with your preferred configuration.

    
    1. [Create a service account](../../../iam/operations/sa/create.md#create-sa) `ydb-account` with the `ydb.editor` role. The transfer will use it to access the database.


* Using {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [opensearch-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-opensearch-to-ydb/blob/main/opensearch-to-ydb.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) and rules for internet access to the {{ mos-name }} cluster.
        * {{ ydb-name }} database.
        * Target {{ mos-name }} cluster.
        * Target endpoint.
        * Transfer.

    1. In the `opensearch-to-ydb.tf` file, specify the following settings:

        * `mos_version`: {{ OS }} version.
        * `mos_password`: {{ OS }} database owner’s password.
        * `profile_name`: Name of your CLI profile. 

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Prepare your test data {#prepare-data}

1. [Connect to the source {{ mos-name }} cluster](../../../managed-opensearch/operations/connect.md).

1. Create a test index named `people` and set its schema:

    ```bash
    curl --user admin:<password> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people' && \
    curl --user admin:<password> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_mapping?pretty' \
         --data'
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
    curl --user admin:<password> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user admin:<password> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Robert",
               "age" : "32"
         }
         '
    ```

1. Optionally, check the data in the test index:

    ```bash
    curl --user admin:<password> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_search?pretty'
    ```

## Set up and activate the transfer {#prepare-transfer}

1. Create an `{{ OS }}`-type [source endpoint](../../../data-transfer/operations/endpoint/source/opensearch.md#endpoint-settings) with the following settings:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.connection_type.title }}**: `{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnectionType.mdb_cluster_id.title }}**: Select the {{ mos-name }} cluster from the list.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.user.title }}**: `admin`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.opensearch.console.form.opensearch.OpenSearchConnection.password.title }}**: `<user_password>`.

1. Create a target endpoint and set up the transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a `{{ ydb-short-name }}` target endpoint](../../../data-transfer/operations/endpoint/target/yandex-database.md#endpoint-settings) with the following settings:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}**: Select your `ydb1` database from the list.

            
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}**: Select the `ydb-account` service account from the list.


        1. [Create](../../../data-transfer/operations/transfer.md#create) a **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_**-type transfer configured to use the new endpoints.

        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    - Using {{ TF }} {#tf}

        1. In the `opensearch-to-ydb.tf` file, specify the following settings:

            * `source_endpoint_id`: Source endpoint ID.
            * `transfer_enabled`: `1` to create a target endpoint and a transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. The transfer will activate automatically upon creation. Wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. [Connect to the {{ ydb-name }} database](../../../ydb/operations/connection.md).

1. Run this query:

    ```sql
    SELECT * FROM people;
    ```

    {% cut "Response example" %}

    ```text
    # |          _id           | age | name
    --+------------------------+-----+---------
    0 | "5wn5BJEBRVOYnL8d13sP" | 30  | "Alice"
    1 | "6An5BJEBRVOYnL8d13uy" | 32  | "Robert"
    ```

    {% endcut %}

## Delete the resources you created {#clear-out}

{% note info %}

Before deleting the resources, [deactivate the transfer](../../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

To reduce the consumption of resources you do not need, delete them:

1. Delete the resources depending on how you created them:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
        1. [Delete the target endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
        1. [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).
        1. [Delete the {{ ydb-name }} database](../../../ydb/operations/manage-databases.md#delete-db).

        
        1. [Delete the service account](../../../iam/operations/sa/delete.md).


    - Using {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}

1. [Delete the source endpoint](../../../data-transfer/operations/endpoint/index.md#delete).
