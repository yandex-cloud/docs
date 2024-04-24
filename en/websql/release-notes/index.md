# {{ websql-full-name }} release notes

## March 2024 {#mar-2024}

### New features {#new-features-mar}

1. Added viewing sequence information in {{ PG }} database [schemas](../operations/connect.md##view-scheme).

1. In the [query editor](../operations/query-executor.md), added role tips for {{ PG }} databases.

## February 2024 {#feb-2024}

### New features {#new-features-feb}

1. New improved autocompletion feature for SQL queries in the [query editor](../operations/query-executor.md).

1. If the table has indexes or triggers, information about them will appear in separate [table information](../operations/connect.md#view-table) sections.

1. The autocompletion feature provides information about indexes and triggers.

### Fixed issues {#problems-solved-feb}

Fixed the incorrect display of variables when opening [saved queries](../operations/history.md).

## January 2024 {#jan-2024}

### New features {#new-features-jan}

1. Grouping by date in the [query history](../operations/history.md).

1. [Visual settings of the editor](../operations/query-executor.md#sql-editor-settings).

1. Managing the transfer of the {{ websql-name }} SSL certificate [upon connection](../operations/connect.md#connect-db).

1. Support for [views](../operations/connect.md#view-view) in the database structure.

1. Grouping by [connection type](../concepts/index.md##connection): external, demo, and {{ yandex-cloud }} connections.

1. Simplified modal window for [reconnecting](../operations/connect.md#update-connection).
