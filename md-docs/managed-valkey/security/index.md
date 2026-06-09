# Управление доступом в {{ mrd-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `managed-redis.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Чтобы разрешить доступ к ресурсам сервиса (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

В [консоли управления]({{ link-console-main }}), через [CLI](../../cli/index.md) или [API](../api-ref/authentication.md) роль также можно назначить на отдельный кластер.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

```mermaid
%%{
  init: {
    "flowchart": { "defaultRenderer": "elk" },
    "elk": { "nodePlacementStrategy": "BRANDES_KOEPF" }
  }
}%%
flowchart BT
    managed-redis.clusters.connector["`managed-redis.
    clusters.connector`"] ~~~ mdb.auditor
    vpc.publicAdmin ~~~ mdb.admin
    managed-redis.auditor --> mdb.auditor
    mdb.auditor --> mdb.maintenanceTask.viewer
    mdb.auditor --> mdb.viewer
    mdb.viewer --> mdb.admin
    managed-redis.restorer --> mdb.restorer
    mdb.viewer --> mdb.restorer
    managed-redis.viewer --> mdb.viewer
    managed-redis.viewer --> managed-redis.restorer
    managed-redis.maintenanceTask.viewer --> mdb.maintenanceTask.viewer["`mdb.maintenanceTask.
    viewer`"]
    managed-redis.maintenanceTask.viewer --> managed-redis.maintenanceTask.editor["`managed-redis.
    maintenanceTask.editor`"]
    mdb.maintenanceTask.viewer --> mdb.maintenanceTask.editor
    managed-redis.maintenanceTask.editor --> mdb.maintenanceTask.editor["`mdb.maintenanceTask.
    editor`"]
    managed-redis.switcher --> managed-redis.editor
    managed-redis.restorer --> managed-redis.editor
    managed-redis.maintenanceTask.editor --> managed-redis.editor
    managed-redis.auditor --> managed-redis.maintenanceTask.viewer["`managed-redis.
    maintenanceTask.viewer`"]
    managed-redis.user --> managed-redis.editor
    managed-redis.editor --> managed-redis.admin
    managed-redis.admin --> mdb.admin
    managed-redis.switcher --> mdb.switcher
    managed-redis.viewer --> managed-redis.switcher
    managed-redis.maintenanceTask.viewer --> managed-redis.viewer
```

### Сервисные роли {#service-roles}

#### managed-redis.clusters.connector {#managed-redis-clusters-connector}

Роль `managed-redis.clusters.connector` позволяет [пользователям](../../iam/concepts/users/accounts.md) {{ yandex-cloud }} подключаться к базам данных в [кластерах {{ VLK }}](../concepts/index.md) с помощью механизмов сервиса [{{ iam-full-name }}](../../iam/index.md).

#### managed-redis.auditor {#managed-redis-auditor}

Роль `managed-redis.auditor` позволяет просматривать информацию о [кластерах](../concepts/index.md) {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, а также о [квотах](../concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

#### managed-redis.viewer {#managed-redis-viewer}

Роль `managed-redis.viewer` позволяет просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../concepts/index.md) {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролями `managed-redis.auditor` и `managed-redis.maintenanceTask.viewer`.

#### managed-redis.restorer {#managed-redis-restorer}

Роль `managed-redis.restorer` позволяет восстанавливать кластеры {{ VLK }} из резервных копий, а также просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров {{ VLK }}, а также восстанавливать [кластеры](../concepts/index.md) из резервных копий;
* просматривать информацию о кластерах {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

#### managed-redis.user {#managed-redis-user}

Роль `managed-redis.user` позволяет использовать [кластеры {{ VLK }}](../concepts/index.md).

#### managed-redis.switcher {#managed-redis-switcher}

Роль `managed-redis.switcher` позволяет переназначать хост-мастер в кластерах {{ VLK }}, просматривать информацию о хостах и кластерах {{ VLK }}, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах {{ VLK }}](../concepts/index.md);
* просматривать информацию о кластерах {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }};
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров {{ VLK }};
* просматривать информацию о [шардах](../concepts/sharding.md) кластеров {{ VLK }};
* просматривать [информацию](../operations/user-list.md) о пользователях {{ VLK }};
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров {{ VLK }};
* просматривать информацию об алертах {{ VLK }};
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

#### managed-redis.editor {#managed-redis-editor}

Роль `managed-redis.editor` позволяет управлять кластерами {{ VLK }}.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах](../concepts/index.md) {{ VLK }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к кластерам {{ VLK }};
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров {{ VLK }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ VLK }};
* просматривать информацию о [шардах](../concepts/sharding.md) кластеров {{ VLK }}, а также создавать и удалять их;
* просматривать [информацию](../operations/user-list.md) о пользователях {{ VLK }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров {{ VLK }}, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ VLK }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролями `managed-redis.viewer`, `managed-redis.restorer`, `managed-redis.user`, `managed-redis.switcher` и `managed-redis.maintenanceTask.editor`.

Для создания кластеров {{ VLK }} дополнительно необходима роль `vpc.user`.

#### managed-redis.admin {#managed-redis-admin}

