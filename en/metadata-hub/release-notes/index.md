---
title: '{{ metadata-hub-full-name }} release notes'
description: This section contains {{ metadata-hub-name }} release notes.
---

# {{ metadata-hub-full-name }} release notes

## 2025 {#2025}

### June {#june25}

#### New features {#new-features-june25}


* {{ metadata-hub-name }} now features [{{ data-catalog-name }}](../concepts/data-catalog.md), a tool for collecting, analyzing, and marking up metadata from various sources. {{ data-catalog-name }} is at the [Technical preview](../../overview/concepts/launch-stages.md) stage and is available upon request to [support]({{ link-console-support }}).

* When creating new [{{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) and [{{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) clusters, connections to [{{ connection-manager-name }}](../concepts/connection-manager.md) are now automatically created. Migration is available for old clusters.


* Expanded the list of endpoints in {{ data-transfer-full-name }} with support for {{ connection-manager-name }} integration.

### April {#april25}

#### New features {#new-features-april25}


* Now creating a new [{{ mpg-name }}](../../managed-postgresql/operations/cluster-create.md) cluster automatically creates connections in [{{ connection-manager-name }}](../concepts/connection-manager.md). Migration is available for old clusters.


#### Fixed issues {#problems-solved-april25}

* Fixed the {{ schema-registry-name }} configuration to eliminate the `too many active clients for user` error.
* Fixed subject and schema deletion in {{ schema-registry-name }}.


### March {#march25}

#### New features {#new-features-march25}

* Added a button to upload a schema to an existing {{ schema-registry-name }} [subject](../concepts/schema-registry.md#subject).
* Added [{#T}](../public-talks.md) to the {{ metadata-hub-name }} documentaition.

### February {#february25}

#### New features {#new-features-february25}

* Implemented access control in the list of connections. Users will only see connections they have access to (they have the [`connection-manager.auditor` role](../security/connection-manager-roles.md#connection-manager-auditor) or [`connection-manager.viewer` role](../security/connection-manager-roles.md#connection-manager-viewer)). A user with access to a folder will see all connections in that folder.
* Improved stability when providing passwords to {{ data-transfer-full-name }}, {{ websql-full-name }}, and {{ datalens-name }}.

### January {#january25}

#### New features {#new-features-january25}

* Now you can manage connections with custom [{{ MG }}](../operations/create-connection.md#mongodb-on-premise) installations and [{{ mmg-name }}](../operations/create-connection.md#mdb-mongodb) clusters.
* Updated the password entry setting in the connection [create](../operations/create-connection.md) and [edit](../operations/update-connection.md) form. 
* You can now set up the JSON schema compatibility policy in the [schema registry](../concepts/schema-registry.md).

#### Fixed issues {#problems-solved-january25}

* Fixed the schema registry error that caused redundant connections to databases.

## 2024 {#2024}

### December {#december}

#### New features {#new-features-december}

Added the ability to manage connections to the following databases:
* [{{ TR }}](../operations/create-connection.md#trino-on-premise) custom installation
* [{{ OS }}](../operations/create-connection.md#opensearch-on-premise) custom installation
* [{{ mos-name }}](../operations/create-connection.md#mdb-opensearch) cluster

### November {#november}

#### New features {#new-features-november}

* In the management console, you can now connect to a selected {{ schema-registry-name }} [namespace](../operations/update-name-space.md).

### October {#october}

#### New features {#new-features-october}

* Added a new feature for integrating {{ connection-manager-name }} with [{{ data-transfer-full-name }}](../../data-transfer/quickstart.md): when creating a transfer, you can now use a drop-down list of available connections.
* {{ schema-registry-name }} now supports authentication with [API keys](../../iam/concepts/authorization/api-key.md) so you no longer need to regularly update your secret for authentication.

#### Fixed issues {#problems-solved-october}

* Improved stability when mass creating connections in {{ connection-manager-name }}.

### September {#september}

#### New features {#new-features-september}

* [{{ metastore-full-name }}](../concepts/metastore.md) clusters are now part of {{ metadata-hub-name }}.
* [{{ schema-registry-name }}](../quickstart/schema-registry.md) is available in [Preview](../../overview/concepts/launch-stages.md).
* {{ data-transfer-full-name }} users can now specify a {{ connection-manager-name }} connection ID to [configure the {{ mpg-short-name }}](../../data-transfer/operations/endpoint/source/postgresql.md) endpoint.
* In {{ datalens-full-name }}, you can now use {{ connection-manager-name }} to create [{{ PG }}](../../datalens/operations/connection/create-postgresql.md#conn-man), [{{ CH }}](../../datalens/operations/connection/create-clickhouse.md#conn-man), and [{{ MY }}](../../datalens/operations/connection/create-mysql.md#conn-man) connections.

### August {#august}

#### New features {#new-features-august}

Added support for custom {{ RD }} DB installation and [Managed Service for Redis](../../managed-redis/concepts/index.md) cluster connections.

### July {#july}

#### New features {#new-features-july}

Added [{{ connection-manager-name }}](../concepts/connection-manager.md) integration with [{{ mch-short-name }}](../../managed-clickhouse). Connections for {{ mch-short-name }} clusters [will be created automatically](../quickstart/connection-manager.md).

### June {#june}

#### New features {#new-features-june}

1. Added filtering by name in the [list of connections](../operations/view-connection.md).
1. Added viewing the [operations](../operations/view-connection.md#operations) of any selected connection.

#### Fixed issues {#problems-solved-june}

1. Fixed a bug with viewing connections to user database installations.
1. You can now edit connection parameters.

### May {#may}

#### New features {#new-features-may}

1. Added [{{ connection-manager-name }}](../concepts/connection-manager.md) integration with [{{ mmy-short-name }}](../../managed-mysql). Connections for {{ mmy-short-name }} clusters [will be created automatically](../quickstart/connection-manager.md).
1. Now you can specify databases in connections to [{{ CH }}](../operations/create-connection.md#mdb-clickhouse).


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
