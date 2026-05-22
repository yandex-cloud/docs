# История изменений в Yandex Identity and Access Management

## Апрель 2026 {#april-2026}

### Изменения в сервисе Identity and Access Management {#iam-april-2026}

* Добавлено поле `MASKED KEY`, показывающее 6 последних символов секретной части ключа в выводе списка API-ключей.

### Новые роли {#roles-april-2026}

{% cut "Yandex Cloud Notification Service" %}

   Роль | Описание
   --- | ---
   `notifications.admin` | Позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.
   `notifications.auditor` | Позволяет просматривать метаданные всех каналов уведомлений, метаданные топиков, а также информацию о квотах сервиса.
   `notifications.editor` | Позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.
   `notifications.publisher` | Позволяет отправлять уведомления во все каналы и топики.
   `notifications.viewer` | Позволяет просматривать информацию о топиках и каналах уведомлений, а также о квотах сервиса.

{% endcut %}

{% cut "Yandex DataLens" %}

   Роль | Описание
   --- | ---
   `datalens.metaReader` | Позволяет выполнять запросы из раздела Audit в [DataLens Public API](../datalens/operations/api-start.md).

{% endcut %}

{% cut "Yandex Cloud DNS" %}

   Роль | Описание
   --- | ---
   `dns.firewallEditor` | Позволяет управлять DNS-фильтрами и использовать облака, каталоги и облачные сети в качестве ресурсов для них.
   `dns.firewallUser` | Позволяет использовать облака, каталоги и облачные сети в качестве ресурсов для DNS-фильтров, а также просматривать информацию о ресурсах и квотах сервиса.

{% endcut %}

{% cut "Yandex Identity Hub" %}

   Роль | Описание
   --- | ---
   `organization-manager.groups.viewer` | Позволяет просматривать информацию о группах пользователей и о назначенных правах доступа к ним, а также просматривать список пользователей и сервисных аккаунтов, входящих в группу.

{% endcut %}

{% cut "Yandex Managed Service for Kubernetes" %}

   Роль | Описание
   --- | ---
   `k8s.cluster-api.admin` | Предоставляет группу `yc:k8s-core-admin` и роль `admin` в Kubernetes RBAC.

{% endcut %}

{% cut "Управляемые базы данных" %}

   Роль | Описание
   --- | ---
   `mdb.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных и изменять такие задания, просматривать информацию о кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервисов.
   `mdb.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных, а также информацию о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервисов.
   `mdb.switcher` | Позволяет переназначать хост-мастер в кластерах управляемых баз данных, просматривать информацию о кластерах, хостах, базах данных и пользователях, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервисов.

{% endcut %}

## Март 2026 {#march-2026}

### Новые роли {#roles-march-2026}

{% cut "Yandex AI Studio" %}

   Роль | Описание
   --- | ---
   `ai.guardrails.admin` | Позволяет просматривать информацию о правилах модерации ответов моделей, а также создавать, применять, изменять и удалять такие правила.
   `ai.guardrails.auditor` | Позволяет просматривать метаданные правил модерации ответов моделей.
   `ai.guardrails.editor` | Позволяет просматривать информацию о правилах модерации ответов моделей, а также создавать, применять, изменять и удалять такие правила.
   `ai.guardrails.user` | Позволяет применять правила модерации ответов моделей и просматривать метаданные таких правил.
   `ai.guardrails.viewer` | Позволяет просматривать информацию о правилах модерации ответов моделей.

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-greenplum.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Greenplum® и изменять такие задания, просматривать информацию о кластерах Greenplum® и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-greenplum.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Greenplum®, а также о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервиса.
   `managed-greenplum.user` | Позволяет использовать кластеры Greenplum®.

{% endcut %}

