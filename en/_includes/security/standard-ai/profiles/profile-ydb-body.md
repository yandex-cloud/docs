{#profile-ydb-applicability}

**Scope and status**

The profile is applied if {{ ydb-short-name }} is used as a storage for documents, metadata, or RAG search results.

{#profile-ydb-flow}

**Flow and trust boundaries**

`runtime → database endpoint and path → tables and indexes → rows → model context`. User authorization for a document or row remains an application-level boundary.

{#profile-ydb-authentication}

**Workload identity and authentication**

A {{ ydb-short-name }} SDK or CLI client uses an IAM token or a documented credential provider, which gets IAM tokens from an authorized access key or runtime metadata service. The choice of library and provider is recorded according to the [{{ ydb-short-name }} connection guide](../../../../ydb/operations/connection.md).

For direct access to the management API, only the IAM token is provided in the Bearer scheme according to the [API authentication reference](../../../../ydb/api-ref/authentication.md); the authorized access key is not declared as direct Bearer credentials.

{#profile-ydb-roles}

**Roles and scope**

`ydb.auditor` is used for connection and metadata within the docs; `ydb.viewer`, for reading; `ydb.editor`, for reading, writing, and schema changes; and `ydb.admin`, for access management. Roles are assigned for a specific database when the assignment supports the required operation. They are not a ready-made list of access controls applied at the row or document level. For more information, see the description of the [{{ ydb-short-name }} access model](../../../../ydb/security/index.md).

{#profile-ydb-network}

**Network**

The serverless or dedicated mode, endpoint, database path, and actual network path are recorded. For a dedicated database, the [official connection guide](../../../../ydb/operations/connection.md) requires incoming and outgoing TCP traffic on port `2135`; the source and destination of the rule are limited to the actual application environment, not the `0.0.0.0/0` example. The serverless database uses the `grpcs` endpoint and path issued by the service; the security group setup of the dedicated database is not transferred to it.

{#profile-ydb-secrets}

**Secrets and credentials**

With an IAM token from the metadata service, there is no long-lived secret, which is marked as `N/A` with an indication of the workload identity. The authorized access key file for the SDK or CLI is stored and delivered according to `AI-SECRET1`; the IAM token obtained through it does not replace key accounting.

{#profile-ydb-configuration}

**Configuration objects**

Database ID and mode, endpoint and database path, IAM federated credentials, tables, indexes, schema, authentication method, security groups for the dedicated database, tenant application schema, and document-level access control lists.

{#profile-ydb-telemetry}

**Telemetry and blind spots**

The [{{ ydb-short-name }} {{ at-name }} reference](../../../../ydb/at-ref.md) describes management events. It does not log reads and edits of each row; these operations and the application ACL decision are logged by the application or an approved query layer.

{#profile-ydb-checks}

**Positive and negative checks**

1. Run an allowed read and a query to a foreign tenant or row.
1. Run a direct query bypassing the search API and a call with revoked credentials.
1. Separately show the management event and the application trace of the data plane query.

{#profile-ydb-inputs}

**What you need for profile implementation**

* Architecture: database mode, schema, indexes, and ACL.
* Policy: authentication method, query rules, and log period.
* Legal approach: data categories. {{ kms-short-name }} configuration is not declared without an official confirmation for the selected {{ ydb-short-name }} configuration.
