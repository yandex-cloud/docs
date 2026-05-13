# Управление доступом в Yandex Data Processing

Пользователь Yandex Cloud может выполнять только те операции над ресурсами, которые разрешены назначенными ему [ролями](../../iam/concepts/access-control/roles.md). Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса Yandex Data Processing (кластерам или подкластерам), назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса Yandex Resource Manager.

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `dataproc.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## Назначение ролей {#grant-role}

Чтобы назначить пользователю роль:

1. При необходимости [добавьте](../../organization/operations/add-account.md) нужного пользователя.
1. В [консоли управления](https://console.yandex.cloud) слева [выберите](../../resource-manager/operations/cloud/switch-cloud.md) облако.
1. Перейдите на вкладку **Права доступа**.
1. Нажмите кнопку **Настроить доступ**.
1. В открывшемся окне выберите раздел **Пользовательские аккаунты**.
1. Выберите пользователя из списка или воспользуйтесь поиском.
1. Нажмите кнопку ![image](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль в облаке.
1. Нажмите кнопку **Сохранить**.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе Yandex Data Processing.

```mermaid
flowchart BT
    dataproc.auditor --> dataproc.viewer
    dataproc.viewer --> dataproc.user
    mdb.viewer --> dataproc.user
    mdb.viewer --> mdb.admin
    mdb.auditor --> mdb.viewer
    dataproc.provisioner ~~~ dataproc.agent
    dataproc.user --> dataproc.editor
    dataproc.editor --> dataproc.admin
    dataproc.viewer --> mdb.viewer
    dataproc.admin --> mdb.admin 