{% cut "Yandex Managed Service for Apache Airflow™" %}

   Роль | Описание
   --- | ---
   `managed-airflow.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Apache Airflow™ и изменять такие задания, просматривать информацию о кластерах Apache Airflow™ и назначенных правах доступа к ним, а также о квотах сервиса.
   `managed-airflow.maintenanceTask.viewer` | Позволяет просматривать информацию о кластерах Apache Airflow™ и назначенных правах доступа к ним, о заданиях на техническое обслуживание таких кластеров, а также о квотах сервиса.

{% endcut %}

{% cut "Yandex Managed Service for Apache Kafka®" %}

   Роль | Описание
   --- | ---
   `managed-kafka.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Apache Kafka® и изменять такие задания, просматривать информацию о кластерах Apache Kafka® и назначенных правах доступа к ним, а также о квотах и операциях с ресурсами сервиса.
   `managed-kafka.maintenanceTask.viewer` | Позволяет просматривать информацию о кластерах Apache Kafka® и назначенных правах доступа к ним, о заданиях на техническое обслуживание таких кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-kafka.user` | Позволяет использовать кластеры Apache Kafka®.

{% endcut %}

{% cut "Yandex Managed Service for Apache Spark™" %}

   Роль | Описание
   --- | ---
   `managed-spark.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Apache Spark™ и изменять такие задания, просматривать информацию о кластерах Apache Spark™ и назначенных правах доступа к ним, а также о квотах сервиса.
   `managed-spark.maintenanceTask.viewer` | Позволяет просматривать информацию о кластерах Apache Spark™ и назначенных правах доступа к ним, а также о заданиях на техническое обслуживание таких кластеров и квотах сервиса.

{% endcut %}

{% cut "Yandex Managed Service for ClickHouse®" %}

   Роль | Описание
   --- | ---
   `managed-clickhouse.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров ClickHouse® и изменять такие задания, просматривать информацию о кластерах ClickHouse® и назначенных правах доступа к ним, а также о квотах и операциях с ресурсами сервиса.
   `managed-clickhouse.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров ClickHouse®, о кластерах ClickHouse® и назначенных правах доступа к ним, а также о квотах и операциях с ресурсами сервиса.
   `managed-clickhouse.user` | Позволяет использовать кластеры ClickHouse®.

{% endcut %}

{% cut "Yandex Managed Service for MySQL®" %}

   Роль | Описание
   --- | ---
   `managed-mysql.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров MySQL® и изменять такие задания, просматривать информацию о кластерах MySQL® и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-mysql.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров MySQL®, а также о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервиса.
   `managed-mysql.switcher` | Позволяет переназначать хост-мастер в кластерах MySQL®, просматривать информацию о кластерах, хостах, базах данных и пользователях MySQL®, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.
   `managed-mysql.user` | Позволяет использовать кластеры MySQL®.

{% endcut %}

{% cut "Yandex Managed Service for OpenSearch" %}

   Роль | Описание
   --- | ---
   `managed-opensearch.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров OpenSearch и изменять такие задания, просматривать информацию о кластерах OpenSearch и назначенных правах доступа к ним, а также о квотах и операциях с ресурсами сервиса.
   `managed-opensearch.maintenanceTask.viewer` | Позволяет просматривать информацию о кластерах OpenSearch и назначенных правах доступа к ним, о заданиях на техническое обслуживание таких кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-opensearch.user` | Позволяет использовать кластеры OpenSearch.

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-postgresql.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров PostgreSQL и изменять такие задания, просматривать информацию о кластерах PostgreSQL и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-postgresql.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров PostgreSQL, а также о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях, о квотах и операциях с ресурсами сервиса.
   `managed-postgresql.switcher` | Позволяет переназначать хост-мастер в кластерах PostgreSQL, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.
   `managed-postgresql.user` | Позволяет использовать кластеры PostgreSQL.

{% endcut %}

{% cut "Yandex Managed Service for Sharded PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-spqr.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Sharded PostgreSQL и изменять такие задания, просматривать информацию о кластерах Sharded PostgreSQL и назначенных правах доступа к ним, а также о хостах кластеров, квотах и операциях с ресурсами сервиса.
   `managed-spqr.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Sharded PostgreSQL, а также о таких кластерах и назначенных правах доступа к ним, о хостах кластеров, квотах и операциях с ресурсами сервиса.

{% endcut %}

{% cut "Yandex Managed Service for Trino" %}

   Роль | Описание
   --- | ---
   `managed-trino.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Trino и изменять такие задания, просматривать информацию о кластерах Trino и назначенных правах доступа к ним, а также о квотах сервиса.
   `managed-trino.maintenanceTask.viewer` | Позволяет просматривать информацию о кластерах Trino и назначенных правах доступа к ним, а также о заданиях на техническое обслуживание таких кластеров и квотах сервиса.

{% endcut %}

{% cut "Yandex Managed Service for Valkey™" %}

   Роль | Описание
   --- | ---
   `managed-redis.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Valkey™ и изменять такие задания, просматривать информацию о кластерах Valkey™ и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-redis.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Valkey™, а также о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервиса.
   `managed-redis.switcher` | Позволяет переназначать хост-мастер в кластерах Valkey™, просматривать информацию о хостах и кластерах Valkey™, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.
   `managed-redis.user` | Позволяет использовать кластеры Valkey™.

