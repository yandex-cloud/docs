---
title: Introduction to using {{ ydb-short-name }} via {{ TF }}
description: This article describes the basic {{ TF }} CLI commands and provides the list of guides on using {{ ydb-short-name }} via {{ TF }}.
---

# Introduction to using {{ ydb-short-name }} via {{ TF }}

[{{ TF }}](https://www.terraform.io) is an open-source software solution developed by HashiCorp for managing a cloud infrastructure based on the _Infrastructure as Code_ paradigm. This means that you describe the target infrastructure state in configuration files, and {{ TF }} applies these changes to the infrastructure using auxiliary programs (providers). Configuration files use a special language, [HCL](https://developer.hashicorp.com/terraform/language/syntax) (HashiCorp Configuration Language), and have the `tf` extension. The HCL code is very similar to JSON and arranged into logical sections within configuration files.

With {{ TF }}, you can create and update {{ ydb-short-name }} databases, as well as manage their resources, such as tables, indexes, and table change data feeds. You should keep in mind that the configuration file you create to manage {{ ydb-short-name }} becomes the single point of control for the database state, and you should describe any database updates in it. This is because after you successfully apply changes, {{ TF }} creates a special state file, i.e., a text representation of the current database state, and uses it for reference in all subsequent updates.

If you update the database state via the configuration file and then change something else using the management console or CLI, {{ TF }} will remain unaware of these changes until you run the `terraform plan` or `terraform refresh` commands. These commands will force {{ TF }} to check the current state of the resources against the code in the state file. However, this does not mean that {{ TF }} will automatically accept new changes and update the state file. The next time you run the `terraform apply` command, {{ TF }} will try to bring the resources back to the state described in your configuration file, which can overwrite or delete your changes made outside {{ TF }}. Therefore, to avoid conflicts between {{ ydb-short-name }} state updates, you should use the configuration file as the single point of access.

Terraform connects to {{ ydb-short-name }} via the `yandex_ydb` provider, with authentication via the [yc](../../cli/quickstart.md) console client.

This section contains the following guides:
1. [Getting authentication credentials](credentials.md).
1. [Installing and configuring {{ TF }} and a provider to connect to {{ ydb-short-name }}](install.md).
1. [Creating configuration files and connecting to {{ ydb-short-name }}](configure.md).
1. [Creating and reconfiguring a serverless database](serverless-database.md).
1. [Creating and reconfiguring a dedicated database](dedicated-database.md).
1. [Creating row-oriented and column-oriented tables in a database](tables.md).
1. [Creating a change data feed for a table](cdc.md).
1. [Creating secondary indexes in row-oriented tables](row-tables-secondary-index.md).
1. [Creating topics](topic.md).

## Resources {#resources}

{{ ydb-name }} supports the following {{ TF }} provider resources:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-resources-link }}/ydb_database_dedicated) | Database [on dedicated resources](../concepts/resources.md#resource-presets) |
| [yandex_ydb_database_iam_binding]({{ tf-provider-resources-link }}/ydb_database_iam_binding) | [Binding](../../iam/concepts/access-control/index.md#access-bindings) access permissions to a database |
| [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless) | [Serverless](../concepts/resources.md#serverless) database |
| [yandex_ydb_topic]({{ tf-provider-resources-link }}/ydb_topic) | [Topic]({{ ydb.docs }}/concepts/topic) |
| [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table) | [Table]({{ ydb.docs }}/concepts/datamodel/table) |
| [yandex_ydb_table_changefeed]({{ tf-provider-resources-link }}/ydb_table_changefeed) | [Change Data Capture]({{ ydb.docs }}/concepts/cdc) |
| `yandex_ydb_table_index` | [Table secondary index]({{ ydb.docs }}/concepts/secondary_indexes) |

## Data sources {#data-sources}

{{ ydb-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-datasources-link }}/ydb_database_dedicated) | Information about a database [on dedicated resources](../concepts/resources.md#resource-presets) |
| [yandex_ydb_database_serverless]({{ tf-provider-datasources-link }}/ydb_database_serverless) | Information about a [serverless](../concepts/resources.md#serverless) database |