```

### Сервисные роли {#service-roles}

#### dataproc.agent {#dataproc-agent}

Роль `dataproc.agent` позволяет [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), привязанному к кластеру Yandex Data Processing, сообщать сервису о состоянии хостов кластера. Роль назначается сервисному аккаунту, привязанному к кластеру Yandex Data Processing.

Сервисные аккаунты с этой ролью могут:
* сообщать сервису Yandex Data Processing о состоянии хостов [кластера](../concepts/index.md#resources);
* получать информацию о [заданиях](../concepts/jobs.md) и статусах их выполнения;
* получать информацию о [лог-группах](../../logging/concepts/log-group.md) и добавлять в них записи.

Сейчас эту роль можно назначить только на каталог или облако.

#### dataproc.auditor {#dataproc-auditor}

Роль `dataproc.auditor` позволяет просматривать информацию о [кластерах](../concepts/index.md#resources) Yandex Data Processing.

#### dataproc.viewer {#dataproc-viewer}

Роль `dataproc.viewer` позволяет просматривать информацию о [кластерах](../concepts/index.md#resources) Yandex Data Processing и [заданиях](../concepts/jobs.md).

#### dataproc.user {#dataproc-user}

Роль `dataproc.user` предоставляет доступ к веб-интерфейсам компонентов Yandex Data Processing и позволяет создавать задания, а также позволяет просматривать информацию о кластерах управляемых баз данных Yandex Cloud.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../concepts/index.md#resources) Yandex Data Processing и [заданиях](../concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам Yandex Data Processing;
* просматривать информацию о кластерах [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [Yandex StoreDoc](../../storedoc/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Valkey™](../../managed-valkey/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md) и SQL Server;
* просматривать информацию о хостах кластеров [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [Yandex StoreDoc](../../storedoc/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Valkey™](../../managed-valkey/concepts/instance-types.md) и SQL Server;
* просматривать информацию о резервных копиях БД кластеров [Greenplum®](../../managed-greenplum/concepts/backup.md), [Yandex StoreDoc](../../storedoc/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Valkey™](../../managed-valkey/concepts/backup.md) и SQL Server;
* просматривать информацию о пользователях кластеров [Yandex StoreDoc](../../storedoc/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md) и SQL Server;
* просматривать информацию о базах данных Yandex StoreDoc, MySQL®, PostgreSQL и SQL Server;
* просматривать информацию об алертах Yandex StoreDoc, MySQL®, PostgreSQL и Valkey™;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®, Yandex StoreDoc, MySQL® и PostgreSQL;
* просматривать информацию о шардах кластеров [Yandex StoreDoc](../../storedoc/concepts/sharding.md) и [Valkey™](../../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров Greenplum®, Yandex StoreDoc, MySQL®, PostgreSQL, Valkey™ и SQL Server;
* просматривать информацию о квотах сервисов [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/concepts/limits.md#quotas), [Yandex StoreDoc](../../storedoc/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Yandex Managed Service for Valkey™](../../managed-valkey/concepts/limits.md#mrd-quotas) и SQL Server;
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `dataproc.viewer` и `mdb.viewer`.

#### dataproc.provisioner {#dataproc-provisioner}

Роль `dataproc.provisioner` предоставляет доступ к API для создания, изменения и удаления объектов кластеров Yandex Data Processing.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [DNS-зонах](../../dns/concepts/dns-zone.md), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о [ресурсных записях](../../dns/concepts/resource-record.md), а также создавать, изменять и удалять их;
* создавать вложенные публичные DNS-зоны;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к DNS-зонам;
* просматривать информацию о доступных [платформах](../../compute/concepts/vm-platforms.md) и использовать их;
* создавать, изменять, запускать, перезапускать, останавливать, переносить и удалять [виртуальные машины](../../compute/concepts/vm.md);
* просматривать список виртуальных машин, информацию о них и о назначенных правах доступа к ним;
* подключать к виртуальным машинам и отключать от них диски, файловые хранилища и сетевые интерфейсы, привязывать [группы безопасности](../../vpc/concepts/security-groups.md) к сетевым интерфейсам виртуальных машин;
* создавать виртуальные машины с пользовательскими [FQDN](../../vpc/concepts/address.md#fqdn), создавать мультиинтерфейсные виртуальные машины;
* привязывать [сервисные аккаунты](../../iam/concepts/users/service-accounts.md) к виртуальным машинам, активировать на виртуальных машинах токен AWS v1;
* просматривать список сервисных аккаунтов и информацию о них, а также выполнять операции от имени сервисного аккаунта;
* использовать [последовательный порт](../../compute/operations/vm-info/get-serial-port-output.md) виртуальной машины в режиме чтения и записи;
* имитировать события обслуживания виртуальной машины;
* просматривать [метаданные](../../compute/concepts/vm-metadata.md) виртуальной машины;
* просматривать информацию о статусе настройки доступа по [OS Login](../../organization/concepts/os-login.md) на виртуальных машинах и подключаться к виртуальным машинам через OS Login с помощью SSH-сертификатов или SSH-ключей;
* просматривать список [групп виртуальных машин](../../compute/concepts/instance-groups/index.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, запускать, останавливать и удалять группы виртуальных машин;
* просматривать список [групп размещения виртуальных машин](../../compute/concepts/placement-groups.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения виртуальных машин;
* просматривать списки ВМ, входящих в группы размещения;
* просматривать список [групп выделенных хостов](../../compute/concepts/dedicated-host.md#host-group-size), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы выделенных хостов;
* просматривать списки [хостов](../../compute/concepts/dedicated-host.md) и виртуальных машин, входящих в группы выделенных хостов;
* изменять запланированное время обслуживания хостов, входящих в группы выделенных хостов;
* использовать [кластеры GPU](../../compute/concepts/gpus.md#gpu-clusters), а также создавать, изменять и удалять их;
* просматривать информацию о кластерах GPU и виртуальных машинах, входящих в кластеры GPU, а также о назначенных правах доступа к таким кластерам;
* просматривать список [дисков](../../compute/concepts/disk.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять, переносить и удалять диски;
* создавать [зашифрованные диски](../../compute/concepts/disk.md#encryption);
* просматривать и обновлять ссылки на диски;
* просматривать список [файловых хранилищ](../../compute/concepts/filesystem.md), информацию о них и о назначенных правах доступа к ним, а также использовать файловые хранилища и создавать, изменять и удалять их;
* просматривать список [групп размещения нереплицируемых дисков](../../compute/concepts/disk-placement-group.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять группы размещения нереплицируемых дисков;
* просматривать списки дисков, входящих в группы размещения;
* просматривать список [образов](../../compute/concepts/image.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять образы;
* создавать, изменять и удалять [семейства образов](../../compute/concepts/image.md#family), обновлять образы в них;
* просматривать информацию о семействах образов, о входящих в семейства образах, о наиболее актуальном образе в семействе, а также о назначенных правах доступа к семействам образов;
* просматривать список [снимков дисков](../../compute/concepts/snapshot.md), информацию о них и о назначенных правах доступа к ним, а также использовать, создавать, изменять и удалять снимки дисков;
* просматривать информацию о [расписаниях](../../compute/concepts/snapshot-schedule.md) создания снимков дисков и о назначенных правах доступа к расписаниям, а также создавать, изменять и удалять их;
* просматривать список [облачных сетей](../../vpc/concepts/network.md#network) и информацию о них, а также использовать облачные сети;
* просматривать список [подсетей](../../vpc/concepts/network.md#subnet) и информацию о них, а также использовать подсети;
* просматривать список [адресов облачных ресурсов](../../vpc/concepts/address.md) и информацию о них, а также использовать такие адреса;
* просматривать список [таблиц маршрутизации](../../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также использовать таблицы маршрутизации;
* просматривать список групп безопасности и информацию о них, а также использовать группы безопасности;
* просматривать информацию о [NAT-шлюзах](../../vpc/concepts/gateways.md) и подключать их к таблицам маршрутизации;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [метриках](../../monitoring/concepts/data-model.md#metric) Monitoring и их [метках](../../monitoring/concepts/data-model.md#label), а также выгружать метрики;
* просматривать список [дашбордов](../../monitoring/concepts/visualization/dashboard.md) и [виджетов](../../monitoring/concepts/visualization/widget.md) Monitoring, а также информацию о них;
* просматривать историю [уведомлений](../../monitoring/concepts/alerting/notification-channel.md) Monitoring;
* просматривать информацию о [лог-группах](../../logging/concepts/log-group.md);
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных правах доступа к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать в консоли управления информацию об объеме потребления ресурсов и [квот](../../compute/concepts/limits.md#compute-quotas) Compute Cloud, о [лимитах дисков](../../compute/concepts/limits.md#compute-limits-disks);
* просматривать информацию о квотах сервисов [Cloud DNS](../../dns/concepts/limits.md#cloud-dns-quotas), 
[Virtual Private Cloud](../../vpc/concepts/limits.md#vpc-quotas), и [Monitoring](../../monitoring/concepts/limits.md#monitoring-quotas);
* просматривать списки операций с ресурсами сервиса Compute Cloud и информацию об операциях, а также отменять выполнение этих операций;
* просматривать информацию об операциях с ресурсами сервиса Virtual Private Cloud;
* просматривать список [зон доступности](../../overview/concepts/geo-scope.md), информацию о них и о назначенных правах доступа к ним;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролями `iam.serviceAccounts.user`, `dns.editor`, `compute.editor`, `monitoring.viewer` и `logging.viewer`.

#### dataproc.editor {#dataproc-editor}

Роль `dataproc.editor` позволяет управлять кластерами Yandex Data Processing, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../concepts/index.md#resources) Yandex Data Processing, а также создавать, изменять, запускать останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам Yandex Data Processing;
* просматривать информацию о кластерах [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [Yandex StoreDoc](../../storedoc/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Valkey™](../../managed-valkey/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md) и SQL Server;
* просматривать информацию о хостах кластеров [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [Yandex StoreDoc](../../storedoc/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Valkey™](../../managed-valkey/concepts/instance-types.md) и SQL Server;
* просматривать информацию о резервных копиях БД кластеров [Greenplum®](../../managed-greenplum/concepts/backup.md), [Yandex StoreDoc](../../storedoc/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Valkey™](../../managed-valkey/concepts/backup.md) и SQL Server;
* просматривать информацию о пользователях кластеров [Yandex StoreDoc](../../storedoc/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md) и SQL Server;
* просматривать информацию о базах данных Yandex StoreDoc, MySQL®, PostgreSQL и SQL Server;
* просматривать информацию об алертах Yandex StoreDoc, MySQL®, PostgreSQL и Valkey™;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®, Yandex StoreDoc, MySQL® и PostgreSQL;
* просматривать информацию о шардах кластеров [Yandex StoreDoc](../../storedoc/concepts/sharding.md) и [Valkey™](../../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров Greenplum®, Yandex StoreDoc, MySQL®, PostgreSQL, Valkey™ и SQL Server;
* просматривать информацию о квотах сервисов [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/concepts/limits.md#quotas), [Yandex StoreDoc](../../storedoc/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Yandex Managed Service for Valkey™](../../managed-valkey/concepts/limits.md#mrd-quotas) и SQL Server;
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.user`.