{% endcut %}

{% cut "Yandex StoreDoc" %}

   Роль | Описание
   --- | ---
   `managed-mongodb.maintenanceTask.editor` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Yandex StoreDoc и изменять такие задания, просматривать информацию о кластерах Yandex StoreDoc и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервиса.
   `managed-mongodb.maintenanceTask.viewer` | Позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Yandex StoreDoc, а также о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервиса.
   `managed-mongodb.switcher` | Позволяет переназначать хост-мастер в кластерах Yandex StoreDoc, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях Yandex StoreDoc, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.
   `managed-mongodb.user` | Позволяет использовать кластеры Yandex StoreDoc.

{% endcut %}

## Февраль 2026 {#february-2026}

### Изменения в сервисе Identity and Access Management {#iam-february-2026}

* Добавлены [политики авторизации](concepts/access-control/access-policies.md).

### Новые роли {#roles-february-2026}

{% cut "Yandex Cloud Backup" %}

   Роль | Описание
   --- | ---
   `backup.auditor` | Позволяет просматривать информацию о виртуальных машинах и серверах BareMetal, подключенных к сервису Cloud Backup, о политиках резервного копирования и квотах сервиса, а также об облаке и каталоге.

{% endcut %}

## Декабрь 2025 {#december-2025}

### Изменения в сервисе Identity and Access Management {#iam-december-2025}

* Добавлены [эфемерные ключи](concepts/authorization/ephemeral-keys.md).
* В Terraform-ресурсе `yandex_iam_oauth_client` исправлено сравнение полей `scopes` и `redirect_uris`: они теперь имеют тип set, чтобы избежать коллизий при сравнении.

### Новые роли {#roles-december-2025}

{% cut "Yandex Cloud Backup" %}

   Роль | Описание
   --- | ---
   `backup.user` | Позволяет подключать провайдеров резервного копирования, подключать к сервису виртуальные машины и серверы Yandex BareMetal, привязывать политики резервного копирования к виртуальным машинам и серверам Yandex BareMetal и отвязывать их, а также просматривать информацию о ресурсах и квотах сервиса.

{% endcut %}

