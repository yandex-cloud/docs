# Access to {{ MS }} components and features

To reduce client costs to administer an {{ MS }} instance, {{ mms-name }} takes on administrative tasks related to its maintenance. This apportioning of responsibilities implies that users have limited access or no access at all to some server-level DBMS components.

## Available components {#available}

- [Database engine]({{ link-ms-docs }}/sql/database-engine/install-windows/install-sql-server-database-engine): core {{ MS }} component with all the functionality normally implemented at the level of a stand-alone database.
- [In-memory databases]({{ link-ms-docs }}/sql/relational-databases/in-memory-database): data management system optimized to use large amounts of memory.
- [Full-text search]({{ link-ms-docs }}/sql/relational-databases/search/full-text-search): components for full-text queries against character data in tables.

## Restricted access components {#restricted}

- [Always-On availability groups]({{ link-ms-docs }}/sql/database-engine/availability-groups/windows): available in the Enterprise Edition. For more information about using this component, see [Replication](replication.md). At the same time, the following is not available:
  - [Listener]({{ link-ms-docs }}/sql/database-engine/availability-groups/windows/create-or-configure-an-availability-group-listener-sql-server): a [special FQDN](../operations/connect#fqdn-primary-replica) is provided as a replacement for the single cluster connection point.
  - [Asynchronous-commit availability mode]({{ link-ms-docs }}/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups#asynchronous-commit-availability-mode): both secondary replicas are synced up and have automatic failover.
  - [Read-only routing]({{ link-ms-docs }}/sql/database-engine/availability-groups/windows/configure-read-only-routing-for-an-availability-group-sql-server).
  - [Distributed Transaction Coordinator]({{ link-ms-docs }}/sql/database-engine/availability-groups/windows/configure-availability-group-for-distributed-transactions).
- [Server-level roles and privileges]({{ link-ms-docs }}/sql/relational-databases/security/authentication-access/server-level-roles): only a query store for [performance diagnostics](../operations/performance-diagnostics#activate-stats-collector) and [user session management](../operations/sessions.md) with built-in stored procedures are available.
- [Replication]({{ link-ms-docs }}/sql/relational-databases/replication): you are only able to use the database in a {{ mms-name }} cluster as subscriber to [transaction publication](../tutorials/data-migration.md#replication). For [in-cluster replication](replication.md), the Always On availability groups are used.

## Unavailable components {#unavailable}

- [Always Encrypted]({{ link-ms-docs }}/sql/relational-databases/security/encryption/always-encrypted-database-engine).
- [Analysis Services]({{ link-ms-docs }}/analysis-services/ssas-overview).
- [CLR integration in .NET]({{ link-ms-docs }}/dotnet/framework/data/adonet/sql/sql-server-common-language-runtime-integration).
- [Database mail]({{ link-ms-docs }}/sql/relational-databases/database-mail).
- [Data Quality Services]({{ link-ms-docs }}/sql/data-quality-services).
- [Distributed Replay controller]({{ link-ms-docs }}/sql/tools/distributed-replay/sql-server-distributed-replay).
- [Extended Events]({{ link-ms-docs }}/sql/relational-databases/extended-events).
- [Integration Services]({{ link-ms-docs }}/sql/integration-services).
- [Linked servers]({{ link-ms-docs }}/sql/relational-databases/linked-servers).
- [Machine Learning Services]({{ link-ms-docs }}/sql/machine-learning/sql-server-machine-learning-services).
- [Master Data Services]({{ link-ms-docs }}/sql/master-data-services/master-data-services-overview-mds).
- [OLE Automation objects]({{ link-ms-docs }}/sql/relational-databases/stored-procedures/ole-automation-objects-in-transact-sql).
- [Reporting Services]({{ link-ms-docs }}/sql/reporting-services).
- [{{ MS }} Agent]({{ link-ms-docs }}/sql/ssms/agent).
- [{{ MS }} Profiler]({{ link-ms-docs }}/sql/tools/sql-server-profiler).
- [Transparent Data Encryption]({{ link-ms-docs }}/sql/relational-databases/security/encryption/transparent-data-encryption).
- [Windows Authentication]({{ link-ms-docs }}/sql/relational-databases/security/choose-an-authentication-mode#connecting-through-windows-authentication).

## Unavailable features {#unavailable-features}

- Creating a named {{ MS }} Instance.
- Creating databases or database snapshots via Transact-SQL commands or graphical tools.
- Creating accounts via Transact-SQL commands or graphical tools.
- Changing the database owner.
- Manually changing the primary replica.
- Backup to [SMB shared folders]({{ link-ms-docs }}/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option).
- Creating and running [maintenance plans]({{ link-ms-docs }}/sql/relational-databases/maintenance-plans).
- Using [relational operators]({{ link-ms-docs }}/sql/t-sql/language-elements/relational-operators-transact-sql) `OPENROWSET`, `OPENQUERY`, and `OPENDATASOURCE`.
- Running the `xp_cmdshell` [procedure]({{ link-ms-docs }}/sql/relational-databases/system-stored-procedures/xp-cmdshell-transact-sql).
