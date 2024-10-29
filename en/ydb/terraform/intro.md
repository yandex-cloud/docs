---
title: Introduction to {{ ydb-short-name }} via {{ TF }}
description: This tutorial describes basic {{ TF }} CLI commands and gives the list of guides on how to use {{ ydb-short-name }} via {{ TF }}.
---

# Introduction to {{ ydb-short-name }} via {{ TF }}

[{{ TF }}](https://www.terraform.io) is an open-source software solution developed by HashiCorp for managing cloud infrastructure based on the Infrastructure as Code paradigm. This means that the target state of the infrastructure is described in configuration files, and {{ TF }} applies these changes to the infrastructure using auxiliary programs (providers). Terraform's `.tf` configuration files use a special language called [HCL](https://developer.hashicorp.com/terraform/language/syntax) (HashiCorp Configuration Language). The HCL code is very similar to JSON and organized into logical sections within configuration files.

With {{ TF }}, you can create and modify {{ ydb-short-name }} databases, as well as manage their resources, such as tables, indexes, and table changefeeds. It is important to understand that the configuration file you create to manage {{ ydb-short-name }} becomes the single point of control for the database state, and all your database updates must take place through it. This is because after each successful update, {{ TF }} creates a special state file, i.e., a textual representation of the current database state, and uses it for reference in all subsequent updates.

If you modify the database state via the configuration file and then change something else via the management console or CLI, {{ TF }} will remain unaware of these changes until you run the `terraform plan` or `terraform refresh` commands. These commands will force {{ TF }} to check the current state of the resources against what is written in the state file. However, this does not mean that {{ TF }} will automatically accept new changes and update the state file. All because the next time you run the `terraform apply` command, {{ TF }} will try to bring the resources to the state described in your configuration file, which can overwrite or delete your external changes. Therefore, to avoid conflicts between {{ ydb-short-name }} state updates, you should use the single point of access, i.e., the configuration file.

We offer the `yandex_ydb` provider to connect Terraform to {{ ydb-short-name }}, and the [yc](../../cli/quickstart.md) console client for authentication.

This section contains the following guides:
1. [Obtaining authentication data](credentials.md).
1. [Installing and configuring {{ TF }} and a provider to connect to {{ ydb-short-name }}](install.md).
1. [Creating configuration files and connecting to {{ ydb-short-name }}](configure.md).
1. [Creating and editing parameters of a serverless database](serverless-database.md).
1. [Creating and editing parameters of a dedicated database](dedicated-database.md).
1. [Creating row-based tables in a database](row-tables.md).
1. [Creating a table changefeed](cdc.md).
1. [Creating secondary indexes in row-based tables](row-tables-secondary-index.md).
1. [Creating topics](topic.md).

## Resources {#resources}

The following {{ TF }} provider resources are supported for {{ ydb-name }}:

| **{{ TF }} resource** | **{{ yandex-cloud }} resource** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-resources-link }}/ydb_database_dedicated) | Database [on dedicated resources](../concepts/resources.md#resource-presets) |
| [yandex_ydb_database_iam_binding]({{ tf-provider-resources-link }}/ydb_database_iam_binding) | [Binding](../../iam/concepts/access-control/index.md#access-bindings) access privileges to a database |
| [yandex_ydb_database_serverless]({{ tf-provider-resources-link }}/ydb_database_serverless) | [Serverless](../concepts/resources.md#serverless) database |
| [yandex_ydb_topic]({{ tf-provider-resources-link }}/ydb_topic) | [Topic]({{ ydb.docs }}/concepts/topic) |
| [yandex_ydb_table]({{ tf-provider-resources-link }}/ydb_table) | [Table]({{ ydb.docs }}/concepts/datamodel/table) |
| [yandex_ydb_table_changefeed]({{ tf-provider-resources-link }}/ydb_table_changefeed) | [Change Data Capture]({{ ydb.docs }}/concepts/cdc) |
| `yandex_ydb_table_index` | [Table secondary index]({{ ydb.docs }}/concepts/secondary_indexes) |

## Data sources {#data-sources}

{{ ydb-name }} supports the following {{ TF }} provider data sources:

| **{{ TF }} data source** | **Description** |
| --- | --- |
| [yandex_ydb_database_dedicated]({{ tf-provider-datasources-link }}/datasource_ydb_database_dedicated) | Information about a database [on dedicated resources](../concepts/resources.md#resource-presets) |
| [yandex_ydb_database_serverless]({{ tf-provider-datasources-link }}/datasource_ydb_database_serverless) | Information about a [Serverless](../concepts/resources.md#serverless) database |
