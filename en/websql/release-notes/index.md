# {{ websql-full-name }} release notes: 2024

## June {#june}

### New features {#new-features-june}

1. The **Connections** tab now displays the {{ yandex-cloud }} managed database clusters available to the user from the selected folder. This speeds up the process of creating connections to these clusters, as most of the cluster information is populated automatically. Also updates were made to the forms for creating connections.

1. {{ websql-name }} is the first service integrated with {{ metadata-hub-full-name }}. All connections are stored in {{ connection-manager-name }}, but you can also manage (create, delete, and edit) them from the {{ websql-name }} interface. All changes you make in {{ websql-name }} are displayed in {{ connection-manager-name }} and vice versa.

1. You can now publish saved and historical queries. Once published, the query will be available for all folder users. This action cannot be undone; you can only delete a published query. Roles allow you to manage user access levels to a published query: viewing, editing, or managing access permissions for the query.

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
