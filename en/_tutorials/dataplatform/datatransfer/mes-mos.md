# Migrating data from {{ ES }} to {{ mos-full-name }} using {{ data-transfer-full-name }}


You can set up data transfer from {{ ES }} to {{ mos-name }} indexes using {{ data-transfer-name }}. To do this:

1. [Set up the source cluster](#configure-source).
1. [Prepare the test data](#prepare-data).
1. [Configure the target cluster](#configure-target).
1. [Set up and activate the transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

The support cost includes:

* {{ mos-name }} cluster fee: Using computing resources allocated to hosts (including hosts with the `MANAGER` role) and disk space (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Fee for using public IP addresses for cluster hosts (see [{{ vpc-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. [Create a custom {{ ES }} installation]({{ links.es.docs }}/elasticsearch/reference/current/getting-started.html).
1. [Enable access to the cluster from {{ yandex-cloud }}](../../../data-transfer/concepts/network.md#source-external).
1. Create a {{ mos-name }} target cluster:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Create a {{ mos-name }} target cluster](../../../managed-opensearch/operations/cluster-create.md) in any suitable configuration with publicly available hosts.

    - {{ TF }} {#tf}

        1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
        1. Download the [file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and specify the parameter values.
        1. Download the [data-transfer-es-mos.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-elasticsearch-to-opensearch/blob/main/data-transfer-es-mos.tf) configuration file to your current working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mos-name }} cluster.
            * {{ mos-name }} target cluster.
            * Transfer.

        1. In the `data-transfer-es-mos.tf` file, specify the following variables:

            * `mos_version`: {{ OS }} version.
            * `mos_admin_password`: {{ mos-name }} admin user password.
            * `transfer_enabled`: Set to `0` to ensure that no transfer is created until you [create endpoints manually](#prepare-transfer).

        1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use its resources and data sources.
        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Install the following tools:

    * [curl](https://curl.se/) to make requests to clusters.

        ```bash
        sudo apt update && sudo apt install --yes curl
        ```

    * [jq](https://stedolan.github.io/jq/) for JSON file stream processing.

        ```bash
        sudo apt update && sudo apt install --yes jq
        ```

## Set up the source cluster {#configure-source}


You can provide data from the {{ ES }} cluster as the `admin` user with the `superuser` role; however, it is more secure to create separate users with limited privileges for each task. To do this, create a user to execute the transfer:

1. In the source cluster, [create a role]({{ links.es.docs }}/elasticsearch/reference/current/defining-roles.html) with the `create_index` and `write` [privileges]({{ links.es.docs }}/elasticsearch/reference/current/security-privileges.html#privileges-list-indices) for all indexes (`*`).

1. In the source cluster, create a user to run the transfer and assign the user the role you created.

## Prepare the test data {#prepare-data}

1. In the source cluster, create a test index named `people` and define its mapping:

    ```bash
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ ES }}_host_with_Data_role>:{{ port-mes }}/people' && \
    curl --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ ES }}_host_with_Data_role>:{{ port-mes }}/people/_mapping?pretty' \
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
    curl --user <source_cluster_username>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ ES }}_host_with_Data_role>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Alice",
               "age" : "30"
         }
         ' && \
    curl --user <username_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ ES }}_host_with_Data_role>:{{ port-mes }}/people/_doc/?pretty' \
         --data'
         {
               "name" : "Robert",
               "age" : "32"
         }
         '
    ```

1. Optionally, check the data in the test index:

    ```bash
    curl --user <username_in_target_cluster>:<user_password_in_target_cluster> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ ES }}_host_with_Data_role>:{{ port-mes }}/people/_search?pretty'
    ```

## Configure the target cluster {#configure-target}

1. [Obtain an SSL certificate](../../../managed-opensearch/operations/connect.md#ssl-certificate) for secure access to the {{ mos-name }} cluster.

1. Optionally, create a user to execute the transfer.

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
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

    - {{ TF }} {#tf}

        1. In the `data-transfer-mes-mos.tf` file, specify the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: ID of the target endpoint.
            * `transfer_enabled`: `1` (create a transfer).

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate) and wait for its status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.

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
1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete other resources using the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
