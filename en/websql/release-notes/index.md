---
title: '{{ websql-full-name }} release notes'
description: This section contains {{ websql-name }} release notes.
---

# {{ websql-full-name }} release notes: 2025

## September {#september-2025}

### New features {#new-features-september-2025}


1. Integrated an [AI assistant](../operations/ai-assistant.md) into {{ websql-name }}. You can use it to generate queries to databases, analyze their structure, as well as to fix and optimize queries directly from the editor.


1. Added the ability to use the `ISODate`, `UUID`, and `ObjectId` functions in {{ MG }}. You can use these functions to work with dates, create unique IDs, and generate primary keys for documents. 

1. Added the `authentication_source` parameter that enables selecting a database in the cluster to use for authentication when connecting to {{ MG }}.

### Improvements {#improvements-september-2025}

1. Removed the error message that appeared on successful connection to a database with a schema export error. This way, you will still be able to query the database.


1. In the [management console]({{ link-console-main }}), added links to the [Privacy policy](https://yandex.com/legal/confidential/en/) and [Terms of use](https://yandex.com/legal/cloud_termsofuse/en/) sections to the left-hand menu.


### Fixed issues {#fixes-september-2025}

1. Fixed the issue of random page refreshes when pressing arrow keys and `Enter`.

1. Fixed the incorrect behavior of the `Readonly` user management setting in {{ CH }}.

1. Fixed the incorrect behavior of the `sha256_password` authentication plugin in {{ MY }}.


1. Fixed the error where catalog data did not load when opening {{ websql-name }} from the management console.


## August {#august-2025}



### Fixed issues {#fixes-august-2025}

Fixed incorrect autocompletion of queries when the editor text contained emoji.

## July {#july-2025}

### New features {#new-features-july-2025}

1. Added a notification with a link to a survey that collects {{ websql-name }} feedback. Please, complete [it](https://forms.yandex.ru/cloud/686f7470eb614649fe8f8cb2/).

1. The trial feature to run subqueries within a [muli-query](../operations/query-executor.md#multiple-queries) became basic for all {{ websql-name }} users.

1. The query editor now stores the last query written to keep the query in the editor in case of service overloads or after a long break.

1. Added the automatic substitution of the default CA certificate for external connections.

### Improvements {#improvements-july-2025}

1. Improved the query performance reliability.

1. Fixed the appearance of large data amounts in the query results.

## June {#june}

### New features {#new-features-june-2025}

1. Added support for {{ GP }} connections.

1. Added support for [pagination](../operations/query-executor.md#pagination) in the query editor.

1. Added an option to share a query link from the editor.

### Improvements {#improvements-june-2025}

1. Added support for materialized views and partitioned tables in {{ PG }} connections.

1. Added info on table columns in the connection tree.

1. Improved command autocompletion in {{ SD }} connections.

## May {#may-2025}

### Improvements {#improvements-may-2025}

1. The editor now features improved query formatting.

1. In multi-queries, metadata is now displayed separately for each subquery.

### Fixed issues {#fixes-may-2025}

1. Fixed an issue with the connection creation dialog rendering.

1. Fixed incorrect rendering of empty values in the query results table.

1. Fixed incorrect editor fonts in Windows.

## April {#april-2025}

### New features {#new-features-apr-2025}

1. You can now resize the columns in the query output section.

1. Added the **Open support chat** item to the **Support center** menu.

### Fixed issues {#fixes-apr-2025}

1. Fixed timestamp operations for all databases: the database time zone is now used.

1. After a query is run, the cursor focuses on the query editor.

## March {#march-2025}

### New features {#new-features-march-2025}

1. Now you can run subqueries within a [muli-query](../operations/query-executor.md#multiple-queries) in all available database types.

1. Added support for {{ SD }} and {{ mtr-full-name }} connections ({{ mtr-full-name }} is currently at the [Preview](../../overview/concepts/launch-stages.md) stage).

## February {#february-2025}

### New features {#new-features-feb-2025}

Now you can run [multi-queries](../operations/query-executor.md#multiple-queries) for {{ CH }} databases.

### Fixed issues {#fixes-feb-2025}

Fixed an issue where certain authors were shown as unknown users in the query history.

## January {#january-2025}

### New features {#new-features-jan-2025}

1. Added an option to export query results in XLS format.
1. Added an option to attach a screenshot when creating a support ticket.
1. Added a setting for the connection tree to display only those connections the user has access to.
1. Added query formatting to the query editor.
1. Migrated {{ yandex-cloud }} connections to {{ RD }} managed database clusters to {{ VLK }}.

### Improvements {#improvements-jan-2025}

Fixed the behavior of the **Share query** button where it appeared before running a query.

## 2024 {#2024-2025}

### November {#november-2024}

#### Improvements {#improvements-nov-2024}

1. Added an icon to the list of connections to indicate the connection control type, automatic ![](../../_assets/console-icons/person-nut-hex.svg) or manual ![](../../_assets/console-icons/person.svg).

1. Now you can use {{ websql-name }} even if you were unable to export clusters of a certain database type. The successfully exported clusters will be available.

1. Reduced the time for getting the {{ PG }} cluster structure.

1. In {{ CH }}, supported autocompletion of the `GRANT` and `REVOKE` commands and improved autocompletion of the `SELECT`, `CREATE`, `DELETE`, `ALTER`, and `INSERT` commands.

#### Fixed issues {#fixes-nov-2024}

1. Fixed an issue when working with tables whose names begin with a capital letter in {{ PG }}.

1. Fixed an issue with displaying numeric data types as strings in {{ CH }}.

1. Fixed the duplication of {{ RD }} in the **Database type** list when creating an external connection.

### October {#october-2024}

#### Improvements {#improvements-october-2024}

1. You can now share the result right after the query was executed.

1. Reduced processing time for fast queries.

### September {#september-2024}

#### New features {#new-features-september-2024}

1. Now you can [connect](../quickstart.md) to non-sharded {{ RD }} clusters.

1. Added the [`websql.auditor`](../security/index.md#websql-auditor), [`websql.executedQueries.auditor`](../security/index.md#websql-executedqueries-auditor), and [`websql.savedQueries.auditor`](../security/index.md#websql-savedqueries-auditor) roles to view query metadata and related access permissions.

#### Improvements {#improvements-september-2024}

1. Added the experiment of displaying connections as database users.

1. {{ PG }} tables are now displayed as database objects even if the user does not have access to these tables.

1. Added the display of empty {{ PG }} schemas to the list of database objects.

#### Fixed issues {#fixes-september-2024}

The backend query timeout was set to 25 seconds.

### August {#august-2024}

#### Improvements {#improvements-august-2024}

1. Added [access permission management](../security/index.md) interfaces for completed and saved queries.

1. Integrated cloud-based time settings.

1. Added the modal window interface for contacting technical support.

1. Now only the tables the user has access to are displayed in {{ PG }} databases.

1. Added statistics for completed queries.

#### Fixed issues {#fixes-august-2024}

Fixed the filter workflow on the completed queries page.

### July {#july-2024}

#### Improvements {#improvements-july-2024}

1. The query history displays authors of completed queries.

1. Enabled running queries without exporting the connection structure.

1. Added support for long-running database queries.

1. Added information about databases and certificates to the connection card.

#### Fixed issues {#fixes-july-2024}

1. Fixed an error when running all DML queries in a {{ CH }} cluster.

1. Fixed the query editor issue for Safari version 15.

### June {#june-2024}

#### New features {#new-features-june-2024}

1. The **Connections** tab now displays the {{ yandex-cloud }} managed database clusters from the selected folder available to the user. This speeds up the process of creating connections to these clusters, as most of the cluster information is populated automatically. Also updates were made to the forms for [creating connections](../operations/create-connection.md).

1. [{{ websql-name }}](/services/websql) is the first service integrated with [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml). All [connections](../concepts/index.md#connection) are stored in [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md), but you can also manage ([create](../operations/create-connection.md), [delete](../operations/delete-connection.md), and [edit](../operations/change-connection-settings.md)) them from the {{ websql-name }} interface. All changes you make in {{ websql-name }} are displayed in {{ connection-manager-name }} and vice versa.

1. You can now publish [saved](../operations/templates.md#publish-query) and [historical queries](../operations/history.md#publish-query). Once published, the query will be available to all folder users. This action cannot be undone — you can only delete the query you published. [Roles](../security/index.md#roles-list) allow you to manage user access to a published query: you can grant permissions for viewing and editing a query or managing its access permissions.

1. The {{ websql-name }} interface now allows you to share links to various entities. For example, you can send a link to a connection, saved query you published, or page with access permissions for a published query to your colleague.

#### Fixed issues {#fixes-june-2024}

Improved user query storage mechanism: queries are now linked to the user's account. No matter what device or browser was used to access {{ websql-name }}, the user will see all their previous queries.

### May {#may-2024}

#### Improvements {#improvements-may-2024}

Updated the service favicon ![](../../_assets/websql/favicon.svg).

#### Fixed issues {#fixes-may-2024}

Fixed an error on connection to a database in which no tables or schemas (for {{ PG }}) had been created.

### April {#april-2024}

#### Fixed issues {#fixes-april-2024}

Fixed a bug that caused the interface to become unavailable when selecting a high-contrast theme in the management console.

### March {#mar-2024}

#### New features {#new-features-mar-2024}

1. Added viewing sequence information in {{ PG }} database [schemas](../operations/view-db-objects-info.md#view-schema).

1. In the [query editor](../operations/query-executor.md), added role tips for [{{ PG }}](https://www.postgresql.org/) databases.

### February {#feb-2024}

#### New features {#new-features-feb-2024}

1. New improved autocompletion feature for SQL queries in the [query editor](../operations/query-executor.md).

1. If the table has indexes or triggers, information about them will appear in separate [table information](../operations/view-db-objects-info.md#view-table) sections.

1. The autocompletion feature provides information about indexes and triggers.

#### Fixed issues {#problems-solved-feb-2024}

Fixed the incorrect display of variables when opening [saved queries](../operations/history.md).

### January {#jan-2024}

#### New features {#new-features-jan-2024}

1. Grouping by date in the [query history](../operations/history.md).

1. [Visual settings of the editor](../operations/query-executor.md#sql-editor-settings).

1. Managing the transfer of the {{ websql-name }} SSL certificate [upon connection](../operations/create-connection.md#connect-db).

1. Support for [views](../operations/view-db-objects-info.md#view-view) in the database structure.

1. Grouping by [connection type](../concepts/index.md#connection): external, demo, and {{ yandex-cloud }} connections.

1. Simplified modal window for [reconnecting](../operations/update-connection.md).

