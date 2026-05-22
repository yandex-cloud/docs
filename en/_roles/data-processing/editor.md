
The `dataproc.editor` role allows you to manage {{ dataproc-name }} clusters, run jobs, and view information on them. It also grants access to the Data Proc component web interfaces.

{% cut "Users with this role can:" %}

* View info on {{ dataproc-name }} [clusters](../../data-proc/concepts/index.md#resources), as well as create, modify, run, stop, and delete them.
* View info on [jobs](../../data-proc/concepts/jobs.md) and create them.
* Use the web interface to access the {{ dataproc-name }} components.
* View info on [{{ CH }}](../../managed-clickhouse/concepts/index.md), [{{ mgp-name }}](../../managed-greenplum/concepts/index.md), [{{ KF }}](../../managed-kafka/concepts/index.md), [{{ SD }}](../../storedoc/concepts/index.md), [{{ MY }}](../../managed-mysql/concepts/index.md), [{{ PG }}](../../managed-postgresql/concepts/index.md), [{{ VLK }}](../../managed-valkey/concepts/index.md), [{{ OS }}](../../managed-opensearch/concepts/index.md), and {{ MS }} clusters.
* View info on [{{ mgp-name }}](../../managed-greenplum/concepts/instance-types.md), [{{ SD }}](../../storedoc/concepts/instance-types.md), [{{ MY }}](../../managed-mysql/concepts/instance-types.md), [{{ PG }}](../../managed-postgresql/concepts/instance-types.md), [{{ VLK }}](../../managed-valkey/concepts/instance-types.md), and {{ MS }} cluster hosts.
* View info on database backups for [{{ mgp-name }}](../../managed-greenplum/concepts/backup.md), [{{ SD }}](../../storedoc/concepts/backup.md), [{{ MY }}](../../managed-mysql/concepts/backup.md), [{{ PG }}](../../managed-postgresql/concepts/backup.md), [{{ VLK }}](../../managed-valkey/concepts/backup.md), and {{ MS }} clusters.
* View info on [{{ SD }}](../../storedoc/concepts/users-and-roles.md), [{{ MY }}](../../managed-mysql/concepts/user-rights.md), [{{ PG }}](../../managed-postgresql/concepts/roles.md), and {{ MS }} cluster users.
* View info on {{ SD }}, {{ MY }}, {{ PG }}, and {{ MS }} DBs.
* View info on {{ SD }}, {{ MY }}, {{ PG }}, and {{ VLK }} alerts.
* View info on the results of {{ mgp-name }}, {{ SD }}, {{ MY }}, and {{ PG }} cluster performance diagnostics.
* View info on [{{ SD }}](../../storedoc/concepts/sharding.md) and [{{ VLK }}](../../managed-valkey/concepts/sharding.md) cluster shards.
* View {{ mgp-name }}, {{ SD }}, {{ MY }}, {{ PG }}, {{ VLK }}, and {{ MS }} cluster logs.
* View info on [{{ mch-name }}](../../managed-clickhouse/concepts/limits.md#mch-quotas), [{{ mkf-name }}](../../managed-kafka/concepts/limits.md#mkf-quotas), [{{ mos-name }}](../../managed-opensearch/concepts/limits.md#quotas), [{{ mgp-name }}](../../managed-greenplum/concepts/limits.md#quotas), [{{ SD }}](../../storedoc/concepts/limits.md#mmg-quotas), [{{ mmy-name }}](../../managed-mysql/concepts/limits.md#mmy-quotas), [{{ mpg-name }}](../../managed-postgresql/concepts/limits.md#mpg-quotas), [{{ mrd-name }}](../../managed-valkey/concepts/limits.md#mrd-quotas), and {{ MS }} quotas.
* View info on resource operations for all {{ yandex-cloud }} managed DB services.
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

This role includes the `dataproc.user` permissions.