#### dataproc.admin {#dataproc-admin}

Роль `dataproc.admin` позволяет управлять кластерами Yandex Data Processing, запускать задания и просматривать информацию о них, а также предоставляет доступ к веб-интерфейсам компонентов сервиса.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [кластерах](../concepts/index.md#resources) Yandex Data Processing, а также создавать, изменять, запускать, останавливать и удалять такие кластеры;
* просматривать информацию о [заданиях](../concepts/jobs.md), а также создавать задания;
* использовать веб-интерфейс для доступа к компонентам Yandex Data Processing;
* просматривать информацию о кластерах [ClickHouse®](../../managed-clickhouse/concepts/index.md), [Greenplum®](../../managed-greenplum/concepts/index.md), [Apache Kafka®](../../managed-kafka/concepts/index.md), [Yandex StoreDoc](../../storedoc/concepts/index.md), [MySQL®](../../managed-mysql/concepts/index.md), [PostgreSQL](../../managed-postgresql/concepts/index.md), [Valkey™](../../managed-valkey/concepts/index.md), [OpenSearch](../../managed-opensearch/concepts/index.md) и SQL Server;
* просматривать информацию о хостах кластеров [Greenplum®](../../managed-greenplum/concepts/instance-types.md), [Yandex StoreDoc](../../storedoc/concepts/instance-types.md), [MySQL®](../../managed-mysql/concepts/instance-types.md), [PostgreSQL](../../managed-postgresql/concepts/instance-types.md), [Valkey™](../../managed-valkey/concepts/instance-types.md) и SQL Server;
* просматривать информацию о резервных копиях БД кластеров [Greenplum®](../../managed-greenplum/concepts/backup.md), [Yandex StoreDoc](../../storedoc/concepts/backup.md), [MySQL®](../../managed-mysql/concepts/backup.md), [PostgreSQL](../../managed-postgresql/concepts/backup.md), [Valkey™](../../managed-valkey/concepts/backup.md) и SQL Server;
* просматривать информацию о пользователях кластеров [Yandex StoreDoc](../../storedoc/concepts/users-and-roles.md), [MySQL®](../../managed-mysql/concepts/user-rights.md), [PostgreSQL](../../managed-postgresql/concepts/roles.md) и SQL Server;
* просматривать информацию о базах данных Yandex StoreDoc, MySQL®, PostgreSQL и SQL Server;
* просматривать информацию об алертах Yandex StoreDoc, MySQL®, PostgreSQL и Valkey™;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®, Yandex StoreDoc, MySQL® и PostgreSQL;
* просматривать информацию о шардах кластеров [Yandex StoreDoc](../../storedoc/concepts/sharding.md) и [Valkey™](../../managed-valkey/concepts/sharding.md);
* просматривать логи работы кластеров Greenplum®, Yandex StoreDoc, MySQL®, PostgreSQL, Valkey™ и SQL Server;
* просматривать информацию о квотах сервисов [Managed Service for ClickHouse®](../../managed-clickhouse/concepts/limits.md#mch-quotas), [Managed Service for Apache Kafka®](../../managed-kafka/concepts/limits.md#mkf-quotas), [Managed Service for OpenSearch](../../managed-opensearch/concepts/limits.md#quotas), [Yandex MPP Analytics for PostgreSQL](../../managed-greenplum/concepts/limits.md#quotas), [Yandex StoreDoc](../../storedoc/concepts/limits.md#mmg-quotas), [Managed Service for MySQL®](../../managed-mysql/concepts/limits.md#mmy-quotas), [Managed Service for PostgreSQL](../../managed-postgresql/concepts/limits.md#mpg-quotas), [Yandex Managed Service for Valkey™](../../managed-valkey/concepts/limits.md#mrd-quotas) и SQL Server;
* просматривать информацию об операциях с ресурсами всех сервисов управляемых баз данных Yandex Cloud;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `dataproc.editor`.

#### mdb.auditor {#mdb-auditor}

Роль `mdb.auditor` предоставляет минимально необходимые разрешения для просмотра информации о кластерах управляемых баз данных (без доступа к данным и логам работы).

Пользователи с этой ролью могут просматривать информацию о кластерах управляемых баз данных, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `managed-opensearch.auditor`, `managed-kafka.auditor`, `managed-mysql.auditor`, `managed-postgresql.auditor`, `managed-spqr.auditor`, `managed-greenplum.auditor`, `managed-clickhouse.auditor`, `managed-redis.auditor` и `managed-mongodb.auditor`.

#### mdb.viewer {#mdb-viewer}

Роль `mdb.viewer` предоставляет доступ к чтению информации из кластеров управляемых баз данных и к логам работы кластеров.

Пользователи с этой ролью могут читать информацию из баз данных и просматривать логи кластеров управляемых баз данных, просматривать информацию о заданиях на техническое обслуживание кластеров, а также информацию о кластерах, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `managed-opensearch.viewer`, `managed-kafka.viewer`, `managed-mysql.viewer`, `managed-postgresql.viewer`, `managed-greenplum.viewer`, `managed-clickhouse.viewer`, `managed-redis.viewer`, `managed-mongodb.viewer` и `dataproc.viewer`.

#### mdb.admin {#mdb-admin}

Роль `mdb.admin` предоставляет полный доступ к кластерам управляемых баз данных.

Пользователи с этой ролью могут создавать, изменять, удалять, запускать и останавливать кластеры управляемых баз данных, управлять доступом к кластерам, создавать резервные копии кластеров и восстанавливать кластеры из резервных копий, читать и сохранять информацию в базах данных, а также просматривать информацию о кластерах, просматривать и изменять задания на техническое обслуживание кластеров, просматривать логи работы кластеров, информацию о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `vpc.user`, `managed-opensearch.admin`, `managed-kafka.admin`, `managed-mysql.admin`, `managed-postgresql.admin`, `managed-spqr.admin`, `managed-greenplum.admin`, `managed-clickhouse.admin`, `managed-redis.admin`, `managed-mongodb.admin` и `dataproc.admin`.

### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../../overview/concepts/services.md) Yandex Cloud.

#### auditor {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе](../../resource-manager/concepts/resources-hierarchy.md);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов](../../overview/concepts/services.md). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### viewer {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов](../../overview/concepts/services.md) в режиме чтения.

#### editor {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления, а также удаления [ключей шифрования](../../kms/concepts/index.md) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### admin {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами](../../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме передачи прав владения [организацией](../../organization/concepts/organization.md) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) или [платежный аккаунт](../../billing/concepts/billing-account.md), ознакомьтесь с информацией о защите [привилегированных аккаунтов](../../security/standard/all.md#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях см. в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md#primitive-roles).