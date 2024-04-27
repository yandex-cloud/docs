# Running migration from {{ GL }} to {{ mgl-name }}

During migration from a {{ GL }} custom installation to {{ mgl-name }}, you can migrate such entities as projects, users, [user groups]({{ gl.docs }}/ee/user/group/), configured access rights, and pipelines. You can also reconfigure your [custom domain name]({{ gl.docs }}/ee/user/project/pages/custom_domains_ssl_tls_certification/) to a new [{{ GL }} instance](index.md#instance). As a result, all the data and settings you need will be migrated to the cloud.

Migration is only available for a _custom installation_ where {{ GL }} is installed on a server or local computer (self-managed {{ GL }}). You cannot migrate data from {{ GL }}.com.

{% note info %}

The migration service is at the [Preview](../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## How to run migration {#process}

The migration process consists of two stages: test and production. At the test stage, the system verifies whether the data are correctly transferred to the cloud. Then, the production migration date is set during which the data is again migrated to the cloud.

At each migration stage, it is assumed that data is migrated using a backup of your {{ GL }} custom installation. You provide this backup to the {{ yandex-cloud }} technical support, and they use it to deploy a {{ mgl-name }} instance.

For more information on how to run migration, read [this guide](../operations/instance/migration.md).

The {{ GL }} version in the custom installation must match the {{ GL }} version in the {{ mgl-name }} instance. To learn which cloud version to use, consult our technical support during migration, as {{ GL }} regularly releases new versions.

## Migration service packages {#packages}

There are two packages available for migration in {{ mgl-name }}:

* **Basic package**: During the migration you configure your {{ mgl-name }} instance yourself; if issues occur, you can submit a separate support request. Generally, the _one request per issue_ rule applies.

   To use the basic package, you must meet at least one of these conditions:

   * Your {{ GL }} instance type determining the [number of cores (vCPU) and amount of memory (RAM)](../../compute/concepts/vm-platforms.md) is `s2.small` or higher.
   * Your {{ yandex-cloud }} [service plan](https://yandex.cloud/en/support) is either <q>Business</q> or <q>Premium</q>.

* **Extended package**: You tell our technical support which instance settings you need and how you prefer to run your migration. Next, they help you to perform the migration and give you instance setup advice within a single request. The support also helps you to set the [approval rules](approval-rules.md) and resolve the related issues. As a result, you can move your data to the cloud and customize your instance faster compared to the basic package.

   To use the extended package, you must meet one of these conditions:

   * Your service plan is <q>Premium</q>.
   * Your service plan is <q>Business</q> and your instance type is `s2.small` or higher.