{% cut "Yandex Managed Service for MySQL®" %}

   Роль | Описание
   --- | ---
   `managed-mysql.clusters.connector` | Позволяет пользователям Yandex Cloud подключаться к базам данных в кластерах Yandex Managed Service for MySQL® с помощью механизмов сервиса Yandex Identity and Access Management.

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-postgresql.clusters.connector` | Позволяет пользователям Yandex Cloud подключаться к базам данных в кластерах Yandex Managed Service for PostgreSQL с помощью механизмов сервиса Yandex Identity and Access Management.

{% endcut %}

{% cut "Yandex Monium" %}

   Роль | Описание
   --- | ---
   `monium.admin` | Позволяет управлять ресурсами Monium, просматривать и записывать все виды телеметрии, а также управлять проектами и доступом к ним.
   `monium.editor` | Позволяет управлять ресурсами Monium, просматривать и записывать все виды телеметрии.
   `monium.viewer` | Позволяет просматривать информацию о ресурсах Monium с возможностью чтения всех видов телеметрии.
   `monium.auditor` | Позволяет просматривать информацию о ресурсах Monium.
   `monium.alerts.editor` | Позволяет просматривать список алертов, их настройки и историю срабатываний, а также создавать, изменять и удалять алерты.
   `monium.alerts.viewer` | Позволяет просматривать список алертов, их настройки и историю срабатываний.
   `monium.channels.editor` | Позволяет просматривать список и информацию о каналах уведомлений для алертов, а также создавать, изменять и удалять каналы уведомлений.
   `monium.channels.viewer` | Позволяет просматривать список и информацию о каналах уведомлений для алертов.
   `monium.contextLinks.editor` | Позволяет просматривать настроенные контекстные ссылки на графиках дашбордов, а также создавать, изменять и удалять контекстные ссылки.
   `monium.contextLinks.viewer` | Позволяет просматривать настроенные контекстные ссылки на графиках дашбордов.
   `monium.dashboards.editor` | Позволяет просматривать дашборды и их виджеты, а также создавать, изменять и удалять дашборды.
   `monium.dashboards.viewer` | Позволяет просматривать дашборды и их виджеты.
   `monium.escalationPolicies.editor` | Позволяет просматривать список и настройки политик эскалации для алертов, а также создавать, изменять и удалять политики эскалации.
   `monium.escalationPolicies.viewer` | Позволяет просматривать список и настройки политик эскалации для алертов.
   `monium.escalations.editor` | Позволяет просматривать информацию об уведомлениях и эскалациях для алертов, а также создавать, изменять и удалять эскалации.
   `monium.escalations.viewer` | Позволяет просматривать информацию об уведомлениях и эскалациях для алертов.
   `monium.logErrorLabels.editor` | Позволяет просматривать, а также добавлять новые, редактировать и удалять существующие лейблы к ошибкам в логах.
   `monium.logErrorLabels.viewer` | Позволяет просматривать лейблы, привязанные к ошибкам в логах.
   `monium.logs.reader` | Позволяет читать логи и просматривать статистику ошибок по логам.
   `monium.logs.writer` | Позволяет записывать логи.
   `monium.metrics.reader` | Позволяет читать метрики, их значения и метки.
   `monium.metrics.writer` | Позволяет записывать метрики.
   `monium.mutes.editor` | Позволяет просматривать, а также создавать, изменять и удалять мьюты — правила временного отключения уведомлений для алертов.
   `monium.mutes.viewer` | Позволяет просматривать мьюты — правила временного отключения уведомлений для алертов.
   `monium.quickLinks.editor` | Позволяет просматривать список настроенных быстрых ссылок и информацию о них в меню проекта, а также создавать, изменять и удалять быстрые ссылки.
   `monium.quickLinks.viewer` | Позволяет просматривать список настроенных быстрых ссылок и информацию о них в меню проектов.
   `monium.serviceLevelObjectives.editor` | Позволяет просматривать настроенные SLO (Service Level Objectives), а также создавать, изменять и удалять SLO.
   `monium.serviceLevelObjectives.viewer` | Позволяет просматривать настроенные SLO (Service Level Objectives).
   `monium.shards.editor` | Позволяет просматривать информацию о шардах, кластерах, сервисах и их квотах, а также создавать, изменять и удалять шарды.
   `monium.shards.viewer` | Позволяет просматривать информацию о шардах, кластерах, сервисах и их квотах.
   `monium.telemetry.reader` | Позволяет читать все виды телеметрии Monium: метрики, логи и распределенные трассировки.
   `monium.telemetry.writer` | Позволяет записывать все виды телеметрии Monium: метрики, логи и распределенные трассировки.
   `monium.traces.reader` | Позволяет просматривать данные распределенных трассировок.
   `monium.traces.writer` | Позволяет записывать данные распределенных трассировок.

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-greenplum.clusters.connector` | Позволяет пользователям Yandex Cloud подключаться к базам данных в кластерах Yandex MPP Analytics for PostgreSQL с помощью механизмов сервиса Yandex Identity and Access Management.

{% endcut %}

{% cut "Yandex Security Deck" %}

   Роль | Описание
   --- | ---
   `security-deck.alertSinks.admin` | Позволяет управлять приемниками алертов и алертами, а также доступом к ним.
   `security-deck.alertSinks.editor` | Позволяет управлять приемниками алертов, алертами и комментариями в них.
   `security-deck.alertSinks.user` | Позволяет просматривать информацию о приемниках алертов и использовать их.
   `security-deck.alertSinks.viewer` | Позволяет просматривать информацию об алертах и приемниках алертов, а также о назначенных правах доступа к ним.
   `security-deck.alertSinks.auditor` | Позволяет просматривать информацию о приемниках алертов и назначенных правах доступа к ним.

{% endcut %}

## Ноябрь 2025 {#november-2025}

### Изменения в сервисе Identity and Access Management {#iam-november-2025}

* [Добавлена](../organization/operations/view-subject-access-bindings.md) возможность посмотреть список доступов субъекта.

### Новые роли {#roles-november-2025}

{% cut "Yandex Cloud Interconnect" %}

   Роль | Описание
   --- | ---
   `cic.admin` | Позволяет управлять ресурсами сервиса Cloud Interconnect.

{% endcut %}

{% cut "Yandex Cloud Router" %}

   Роль | Описание
   --- | ---
   `cloud-router.admin` | Позволяет управлять ресурсами сервиса Cloud Router.
   `cloud-router.prefixEditor` | Позволяет управлять IP-префиксами облачных подсетей в Routing Instance, а также просматривать информацию о ресурсах сервиса Cloud Router.

{% endcut %}

