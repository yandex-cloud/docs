# Migrating data from {{ OS }} to {{ mos-full-name }} using {{ data-transfer-full-name }}


{{ data-transfer-name }} enables you to transfer data from a third-party {{ OS }} source cluster's indexes to {{ mos-name }} indexes. Follow these steps:

1. [Configure the source cluster](#configure-source).
1. [Prepare your test data](#prepare-data).
1. [Configure the target cluster](#configure-target).
1. [Prepare and activate your transfer](#prepare-transfer).
1. [Test the transfer](#verify-transfer).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources}

* {{ mos-name }} cluster: use of computing resources, storage and backup size (see [{{ mos-name }} pricing](../../../managed-opensearch/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).


## Getting started {#before-you-begin}

1. [Enable access to the {{ OS }} source cluster from {{ yandex-cloud }}](../../../data-transfer/concepts/network.md#source-external).

1. Create a {{ mos-name }} target cluster:

    {% list tabs group=instructions %}

    - Manually {#manual}

        [Create a {{ mos-name }} target cluster](../../../managed-opensearch/operations/cluster-create.md) in any suitable configuration with publicly accessible hosts.

        {% include [public-access](../../../_includes/mdb/note-public-access.md) %}

    - {{ TF }} {#tf}

        1. {% include [terraform-install](../../../_includes/terraform-install.md) %}
        1. Download the [file with provider settings](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf). Place it in a separate working directory and specify the parameter values.
        1. Download the [data-transfer-os-mos.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-opensearch-from-onprem-to-cloud/blob/main/data-transfer-os-mos.tf) configuration file to your current working directory.

            This file describes:

            * [Network](../../../vpc/concepts/network.md#network).
            * [Subnet](../../../vpc/concepts/network.md#subnet).
            * [Security group](../../../vpc/concepts/security-groups.md) and rules for connecting to a {{ mos-name }} cluster.
            * {{ mos-name }} target cluster.
            * Transfer.

        1. In `data-transfer-os-mos.tf`, specify the following variables:

            * `mos_version`: {{ OS }} version.
            * `mos_admin_password`: {{ mos-name }} admin password.
            * `transfer_enabled`: Set to `0` to prevent a transfer from being created before [endpoints are created manually](#prepare-transfer).
            * `profile_name`: Name of your CLI profile.

              {% include [cli-install](../../../_includes/cli-install.md) %}

        1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration file, making its resources and data sources available for use.
        1. Validate your {{ TF }} configuration using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. Install these tools:

    * [curl](https://curl.se/) to make requests to clusters.

        ```bash
        sudo apt update && sudo apt install --yes curl
        ```

    * [jq](https://stedolan.github.io/jq/): For stream processing of JSON files.

        ```bash
        sudo apt update && sudo apt install --yes jq
        ```

## Configure the source cluster {#configure-source}

Create a user to run the transfer.

While you can deliver data from an {{ OS }} cluster as `admin` with the `superuser` role, it is safer to create a separate user with limited privileges for each task.

1. Optionally, in the source cluster, [create a role]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) with the `create_index` and `write` privileges for all indexes (`*`).

1. Optionally, in the source cluster, [create a user]({{ os.docs }}/security-plugin/access-control/users-roles) to run the transfer and assign them the role you created.

## Prepare your test data {#prepare-data}

1. In the source cluster, create a test index named `people` and define its schema:

    ```bash
    curl --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people' && \
    curl --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
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
    curl --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Alice",
               "age": "30"
         }
         ' && \
    curl --user <user_name_in_source_cluster>:<user_password_in_source_cluster> \
         --header 'Content-Type: application/json' \
         --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_doc/?pretty' \
         --data'
         {
               "name": "Robert",
               "age": "32"
         }
         '
    ```

1. Optionally, check the data in the test index:

    ```bash
    curl --user <user_name_in_target_cluster>:<user_password_in_target_cluster> \
         --header 'Content-Type: application/json' \
         --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_search?pretty'
    ```

## Configure the target cluster {#configure-target}

1. [Obtain an SSL certificate](../../../managed-opensearch/operations/connect/index.md#ssl-certificate) required to connect to the {{ mos-name }} cluster.

1. Optionally, create a user to run the transfer.

    While you can deliver data to a {{ mos-name }} cluster as `admin` with the `superuser` role, it is safer to create a separate user with limited privileges for each task.

    1. [Create a role]({{ os.docs }}/security-plugin/access-control/users-roles/#create-roles) with the `create_index` and `write` privileges for all indexes (`*`).

    1. [Create a user](../../../managed-opensearch/operations/cluster-users.md) and assign this role to them.

## Prepare and activate a transfer {#prepare-transfer}

1. [Create an endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the [{{ OS }} source cluster](../../../data-transfer/operations/endpoint/source/opensearch.md#on-premise).

1. [Create an endpoint](../../../data-transfer/operations/endpoint/index.md#create) for the [{{ mos-name }} target cluster](../../../data-transfer/operations/endpoint/target/opensearch.md).

1. Create a transfer:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a transfer](../../../data-transfer/operations/transfer.md#create) of the **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot.title }}_** type that will use the endpoints you created.
        1. [Activate the transfer](../../../data-transfer/operations/transfer.md#activate).

    - {{ TF }} {#tf}

        1. In `data-transfer-os-mos.tf`, specify the following variables:

            * `source_endpoint_id`: Source endpoint ID.
            * `target_endpoint_id`: Target endpoint ID.
            * `transfer_enabled`: Set to `1` to create the transfer.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

            Once created, the transfer becomes active automatically.

    {% endlist %}

## Test the transfer {#verify-transfer}

1. Wait for the transfer status to change to **{{ ui-key.yacloud.data-transfer.label_connector-status-DONE }}**.
1. Check that the {{ mos-name }} cluster's `people` index contains the data you sent:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      Run this command:

      ```bash
      curl --user <user_name_in_target_cluster>:<user_password_in_target_cluster> \
           --cacert ~/.opensearch/root.crt \
           --header 'Content-Type: application/json' \
           --request GET 'https://<FQDN_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/people/_search?pretty'
      ```

    - {{ OS }} Dashboards {#opensearch}

      1. [Connect](../../../managed-opensearch/operations/connect/clients.md#dashboards) to the target cluster via {{ OS }} Dashboards.
      1. Select the `Global` tenant.
      1. Open the management panel by clicking ![os-dashboards-sandwich](../../../_assets/console-icons/bars.svg).
      1. Under **OpenSearch Dashboards**, select **Discover**.
      1. In the **CHANGE INDEX PATTERN** field, select the `people` index.

    {% endlist %}

## Delete the resources you created {#clear-out}

To reduce resource usage, delete the resources you no longer need:

1. [Delete the transfer](../../../data-transfer/operations/transfer.md#delete).
1. [Delete the source and target endpoints](../../../data-transfer/operations/endpoint/index.md#delete).
1. Delete other resources, applying the same method used for their creation:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Delete the {{ mos-name }} cluster](../../../managed-opensearch/operations/cluster-delete.md).

        1. [Delete the subnet](../../../vpc/operations/subnet-delete.md) and [network](../../../vpc/operations/network-delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
