# Управление доступом в Yandex MPP Analytics for PostgreSQL


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `managed-greenplum.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Чтобы разрешить доступ к ресурсам сервиса Yandex MPP Analytics for PostgreSQL, назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

В [консоли управления](https://console.yandex.cloud), через [CLI](../../cli/index.md) или [API](../api-ref/authentication.md) роль также можно назначить на отдельный кластер.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

```mermaid
%%{init: { "flowchart": { "padding": 4 } } }%%
flowchart BT
    vpc.publicAdmin ~~~ mdb.admin
    mdb.viewer --> mdb.admin
    mdb.viewer ~~~ mdb.admin
    mdb.restorer ~~~ mdb.admin
    mdb.viewer --> mdb.restorer
    managed-greenplum.admin --> mdb.admin
    managed-greenplum.viewer --> managed-greenplum.restorer["`managed-greenplum.
    restorer`"]
    managed-greenplum.restorer --> managed-greenplum.editor
    mdb.auditor --> mdb.maintenanceTask.viewer
    mdb.maintenanceTask.viewer --> mdb.maintenanceTask.editor
    managed-greenplum.maintenanceTask.viewer --> mdb.maintenanceTask.viewer
    managed-greenplum.maintenanceTask.editor --> managed-greenplum.editor
    managed-greenplum.maintenanceTask.viewer --> managed-greenplum.viewer["`managed-greenplum.
    viewer`"]
    managed-greenplum.maintenanceTask.viewer --> managed-greenplum.maintenanceTask.editor["`managed-greenplum.
    maintenanceTask.editor`"]
    managed-greenplum.maintenanceTask.editor --> mdb.maintenanceTask.editor
    managed-greenplum.auditor --> managed-greenplum.maintenanceTask.viewer["`managed-greenplum.
    maintenanceTask.viewer`"]
    mdb.auditor --> mdb.viewer
    managed-greenplum.viewer --> mdb.viewer
    managed-greenplum.auditor["`managed-greenplum.
    auditor`"] --> mdb.auditor
    managed-greenplum.editor --> managed-greenplum.admin
    managed-greenplum.restorer --> mdb.restorer
    managed-greenplum.user --> managed-greenplum.editor
```

### Сервисные роли {#service-roles}

#### managed-greenplum.clusters.connector {#managed-greenplum-clusters-connector}

Роль `managed-greenplum.clusters.connector` позволяет [пользователям](../../iam/concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах Greenplum®](../concepts/index.md) в сервисе Yandex MPP Analytics for PostgreSQL с помощью механизмов сервиса [Yandex Identity and Access Management](../../iam/index.md).

#### managed-greenplum.auditor {#managed-greenplum-auditor}

Роль `managed-greenplum.auditor` позволяет просматривать информацию о [кластерах Greenplum®](../concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, а также о [квотах](../concepts/limits.md#quotas) и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

#### managed-greenplum.viewer {#managed-greenplum-viewer}

Роль `managed-greenplum.viewer` позволяет просматривать информацию о кластерах и хостах Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Greenplum®](../concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum®;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров Greenplum®;
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров Greenplum®;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролями `managed-greenplum.auditor` и `managed-greenplum.maintenanceTask.viewer`.

#### managed-greenplum.restorer {#managed-greenplum-restorer}

Роль `managed-greenplum.restorer` позволяет восстанавливать из резервных копий кластеры Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL, просматривать информацию о кластерах и хостах Greenplum®, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров Greenplum®](../concepts/index.md) и восстанавливать кластеры из [резервных копий](../concepts/backup.md);
* просматривать информацию о кластерах Greenplum® и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum®;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров Greenplum®;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.viewer`.

#### managed-greenplum.user {#managed-greenplum-user}

Роль `managed-greenplum.user` позволяет использовать [кластеры Greenplum®](../concepts/index.md).

#### managed-greenplum.editor {#managed-greenplum-editor}

Роль `managed-greenplum.editor` позволяет управлять кластерами Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Greenplum®](../concepts/index.md), а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам Greenplum®;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum® и изменять такие задания;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров Greenplum®, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров Greenplum®, создавать и удалять резервные копии кластеров, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролями `managed-greenplum.viewer`, `managed-greenplum.user`, `managed-greenplum.restorer` и `managed-greenplum.maintenanceTask.editor`.

Для создания кластеров Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL дополнительно необходима роль `vpc.user`.

#### managed-greenplum.admin {#managed-greenplum-admin}

Роль `managed-greenplum.admin` позволяет управлять кластерами Greenplum® и доступом к ним в сервисе Yandex MPP Analytics for PostgreSQL.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к [кластерам Greenplum®](../concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах Greenplum®, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum® и изменять такие задания;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров Greenplum®, а также создавать, изменять и удалять их;
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров Greenplum®, создавать и удалять резервные копии кластеров, а также восстанавливать кластеры из резервных копий;
* просматривать логи работы кластеров Greenplum®;
* просматривать информацию о результатах диагностики производительности кластеров Greenplum®;
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.editor`.

Для создания кластеров Greenplum® в сервисе Yandex MPP Analytics for PostgreSQL дополнительно необходима роль `vpc.user`.

#### managed-greenplum.maintenanceTask.viewer {#managed-greenplum-maintenanceTask-viewer}

Роль `managed-greenplum.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum®, а также о таких [кластерах](../concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, о [квотах](../concepts/limits.md#quotas) и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.auditor`.

#### managed-greenplum.maintenanceTask.editor {#managed-greenplum-maintenanceTask-editor}

Роль `managed-greenplum.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров Greenplum® и изменять такие задания, просматривать информацию о [кластерах Greenplum®](../concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, а также о [квотах](../concepts/limits.md#quotas) и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.maintenanceTask.viewer`.

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

#### mdb.restorer {#mdb-restorer}

Роль `mdb.restorer` позволяет восстанавливать кластеры управляемых баз данных из резервных копий, а также предоставляет доступ к чтению информации из кластеров и к логам их работы.

Пользователи с этой ролью могут восстанавливать кластеры управляемых баз данных из резервных копий, читать информацию из баз данных и просматривать логи кластеров, а также просматривать информацию о кластерах, заданиях на их техническое обслуживание, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-opensearch.restorer`, `managed-mysql.restorer`, `managed-postgresql.restorer`, `managed-spqr.restorer`, `managed-greenplum.restorer`, `managed-clickhouse.restorer`, `managed-redis.restorer` и `managed-mongodb.restorer`.

#### mdb.maintenanceTask.viewer {#mdb-maintenanceTask-viewer}

Роль `mdb.maintenanceTask.viewer` предоставляет доступ к информации о заданиях на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных, а также информацию о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.auditor`, `managed-clickhouse.maintenanceTask.viewer`, `managed-greenplum.maintenanceTask.viewer`, `managed-kafka.maintenanceTask.viewer`, `managed-mongodb.maintenanceTask.viewer`, `managed-mysql.maintenanceTask.viewer`, `managed-opensearch.maintenanceTask.viewer`, `managed-postgresql.maintenanceTask.viewer`, `managed-redis.maintenanceTask.viewer` и `managed-spqr.maintenanceTask.viewer`.

#### mdb.maintenanceTask.editor {#mdb-maintenanceTask-editor}

Роль `mdb.maintenanceTask.editor` предоставляет доступ к управлению заданиями на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных и изменять такие задания, просматривать информацию о кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.maintenanceTask.viewer`, `managed-clickhouse.maintenanceTask.editor`, `managed-greenplum.maintenanceTask.editor`, `managed-kafka.maintenanceTask.editor`, `managed-mongodb.maintenanceTask.editor`, `managed-mysql.maintenanceTask.editor`, `managed-opensearch.maintenanceTask.editor`, `managed-postgresql.maintenanceTask.editor`, `managed-redis.maintenanceTask.editor` и `managed-spqr.maintenanceTask.editor`.

При создании кластера Greenplum® вместе с ним автоматически создается пользователь-администратор с ролью `mdb_admin`. Эта роль заменяет суперпользователя при работе с БД и не является аналогом роли `mdb.admin` в Yandex Cloud. Подробнее читайте в разделе [Пользователи и роли в Yandex MPP Analytics for PostgreSQL](../concepts/cluster-users.md).

#### vpc.publicAdmin {#vpc-public-admin}

Роль `vpc.publicAdmin` позволяет управлять NAT-шлюзами, публичными IP-адресами и внешней сетевой связностью, а также просматривать информацию о квотах, ресурсах и операциях с ресурсами сервиса. Роль предоставляет права администратора мультиинтерфейсных ВМ, обеспечивающих связность между несколькими сетями.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать список [облачных сетей](../../vpc/concepts/network.md#network) и информацию о них, а также настраивать внешний доступ к облачным сетям;
* управлять связностью нескольких облачных сетей;
* управлять мультиинтерфейсными ВМ, обеспечивающими связность между несколькими сетями;
* просматривать список [подсетей](../../vpc/concepts/network.md#subnet) и информацию о них, а также изменять подсети;
* просматривать информацию о [NAT-шлюзах](../../vpc/concepts/gateways.md), а также создавать, изменять и удалять их;
* просматривать список [адресов облачных ресурсов](../../vpc/concepts/address.md) и информацию о них, а также создавать, изменять и удалять публичные IP-адреса;
* просматривать список [таблиц маршрутизации](../../vpc/concepts/routing.md#rt-vpc) и информацию о них, а также привязывать таблицы маршрутизации к подсетям;
* просматривать список [групп безопасности](../../vpc/concepts/security-groups.md) и информацию о них;
* просматривать информацию об использованных IP-адресах в подсетях;
* просматривать информацию о [квотах](../../vpc/concepts/limits.md#vpc-quotas) сервиса Virtual Private Cloud;
* просматривать информацию об операциях с ресурсами сервиса Virtual Private Cloud;
* просматривать информацию об операциях с ресурсами сервиса Compute Cloud;
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

Роль можно назначить на облако или каталог.

{% note warning %}

Если сеть и подсеть находятся в разных каталогах, то наличие роли `vpc.publicAdmin` проверяется на том каталоге, в котором находится сеть.

{% endnote %}


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

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль [managed-greenplum.editor или выше](../../iam/concepts/access-control/roles.md) на каталог, в котором создается кластер. Роль `managed-greenplum.viewer` позволит только просматривать список кластеров.

Чтобы создать кластер Greenplum®, нужна роль [vpc.user](../../vpc/security/index.md#vpc-user) и роль `managed-greenplum.editor` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `managed-greenplum.admin` вместо `managed-greenplum.editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


_Greenplum® и Greenplum Database® являются зарегистрированными товарными знаками или товарными знаками Broadcom Inc в США и/или других странах._