{% cut "Yandex Identity Hub" %}

   Роль | Описание
   --- | ---
   `organization-manager.idpInstances.billingAdmin` | Позволяет управлять подпиской на платные возможности сервиса Yandex Identity Hub.
   `organization-manager.idpInstances.billingViewer` | Позволяет просматривать список пользователей, которые в текущем отчетном периоде используют квоту для аутентификации в Yandex Identity Hub, а также информацию о подписке на платные возможности сервиса Yandex Identity Hub и статистике использования квот по этой подписке.

{% endcut %}

## Октябрь 2025 {#october-2025}

### Изменения в сервисе Identity and Access Management {#iam-october-2025}

* [Добавлена](operations/service-control/enable-disable.md) возможность управлять доступом сервисов к ресурсам пользователя.

### Новые роли {#roles-october-2025}

{% cut "Управляемые базы данных" %}

   Роль | Описание
   --- | ---
   `mdb.restorer` | Позволяет восстанавливать кластеры управляемых баз данных из резервных копий, а также предоставляет доступ к чтению информации из кластеров и к логам их работы.

{% endcut %}

{% cut "Yandex Identity Hub" %}

   Роль | Описание
   --- | ---
   `organization-manager.groups.externalConverter` | Позволяет добавлять в группы пользователей Yandex Identity Hub атрибут с идентификатором внешней группы при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.
   `organization-manager.groups.externalCreator` | Позволяет создавать группы пользователей Yandex Identity Hub при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.
   `organization-manager.userpools.syncAgent` | Позволяет выполнять синхронизацию пользователей и групп Yandex Identity Hub с пользователями и группами в каталоге Active Directory или другом внешнем источнике.

{% endcut %}

{% cut "Yandex Managed Service for Apache Kafka®" %}

   Роль | Описание
   --- | ---
   `managed-kafka.restorer` | Позволяет восстанавливать кластеры Apache Kafka® из резервных копий, просматривать информацию о кластерах и логи их работы, а также данные о квотах и операциях с ресурсами сервиса Managed Service for Apache Kafka®.

{% endcut %}

{% cut "Yandex Managed Service for ClickHouse®" %}

   Роль | Описание
   --- | ---
   `managed-clickhouse.restorer` | Позволяет восстанавливать кластеры ClickHouse® из резервных копий, просматривать информацию о кластерах ClickHouse® и логи их работы, а также данные о квотах и операциях с ресурсами сервиса Managed Service for ClickHouse®.

{% endcut %}


{% cut "Yandex Managed Service for MySQL®" %}

   Роль | Описание
   --- | ---
   `managed-mysql.restorer` | Позволяет восстанавливать кластеры MySQL® из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях MySQL®, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса Managed Service for MySQL®.

{% endcut %}

{% cut "Yandex Managed Service for OpenSearch" %}

   Роль | Описание
   --- | ---
   `managed-opensearch.restorer` | Позволяет восстанавливать кластеры OpenSearch из резервных копий, просматривать информацию о кластерах OpenSearch, логи их работы, а также информацию о квотах и операциях с ресурсами сервиса Managed Service for OpenSearch.

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-postgresql.restorer` | Позволяет восстанавливать кластеры PostgreSQL из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса Managed Service for PostgreSQL.

{% endcut %}

{% cut "Yandex Managed Service for Sharded PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-spqr.restorer` | Позволяет восстанавливать кластеры Sharded PostgreSQL из резервных копий, а также просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах Sharded PostgreSQL, логи работы кластеров, данные о квотах и операциях с ресурсами сервиса Managed Service for Sharded PostgreSQL.

{% endcut %}


{% cut "Yandex Managed Service for Valkey™" %}

   Роль | Описание
   --- | ---
   `managed-redis.restorer` | Позволяет восстанавливать кластеры Valkey™ из резервных копий, а также просматривать информацию о хостах и кластерах Valkey™, логи их работы, данные о квотах и операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

   Роль | Описание
   --- | ---
   `managed-greenplum.restorer` | Позволяет восстанавливать кластеры Greenplum® из резервных копий, просматривать информацию о кластерах и хостах Greenplum®, логи их работы, а также данные о квотах и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

{% endcut %}

{% cut "Yandex StoreDoc" %}

   Роль | Описание
   --- | ---
   `managed-mongodb.restorer` | Позволяет восстанавливать кластеры MongoDB из резервных копий, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях MongoDB, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса Yandex StoreDoc.

{% endcut %}

## III квартал 2025 {#q3-2025}

