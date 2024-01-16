# Migrating a {{ ydb-short-name }} database to a different availability zone

Migration to another availability only makes sense for a {{ ydb-short-name }} [dedicated database](../concepts/serverless-and-dedicated.md). Serverless databases are not migrated between availability zones.

A dedicated database is hosted in multiple [availability zones](../../overview/concepts/geo-scope.md) of the central Russia `{{ region-id }}` region. You can replace one zone with another. To do this:

1. [Create a subnet](../../vpc/operations/subnet-create.md) in the availability zone to which you are migrating your database.
1. Move the {{ ydb-short-name }} database to a new set of subnets:

   {% list tabs %}

   - {{ yandex-cloud }} CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      Run this command:

      ```bash
      {{ yc-ydb }} database update <DB_name> \
         --subnet-id <subnet_ID_in_{{ region-id }}-a_availability_zone> \
         --subnet-id <subnet_ID_in_{{ region-id }}-b_availability_zone> \
         --subnet-id <subnet_ID_in_{{ region-id }}-d_availability_zone>
      ```

   - {{ TF }}

      {% include [terraform-install](../../_includes/terraform-install.md) %}

      1. Open the {{ TF }} configuration file containing the infrastructure plan and edit the fragment with the DB description:

         ```hcl
         resource "yandex_ydb_database_dedicated" "<DB_name>" {
            ...
            subnet_ids = [<subnet_IDs>]
            ...
         }
         ```

         In the `subnet_ids` parameter, list the subnet IDs in the `{{ region-id }}-a`, `{{ region-id }}-b`, and `{{ region-id }}-d` availability zones, separated by commas.

      1. Apply the changes:

         {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}

   {% endlist %}

## Migrating to {{ data-transfer-full-name }} {#data-transfer}

If are using a [transfer](../../data-transfer/concepts/transfer-lifecycle.md#transfer-types) of the {{ dt-type-repl }} or {{ dt-type-copy-repl }} type and your database serves as an [endpoint](../../data-transfer/concepts/index.md#endpoint), restart the transfer using one of two methods after changing subnets in the database:

{% include [reactivate-a-transfer](../../_includes/data-transfer/reactivate-a-transfer.md) %}

For more information, see [{#T}](../../data-transfer/operations/endpoint/migration-to-an-availability-zone.md).
