
Роль `dataproc.editor` позволяет управлять кластерами {{ dataproc-name }}, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../../data-proc/concepts/index.md#resources) {{ dataproc-name }}, а также создавать, изменять, запускать останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../../data-proc/concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам {{ dataproc-name }};
* просматривать информацию о кластерах [{{ CH }}](../../managed-clickhouse/concepts/index.md), [{{ mgp-name }}](../../managed-greenplum/concepts/index.md), [{{ KF }}](../../managed-kafka/concepts/index.md), [{{ SD }}](../../storedoc/concepts/index.md), [{{ MY }}](../../managed-mysql/concepts/index.md), [{{ PG }}](../../managed-postgresql/concepts/index.md), [{{ VLK }}](../../managed-valkey/concepts/index.md), [{{ OS }}](../../managed-opensearch/concepts/index.md) и {{ MS }};
* просматривать информацию о хостах кластеров [{{ mgp-name }}](../../managed-greenplum/concepts/instance-types.md), [{{ SD }}](../../storedoc/concepts/instance-types.md), [{{ MY }}](../../managed-mysql/concepts/instance-types.md), [{{ PG }}](../../managed-postgresql/concepts/instance-types.md), [{{ VLK }}](../../managed-valkey/concepts/instance-types.md) и {{ MS }};
* просматривать информацию о резервных копиях БД кластеров [{{ mgp-name }}](../../managed-greenplum/concepts/backup.md), [{{ SD }}](../../storedoc/concepts/backup.md), [{{ MY }}](../../managed-mysql/concepts/backup.md), [{{ PG }}](../../managed-postgresql/concepts/backup.md), [{{ VLK }}](../../managed-valkey/concepts/backup.md) и {{ MS }};
* просматривать информацию о пользователях кластеров [{{ SD }}](../../storedoc/concepts/users-and-roles.md), [{{ MY }}](../../managed-mysql/concepts/user-rights.md), [{{ PG }}](../../managed-postgresql/concepts/roles.md) и {{ MS }};
* просматривать информацию о базах данных {{ SD }}, {{ MY }}, {{ PG }} и {{ MS }};
* просматривать информацию об алертах {{ SD }}, {{ MY }}, {{ PG }} и {{ VLK }};
* просматривать информацию о результатах диагностики производительности кластеров {{ mgp-name }}, {{ SD }}, {{ MY }} и {{ PG }};
* просматривать информацию о шардах кластеров [{{ SD }}](../../storedoc/concepts/sharding.md) и [{{ VLK }}](../../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров {{ mgp-name }}, {{ SD }}, {{ MY }}, {{ PG }}, {{ VLK }} и {{ MS }};
* просматривать информацию о квотах сервисов [{{ mch-name }}](../../managed-clickhouse/concepts/limits.md#mch-quotas), [{{ mkf-name }}](../../managed-kafka/concepts/limits.md#mkf-quotas), [{{ mos-name }}](../../managed-opensearch/concepts/limits.md#quotas), [{{ mgp-name }}](../../managed-greenplum/concepts/limits.md#quotas), [{{ SD }}](../../storedoc/concepts/limits.md#mmg-quotas), [{{ mmy-name }}](../../managed-mysql/concepts/limits.md#mmy-quotas), [{{ mpg-name }}](../../managed-postgresql/concepts/limits.md#mpg-quotas), [{{ mrd-name }}](../../managed-valkey/concepts/limits.md#mrd-quotas) и {{ MS }};
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных {{ yandex-cloud }};
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.user`.