* Реализовано управление секретами OAuth-клиентов с помощью [CLI](../cli/cli-ref/iam/cli-ref/oauth-client-secret/index.md) и [API](api-ref/OAuthClientSecret/index.md). <code><b><small>CLI</small></b></code> <code><b><small>API</small></b></code>
* В [CLI](../cli/cli-ref/iam/cli-ref/oauth-client/index.md) и [API](api-ref/OAuthClient/index.md) добавлена группа команд для управления OAuth-клиентами. <code><b><small>CLI</small></b></code> <code><b><small>API</small></b></code>

## II квартал 2025 {#q2-2025}

* Добавлено создание и использование [Refresh-токенов](concepts/authorization/refresh-token.md). <code><b><small>CLI</small></b></code>

## I квартал 2025 {#q1-2025}

* [Добавлены](concepts/authorization/api-key.md#scoped-api-keys) новые области действия для API-ключей и возможность назначать больше одной области действия в сервисе. <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>
* [Федерации сервисных аккаунтов](concepts/workload-identity.md) (Workload Identity Federation) стали [доступны](../overview/concepts/launch-stages.md) всем пользователям. <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>
* [Добавлено](concepts/authorization/id-token.md) создание ID-токена для сервисного аккаунта, специального короткоживущего токена для аутентификации в сторонних системах. <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>


## IV квартал 2024 {#q4-2024}

* [Добавлена](at-ref.md#data-plane-events) отправка события уровня сервисов `CreateIamToken` при создании IAM-токена.
* Расширена область действия [API-ключей с ограниченным сроком](concepts/authorization/api-key.md#supported-services) для работы с [Yandex Managed Service for YDB](../ydb/index.md) в режиме совместимости с PostgreSQL, [Yandex Cloud Postbox](../postbox/index.md) и [Yandex Serverless Containers](../serverless-containers/index.md). <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>
* Добавлено отображение даты и времени последней аутентификации сервисного аккаунта. Информация доступна в поле `last_authenticated_at` с помощью команды `yc iam user-account get` [Yandex Cloud CLI](../cli/cli-ref/iam/cli-ref/user-account/get.md). <code><b><small>CLI</small></b></code>


## III квартал 2024 {#q3-2024}

* Появились [федерации сервисных аккаунтов](concepts/workload-identity.md) (Workload Identity Federation), которые позволяют предоставлять доступ внешним приложениям без использования долгоживущих ключей доступа. <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>
* Добавлена возможность создавать [API-ключи с ограниченным сроком и областью действия](concepts/authorization/api-key.md#scoped-api-keys). <code><b><small>Консоль управления</small></b></code> <code><b><small>CLI</small></b></code> <code><b><small>Terraform</small></b></code> <code><b><small>API</small></b></code>
* Добавлен метод REST API [ResolveAgent](api-ref/ServiceControl/resolveAgent.md). <code><b><small>API</small></b></code>
* Добавлена возможность отзывать [IAM-токен](concepts/authorization/iam-token.md) с помощью [Yandex Cloud CLI](../cli/cli-ref/iam/cli-ref/revoke-token.md). <code><b><small>CLI</small></b></code>
* Появились [системные группы](concepts/access-control/system-group.md) `All users in organization X` и `All users in federation N`.
* Добавлен источник данных Terraform, который позволяет получить идентификатор [сервисного агента](concepts/service-control.md#service-agent). <code><b><small>Terraform</small></b></code>


## II квартал 2024 {#q2-2024}

* Добавлено отображение даты последнего использования ключей доступа сервисных аккаунтов. Информация доступна на странице сервисного аккаунта в [консоли управления](https://console.yandex.cloud), а также в поле `last_used_at` при вызове методов управления ключами доступа через API. <code><b><small>Консоль управления</small></b></code> <code><b><small>API</small></b></code>


## I квартал 2024 {#q1-2024}

* Добавлен компонент [Security Token Service](concepts/authorization/sts.md) для получения временных ключей доступа, совместимых с [AWS S3 API](../storage/s3/index.md). Функциональность находится на [стадии Preview](../overview/concepts/launch-stages.md). <code><b><small>CLI</small></b></code> <code><b><small>API</small></b></code>
* Добавлена поддержка аутентификации OAuth-клиентов с помощью аутентификации токена сервисного аккаунта.
* Добавлена возможность использования идентификатора для маскированного токена для логов Audit Trails.
* Улучшен механизм ротации ключей в [OpenID Connect](https://openid.net/).