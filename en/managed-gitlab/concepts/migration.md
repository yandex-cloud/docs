# Running migration from {{ GL }} to {{ mgl-name }}

During migration from a custom {{ GL }} installation to {{ mgl-name }}, you can migrate such entities as projects, users, [user groups]({{ gl.docs }}/ee/user/group/), configured access permissions, and pipelines. You can also reconfigure your [custom domain name]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/) for the new [{{ GL }} instance](index.md#instance). This allows you to move all the data and settings you need to the cloud.

Migration is only available for a _custom installation_ which is self-managed {{ GL }} installed on a server or local computer. You cannot migrate data from {{ GL }}.com.

{% note info %}

The migration feature is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## How migration works {#process}

Migration consists of two stages: test and production. At the test stage, the system verifies whether the data are correctly transferred to the cloud. Once the test stage is complete, the production migration is scheduled to finalize the data transfer to the cloud.

At each stage, it is assumed that data is migrated using a backup of your custom {{ GL }} installation. You provide this backup to {{ yandex-cloud }} support team, and they use it to deploy a {{ mgl-name }} instance.

For more information on how to run migration, see [this guide](../operations/instance/migration.md).

The {{ GL }} version in your custom installation must match the {{ GL }} version in the {{ mgl-name }} instance. To select the correct version, contact our support immediately before migration, as {{ GL }} regularly releases new versions.

## Migration service packages {#packages}

There are two packages available for migrating to {{ mgl-name }}:

* **Basic package**: During the migration, you configure your {{ mgl-name }} instance yourself. If issues arise, you can open separate support tickets. Generally, the _one ticket per issue_ rule applies.

   To use the basic package, at least one of the following conditions must be met:

   * Your {{ GL }} instance type which determines the [number of vCPUs and RAM amount](../../compute/concepts/vm-platforms.md) is `s2.small` or higher.
   * Your {{ yandex-cloud }} [service plan](https://yandex.cloud/en/support) is either <q>Business</q> or <q>Premium</q>.

* **Extended package**: You provide support with info on the instance configuration you need and how you prefer to run your migration. The support team help you perform the migration and give you instance setup advice within a single support ticket. The support can also help configure [approval rules](approval-rules.md) and resolve related issues. This allows you to migrate your data to the cloud and set up the instance more quickly compared with the basic package.

   To use the extended package, at least one of the following conditions must be met:

   * Your service plan is <q>Premium</q>.
   * Your service plan is <q>Business</q> and your instance type is `s2.small` or higher.