Роль `managed-redis.admin` позволяет управлять кластерами {{ VLK }} и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к [кластерам](../concepts/index.md) {{ VLK }} и изменять такие права доступа;
* просматривать информацию о кластерах {{ VLK }}, а также создавать, использовать, изменять, удалять, запускать и останавливать их;
* просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания;
* просматривать информацию о [хостах](../concepts/instance-types.md) кластеров {{ VLK }}, а также создавать, изменять и удалять их;
* переназначать хост-мастер в кластерах {{ VLK }};
* просматривать информацию о [шардах](../concepts/sharding.md) кластеров {{ VLK }}, а также создавать и удалять их;
* просматривать [информацию](../operations/user-list.md) о пользователях {{ VLK }}, а также создавать, изменять и удалять таких пользователей;
* просматривать информацию о [резервных копиях](../concepts/backup.md) кластеров {{ VLK }}, создавать резервные копии и восстанавливать кластеры из резервных копий;
* просматривать информацию об алертах {{ VLK }}, а также создавать, изменять и удалять их;
* просматривать логи работы кластеров {{ VLK }};
* просматривать информацию о [квотах](../concepts/limits.md#mrd-quotas) сервиса {{ mrd-full-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.editor`.

Для создания кластеров {{ VLK }} дополнительно необходима роль `vpc.user`.

#### managed-redis.maintenanceTask.viewer {#managed-redis-maintenanceTask-viewer}

Роль `managed-redis.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }}, а также о таких [кластерах](../concepts/index.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, о [квотах](../concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.auditor`.

#### managed-redis.maintenanceTask.editor {#managed-redis-maintenanceTask-editor}

Роль `managed-redis.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../concepts/maintenance.md) кластеров {{ VLK }} и изменять такие задания, просматривать информацию о [кластерах](../concepts/index.md) {{ VLK }} и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, о [хостах](../concepts/instance-types.md) и [резервных копиях](../concepts/backup.md) кластеров, а также о [квотах](../concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса {{ mrd-full-name }}.

Включает разрешения, предоставляемые ролью `managed-redis.maintenanceTask.viewer`.

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

#### mdb.switcher {#mdb-switcher}

Роль `mdb.switcher` позволяет переназначать хост-мастер в кластерах управляемых баз данных, а также предоставляет доступ к информации о кластерах и к логам их работы.

Пользователи с этой ролью могут переназначать хост-мастер в кластерах управляемых баз данных, просматривать информацию о кластерах, хостах, базах данных и пользователях, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-mongodb.switcher`, `managed-mysql.switcher`, `managed-postgresql.switcher` и `managed-redis.switcher`.

#### mdb.maintenanceTask.viewer {#mdb-maintenanceTask-viewer}

Роль `mdb.maintenanceTask.viewer` предоставляет доступ к информации о заданиях на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных, а также информацию о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.auditor`, `managed-clickhouse.maintenanceTask.viewer`, `managed-greenplum.maintenanceTask.viewer`, `managed-kafka.maintenanceTask.viewer`, `managed-mongodb.maintenanceTask.viewer`, `managed-mysql.maintenanceTask.viewer`, `managed-opensearch.maintenanceTask.viewer`, `managed-postgresql.maintenanceTask.viewer`, `managed-redis.maintenanceTask.viewer` и `managed-spqr.maintenanceTask.viewer`.

#### mdb.maintenanceTask.editor {#mdb-maintenanceTask-editor}

Роль `mdb.maintenanceTask.editor` предоставляет доступ к управлению заданиями на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных и изменять такие задания, просматривать информацию о кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.maintenanceTask.viewer`, `managed-clickhouse.maintenanceTask.editor`, `managed-greenplum.maintenanceTask.editor`, `managed-kafka.maintenanceTask.editor`, `managed-mongodb.maintenanceTask.editor`, `managed-mysql.maintenanceTask.editor`, `managed-opensearch.maintenanceTask.editor`, `managed-postgresql.maintenanceTask.editor`, `managed-redis.maintenanceTask.editor` и `managed-spqr.maintenanceTask.editor`.

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
* просматривать информацию о [квотах](../../vpc/concepts/limits.md#vpc-quotas) сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ vpc-name }};
* просматривать информацию об операциях с ресурсами сервиса {{ compute-name }};
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `vpc.viewer`.

Роль можно назначить на облако или каталог.

{% note warning %}

Если сеть и подсеть находятся в разных каталогах, то наличие роли `vpc.publicAdmin` проверяется на том каталоге, в котором находится сеть.

{% endnote %}


### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../../overview/concepts/services.md) {{ yandex-cloud }}.

#### {{ roles-auditor }} {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе]({{ link-docs }}/resource-manager/concepts/resources-hierarchy);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### {{ roles-viewer }} {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов]({{ link-docs }}/overview/concepts/services) в режиме чтения.

#### {{ roles-editor }} {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления, а также удаления [ключей шифрования]({{ link-docs }}/kms/concepts/) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### {{ roles-admin }} {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами]({{ link-docs }}/resource-manager/concepts/resources-hierarchy) Yandex Cloud, кроме передачи прав владения [организацией]({{ link-docs }}/organization/concepts/organization) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако]({{ link-docs }}/resource-manager/concepts/resources-hierarchy#cloud) или [платежный аккаунт]({{ link-docs }}/billing/concepts/billing-account), ознакомьтесь с информацией о защите [привилегированных аккаунтов]({{ link-docs }}/security/standard/all#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях см. в [справочнике ролей {{ yandex-cloud }}](../../iam/roles-reference.md#primitive-roles).

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль [{{ roles.mrd.editor }} или выше](../../iam/concepts/access-control/roles.md) на каталог, в котором создается кластер. Роль `{{ roles.mrd.viewer }}` позволит только просматривать список кластеров.

Чтобы создать кластер {{ mrd-name }}, нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль `{{ roles.mrd.editor }}` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.mrd.admin }}` вместо `{{ roles.mrd.editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).