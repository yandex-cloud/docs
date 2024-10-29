# Configuring an index policy in {{ mos-full-name }}


You can use [policies](../../managed-opensearch/concepts/index-policy.md) to automate certain operations on indexes. For example, to make your data more secure and available, you can set up a policy that will create a new index if at least one of these conditions is met:

* Index is over 50 GB in size.
* Index is over 30 days old.

To configure such a policy:

1. [Create a policy](#create-policy).
1. [Attach the policy to an index](#attach-policy).
1. [Test the policy](#check-policy).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

1. Prepare the infrastructure:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a {{ mos-name }} target cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in the configuration you need with public access to a group of hosts with the `DATA` role.

        1. If using security groups in your cluster, make sure they are configured correctly and allow connecting to the [{{ mos-name }}](../../managed-opensearch/operations/connect.md#configuring-security-groups) cluster.

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [opensearch-index-policy.tf](https://github.com/yandex-cloud-examples/yc-opensearch-index-policy/blob/main/opensearch-index-policy.tf) configuration file to the same working directory. The file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnet](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules required to connect to a {{ mos-name }} cluster.
            * {{ mos-name }} cluster.

        1. In the `opensearch-index-policy.tf` file, specify these variables:

            * `version`: {{ OS }} version.
            * `admin_password`: {{ OS }} admin password.

        1. Make sure the {{ TF }} configuration files are correct using this command:

            ```bash
            terraform validate
            ```

            If there are any errors in the configuration files, {{ TF }} will point them out.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Install an SSL certificate](../../managed-opensearch/operations/connect.md#ssl-certificate).

1. Check the connection to the cluster using [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_includes/mdb/mos/default-connstring.md) %}

    You can obtain the host FQDN with a [list of hosts in the cluster](../../managed-opensearch/operations/host-groups.md#list-hosts).

    A message like this is displayed if the connection is successful:

    ```bash
    {
      "name" : "....{{ dns-zone }}",
      "cluster_name" : "...",
      "cluster_uuid" : "...",
      "version" : {
      "distribution" : "opensearch",
      ...
      },
      "tagline" : "The OpenSearch Project: https://opensearch.org/"
    }
    ```

## Create a policy {#create-policy}

1. Create a policy to roll over an alias to a new index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
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
                                        "min_index_age": "1h",
                                        "min_primary_shard_size": "500b"
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

    Where:

    * `min_index_age`: Age an index must reach before a new index is created. The recommended value is 30 days (`30d`).
    * `min_primary_shard_size`: Size of one of the main index segments. As soon as this size is reached, a new index will be created. The recommended value is 50 GB (`50gb`).
    * `index_patterns`: Template for a new index name.

    To quickly test the policy, we reduced the recommended values to 1 hour and 500 bytes in the request example.

1. Configure an index template with the `log` alias assigned to the policy:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_index_template/ism_rollover?pretty' \
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

## Attach the policy to an index {#attach-policy}

1. Create the `log-000001` index with the `log` alias:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/log-000001?pretty' \
        --data '
            {
                "aliases": {
                    "log": {
                        "is_write_index": true
                    }
                }
            }'
    ```

1. Check if the policy is attached to the index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/_plugins/_ism/explain/log-000001?pretty'
    ```

    You will get a message like this in the results:

    ```bash
    {
      "log-000001" : {
        "index.plugins.index_state_management.policy_id" : "rollover_policy",
        "index.opendistro.index_state_management.policy_id" : "rollover_policy",
        "index" : "log-000001",
        "index_uuid" : "...",
        "policy_id" : "rollover_policy",
        "enabled" : true
      },
      "total_managed_indices" : 1
    }
    ```

## Test the policy {#check-policy}

1. Add a document to the index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request POST 'https://<address_of_{{ OS }}_host_with_DATA_role>:9200/log/_doc?pretty' \
        --data '
            {
                "num": "101",
                "name": "Valya",
                "age": "25"
            }'
    ```

1. Get a list of indexes five minutes after the document is created:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET '<address_of_{{ OS }}_host_with_DATA_role>:9200/_cat/indices?pretty'
    ```

    Five minutes is the default time to check policy conditions again.

    The output should display the `log-000001` and `log-000002` indexes:

    ```bash
    yellow open log-000001 ... 1 1 0 0 5.1kb 5.1kb
    yellow open log-000002 ... 1 1 0 0  208b  208b
    ```

1. Optionally, you can get the index list again one hour after [creating the index](#attach-policy).

    The output should display the `log-000001`, `log-000002`, and `log-000003` indexes:

    ```bash
    yellow open log-000001 ... 1 1 0 0 5.1kb 5.1kb
    yellow open log-000002 ... 1 1 0 0  208b  208b
    yellow open log-000003 ... 1 1 0 0    0b    0b
    ```

    One hour is the policy condition for creating a new index.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    1. In the terminal window, go to the directory containing the infrastructure plan.
    1. Delete the `opensearch-index-policy.tf` configuration file.
    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        If there are any errors in the configuration files, {{ TF }} will point them out.

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        All the resources described in the `opensearch-index-policy.tf` configuration file will be deleted.

{% endlist %}
