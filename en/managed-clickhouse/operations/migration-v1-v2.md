---
title: Migrating a {{ mch-full-name }} cluster from v1 to v2
description: Follow this guide to migrate a {{ mch-name }} cluster from resource v1 to resource v2 of the {{ TF }} provider.
---

# Migrating a cluster from v1 to v2

Before you get started with the migration, review the [changes](../concepts/migration-v1-v2.md).

To migrate a cluster from [resource v1]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster) (`yandex_mdb_clickhouse_cluster`) to [resource v2]({{ tf-provider-link }}/resources/mdb_clickhouse_cluster_v2) (`yandex_mdb_clickhouse_cluster_v2`):

1. [Update the {{ TF }} configuration](#update-config).
1. [Save the cluster ID](#get-id).
1. [Remove the old resource from state](#remove-old-resource).
1. [Import the existing resource into the new one](#import-resource).
1. [Optionally, import databases and users](#import-db-users).
1. [Review the planned changes](#tf-plan).
1. [Apply the changes](#tf-apply).


## Update the {{ TF }} configuration {#update-config}

1. Apply all syntax changes from the table below:

    {% include [v1-v2-syntax-table](../../_includes/managed-clickhouse/v1-v2-syntax-table.md) %}

1. Set keys for your hosts.


## Save the cluster ID {#get-id}

1. Run this command:

    ```sh
    terraform state show yandex_mdb_clickhouse_cluster.main
    ```

1. Copy the `id` value from the output for later.


## Remove the old resource from state {#remove-old-resource}

Run this command:

```sh
terraform state rm yandex_mdb_clickhouse_cluster.main
```


## Import the existing resource into the new one {#import-resource}

Run this command:

```sh
terraform import yandex_mdb_clickhouse_cluster_v2.main <cluster_ID>
```

Use the `id` value you got earlier in the command.

After the import, the hosts’ FQDNs will be used as their keys in `state`, e.g., `"rc1a-abc.{{ dns-zone }}"`.


## Optionally, import databases and users {#import-db-users}

If `database {}` or `user {}` were previously a part of the cluster resource and now are represented by separate resources, import them:

```sh
terraform import 'yandex_mdb_clickhouse_database.mydb' "<cluster_ID>:<DB_name>"
terraform import 'yandex_mdb_clickhouse_user.myuser'   "<cluster_ID>:<username>"
```


## Review the planned changes {#tf-plan}

Run this command:

```sh
terraform plan
```

You will see a list of resources and their properties. This is a verification step: no resources will be created. {{ TF }} will show any errors detected in the configuration.

In `plan`, all hosts may appear as `+` and `-`. While this may look alarming, it is safe for matching hosts to apply the changes.

The provider matches hosts in three steps:

1. Same key in `plan` and `state`: Host remains as-is, no action required.
1. Full match by `zone`, `subnet_id`, `type`, `shard_name`, and `assign_public_ip`: The `state` key is renamed to the `plan` key; the host itself is not affected.
1. Partial match by `zone`, `FQDN`, `shard_name`, and `subnet_id`: The `state` key is renamed to the `plan` key; an update may be required, e.g., `assign_public_ip`.

Hosts in `plan` use short keys, such as `"c1"`, `"k1"`. If `zone`, `subnet`, `type`, and `shard` match, the second step will start: the keys will be renamed without any actual changes to the hosts.

{% note warning %}

Before you run `terraform apply`, make sure that each host displayed as `+` and `-` has the same values for `zone`, `subnet_id`, `type`, `shard_name`, and `assign_public_ip`. Changing any of those fields may cause the host to be recreated.

{% endnote %}


## Apply the changes {#tf-apply}

1. To create resources, run the command:

    ```bash
    terraform apply
    ```

1. Confirm creating the resources by typing `yes` and pressing **Enter**.

    {{ TF }} will create all the required resources. You can check the new resources and their settings in the [management console]({{ link-console-main }}).

In case of errors, read [{#T}](../concepts/migration-v1-v2.md#errors).


#### Useful links {#see-also}

* [{#T}](../concepts/migration-v1-v2.md)