# {{ websql-full-name }} release notes: 2024

## July {#july}

### Improvements {#improvements-july}

1. Query history displays users who ran the queries.
1. Enabled running queries without exporting the connection structure.
1. Added support for long-running database queries.
1. Added information about databases and certificates to the connection card.

### Fixed issues {#fixes-july}

1. Fixed the error when running all DML queries in a {{ CH }} cluster.
1. Fixed the query editor issue for Safari version 15.

## June {#june}

### New features {#new-features-june}

1. The **Connections** tab now displays the {{ yandex-cloud }} managed database clusters from the selected folder available to the user. This speeds up the process of creating connections to these clusters, as most of the cluster information is populated automatically. Also updates were made to the forms for [creating connections](../operations/create-connection.md).

1. [{{ websql-name }}](/services/websql) is the first service integrated with [{{ metadata-hub-full-name }}](../../metadata-hub/index.yaml). All [connections](../concepts/index.md#connection) are stored in [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md), but you can also manage ([create](../operations/create-connection.md), [delete](../operations/connect.md#delete-connection), and [edit](../operations/connect.md#change-connection-settings)) them from the {{ websql-name }} interface. All changes you make in {{ websql-name }} are displayed in {{ connection-manager-name }} and vice versa.

1. You can now [publish saved](../operations/templates.md#publish-query) and [historical queries](../operations/history.md#publish-query). Once published, the query will be available to all folder users. This action cannot be undone — you can only delete the query you published. [Roles](../security/index.md#roles-list) allow you to manage user access to a published query: you can grant permissions for viewing and editing a query or managing its access permissions.

1. The {{ websql-name }} interface now allows you to share links to various entities. For example, you can send a link to a connection, saved query you published, or page with access permissions for a published query to your colleague.

### Fixed issues {#fixes-june}

Improved user query storage mechanism: queries are now linked to the user's account. No matter what device or browser was used to access {{ websql-name }}, the user will see all their previous queries.

## May {#may}

### Improvements {#improvements-may}

1. Updated the service favicon ![](../../_assets/websql/favicon.svg).

### Fixed issues {#fixes-may}

1. Fixed the error occurring on connection to a database in which no tables or schemas (for {{ PG }}) were created.

## April {#april}

### Fixed issues {#fixes-april}

1. Fixed a bug that caused the interface to become unavailable when selecting a high-contrast theme in the management console.

## March {#mar}

### New features {#new-features-mar}

1. Added viewing sequence information in {{ PG }} database [schemas](../operations/view-db-objects-info.md#view-schema).

1. In the [query editor](../operations/query-executor.md), added role tips for {{ PG }} databases.

## February {#feb}

### New features {#new-features-feb}

1. New improved autocompletion feature for SQL queries in the [query editor](../operations/query-executor.md).

1. If the table has indexes or triggers, information about them will appear in separate [table information](../operations/view-db-objects-info.md#view-table) sections.

1. The autocompletion feature provides information about indexes and triggers.

### Fixed issues {#problems-solved-feb}

Fixed the incorrect display of variables when opening [saved queries](../operations/history.md).

## January {#jan}

### New features {#new-features-jan}

1. Grouping by date in the [query history](../operations/history.md).

1. [Visual settings of the editor](../operations/query-executor.md#sql-editor-settings).

1. Managing the transfer of the {{ websql-name }} SSL certificate [upon connection](../operations/create-connection.md#connect-db).

1. Support for [views](../operations/view-db-objects-info.md#view-view) in the database structure.

1. Grouping by [connection type](../concepts/index.md#connection): external, demo, and {{ yandex-cloud }} connections.

1. Simplified modal window for [reconnecting](../operations/connect.md#update-connection).
