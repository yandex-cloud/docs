# Configuring a cold storage policy in {{ mos-full-name }}


You can use [policies](../../managed-opensearch/concepts/index-policy.md) to automate some operations with indexes. For example, to optimize the use of storage, you can set a policy that will move _cold_ data to a specific host group and then repack that data using a [codec](../../managed-opensearch/concepts/indexing.md#codecs) with a higher compression ratio.

To configure such a policy:

1. [Get your cloud ready](#before-you-begin).
1. [Set up your infrastructure](#infrastructure-prepare).
1. [Create a policy](#create-policy).
1. [Attach the policy to an index](#attach-policy).
1. [Test the policy](#check-policy).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

* {{ mos-name }} cluster, which includes the use of computing resources and storage size (see [{{ mos-name }} pricing](../../managed-opensearch/pricing.md)).
* Public IP addresses (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


## Set up your infrastructure {#infrastructure-prepare}

1. Prepare a {{ mos-name }} cluster:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [Create a {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-create.md#create-cluster) in any suitable configuration with the following settings:

            * Two or more host groups with the `DATA` role. Give two groups the names `hot` and `cold`.
            * Public access to any host group.

        1. If there are security groups in your cluster, make sure they allow connections to the [{{ mos-name }}](../../managed-opensearch/operations/connect/index.md#configuring-security-groups).

    - Using {{ TF }} {#tf}

        1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
        1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
        1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
        1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

        1. Download the [opensearch-cold-storage-policy.tf](https://github.com/yandex-cloud-examples/yc-opensearch-cold-storage-policy/blob/main/opensearch-cold-storage-policy.tf) configuration file to the same working directory. This file describes:

            * [Network](../../vpc/concepts/network.md#network).
            * [Subnets](../../vpc/concepts/network.md#subnet).
            * [Security group](../../vpc/concepts/security-groups.md) and rules for connection to a {{ mos-name }} cluster.
            * {{ mos-name }} cluster.

        1. In the `opensearch-cold-storage-policy.tf` file, specify the following variables:

            * `version`: {{ OS }} version.
            * `admin_password`: {{ OS }} admin password.

        1. Validate your {{ TF }} configuration files using this command:

            ```bash
            terraform validate
            ```

            {{ TF }} will display any configuration errors detected in your files.

        1. Create the required infrastructure:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

    {% endlist %}

1. [Install an SSL certificate](../../managed-opensearch/operations/connect/index.md#ssl-certificate).

1. Check the connection to the cluster using [cURL](https://curl.haxx.se/):

    {% include [default-connstring](../../_tutorials/_tutorials_includes/opensearch/check-connection.md) %}

## Create a policy {#create-policy}

Create a policy that turns _hot_ data to _cold_ followed by archiving:

```bash
curl \
    --user admin:<password> \
    --cacert ~/.opensearch/root.crt \
    --header 'Content-Type: application/json' \
    --request PUT 'https://<{{ OS }}_host_address_with_public_access>:9200/_plugins/_ism/policies/archive_policy' \
    --data '
        {
            "policy": {
                "description": "Example archive policy",
                "default_state": "hot",
                "schema_version": 1,
                "states": [
                    {
                        "name": "hot",
                        "actions": [
                            {
                                "allocation": {
                                    "require": { "groupname": "hot" }
                                }
                            }
                        ],
                        "transitions": [
                            {
                                "state_name": "cold",
                                "conditions": {
                                    "min_index_age": "1h"
                                }
                            }
                        ]
                    },
                    {
                        "name": "cold",
                        "actions": [
                            {
                                "allocation": {
                                    "require": { "groupname": "cold" }
                                }
                            }
                        ],
                        "transitions": [
                            {
                                "state_name": "archive",
                                "conditions": {
                                    "min_index_age": "2h"
                                }
                            }
                        ]
                    },
                    {
                        "name": "archive",
                        "actions": [
                            {
                                "repack": {
                                    "new_codec": "lzma"
                                }
                            }
                        ]
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

* `min_index_age`: Index age that triggers creation of a new index. The recommended value is 30 days (`30d`).
* `index_patterns`: Template for a new index name.
* `new_codec`: Name of the codec to repack the data.

For a quick test of the policy, the request example has the following `min_index_age` settings:
* For `hot`: 1 hour. After this time elapses, the data will turn _cold_.
* For `cold`: 2 hours. After this time elapses, the data will be repacked by the `lzma` codec (archiving).

You can specify smaller values but not less than five minutes: this is the default time after which the policy conditions are checked again.

## Attach the policy to an index {#attach-policy}

1. Create the `log-000001` index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request PUT 'https://<{{ OS }}_host_address_with_public_access>:9200/log-000001?pretty' \
        --data '
            {
                "settings": {
                    "index" : {
                        "routing" : {
                            "allocation" : {
                                "require" : {
                                    "groupname" : "hot"
                                }
                            }
                        }
                    }
                }
            }'
    ```

1. Check whether the policy is attached to the index:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_plugins/_ism/explain/log-000001?pretty'
    ```

    You will get a message similar to the following:

    ```bash
    {
      "log-000001" : {
        "index.plugins.index_state_management.policy_id" : "archive_policy",
        "index.opendistro.index_state_management.policy_id" : "archive_policy",
        "index" : "log-000001",
        "index_uuid" : "...",
        "policy_id" : "archive_policy",
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
        --request POST 'https://<{{ OS }}_host_address_with_public_access>:9200/log-000001/_doc?pretty' \
        --data '
            {
                "num": "101",
                "name": "Valya",
                "age": "25"
            }'
    ```

1. Get a list of index shards five minutes after the document is created:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_cat/shards/log-000001?pretty'
    ```

    The results will display the shards of the `log-000001` index and the addresses of the hosts the shards reside on:

    ```bash
    log-000001 0 r STARTED 1 5.2kb 10.2.0.35 rc1b-lgio8pjp********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 5.2kb 10.1.0.4  rc1a-g36ksm4q********.mdb.yandexcloud.net 
    ```

1. Make sure the shard is located in the host group named `hot`. To do this, get a list of hosts with these attributes:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_cat/nodeattrs/?v&h=node,attr,value&pretty'
    ```

    The results will contain the following lines:

    ```bash
    node                                       attr       value
    rc1b-lgio8pjp********.mdb.yandexcloud.net  groupname  hot
    rc1a-g36ksm4q********.mdb.yandexcloud.net  groupname  hot
    ...
    ```

1. Get a list of shards for the `log-000001` index again one hour after [creating the index](#attach-policy):

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_cat/shards/log-000001?pretty'
    ```

    One hour is the policy condition for moving the index to the host group named `cold`.

    The results will display the shards of the `log-000001` index and the new addresses of the hosts the shards reside on:

    ```bash
    log-000001 0 r STARTED 1 5.2kb 10.2.0.22 rc1b-is77nbdv********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 5.2kb 10.1.0.25 rc1a-qocaisq1********.mdb.yandexcloud.net
    ```

1. Re-request a list of hosts with these attributes:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_cat/nodeattrs/?v&h=node,attr,value&pretty'
    ```

    The results will contain the following lines:

    ```bash
    node                                       attr       value
    rc1b-is77nbdv********.mdb.yandexcloud.net  groupname  cold
    rc1a-qocaisq1********.mdb.yandexcloud.net  groupname  cold
    ...
    ```

1. Another hour later, get a list of shards for the `log-000001` index again:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/_cat/shards/log-000001?pretty'
    ```

    Two hours is the policy condition for applying the new codec (transfer to archive).

    The results will display the shards of the `log-000001` index and the addresses of the hosts the shards reside on:

    ```bash
    log-000001 0 r STARTED 1 4.8kb 10.2.0.22 rc1b-is77nbdv********.mdb.yandexcloud.net
    log-000001 0 p STARTED 1 4.8kb 10.1.0.25 rc1a-qocaisq1********.mdb.yandexcloud.net 
    ```

    The shards will now be smaller because the data was repacked by a new codec with a higher compression ratio.

1. Get the index settings and make sure the `lzma` codec is listed in them:

    ```bash
    curl \
        --user admin:<password> \
        --cacert ~/.opensearch/root.crt \
        --header 'Content-Type: application/json' \
        --request GET 'https://<{{ OS }}_host_address_with_public_access>:9200/log-000001/_settings?pretty'
    ```

    Result:

    ```bash
    {
      "log-000001" : {
        "settings" : {
          "index" : {
            ...
            "codec" : "lzma",
            "routing" : {
              "allocation" : {
                "require" : {
                  "groupname" : "cold"
                }
              }
            },
            ...
          }
        }
      }
    }
   ```

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mos-name }} cluster](../../managed-opensearch/operations/cluster-delete.md).

- Using {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
