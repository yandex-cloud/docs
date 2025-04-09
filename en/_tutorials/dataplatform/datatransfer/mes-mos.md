# Migrating data from {{ ES }} to {{ mos-full-name }} using {{ data-transfer-full-name }}


You can set up data transfer from {{ ES }} to {{ mos-name }} indexes using {{ data-transfer-name }}. Proceed as follows:

1. [Set up the source cluster](#configure-source).
1. [Prepare the test data](#prepare-data).
1. [Configure the target cluster](#configure-target).
1. [Set up and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mos-name }} cluster fee: Using computing resources allocated to hosts (including hosts with the `MANAGER` role) and disk space (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. Set up your infrastructure:

    
    1. [Create a custom {{ ES }} installation]({{ links.es.docs }}/elasticsearch/reference/current/getting-started.html).

    1. [Enable access to the cluster from {{ yandex-cloud }}](../../../data-transfer/concepts/network.md#source-external).

    1. [Create a {{ mos-name }} target cluster](../../../managed-opensearch/operations/cluster-create.md) in any suitable configuration with publicly available hosts.


1. Install the utilities:

    * [curl](https://curl.se/) to make requests to clusters.

        ```bash
        sudo apt update && sudo apt install --yes curl
        ```

    * [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

        ```bash
        sudo apt update && sudo apt install --yes jq
        ```

## Set up the source cluster {#configure-source}


1. (Optional) Create a user to execute the transfer.

    You can provide data from the {{ ES }} cluster as the `admin` user with the `superuser` role; however, it is more secure to create separate users with limited privileges for each task.

    1. In the source cluster, [create a role]({{ links.es.docs }}/elasticsearch/reference/current/defining-roles.html) with the `create_index` and `write` [privileges]({{ links.es.docs }}/elasticsearch/reference/current/security-privileges.html#privileges-list-indices) for all indexes (`*`).

    1. In the source cluster, [create a user](../../../managed-elasticsearch/operations/cluster-users.md) to execute the transfer and assign the user the role you created.

## Prepare the test data {#prepare-data}

1. In the source cluster, create a test index named `people` and set its schema:

    ```bash
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ ES }}_host_with_Data_Node_role>:{{ port-mes }}/people' && \
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ ES }}_host_with_Data_Node_role>:{{ port-mes }}/people/_mapping?pretty' \
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
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ ES }}_host_with_Data_Node_role>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ ES }}_host_with_Data_Node_role>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Robert",
               "age" : "32"
         }
         '
    ```

1. (Optional) Check the data in the test index:

    ```bash
    curl --user <username_in_target_cluster>:<user_password_in_target_cluster> \
         --cacert ~/.elasticsearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ ES }}_host_with_Data_Node_role>:{{ port-mes }}/people/_search?pretty'
    ```

## Configure the target cluster {#configure-target}

1. [Get an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) to connect to the {{ mos-name }} cluster.

1. (Optional) Create a user to execute the transfer.

    You can provide data to the {{ mos-name }} cluster as the `admin` user with the `superuser` role; however, it is more secure to create separate users with limited privileges for each task.

    1. [Create a role]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) with the `create_index` and `write` privileges for all indexes (`*`).

    1. [Create a user](../../../managed-opensearch/operations/cluster-users.md) and assign this role to them.

## Set up and activate the transfer {#prepare-transfer}

1. [Create an endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the [{{ ES }} source](../../../data-transfer/operations/endpoint/source/elasticsearch.md).

1. [Create an endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the [{{ OS }} target](../../../data-transfer/operations/endpoint/target/opensearch.md).

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the endpoints you created.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait until its status switches to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mes-mos.tf` file, specify these variables:

            * `source_endpoint_id`: ID of the source endpoint.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: `1` to create a transfer.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait until its status switches to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    {% endlist %}

## Test the transfer {#verify-transfer}

Check that the {{ mos-name }} cluster's `people` index contains the data that was sent:

{% list tabs group=programming_language %}

- Bash {#bash}

    Run this command:

    ```bash
    curl --user <username_in_target_cluster>:<user_password_in_target_cluster> \
         --cacert ~/.opensearch/root.crt \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ OS }}_host_with_Data_Node_role>:{{ port-mos }}/people/_search?pretty'
    ```

- {{ OS }} Dashboards {#opensearch}

    1. [Connect](../../../managed-opensearch/operations/connect.md#dashboards) to the target cluster using {{ OS }} Dashboards.
    1. Select the `Global` tenant.
    1. Open the control panel by clicking ![os-dashboards-sandwich](../../../_assets/console-icons/bars.svg).
    1. Under **OpenSearch Dashboards**, select **Discover**.
    1. In the **CHANGE INDEX PATTERN** field, select the `people` index.

{% endlist %}

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../../../data-transfer/operations/endpoint/index.md#delete) for both the source and target.


1. [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).
1. [Delete the subnet](../../../vpc/operations/subnet-delete.md) and [network](../../../vpc/operations/network-delete.md).

