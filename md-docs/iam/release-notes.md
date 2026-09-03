[Документация Yandex Cloud](../index.md) > [Yandex Identity and Access Management](index.md) > История изменений

# История изменений в Yandex Identity and Access Management

## Август 2026 {#august-2026}

### Изменения в сервисе Identity and Access Management {#iam-august-2026}

* Роли `compute.editor` и `compute.admin` сервиса Compute Cloud, а также `baremetal.editor` и `baremetal.admin` сервиса BareMetal теперь включают разрешения роли [`backup.user`](../backup/security/index.md#backup-user).

### Новые роли {#roles-august-2026}

{% cut "Yandex Cloud Billing" %}

#### billing.usagerecords.admin {#billing-usagerecords-admin}

Роль `billing.usagerecords.admin` назначается на [организацию](../organization/concepts/organization.md), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) или [каталог](../resource-manager/concepts/resources-hierarchy.md#folder). Позволяет просматривать детализацию потребления ресурсов без доступа к [платежному аккаунту](../billing/concepts/billing-account.md).

{% endcut %}

{% cut "Yandex Managed Service for ClickHouse®" %}

#### managed-clickhouse.clusters.connector {#managed-clickhouse-clusters-connector}

Роль `managed-clickhouse.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах ClickHouse®](../managed-clickhouse/concepts/index.md) с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

{% cut "Yandex Managed Service for GitLab" %}

#### gitlab.backupAdmin {#gitlab-backupadmin}

Роль `gitlab.backupAdmin` позволяет полностью управлять резервными копиями [инстансов](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab. Пользователи с этой ролью могут создавать и удалять резервные копии, восстанавливать из них инстансы, а также скачивать резервные копии, в том числе секреты GitLab из этих резервных копий.

Включает разрешения, предоставляемые ролями `gitlab.backupRestorer` и `gitlab.backupDownloader`.

#### gitlab.backupDownloader {#gitlab-backupdownloader}

Роль `gitlab.backupDownloader` позволяет скачивать резервные копии [инстансов](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab, в том числе секреты GitLab из этих резервных копий.

#### gitlab.backupRestorer {#gitlab-backuprestorer}

Роль `gitlab.backupRestorer` позволяет восстанавливать [инстансы](../managed-gitlab/concepts/index.md#instance) Managed Service for GitLab из резервных копий.

{% endcut %}

## Июль 2026 {#july-2026}

### Изменения в сервисе Identity and Access Management {#iam-july-2026}

* Добавлена возможность блокировки сервисного аккаунта и управления сроком его жизни.
* Добавлен шаблон [политики авторизации](concepts/access-control/access-policies.md#resourceManager-denyFolderRemoval) `resourceManager.denyFolderRemoval`, который позволяет запретить удаление каталогов.
* Добавлен шаблон [политики авторизации](concepts/access-control/access-policies.md#aistudio-responses-restrictNetworkAccess) `aistudio.responses.restrictNetworkAccess`, который позволяет ограничить доступ к Responses API в Yandex AI Studio по IP-адресам и облачным сетям.

### Новые роли {#roles-july-2026}

{% cut "Yandex Cloud Registry" %}

#### cloud-registry.artifacts.scanner {#cloud-registry-artifacts-scanner}

Роль `cloud-registry.artifacts.scanner` позволяет сканировать артефакты в реестрах на наличие уязвимостей, а также скачивать артефакты, просматривать информацию об артефактах и реестрах, о назначенных правах доступа к реестрам, а также о квотах сервиса Cloud Registry.

Пользователи с этой ролью могут:
* сканировать [артефакты](../cloud-registry/concepts/artifacts/index.md) в [реестрах](../cloud-registry/concepts/registry.md) на наличие уязвимостей;
* просматривать настройки и результаты сканирования артефактов на наличие уязвимостей;
* просматривать информацию об артефактах и скачивать их;
* просматривать информацию о реестрах;
* просматривать политики доступа к реестрам;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к реестрам, папкам внутри реестров и артефактам;
* просматривать информацию о [политиках жизненного цикла](../cloud-registry/concepts/lifecycle-policy.md) реестров;
* просматривать информацию о квотах сервиса Cloud Registry;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-registry.viewer`.

{% endcut %}

{% cut "Yandex Security Deck" %}

#### threat-detector.admin {#threat-detector-admin}

Роль `threat-detector.admin` позволяет просматривать информацию о правилах контроля безопасности [модуля Обнаружение угроз](../security-deck/concepts/threat-detector.md), создавать исключения из правил контроля безопасности, а также просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к модулю Обнаружение угроз и изменять их.

Включает разрешения, предоставляемые ролью `threat-detector.editor`.

#### threat-detector.auditor {#threat-detector-auditor}

Роль `threat-detector.auditor` позволяет просматривать информацию о правилах контроля безопасности [модуля Обнаружение угроз](../security-deck/concepts/threat-detector.md) и назначенных [правах доступа](concepts/access-control/index.md) к нему.

#### threat-detector.editor {#threat-detector-editor}

Роль `threat-detector.editor` позволяет просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к [модулю Обнаружение угроз](../security-deck/concepts/threat-detector.md) и правилах контроля безопасности этого модуля, а также создавать исключения из правил контроля безопасности.

Включает разрешения, предоставляемые ролью `threat-detector.viewer`.

#### threat-detector.viewer {#threat-detector-viewer}

Роль `threat-detector.viewer` позволяет просматривать информацию о правилах контроля безопасности [модуля Обнаружение угроз](../security-deck/concepts/threat-detector.md) и назначенных [правах доступа](concepts/access-control/index.md) к нему.

Включает разрешения, предоставляемые ролью `threat-detector.auditor`.

#### threat-detector.worker {#threat-detector-worker}

Роль `threat-detector.worker` позволяет просматривать логи, регистрируемые в инфраструктуре клиента, с помощью сервиса [Yandex Audit Trails](../audit-trails/index.md).

Роль выдается [сервисному аккаунту](concepts/users/service-accounts.md), от имени которого будет выполняться контроль безопасности с использованием модуля Обнаружение угроз, и назначается на организацию, облако или каталог. Этот сервисный аккаунт указывается при [создании](../security-deck/operations/workspaces/create.md) окружения.

#### vulnerability-manager.admin {#vulnerability-manager-admin}

Роль `vulnerability-manager.admin` позволяет просматривать информацию о заданиях сканирования [модуля Управление уязвимостями](../security-deck/concepts/vulnerability-management.md), запускать и изменять такие задания, а также просматривать результаты их выполнения.

Включает разрешения, предоставляемые ролью `vulnerability-manager.editor`.

#### vulnerability-manager.auditor {#vulnerability-manager-auditor}

Роль `vulnerability-manager.auditor` позволяет просматривать результаты сканирования [модуля Управление уязвимостями](../security-deck/concepts/vulnerability-management.md).

#### vulnerability-manager.editor {#vulnerability-manager-editor}

Роль `vulnerability-manager.editor` позволяет просматривать информацию о заданиях сканирования [модуля Управление уязвимостями](../security-deck/concepts/vulnerability-management.md), запускать и изменять такие задания, а также просматривать результаты их выполнения.

Включает разрешения, предоставляемые ролью `vulnerability-manager.viewer`.

#### vulnerability-manager.viewer {#vulnerability-manager-viewer}

Роль `vulnerability-manager.viewer` позволяет просматривать информацию о заданиях сканирования [модуля Управление уязвимостями](../security-deck/concepts/vulnerability-management.md) и результаты сканирования в рамках этих заданий.

Включает разрешения, предоставляемые ролью `vulnerability-manager.auditor`.

{% endcut %}

{% cut "Yandex StoreDoc" %}

#### managed-mongodb.clusters.connector {#managed-mongodb-clusters-connector}

Роль `managed-mongodb.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах Yandex StoreDoc](../storedoc/concepts/index.md) с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

## Июнь 2026 {#june-2026}

### Изменения в сервисе Identity and Access Management {#iam-june-2026}

* Добавлен шаблон [политики авторизации](concepts/access-control/access-policies.md#resourceManager-denyCloudRemoval) `resourceManager.denyCloudRemoval`, который позволяет запретить удаление облаков.

### Новые роли {#roles-june-2026}

{% cut "Apache Hive™ Metastore" %}

#### managed-metastore.maintenanceTask.editor {#managed-metastore-maintenancetask-editor}

Роль `managed-metastore.maintenanceTask.editor` позволяет просматривать информацию о заданиях на техническое обслуживание [кластеров Apache Hive™ Metastore](../metadata-hub/concepts/metastore.md) и изменять такие задания, просматривать информацию о кластерах Apache Hive™ Metastore и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о квотах сервисов управляемых баз данных Yandex Cloud.

Включает разрешения, предоставляемые ролью `managed-metastore.maintenanceTask.viewer`.

#### managed-metastore.maintenanceTask.viewer {#managed-metastore-maintenancetask-viewer}

Роль `managed-metastore.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Apache Hive™ Metastore](../metadata-hub/concepts/metastore.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на техническое обслуживание таких кластеров, а также о квотах сервисов управляемых баз данных Yandex Cloud.

{% endcut %}

{% cut "Yandex DataLens" %}

#### datalens.collections.creator {#datalens-collections-creator}

Роль `datalens.collections.creator` назначается на коллекцию и позволяет просматривать коллекцию, а также создавать объекты внутри нее без доступа к другим объектам, существующим внутри коллекции. В интерфейсе DataLens эта роль называется `Создание в коллекции`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.collections.visitor`.

#### datalens.collections.entryBindingCreator {#datalens-collections-entrybindingcreator}

Роль `datalens.collections.entryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции как без делегации прав доступа, так и с делегацией. В интерфейсе DataLens эта роль называется `Привязки с делегацией`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.entryBindingCreator`.

#### datalens.collections.limitedEntryBindingCreator {#datalens-collections-limitedentrybindingcreator}

Роль `datalens.collections.limitedEntryBindingCreator` назначается на коллекцию и позволяет переиспользовать общие объекты из этой коллекции без делегации прав доступа. В интерфейсе DataLens эта роль называется `Привязки без делегаций`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedEntryBindingCreator`.

#### datalens.collections.visitor {#datalens-collections-visitor}

Роль `datalens.collections.visitor` назначается на коллекцию и позволяет просматривать информацию о текущей коллекции без доступа ко вложенным в нее объектам. В интерфейсе DataLens эта роль называется `Посещение коллекции`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.sharedEntries.admin {#datalens-sharedentries-admin}

Роль `datalens.sharedEntries.admin` назначается на общий объект и позволяет просматривать его и полностью управлять им: редактировать, перемещать, удалять и настраивать права доступа к нему. В интерфейсе DataLens эта роль называется `Администрирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролями `datalens.sharedEntries.editor` и `datalens.sharedEntries.entryBindingCreator`.

#### datalens.sharedEntries.editor {#datalens-sharedentries-editor}

Роль `datalens.sharedEntries.editor` назначается на общий объект и позволяет редактировать этот объект, а также просматривать его и назначенные права доступа к нему. В интерфейсе DataLens эта роль называется `Редактирование`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.viewer`.

#### datalens.sharedEntries.entryBindingCreator {#datalens-sharedentries-entrybindingcreator}

Роль `datalens.sharedEntries.entryBindingCreator` назначается на общий объект и позволяет переиспользовать его в воркбуках как без делегации прав доступа, так и с делегацией. В интерфейсе DataLens эта роль называется `Привязки с делегацией`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedEntryBindingCreator`.

#### datalens.sharedEntries.limitedEntryBindingCreator {#datalens-sharedentries-limitedentrybindingcreator}

Роль `datalens.sharedEntries.limitedEntryBindingCreator` назначается на общий объект и позволяет переиспользовать его в воркбуках без делегации прав доступа. В интерфейсе DataLens эта роль называется `Привязки без делегаций`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.sharedEntries.limitedViewer {#datalens-sharedentries-limitedviewer}

Роль `datalens.sharedEntries.limitedViewer` назначается на общий объект и позволяет просматривать [чарты](../datalens/concepts/chart/index.md) и [дашборды](../datalens/concepts/dashboard.md), которые используют его, без прямого доступа к самому общему объекту. В интерфейсе DataLens эта роль называется `Ограниченный просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

#### datalens.sharedEntries.viewer {#datalens-sharedentries-viewer}

Роль `datalens.sharedEntries.viewer` назначается на общий объект и позволяет просматривать его, а также назначенные права доступа к нему. В интерфейсе DataLens эта роль называется `Просмотр`. Рекомендуем выдавать эту роль только через интерфейс DataLens.

Включает разрешения, предоставляемые ролью `datalens.sharedEntries.limitedViewer`.

{% endcut %}

## Май 2026 {#may-2026}

### Изменения в сервисе Identity and Access Management {#iam-may-2026}

* Добавлены новые [области действия API-ключей](concepts/authorization/api-key.md#scoped-api-keys): для работы с Yandex Cloud Registry и для запуска рабочих процессов в Workflows.
* Обновлены шаблоны [политик авторизации](concepts/access-control/access-policies.md): общие шаблоны `serverless.restrictPrivateNetworkInvocation` и `serverless.restrictPublicInvocation` заменены отдельными шаблонами для Yandex Serverless Containers, Yandex Cloud Functions, MCP Hub и Workflows.

### Новые роли {#roles-may-2026}

{% cut "Yandex Cloud Apps" %}

#### cloudapps.admin {#cloudapps-admin}

Роль `cloudapps.admin` позволяет просматривать информацию об установленных приложениях Cloud Apps, а также создавать, изменять и удалять такие приложения.

Включает разрешения, предоставляемые ролью `cloudapps.editor`.

#### cloudapps.auditor {#cloudapps-auditor}

Роль `cloudapps.auditor` позволяет просматривать метаданные установленных приложений Cloud Apps.

#### cloudapps.editor {#cloudapps-editor}

Роль `cloudapps.editor` позволяет просматривать информацию об установленных приложениях Cloud Apps, а также создавать, изменять и удалять такие приложения.

Включает разрешения, предоставляемые ролью `cloudapps.viewer`.

#### cloudapps.viewer {#cloudapps-viewer}

Роль `cloudapps.viewer` позволяет просматривать информацию об установленных приложениях Cloud Apps.

Включает разрешения, предоставляемые ролью `cloudapps.auditor`.

{% endcut %}

{% cut "Yandex Cloud Marketplace" %}

#### marketplace.productInstances.admin {#marketplace-productinstances-admin}

Роль `marketplace.productInstances.admin` позволяет управлять установленными продуктами Marketplace и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к установленным продуктам Marketplace и изменять такие права доступа;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.editor`.

#### marketplace.productInstances.auditor {#marketplace-productinstances-auditor}

Роль `marketplace.productInstances.auditor` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать метаданные [каталога](../resource-manager/concepts/resources-hierarchy.md#folder).

#### marketplace.productInstances.editor {#marketplace-productinstances-editor}

Роль `marketplace.productInstances.editor` позволяет управлять установленными продуктами Marketplace.

Пользователи с этой ролью могут:
* просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать продукты Marketplace, изменять их метаданные, а также активировать и деактивировать продукты Marketplace;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.user`.

#### marketplace.productInstances.saasSupervisor {#marketplace-productinstances-saassupervisor}

Роль `marketplace.productInstances.saasSupervisor` позволяет просматривать информацию об установленных SaaS-[продуктах](../marketplace/concepts/product.md) Marketplace и активировать такие продукты.

#### marketplace.productInstances.user {#marketplace-productinstances-user}

Роль `marketplace.productInstances.user` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace, активировать и деактивировать их, просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.viewer`.

#### marketplace.productInstances.viewer {#marketplace-productinstances-viewer}

Роль `marketplace.productInstances.viewer` позволяет просматривать информацию об установленных [продуктах](../marketplace/concepts/product.md) Marketplace и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `marketplace.productInstances.auditor`.

{% endcut %}

{% cut "Yandex Cloud Postbox" %}

#### postbox.messages.reader {#postbox-messages-reader}

Роль `postbox.messages.reader` позволяет просматривать в разделе **Отправленные письма** [консоли управления](https://console.yandex.cloud) информацию об отправленных письмах, включая сведения об отправителе, получателях, теме, дате отправки, а также о [метриках](../postbox/concepts/statistics.md#metrics) доставки и вовлеченности, жалобах и отписках.

#### postbox.statistics.reader {#postbox-statistics-reader}

Роль `postbox.statistics.reader` позволяет просматривать [статистику](../postbox/concepts/statistics.md) по отправленным письмам в разделе **Статистика** [консоли управления](https://console.yandex.cloud).

{% endcut %}

{% cut "Yandex Identity and Access Management" %}

#### iam.serviceAccounts.ephemeralAccessKeyAdmin {#iam-serviceaccounts-ephemeralaccesskeyadmin}

Роль `iam.serviceAccounts.ephemeralAccessKeyAdmin` позволяет создавать [эфемерные ключи доступа](concepts/authorization/ephemeral-keys.md) сервисных аккаунтов.

{% endcut %}

{% cut "Yandex Managed Service for Valkey™" %}

#### managed-redis.clusters.connector {#managed-redis-clusters-connector}

Роль `managed-redis.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах Valkey™](../managed-valkey/concepts/index.md) с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

{% cut "Yandex SIEM" %}

#### ycem.executor {#ycem-executor}

Роль `ycem.executor` позволяет управлять запросами, расследованиями, датасетами, а также правилами корреляции.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [расследованиях](../siem/concepts/investigations.md), а также создавать, обновлять, удалять и выполнять расследования;
* просматривать информацию о [датасетах](../siem/concepts/investigations.md#datasets-schema) и их содержимом, а также создавать, обновлять и удалять датасеты;
* просматривать информацию о [запросах](../siem/concepts/queries.md), а также создавать, обновлять, удалять и выполнять запросы;
* просматривать информацию о [правилах корреляции](../siem/concepts/correlation-rules.md#correlation-rules), а также обновлять правила корреляции;
* просматривать информацию об [исключениях](../siem/concepts/correlation-rules.md#exceptions), а также список запросов, которые используют эти исключения;
* просматривать информацию об [инстансах](../siem/concepts/index.md) Yandex SIEM и версии их компонентов.

{% endcut %}

Включает разрешения, предоставляемые ролью `ycem.inspector`.

#### ycem.inspector {#ycem-inspector}

Роль `ycem.inspector` позволяет управлять запросами, расследованиями и датасетами.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [расследованиях](../siem/concepts/investigations.md), а также создавать, обновлять, удалять и выполнять расследования;
* просматривать информацию о [датасетах](../siem/concepts/investigations.md#datasets-schema), а также создавать, обновлять и удалять датасеты;
* просматривать информацию о [запросах](../siem/concepts/queries.md), а также создавать, обновлять, удалять и выполнять запросы;
* просматривать информацию об [инстансах](../siem/concepts/index.md) Yandex SIEM.

{% endcut %}

{% endcut %}

## Апрель 2026 {#april-2026}

### Изменения в сервисе Identity and Access Management {#iam-april-2026}

* Добавлено поле `MASKED KEY`, показывающее 6 последних символов секретной части ключа в выводе списка API-ключей.

### Новые роли {#roles-april-2026}

{% cut "Yandex Cloud Notification Service" %}

#### notifications.admin {#notifications-admin}

Роль `notifications.admin` позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md), создавать, изменять и удалять их;
* просматривать информацию о подписках в топиках, а также создавать и удалять их;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints), а также создавать, изменять и удалять каналы мобильных Push-уведомлений и их эндпоинты;
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint), а также создавать, изменять и удалять каналы Push-уведомлений в браузере и их эндпоинты;
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), а также создавать, изменять и удалять их;
* просматривать информацию о [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах, а также изменять их;
* отправлять уведомления во все топики и каналы;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролью `notifications.editor`.

#### notifications.auditor {#notifications-auditor}

Роль `notifications.auditor` позволяет просматривать метаданные всех [каналов уведомлений](../notifications/concepts/index.md#channels), метаданные [топиков](../notifications/concepts/topics.md), а также информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

#### notifications.editor {#notifications-editor}

Роль `notifications.editor` позволяет управлять всеми каналами уведомлений и топиками, а также отправлять уведомления во все каналы и топики.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md), создавать, изменять и удалять их;
* просматривать информацию о подписках в топиках, а также создавать и удалять их;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints), а также создавать, изменять и удалять каналы мобильных Push-уведомлений и их эндпоинты;
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint), а также создавать, изменять и удалять каналы Push-уведомлений в браузере и их эндпоинты;
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), а также создавать, изменять и удалять их;
* просматривать информацию о [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах, а также изменять их;
* отправлять уведомления во все топики и каналы;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролями `notifications.viewer` и `notifications.publisher`.

#### notifications.publisher {#notifications-publisher}

Роль `notifications.publisher` позволяет отправлять уведомления во все [каналы](../notifications/concepts/index.md#channels) и [топики](../notifications/concepts/topics.md).

#### notifications.viewer {#notifications-viewer}

Роль `notifications.viewer` позволяет просматривать информацию о топиках и каналах уведомлений, а также о квотах сервиса Cloud Notification Service.

Пользователи с этой ролью могут:
* просматривать информацию о [топиках](../notifications/concepts/topics.md) и подписках в них;
* просматривать информацию о каналах [мобильных Push-уведомлений](../notifications/concepts/push.md) и их [эндпоинтах](../notifications/concepts/push.md#mobile-endpoints);
* просматривать информацию о каналах [Push-уведомлений в браузере](../notifications/concepts/browser.md) и их [эндпоинтах](../notifications/concepts/browser.md#create-endpoint);
* просматривать информацию о каналах [SMS-уведомлений](../notifications/concepts/sms.md), [шаблонах](../notifications/concepts/sms.md#templates) SMS и [тестовых](../notifications/concepts/sms.md#sandbox) телефонных номерах;
* просматривать информацию о [квотах](../notifications/concepts/limits.md) сервиса Cloud Notification Service.

Включает разрешения, предоставляемые ролью `notifications.auditor`.

{% endcut %}

{% cut "Yandex DataLens" %}

#### datalens.metaReader {#datalens-metareader}

Роль `datalens.metaReader` позволяет выполнять запросы в [DataLens Public API](../datalens/operations/api-start.md) из раздела [Audit](https://api.datalens.tech/#/Audit), а также запросы для получения сущностей DataLens.

Доступно получение следующих сущностей:

* подключение — [метод](https://api.datalens.tech/#/Connection/post_rpc_getConnection) `getConnection`;
* датасет — [метод](https://api.datalens.tech/#/Dataset/post_rpc_getDataset) `getDataset`;
* чарт в Wizard — [метод](https://api.datalens.tech/#/Wizard/post_rpc_getWizardChart) `getWizardChart`;
* чарт в Editor — [метод](https://api.datalens.tech/#/Editor/post_rpc_getEditorChart) `getEditorChart`;
* QL-чарт — [метод](https://api.datalens.tech/#/QL/post_rpc_getQLChart) `getQLChart`;
* дашборд — [метод](https://api.datalens.tech/#/Dashboard/post_rpc_getDashboard) `getDashboard`;
* отчет — [метод](https://api.datalens.tech/#/Reports/post_rpc_getReport) `getReport`.

{% note warning %}

Получение сущностей работает, только если в запросе передан заголовок `x-dl-audit-mode` со значением `true`.

{% endnote %}

{% endcut %}

{% cut "Yandex Cloud DNS" %}

#### dns.firewallEditor {#dns-firewalleditor}

Роль `dns.firewallEditor` позволяет управлять DNS-фильтрами и использовать облака, каталоги и облачные сети в качестве ресурсов для них.

Пользователи с этой ролью могут:
* просматривать информацию о DNS-фильтрах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, изменять и удалять DNS-фильтры;
* использовать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных правах доступа к ним;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса Cloud DNS;
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролью `dns.firewallUser`.

#### dns.firewallUser {#dns-firewalluser}

Роль `dns.firewallUser` позволяет использовать облака, каталоги и облачные сети в качестве ресурсов для DNS-фильтров, а также просматривать информацию о ресурсах и квотах сервиса Cloud DNS.

Пользователи с этой ролью могут:
* просматривать информацию о DNS-фильтрах и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* использовать [облака](../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоги](../resource-manager/concepts/resources-hierarchy.md#folder) и [облачные сети](../vpc/concepts/network.md#network) в качестве ресурсов для DNS-фильтров;
* просматривать информацию о [DNS-зонах](../dns/concepts/dns-zone.md) и назначенных правах доступа к ним;
* просматривать информацию о [квотах](../dns/concepts/limits.md#cloud-dns-quotas) сервиса Cloud DNS;
* просматривать информацию о каталоге.

Включает разрешения, предоставляемые ролью `dns.auditor`.

{% endcut %}

{% cut "Yandex Identity Hub" %}

#### organization-manager.groups.viewer {#organization-manager-groups-viewer}

Роль `organization-manager.groups.viewer` позволяет просматривать информацию о [группах пользователей](../organization/concepts/groups.md) и о назначенных [правах доступа](concepts/access-control/index.md) к ним, а также просматривать список [пользователей](../overview/roles-and-resources.md#users) и [сервисных аккаунтов](concepts/users/service-accounts.md), входящих в группу.

{% endcut %}

{% cut "Yandex Managed Service for Kubernetes" %}

#### k8s.cluster-api.admin {#k8s-cluster-api-admin}

Пользователь с ролью `k8s.cluster-api.admin` получает группу `yc:k8s-core-admin` и роль `admin` в Kubernetes RBAC.

{% endcut %}

{% cut "Управляемые базы данных" %}

#### mdb.maintenanceTask.editor {#mdb-maintenancetask-editor}

Роль `mdb.maintenanceTask.editor` предоставляет доступ к управлению заданиями на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных и изменять такие задания, просматривать информацию о кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, а также о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.maintenanceTask.viewer`, `managed-clickhouse.maintenanceTask.editor`, `managed-greenplum.maintenanceTask.editor`, `managed-kafka.maintenanceTask.editor`, `managed-mongodb.maintenanceTask.editor`, `managed-mysql.maintenanceTask.editor`, `managed-opensearch.maintenanceTask.editor`, `managed-postgresql.maintenanceTask.editor`, `managed-redis.maintenanceTask.editor` и `managed-spqr.maintenanceTask.editor`.

#### mdb.maintenanceTask.viewer {#mdb-maintenancetask-viewer}

Роль `mdb.maintenanceTask.viewer` предоставляет доступ к информации о заданиях на техническое обслуживание кластеров управляемых баз данных.

Пользователи с этой ролью могут просматривать информацию о заданиях на техническое обслуживание кластеров управляемых баз данных, а также информацию о таких кластерах и назначенных правах доступа к ним, о хостах и резервных копиях кластеров, о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.auditor`, `managed-clickhouse.maintenanceTask.viewer`, `managed-greenplum.maintenanceTask.viewer`, `managed-kafka.maintenanceTask.viewer`, `managed-mongodb.maintenanceTask.viewer`, `managed-mysql.maintenanceTask.viewer`, `managed-opensearch.maintenanceTask.viewer`, `managed-postgresql.maintenanceTask.viewer`, `managed-redis.maintenanceTask.viewer` и `managed-spqr.maintenanceTask.viewer`.

#### mdb.switcher {#mdb-switcher}

Роль `mdb.switcher` позволяет переназначать хост-мастер в кластерах управляемых баз данных, а также предоставляет доступ к информации о кластерах и к логам их работы.

Пользователи с этой ролью могут переназначать хост-мастер в кластерах управляемых баз данных, просматривать информацию о кластерах, хостах, базах данных и пользователях, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-mongodb.switcher`, `managed-mysql.switcher`, `managed-postgresql.switcher` и `managed-redis.switcher`.

{% endcut %}

## Март 2026 {#march-2026}

### Новые роли {#roles-march-2026}

{% cut "Yandex AI Studio" %}

#### ai.guardrails.admin {#ai-guardrails-admin}

Роль `ai.guardrails.admin` позволяет просматривать информацию о [правилах модерации](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила.

Включает разрешения, предоставляемые ролью `ai.guardrails.editor`.

#### ai.guardrails.auditor {#ai-guardrails-auditor}

Роль `ai.guardrails.auditor` позволяет просматривать метаданные [правил модерации](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/security/guardrails#rules) ответов моделей.

#### ai.guardrails.editor {#ai-guardrails-editor}

Роль `ai.guardrails.editor` позволяет просматривать информацию о [правилах модерации](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/security/guardrails#rules) ответов моделей, а также создавать, применять, изменять и удалять такие правила.

Включает разрешения, предоставляемые ролями `ai.guardrails.viewer` и `ai.guardrails.user`.

#### ai.guardrails.user {#ai-guardrails-user}

Роль `ai.guardrails.user` позволяет применять [правила модерации](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/security/guardrails#rules) ответов моделей и просматривать метаданные таких правил.

#### ai.guardrails.viewer {#ai-guardrails-viewer}

Роль `ai.guardrails.viewer` позволяет просматривать информацию о [правилах модерации](https://aistudio.yandex.ru/docs/ru/ai-studio/concepts/security/guardrails#rules) ответов моделей.

Включает разрешения, предоставляемые ролью `ai.guardrails.auditor`.

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

#### managed-greenplum.maintenanceTask.editor {#managed-greenplum-maintenancetask-editor}

Роль `managed-greenplum.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров Yandex MPP Analytics for PostgreSQL и изменять такие задания, просматривать информацию о [кластерах Yandex MPP Analytics for PostgreSQL](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-greenplum/concepts/instance-types.md) и [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров, а также о [квотах](../managed-greenplum/concepts/limits.md#quotas) и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.maintenanceTask.viewer`.

#### managed-greenplum.maintenanceTask.viewer {#managed-greenplum-maintenancetask-viewer}

Роль `managed-greenplum.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров Yandex MPP Analytics for PostgreSQL, а также о таких [кластерах](../managed-greenplum/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-greenplum/concepts/instance-types.md) и [резервных копиях](../managed-greenplum/concepts/backup.md) кластеров, о [квотах](../managed-greenplum/concepts/limits.md#quotas) и операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.auditor`.

#### managed-greenplum.user {#managed-greenplum-user}

Роль `managed-greenplum.user` позволяет использовать [кластеры Yandex MPP Analytics for PostgreSQL](../managed-greenplum/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for Apache Airflow™" %}

#### managed-airflow.maintenanceTask.editor {#managed-airflow-maintenancetask-editor}

Роль `managed-airflow.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) кластеров Apache Airflow™ и изменять такие задания, просматривать информацию о [кластерах Apache Airflow™](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса Managed Service for Apache Airflow™.

Включает разрешения, предоставляемые ролью `managed-airflow.maintenanceTask.viewer`.

#### managed-airflow.maintenanceTask.viewer {#managed-airflow-maintenancetask-viewer}

Роль `managed-airflow.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Apache Airflow™](../managed-airflow/concepts/index.md#cluster) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-airflow/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-airflow/concepts/limits.md#quotas) сервиса Managed Service for Apache Airflow™.

Включает разрешения, предоставляемые ролью `managed-airflow.auditor`.

{% endcut %}

{% cut "Yandex Managed Service for Apache Kafka®" %}

#### managed-kafka.maintenanceTask.editor {#managed-kafka-maintenancetask-editor}

Роль `managed-kafka.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров Apache Kafka® и изменять такие задания, просматривать информацию о [кластерах Apache Kafka®](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) и операциях с ресурсами сервиса Managed Service for Apache Kafka®.

Включает разрешения, предоставляемые ролью `managed-kafka.maintenanceTask.viewer`.

#### managed-kafka.maintenanceTask.viewer {#managed-kafka-maintenancetask-viewer}

Роль `managed-kafka.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Apache Kafka®](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) и операциях с ресурсами сервиса Managed Service for Apache Kafka®.

Включает разрешения, предоставляемые ролью `managed-kafka.auditor`.

#### managed-kafka.user {#managed-kafka-user}

Роль `managed-kafka.user` позволяет использовать [кластеры Apache Kafka®](../managed-kafka/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for Apache Spark™" %}

#### managed-spark.maintenanceTask.editor {#managed-spark-maintenancetask-editor}

Роль `managed-spark.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) кластеров Apache Spark™ и изменять такие задания, просматривать информацию о [кластерах Apache Spark™](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-spark/concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.maintenanceTask.viewer`.

#### managed-spark.maintenanceTask.viewer {#managed-spark-maintenancetask-viewer}

Роль `managed-spark.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Apache Spark™](../managed-spark/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о заданиях на [техническое обслуживание](../managed-spark/concepts/maintenance.md) таких кластеров и [квотах](../managed-spark/concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.auditor`.

{% endcut %}

{% cut "Yandex Managed Service for ClickHouse®" %}

#### managed-clickhouse.maintenanceTask.editor {#managed-clickhouse-maintenancetask-editor}

Роль `managed-clickhouse.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров ClickHouse® и изменять такие задания, просматривать информацию о [кластерах ClickHouse®](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) и операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролью `managed-clickhouse.maintenanceTask.viewer`.

#### managed-clickhouse.maintenanceTask.viewer {#managed-clickhouse-maintenancetask-viewer}

Роль `managed-clickhouse.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров ClickHouse®, о [кластерах ClickHouse®](../managed-clickhouse/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) и операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролью `managed-clickhouse.auditor`.

#### managed-clickhouse.user {#managed-clickhouse-user}

Роль `managed-clickhouse.user` позволяет использовать [кластеры ClickHouse®](../managed-clickhouse/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for MySQL®" %}

#### managed-mysql.maintenanceTask.editor {#managed-mysql-maintenancetask-editor}

Роль `managed-mysql.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров MySQL® и изменять такие задания, просматривать информацию о [кластерах MySQL®](../managed-mysql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-mysql/concepts/instance-types.md) и [резервных копиях](../managed-mysql/concepts/backup.md) кластеров, а также о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) и операциях с ресурсами сервиса Managed Service for MySQL®.

Включает разрешения, предоставляемые ролью `managed-mysql.maintenanceTask.viewer`.

#### managed-mysql.maintenanceTask.viewer {#managed-mysql-maintenancetask-viewer}

Роль `managed-mysql.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров MySQL®, а также о таких [кластерах](../managed-mysql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-mysql/concepts/instance-types.md) и [резервных копиях](../managed-mysql/concepts/backup.md) кластеров, о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) и операциях с ресурсами сервиса Managed Service for MySQL®.

Включает разрешения, предоставляемые ролью `managed-mysql.auditor`.

#### managed-mysql.switcher {#managed-mysql-switcher}

Роль `managed-mysql.switcher` позволяет переназначать хост-мастер в кластерах MySQL®, просматривать информацию о кластерах, хостах, базах данных и пользователях MySQL®, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах MySQL®](../managed-mysql/concepts/index.md);
* просматривать информацию о кластерах MySQL® и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров MySQL®;
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров MySQL®;
* просматривать информацию о базах данных MySQL®;
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) MySQL®;
* просматривать информацию о [резервных копиях](../managed-mysql/concepts/backup.md) кластеров MySQL®;
* просматривать информацию об алертах MySQL®;
* просматривать логи работы кластеров MySQL®;
* просматривать информацию о результатах диагностики производительности кластеров MySQL®;
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса Managed Service for MySQL®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for MySQL®.

Включает разрешения, предоставляемые ролью `managed-mysql.viewer`.

#### managed-mysql.user {#managed-mysql-user}

Роль `managed-mysql.user` позволяет использовать [кластеры MySQL®](../managed-mysql/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for OpenSearch" %}

#### managed-opensearch.maintenanceTask.editor {#managed-opensearch-maintenancetask-editor}

Роль `managed-opensearch.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров OpenSearch и изменять такие задания, просматривать информацию о [кластерах OpenSearch](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-opensearch/concepts/limits.md#quotas) и операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролью `managed-opensearch.maintenanceTask.viewer`.

#### managed-opensearch.maintenanceTask.viewer {#managed-opensearch-maintenancetask-viewer}

Роль `managed-opensearch.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах OpenSearch](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) таких кластеров, а также о [квотах](../managed-opensearch/concepts/limits.md#quotas) и операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролью `managed-opensearch.auditor`.

#### managed-opensearch.user {#managed-opensearch-user}

Роль `managed-opensearch.user` позволяет использовать [кластеры OpenSearch](../managed-opensearch/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

#### managed-postgresql.maintenanceTask.editor {#managed-postgresql-maintenancetask-editor}

Роль `managed-postgresql.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL и изменять такие задания, просматривать информацию о [кластерах PostgreSQL](../managed-postgresql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-postgresql/concepts/instance-types.md) и [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров, а также о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) и операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.maintenanceTask.viewer`.

#### managed-postgresql.maintenanceTask.viewer {#managed-postgresql-maintenancetask-viewer}

Роль `managed-postgresql.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL, а также о таких [кластерах](../managed-postgresql/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-postgresql/concepts/instance-types.md) и [резервных копиях](../managed-postgresql/concepts/backup.md), о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) и операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.auditor`.

#### managed-postgresql.switcher {#managed-postgresql-switcher}

Роль `managed-postgresql.switcher` позволяет переназначать хост-мастер в кластерах PostgreSQL, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах PostgreSQL](../managed-postgresql/concepts/index.md);
* просматривать информацию о кластерах PostgreSQL и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL;
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров PostgreSQL;
* просматривать информацию о базах данных PostgreSQL;
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) PostgreSQL;
* просматривать информацию о [резервных копиях](../managed-postgresql/concepts/backup.md) кластеров PostgreSQL;
* просматривать информацию об алертах PostgreSQL;
* просматривать логи работы кластеров PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров PostgreSQL;
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса Managed Service for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.

#### managed-postgresql.user {#managed-postgresql-user}

Роль `managed-postgresql.user` позволяет использовать [кластеры PostgreSQL](../managed-postgresql/concepts/index.md).

{% endcut %}

{% cut "Yandex Managed Service for Sharded PostgreSQL" %}

#### managed-spqr.maintenanceTask.editor {#managed-spqr-maintenancetask-editor}

Роль `managed-spqr.maintenanceTask.editor` позволяет просматривать информацию о заданиях на техническое обслуживание [кластеров Sharded PostgreSQL](../managed-spqr/concepts/index.md) и изменять такие задания, просматривать информацию о кластерах Sharded PostgreSQL и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [хостах](../managed-spqr/concepts/instance-types.md) кластеров, [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) и операциях с ресурсами сервиса Managed Service for Sharded PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-spqr.maintenanceTask.viewer`.

#### managed-spqr.maintenanceTask.viewer {#managed-spqr-maintenancetask-viewer}

Роль `managed-spqr.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на техническое обслуживание кластеров Sharded PostgreSQL, а также о таких [кластерах](../managed-spqr/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-spqr/concepts/instance-types.md) кластеров, [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) и операциях с ресурсами сервиса Managed Service for Sharded PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-spqr.auditor`.

{% endcut %}

{% cut "Yandex Managed Service for Trino" %}

#### managed-trino.maintenanceTask.editor {#managed-trino-maintenancetask-editor}

Роль `managed-trino.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) кластеров Trino и изменять такие задания, просматривать информацию о [кластерах Trino](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о [квотах](../managed-trino/concepts/limits.md#quotas) сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролью `managed-trino.maintenanceTask.viewer`.

#### managed-trino.maintenanceTask.viewer {#managed-trino-maintenancetask-viewer}

Роль `managed-trino.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Trino](../managed-trino/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также о заданиях на [техническое обслуживание](../managed-trino/concepts/maintenance.md) таких кластеров и [квотах](../managed-trino/concepts/limits.md#quotas) сервиса Managed Service for Trino.

Включает разрешения, предоставляемые ролью `managed-trino.auditor`.

{% endcut %}

{% cut "Yandex Managed Service for Valkey™" %}

#### managed-redis.maintenanceTask.editor {#managed-redis-maintenancetask-editor}

Роль `managed-redis.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров Valkey™ и изменять такие задания, просматривать информацию о [кластерах](../managed-valkey/concepts/index.md) Valkey™ и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-valkey/concepts/instance-types.md) и [резервных копиях](../managed-valkey/concepts/backup.md) кластеров, а также о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.maintenanceTask.viewer`.

#### managed-redis.maintenanceTask.viewer {#managed-redis-maintenancetask-viewer}

Роль `managed-redis.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров Valkey™, а также о таких [кластерах](../managed-valkey/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../managed-valkey/concepts/instance-types.md) и [резервных копиях](../managed-valkey/concepts/backup.md) кластеров, о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) и операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.auditor`.

#### managed-redis.switcher {#managed-redis-switcher}

Роль `managed-redis.switcher` позволяет переназначать хост-мастер в кластерах Valkey™, просматривать информацию о хостах и кластерах Valkey™, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах Valkey™](../managed-valkey/concepts/index.md);
* просматривать информацию о кластерах Valkey™ и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров Valkey™;
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров Valkey™;
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров Valkey™;
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях Valkey™;
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров Valkey™;
* просматривать информацию об алертах Valkey™;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

#### managed-redis.user {#managed-redis-user}

Роль `managed-redis.user` позволяет использовать [кластеры Valkey™](../managed-valkey/concepts/index.md).

{% endcut %}

{% cut "Yandex StoreDoc" %}

#### managed-mongodb.maintenanceTask.editor {#managed-mongodb-maintenancetask-editor}

Роль `managed-mongodb.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров Yandex StoreDoc и изменять такие задания, просматривать информацию о [кластерах Yandex StoreDoc](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../storedoc/concepts/instance-types.md) и [резервных копиях](../storedoc/concepts/backup.md) кластеров, а также о [квотах](../storedoc/concepts/limits.md#mmg-quotas) и операциях с ресурсами сервиса.

Включает разрешения, предоставляемые ролью `managed-mongodb.maintenanceTask.viewer`.

#### managed-mongodb.maintenanceTask.viewer {#managed-mongodb-maintenancetask-viewer}

Роль `managed-mongodb.maintenanceTask.viewer` позволяет просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров Yandex StoreDoc, а также о таких [кластерах](../storedoc/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним, о [хостах](../storedoc/concepts/instance-types.md) и [резервных копиях](../storedoc/concepts/backup.md) кластеров, о [квотах](../storedoc/concepts/limits.md#mmg-quotas) и операциях с ресурсами сервиса.

Включает разрешения, предоставляемые ролью `managed-mongodb.auditor`.

#### managed-mongodb.switcher {#managed-mongodb-switcher}

Роль `managed-mongodb.switcher` позволяет переназначать хост-мастер в кластерах Yandex StoreDoc, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях Yandex StoreDoc, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* переназначать хост-мастер в [кластерах Yandex StoreDoc](../storedoc/concepts/index.md);
* просматривать информацию о кластерах Yandex StoreDoc и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров Yandex StoreDoc;
* просматривать информацию о [хостах](../storedoc/concepts/instance-types.md) кластеров Yandex StoreDoc;
* просматривать информацию о [шардах](../storedoc/concepts/sharding.md) кластеров Yandex StoreDoc;
* просматривать информацию о базах данных Yandex StoreDoc;
* просматривать информацию о [пользователях](../storedoc/concepts/users-and-roles.md) Yandex StoreDoc;
* просматривать информацию о [резервных копиях](../storedoc/concepts/backup.md) кластеров Yandex StoreDoc;
* просматривать информацию об алертах Yandex StoreDoc;
* просматривать [логи](../storedoc/operations/cluster-logs.md) работы кластеров Yandex StoreDoc;
* просматривать информацию о результатах диагностики производительности кластеров Yandex StoreDoc;
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса Yandex StoreDoc;
* просматривать информацию об операциях с ресурсами сервиса Yandex StoreDoc.

Включает разрешения, предоставляемые ролью `managed-mongodb.viewer`.

#### managed-mongodb.user {#managed-mongodb-user}

Роль `managed-mongodb.user` позволяет использовать [кластеры Yandex StoreDoc](../storedoc/concepts/index.md).

{% endcut %}

## Февраль 2026 {#february-2026}

### Изменения в сервисе Identity and Access Management {#iam-february-2026}

* Добавлены [политики авторизации](concepts/access-control/access-policies.md).

### Новые роли {#roles-february-2026}

{% cut "Yandex Cloud Backup" %}

#### backup.auditor {#backup-auditor}

Роль `backup.auditor` позволяет просматривать информацию о защищаемых ресурсах, подключенных к сервису Cloud Backup, о политиках резервного копирования и квотах сервиса, а также об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования;
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним [ресурсах](../backup/concepts/index.md#protected-resources);
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [подключенных](../backup/concepts/vm-connection/index.md) к Cloud Backup ресурсах;
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса Cloud Backup;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Назначить роль `backup.auditor` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

{% endcut %}

## Декабрь 2025 {#december-2025}

### Изменения в сервисе Identity and Access Management {#iam-december-2025}

* Добавлены [эфемерные ключи](concepts/authorization/ephemeral-keys.md).
* В Terraform-ресурсе `yandex_iam_oauth_client` исправлено сравнение полей `scopes` и `redirect_uris`: они теперь имеют тип set, чтобы избежать коллизий при сравнении.

### Новые роли {#roles-december-2025}

{% cut "Yandex Cloud Backup" %}

#### backup.user {#backup-user}

Роль `backup.user` позволяет подключать провайдеров резервного копирования, подключать к Cloud Backup защищаемые ресурсы, привязывать к защищаемым ресурсам политики резервного копирования и отвязывать их, а также просматривать информацию о ресурсах и квотах сервиса, об облаке и каталоге.

Пользователи с этой ролью могут:
* просматривать информацию о подключенных [провайдерах](../backup/concepts/index.md#providers) резервного копирования, а также подключать провайдеров, доступных в Cloud Backup;
* просматривать информацию о [подключенных](../backup/concepts/vm-connection/index.md) к Cloud Backup защищаемых ресурсах, а также подключать и отключать защищаемые ресурсы от сервиса;
* просматривать информацию о [политиках резервного копирования](../backup/concepts/policy.md) и привязанных к ним ресурсах;
* привязывать политики резервного копирования к защищаемым ресурсам, а также отвязывать их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к политикам резервного копирования;
* просматривать информацию о [квотах](../backup/concepts/limits.md#backup-quotas) сервиса Cloud Backup;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder) и его статистику.

Включает разрешения, предоставляемые ролью `backup.auditor`.

Назначить роль `backup.user` может пользователь с ролью `admin` в облаке или `backup.admin` в каталоге.

{% endcut %}

{% cut "Yandex Managed Service for MySQL®" %}

#### managed-mysql.clusters.connector {#managed-mysql-clusters-connector}

Роль `managed-mysql.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах MySQL®](../managed-mysql/concepts/index.md) с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

#### managed-postgresql.clusters.connector {#managed-postgresql-clusters-connector}

Роль `managed-postgresql.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах PostgreSQL](../managed-postgresql/concepts/index.md) с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

{% cut "Yandex Monium" %}

#### monium.admin {#monium-admin}

Роль `monium.admin` позволяет управлять ресурсами платформы Monium, просматривать и записывать все виды телеметрии, а также управлять проектами и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../monium/concepts/glossary.md#project), а также создавать, настраивать и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к проектам и изменять такие права доступа;
* читать и записывать все виды телеметрии платформы Monium: [метрики](../monium/metrics/quickstart.md), [логи](../monium/logs/quickstart.md) и [распределенные трассировки](../monium/traces/index.md);
* просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md), а также создавать, изменять и удалять дашборды;
* просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов, а также создавать, изменять и удалять контекстные ссылки;
* просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню [проекта](../monium/concepts/glossary.md#project), а также создавать, изменять и удалять быстрые ссылки;
* просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах, а также создавать, изменять и удалять шарды;
* просматривать список [алертов](../monium/concepts/alerting/alert.md), их настройки и историю срабатываний, а также создавать, изменять и удалять алерты;
* просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives), а также создавать, изменять и удалять SLO;
* просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов, а также создавать, изменять и удалять каналы уведомлений;
* просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для алертов, а также создавать, изменять и удалять политики эскалации;
* просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для алертов, а также создавать, изменять и удалять эскалации;
* просматривать, а также создавать, изменять и удалять [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать, а также добавлять новые, редактировать и удалять существующие [лейблы](../monium/traces/operations/traces-explorer.md) к ошибкам в логах;
* просматривать информацию о [правилах](../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®, а также создавать, изменять и удалять такие правила;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `monium.editor`.

#### monium.editor {#monium-editor}

Роль `monium.editor` позволяет управлять ресурсами платформы Monium, просматривать и записывать все виды телеметрии.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../monium/concepts/glossary.md#project) и назначенных [правах доступа](concepts/access-control/index.md) к ним, а также настраивать проекты;
* читать и записывать все виды телеметрии платформы Monium: [метрики](../monium/metrics/quickstart.md), [логи](../monium/logs/quickstart.md) и [распределенные трассировки](../monium/traces/index.md);
* просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md), а также создавать, изменять и удалять дашборды;
* просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов, а также создавать, изменять и удалять контекстные ссылки;
* просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню [проекта](../monium/concepts/glossary.md#project), а также создавать, изменять и удалять быстрые ссылки;
* просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах, а также создавать, изменять и удалять шарды;
* просматривать список [алертов](../monium/concepts/alerting/alert.md), их настройки и историю срабатываний, а также создавать, изменять и удалять алерты;
* просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives), а также создавать, изменять и удалять SLO;
* просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов, а также создавать, изменять и удалять каналы уведомлений;
* просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для алертов, а также создавать, изменять и удалять политики эскалации;
* просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для алертов, а также создавать, изменять и удалять эскалации;
* просматривать, а также создавать, изменять и удалять [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать, а также добавлять новые, редактировать и удалять существующие [лейблы](../monium/traces/operations/traces-explorer.md) к ошибкам в логах;
* просматривать информацию о [правилах](../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®, а также создавать, изменять и удалять такие правила;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `monium.viewer`, `monium.telemetry.writer`, `monium.dashboards.editor`, `monium.shards.editor`, `monium.contextLinks.editor`, `monium.quickLinks.editor`, `monium.alerts.editor`, `monium.serviceLevelObjectives.editor`, `monium.channels.editor`, `monium.escalationPolicies.editor`, `monium.escalations.editor`, `monium.mutes.editor` и `monium.logErrorLabels.editor`.

#### monium.viewer {#monium-viewer}

Роль `monium.viewer` позволяет просматривать информацию о ресурсах платформы Monium с возможностью чтения всех видов телеметрии.

Пользователи с этой ролью могут:

* просматривать информацию о [проектах](../monium/concepts/glossary.md#project) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* читать все виды телеметрии платформы Monium: [метрики](../monium/metrics/quickstart.md), [логи](../monium/logs/quickstart.md) и [распределенные трассировки](../monium/traces/index.md);
* просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md);
* просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов;
* просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню проектов;
* просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах;
* просматривать список [алертов](../monium/concepts/alerting/alert.md), а также их настройки и историю срабатываний;
* просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives);
* просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для алертов;
* просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для алертов;
* просматривать [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать [лейблы](../monium/traces/operations/traces-explorer.md), привязанные к ошибкам в логах;
* просматривать информацию о [правилах](../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®;
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `monium.auditor` и `monium.telemetry.reader`.

#### monium.auditor {#monium-auditor}

Роль `monium.auditor` позволяет просматривать информацию о ресурсах платформы Monium без возможности чтения телеметрии.

Пользователи с этой ролью могут:
* просматривать информацию о [проектах](../monium/concepts/glossary.md#project) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md);
* просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов;
* просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню проектов;
* просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах;
* просматривать список [алертов](../monium/concepts/alerting/alert.md), а также их настройки и историю срабатываний;
* просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives);
* просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для алертов;
* просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для алертов;
* просматривать [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для алертов;
* просматривать [лейблы](../monium/traces/operations/traces-explorer.md), привязанные к ошибкам в логах;
* просматривать информацию о [правилах](../monium/operations/prometheus/recording-rules.md) Yandex Managed Service for Prometheus®.

Включает разрешения, предоставляемые ролями `monium.dashboards.viewer`, `monium.shards.viewer`, `monium.contextLinks.viewer`, `monium.quickLinks.viewer`, `monium.alerts.viewer`, `monium.serviceLevelObjectives.viewer`, `monium.channels.viewer`, `monium.escalationPolicies.viewer`, `monium.escalations.viewer`, `monium.mutes.viewer` и `monium.logErrorLabels.viewer`.

#### monium.alerts.editor {#monium-alerts-editor}

Роль `monium.alerts.editor` позволяет просматривать список [алертов](../monium/concepts/alerting/alert.md), их настройки и историю срабатываний, а также создавать, изменять и удалять алерты.

Включает разрешения, предоставляемые ролью `monium.alerts.viewer`.

#### monium.alerts.viewer {#monium-alerts-viewer}

Роль `monium.alerts.viewer` позволяет просматривать список [алертов](../monium/concepts/alerting/alert.md), а также их настройки и историю срабатываний.

#### monium.channels.editor {#monium-channels-editor}

Роль `monium.channels.editor` позволяет просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для [алертов](../monium/concepts/alerting/alert.md), а также создавать, изменять и удалять каналы уведомлений.

Включает разрешения, предоставляемые ролью `monium.channels.viewer`.

#### monium.channels.viewer {#monium-channels-viewer}

Роль `monium.channels.viewer` позволяет просматривать список и информацию о [каналах уведомлений](../monium/concepts/alerting/notification-channel.md) для [алертов](../monium/concepts/alerting/alert.md).

#### monium.contextLinks.editor {#monium-contextlinks-editor}

Роль `monium.contextLinks.editor` позволяет просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов, а также создавать, изменять и удалять контекстные ссылки.

Включает разрешения, предоставляемые ролью `monium.contextLinks.viewer`.

#### monium.contextLinks.viewer {#monium-contextlinks-viewer}

Роль `monium.contextLinks.viewer` позволяет просматривать настроенные контекстные ссылки на [графиках](../monium/concepts/visualization/widget.md#chart) дашбордов.

#### monium.dashboards.editor {#monium-dashboards-editor}

Роль `monium.dashboards.editor` позволяет просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md), а также создавать, изменять и удалять дашборды.

Включает разрешения, предоставляемые ролью `monium.dashboards.viewer`.

#### monium.dashboards.viewer {#monium-dashboards-viewer}

Роль `monium.dashboards.viewer` позволяет просматривать [дашборды](../monium/concepts/visualization/dashboard.md) и их [виджеты](../monium/concepts/visualization/widget.md).

#### monium.escalationPolicies.editor {#monium-escalationpolicies-editor}

Роль `monium.escalationPolicies.editor` позволяет просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для [алертов](../monium/concepts/alerting/alert.md), а также создавать, изменять и удалять политики эскалации.

Включает разрешения, предоставляемые ролью `monium.escalationPolicies.viewer`.

#### monium.escalationPolicies.viewer {#monium-escalationpolicies-viewer}

Роль `monium.escalationPolicies.viewer` позволяет просматривать список и настройки [политик эскалации](../monium/concepts/alerting/escalations.md#intro) для [алертов](../monium/concepts/alerting/alert.md).

#### monium.escalations.editor {#monium-escalations-editor}

Роль `monium.escalations.editor` позволяет просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для [алертов](../monium/concepts/alerting/alert.md), а также создавать, изменять и удалять эскалации.

Включает разрешения, предоставляемые ролью `monium.escalations.viewer`.

#### monium.escalations.viewer {#monium-escalations-viewer}

Роль `monium.escalations.viewer` позволяет просматривать информацию об уведомлениях и [эскалациях](../monium/concepts/alerting/escalations.md) для [алертов](../monium/concepts/alerting/alert.md).

#### monium.logErrorLabels.editor {#monium-logerrorlabels-editor}

Роль `monium.logErrorLabels.editor` позволяет просматривать, а также добавлять новые, редактировать и удалять существующие [лейблы](../monium/traces/operations/traces-explorer.md) к ошибкам в [логах](../monium/logs/quickstart.md).

Включает разрешения, предоставляемые ролью `monium.logErrorLabels.viewer`.

#### monium.logErrorLabels.viewer {#monium-logerrorlabels-viewer}

Роль `monium.logErrorLabels.viewer` позволяет просматривать [лейблы](../monium/traces/operations/traces-explorer.md), привязанные к ошибкам в логах.

#### monium.logs.reader {#monium-logs-reader}

Роль `monium.logs.reader` позволяет читать [логи](../monium/logs/quickstart.md) и просматривать статистику ошибок по логам.

#### monium.logs.writer {#monium-logs-writer}

Роль `monium.logs.writer` позволяет записывать [логи](../monium/logs/quickstart.md) на платформе Monium.

#### monium.metrics.reader {#monium-metrics-reader}

Роль `monium.metrics.reader` позволяет читать [метрики](../monium/metrics/quickstart.md), их значения и [метки](../resource-manager/concepts/labels.md).

#### monium.metrics.writer {#monium-metrics-writer}

Роль `monium.metrics.writer` позволяет записывать [метрики](../monium/metrics/quickstart.md).

#### monium.mutes.editor {#monium-mutes-editor}

Роль `monium.mutes.editor` позволяет просматривать, а также создавать, изменять и удалять [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для [алертов](../monium/concepts/alerting/alert.md).

Включает разрешения, предоставляемые ролью `monium.mutes.viewer`.

#### monium.mutes.viewer {#monium-mutes-viewer}

Роль `monium.mutes.viewer` позволяет просматривать [мьюты](../monium/alerts/mutes.md) — правила временного отключения [уведомлений](../monium/concepts/alerting/notification-channel.md) для [алертов](../monium/concepts/alerting/alert.md).

#### monium.quickLinks.editor {#monium-quicklinks-editor}

Роль `monium.quickLinks.editor` позволяет просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню [проекта](../monium/concepts/glossary.md#project), а также создавать, изменять и удалять быстрые ссылки.

Включает разрешения, предоставляемые ролью `monium.quickLinks.viewer`.

#### monium.quickLinks.viewer {#monium-quicklinks-viewer}

Роль `monium.quickLinks.viewer` позволяет просматривать список настроенных [быстрых ссылок](../monium/concepts/glossary.md#project-menu) и информацию о них в меню [проекта](../monium/concepts/glossary.md#project).

#### monium.serviceLevelObjectives.editor {#monium-servicelevelobjectives-editor}

Роль `monium.serviceLevelObjectives.editor` позволяет просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives), а также создавать, изменять и удалять SLO.

Включает разрешения, предоставляемые ролью `monium.serviceLevelObjectives.viewer`.

#### monium.serviceLevelObjectives.viewer {#monium-servicelevelobjectives-viewer}

Роль `monium.serviceLevelObjectives.viewer` позволяет просматривать настроенные [SLO](../monium/slo/index.md) (Service Level Objectives).

#### monium.shards.editor {#monium-shards-editor}

Роль `monium.shards.editor` позволяет просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах, а также создавать, изменять и удалять шарды.

Включает разрешения, предоставляемые ролью `monium.shards.viewer`.

#### monium.shards.viewer {#monium-shards-viewer}

Роль `monium.shards.viewer` позволяет просматривать информацию о [шардах](../monium/concepts/glossary.md#shard), [кластерах](../monium/concepts/glossary.md#cluster), [сервисах](../monium/concepts/glossary.md#service) и их квотах.

#### monium.telemetry.reader {#monium-telemetry-reader}

Роль `monium.telemetry.reader` позволяет читать все виды телеметрии платформы Monium: [метрики](../monium/metrics/quickstart.md), [логи](../monium/logs/quickstart.md) и [распределенные трассировки](../monium/traces/index.md).

Включает разрешения, предоставляемые ролями `monium.metrics.reader`, `monium.logs.reader` и `monium.traces.reader`.

#### monium.telemetry.writer {#monium-telemetry-writer}

Роль `monium.telemetry.writer` позволяет записывать все виды телеметрии на платформе Monium: [метрики](../monium/metrics/quickstart.md), [логи](../monium/logs/quickstart.md) и [распределенные трассировки](../monium/traces/index.md).

Включает разрешения, предоставляемые ролями `monium.metrics.writer`, `monium.logs.writer` и `monium.traces.writer`.

#### monium.traces.reader {#monium-traces-reader}

Роль `monium.traces.reader` позволяет просматривать данные [распределенных трассировок](../monium/traces/index.md).

#### monium.traces.writer {#monium-traces-writer}

Роль `monium.traces.writer` позволяет записывать [распределенные трассировки](../monium/traces/index.md).

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

#### managed-greenplum.clusters.connector {#managed-greenplum-clusters-connector}

Роль `managed-greenplum.clusters.connector` позволяет [пользователям](concepts/users/accounts.md) Yandex Cloud подключаться к базам данных в [кластерах Yandex MPP Analytics for PostgreSQL](../managed-greenplum/concepts/index.md) в сервисе Yandex MPP Analytics for PostgreSQL с помощью механизмов сервиса [Yandex Identity and Access Management](index.md).

{% endcut %}

{% cut "Yandex Security Deck" %}

#### security-deck.alertSinks.admin {#security-deck-alertsinks-admin}

Роль `security-deck.alertSinks.admin` позволяет управлять приемниками алертов и алертами, а также доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks), а также создавать, использовать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](concepts/access-control/index.md) к приемникам алертов и изменять такие права доступа;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных правах доступа к алертам и изменять такие права доступа;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

Включает разрешения, предоставляемые ролью `security-deck.alertSinks.editor`.

#### security-deck.alertSinks.editor {#security-deck-alertsinks-editor}

Роль `security-deck.alertSinks.editor` позволяет управлять приемниками алертов, алертами и комментариями в них.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* создавать, использовать, изменять и удалять приемники алертов;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем;
* создавать, изменять и удалять алерты;
* просматривать список комментариев к алертам, а также создавать, изменять и удалять комментарии.

Включает разрешения, предоставляемые ролями `security-deck.alertSinks.viewer` и `security-deck.alertSinks.user`.

#### security-deck.alertSinks.user {#security-deck-alertsinks-user}

Роль `security-deck.alertSinks.user` позволяет просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и использовать их.

#### security-deck.alertSinks.viewer {#security-deck-alertsinks-viewer}

Роль `security-deck.alertSinks.viewer` позволяет просматривать информацию об алертах и приемниках алертов, а также о назначенных правах доступа к ним.

Пользователи с этой ролью могут:
* просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию об [алертах](../security-deck/concepts/alerts.md) и назначенных правах доступа к ним;
* просматривать дополнительную информацию об алертах и их источниках, а также перечень затронутых ресурсов и рекомендации по устранению проблем.

Включает разрешения, предоставляемые ролью `security-deck.alertSinks.auditor`.

#### security-deck.alertSinks.auditor {#security-deck-alertsinks-auditor}

Роль `security-deck.alertSinks.auditor` позволяет просматривать информацию о [приемниках алертов](../security-deck/concepts/workspace.md#alert-sinks) и назначенных [правах доступа](concepts/access-control/index.md) к ним.

{% endcut %}

## Ноябрь 2025 {#november-2025}

### Изменения в сервисе Identity and Access Management {#iam-november-2025}

* [Добавлена](../organization/operations/view-subject-access-bindings.md) возможность посмотреть список доступов субъекта.

### Новые роли {#roles-november-2025}

{% cut "Yandex Cloud Interconnect" %}

#### cic.admin {#cic-admin}

Роль `cic.admin` позволяет управлять ресурсами сервиса Cloud Interconnect.

{% cut "Пользователи с этой ролью могут:" %}

* просматривать информацию о [транковых подключениях](../interconnect/concepts/trunk.md), а также создавать, изменять и удалять их;
* просматривать информацию о [приватных соединениях](../interconnect/concepts/priv-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [публичных соединениях](../interconnect/concepts/pub-con.md), а также создавать, изменять и удалять их;
* просматривать информацию о [точках присутствия](../interconnect/concepts/pops.md);
* просматривать информацию о [партнерах CIC](../interconnect/concepts/partners.md);
* просматривать информацию о [квотах](../interconnect/concepts/limits.md#interconnect-quotas) сервиса Cloud Interconnect;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

{% endcut %}

Включает разрешения, предоставляемые ролью `cic.editor`.

{% endcut %}

{% cut "Yandex Cloud Router" %}

#### cloud-router.admin {#cloud-router-admin}

Роль `cloud-router.admin` позволяет управлять ресурсами сервиса Cloud Router.

Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md), а также создавать, изменять и удалять их;
* добавлять, изменять и удалять [IP-префиксы](../cloud-router/concepts/announces.md) облачных [подсетей](../vpc/concepts/network.md#subnet) в Routing Instance;
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.editor`.

#### cloud-router.prefixEditor {#cloud-router-prefixeditor}

Роль `cloud-router.prefixEditor` позволяет управлять IP-префиксами облачных подсетей в Routing Instance, а также просматривать информацию о ресурсах сервиса Cloud Router.

"Пользователи с этой ролью могут:
* просматривать информацию о [Routing Instance](../cloud-router/concepts/routing-instance.md);
* добавлять, изменять и удалять [IP-префиксы](../cloud-router/concepts/announces.md) облачных [подсетей](../vpc/concepts/network.md#subnet) в Routing Instance;
* просматривать информацию о квотах сервиса Cloud Router;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud);
* просматривать информацию о [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролью `cloud-router.viewer`.

{% endcut %}

{% cut "Yandex Identity Hub" %}

#### organization-manager.idpInstances.billingAdmin {#organization-manager-idpinstances-billingadmin}

Роль `organization-manager.idpInstances.billingAdmin` позволяет управлять подпиской на платные возможности сервиса Yandex Identity Hub.

Пользователи с этой ролью могут:
* привязывать сервис Yandex Identity Hub к [платежному аккаунту](../billing/concepts/billing-account.md);
* просматривать информацию о подписке на платные возможности сервиса Yandex Identity Hub;
* просматривать информацию о статистике использования квот по подписке на платные возможности сервиса Yandex Identity Hub, а также изменять эти квоты;
* просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в Yandex Identity Hub.

Включает разрешения, предоставляемые ролью `organization-manager.idpInstances.billingViewer`.

#### organization-manager.idpInstances.billingViewer {#organization-manager-idpinstances-billingviewer}

Роль `organization-manager.idpInstances.billingViewer` позволяет просматривать список пользователей, которые в текущем [отчетном периоде](../billing/concepts/reporting-period.md) используют квоту для аутентификации в Yandex Identity Hub, а также информацию о подписке на платные возможности сервиса Yandex Identity Hub и статистике использования квот по этой подписке.

{% endcut %}

## Октябрь 2025 {#october-2025}

### Изменения в сервисе Identity and Access Management {#iam-october-2025}

* [Добавлена](operations/service-control/enable-disable.md) возможность управлять доступом сервисов к ресурсам пользователя.

### Новые роли {#roles-october-2025}

{% cut "Управляемые базы данных" %}

#### mdb.restorer {#mdb-restorer}

Роль `mdb.restorer` позволяет восстанавливать кластеры управляемых баз данных из резервных копий, а также предоставляет доступ к чтению информации из кластеров и к логам их работы.

Пользователи с этой ролью могут восстанавливать кластеры управляемых баз данных из резервных копий, читать информацию из баз данных и просматривать логи кластеров, а также просматривать информацию о кластерах, заданиях на их техническое обслуживание, квотах и операциях с ресурсами сервисов.

Включает разрешения, предоставляемые ролями `mdb.viewer`, `managed-opensearch.restorer`, `managed-mysql.restorer`, `managed-postgresql.restorer`, `managed-spqr.restorer`, `managed-greenplum.restorer`, `managed-clickhouse.restorer`, `managed-redis.restorer` и `managed-mongodb.restorer`.

{% endcut %}

{% cut "Yandex Identity Hub" %}

#### organization-manager.groups.externalConverter {#organization-manager-groups-externalconverter}

Роль `organization-manager.groups.externalConverter` позволяет добавлять в [группы пользователей](../organization/concepts/groups.md) Yandex Identity Hub атрибут с идентификатором внешней группы при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.groups.externalCreator {#organization-manager-groups-externalcreator}

Роль `organization-manager.groups.externalCreator` позволяет создавать [группы пользователей](../organization/concepts/groups.md) Yandex Identity Hub при выполнении синхронизации с группами пользователей в каталоге Active Directory или другом внешнем источнике.

#### organization-manager.userpools.syncAgent {#organization-manager-userpools-syncagent}

Роль `organization-manager.userpools.syncAgent` позволяет выполнять синхронизацию пользователей и групп Yandex Identity Hub с пользователями и группами в каталоге Active Directory или другом внешнем источнике.

Пользователи с этой ролью могут:
* просматривать информацию о сессиях синхронизации агента Identity Hub AD Sync Agent с сервисом Yandex Identity Hub, а также создавать и изменять такие сессии;
* просматривать информацию о [пулах пользователей](../organization/concepts/user-pools.md) и о настройках синхронизации в пулах пользователей;
* просматривать список и информацию о [группах пользователей](../organization/concepts/groups.md) Yandex Identity Hub, привязанных к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* привязывать группы пользователей к пулам пользователей в процессе синхронизации с пользовательскими группами в каталоге Active Directory или другом внешнем источнике;
* просматривать информацию о пользователях Yandex Identity Hub, создавать, изменять, активировать, деактивировать, удалять пользователей, а также изменять пароли и другие данные пользователей Yandex Identity Hub.

Включает разрешения, предоставляемые ролью `organization-manager.userpools.extGroupsManager`.

{% endcut %}

{% cut "Yandex Managed Service for Apache Kafka®" %}

#### managed-kafka.restorer {#managed-kafka-restorer}

Роль `managed-kafka.restorer` позволяет восстанавливать кластеры Apache Kafka® из резервных копий, просматривать информацию о кластерах и логи их работы, а также данные о квотах и операциях с ресурсами сервиса Managed Service for Apache Kafka®.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Kafka®](../managed-kafka/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* восстанавливать кластеры Apache Kafka® из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-kafka/concepts/maintenance.md) кластеров Apache Kafka®;
* просматривать логи работы кластеров Apache Kafka®;
* просматривать информацию о [квотах](../managed-kafka/concepts/limits.md#mkf-quotas) сервиса Managed Service for Apache Kafka®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Apache Kafka®.

Включает разрешения, предоставляемые ролью `managed-kafka.viewer`.

{% endcut %}

{% cut "Yandex Managed Service for ClickHouse®" %}

#### managed-clickhouse.restorer {#managed-clickhouse-restorer}

Роль `managed-clickhouse.restorer` позволяет восстанавливать кластеры ClickHouse® из резервных копий, просматривать информацию о кластерах и логи их работы, а также данные о квотах и операциях с ресурсами сервиса Managed Service for ClickHouse®.

Пользователи с этой ролью могут:
* восстанавливать [кластеры ClickHouse®](../managed-clickhouse/concepts/index.md) из резервных копий;
* просматривать информацию о кластерах ClickHouse® и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-clickhouse/concepts/maintenance.md) кластеров ClickHouse®;
* просматривать логи работы кластеров ClickHouse®;
* просматривать информацию о результатах диагностики производительности кластеров ClickHouse®;
* просматривать информацию о [квотах](../managed-clickhouse/concepts/limits.md#mch-quotas) сервиса Managed Service for ClickHouse®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for ClickHouse®.

Включает разрешения, предоставляемые ролью `managed-clickhouse.viewer`.

{% endcut %}


{% cut "Yandex Managed Service for MySQL®" %}

#### managed-mysql.restorer {#managed-mysql-restorer}

Роль `managed-mysql.restorer` позволяет восстанавливать кластеры MySQL® из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях MySQL®, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров](../managed-mysql/concepts/index.md) MySQL® и восстанавливать кластеры из [резервных копий](../managed-mysql/concepts/backup.md);
* просматривать информацию о кластерах MySQL® и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-mysql/concepts/maintenance.md) кластеров MySQL®;
* просматривать информацию о [хостах](../managed-mysql/concepts/instance-types.md) кластеров MySQL®;
* просматривать информацию о базах данных MySQL®;
* просматривать информацию о [пользователях](../managed-mysql/concepts/user-rights.md) MySQL®;
* просматривать информацию об алертах MySQL®;
* просматривать логи работы кластеров MySQL®;
* просматривать информацию о результатах диагностики производительности кластеров MySQL®;
* просматривать информацию о [квотах](../managed-mysql/concepts/limits.md#mmy-quotas) сервиса Managed Service for MySQL®;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for MySQL®.

Включает разрешения, предоставляемые ролью `managed-mysql.viewer`.

{% endcut %}

{% cut "Yandex Managed Service for OpenSearch" %}

#### managed-opensearch.restorer {#managed-opensearch-restorer}

Роль `managed-opensearch.restorer` позволяет восстанавливать кластеры OpenSearch из резервных копий, просматривать информацию о кластерах OpenSearch, логи их работы, а также информацию о квотах и операциях с ресурсами сервиса Managed Service for OpenSearch.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах OpenSearch](../managed-opensearch/concepts/index.md) и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* восстанавливать кластеры OpenSearch из резервных копий;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-opensearch/concepts/maintenance.md) кластеров OpenSearch;
* просматривать логи работы кластеров OpenSearch;
* просматривать информацию о [квотах](../managed-opensearch/concepts/limits.md#quotas) сервиса Managed Service for OpenSearch;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for OpenSearch.

Включает разрешения, предоставляемые ролью `managed-opensearch.viewer`.

{% endcut %}

{% cut "Yandex Managed Service for PostgreSQL" %}

#### managed-postgresql.restorer {#managed-postgresql-restorer}

Роль `managed-postgresql.restorer` позволяет восстанавливать кластеры PostgreSQL из резервных копий, просматривать информацию о кластерах, хостах, базах данных и пользователях PostgreSQL, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров PostgreSQL](../managed-postgresql/concepts/index.md) и восстанавливать кластеры из [резервных копий](../managed-postgresql/concepts/backup.md);
* просматривать информацию о кластерах PostgreSQL и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-postgresql/concepts/maintenance.md) кластеров PostgreSQL;
* просматривать информацию о [хостах](../managed-postgresql/concepts/instance-types.md) кластеров PostgreSQL;
* просматривать информацию о базах данных PostgreSQL;
* просматривать информацию о [пользователях](../managed-postgresql/concepts/roles.md) PostgreSQL;
* просматривать информацию об алертах PostgreSQL;
* просматривать логи работы кластеров PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров PostgreSQL;
* просматривать информацию о [квотах](../managed-postgresql/concepts/limits.md#mpg-quotas) сервиса Managed Service for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-postgresql.viewer`.

{% endcut %}

{% cut "Yandex Managed Service for Sharded PostgreSQL" %}

#### managed-spqr.restorer {#managed-spqr-restorer}

Роль `managed-spqr.restorer` позволяет восстанавливать кластеры Sharded PostgreSQL из резервных копий, а также просматривать информацию о кластерах, хостах, базах данных и пользователях в кластерах Sharded PostgreSQL, логи работы кластеров, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров](../managed-spqr/concepts/index.md) Sharded PostgreSQL, а также восстанавливать кластеры из резервных копий;
* просматривать информацию о кластерах Sharded PostgreSQL и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на техническое обслуживание кластеров Sharded PostgreSQL;
* просматривать информацию о [хостах](../managed-spqr/concepts/instance-types.md) кластеров Sharded PostgreSQL;
* просматривать информацию о базах данных в кластерах Sharded PostgreSQL;
* просматривать информацию о пользователях в кластерах Sharded PostgreSQL;
* просматривать логи работы кластеров Sharded PostgreSQL;
* просматривать информацию о [квотах](../managed-spqr/concepts/limits.md#mspqr-quotas) сервиса Managed Service for Sharded PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Managed Service for Sharded PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-spqr.viewer`.

{% endcut %}


{% cut "Yandex Managed Service for Valkey™" %}

#### managed-redis.restorer {#managed-redis-restorer}

Роль `managed-redis.restorer` позволяет восстанавливать кластеры Valkey™ из резервных копий, а также просматривать информацию о хостах и кластерах Valkey™, логи их работы, данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о [резервных копиях](../managed-valkey/concepts/backup.md) кластеров Valkey™, а также восстанавливать [кластеры](../managed-valkey/concepts/index.md) из резервных копий;
* просматривать информацию о кластерах Valkey™ и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-valkey/concepts/maintenance.md) кластеров Valkey™;
* просматривать информацию о [хостах](../managed-valkey/concepts/instance-types.md) кластеров Valkey™;
* просматривать информацию о [шардах](../managed-valkey/concepts/sharding.md) кластеров Valkey™;
* просматривать [информацию](../managed-valkey/operations/user-list.md) о пользователях Valkey™;
* просматривать информацию об алертах Valkey™;
* просматривать логи работы кластеров Valkey™;
* просматривать информацию о [квотах](../managed-valkey/concepts/limits.md#mrd-quotas) сервиса Yandex Managed Service for Valkey™;
* просматривать информацию об операциях с ресурсами сервиса Yandex Managed Service for Valkey™.

Включает разрешения, предоставляемые ролью `managed-redis.viewer`.

{% endcut %}

{% cut "Yandex MPP Analytics for PostgreSQL" %}

#### managed-greenplum.restorer {#managed-greenplum-restorer}

Роль `managed-greenplum.restorer` позволяет восстанавливать из резервных копий кластеры Yandex MPP Analytics for PostgreSQL в сервисе Yandex MPP Analytics for PostgreSQL, просматривать информацию о кластерах и хостах Yandex MPP Analytics for PostgreSQL, логи их работы, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров Yandex MPP Analytics for PostgreSQL](../managed-greenplum/concepts/index.md) и восстанавливать кластеры из [резервных копий](../managed-greenplum/concepts/backup.md);
* просматривать информацию о кластерах Yandex MPP Analytics for PostgreSQL и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../managed-greenplum/concepts/maintenance.md) кластеров Yandex MPP Analytics for PostgreSQL;
* просматривать информацию о [хостах](../managed-greenplum/concepts/instance-types.md) кластеров Yandex MPP Analytics for PostgreSQL;
* просматривать логи работы кластеров Yandex MPP Analytics for PostgreSQL;
* просматривать информацию о результатах диагностики производительности кластеров Yandex MPP Analytics for PostgreSQL;
* просматривать информацию о [квотах](../managed-greenplum/concepts/limits.md#quotas) сервиса Yandex MPP Analytics for PostgreSQL;
* просматривать информацию об операциях с ресурсами сервиса Yandex MPP Analytics for PostgreSQL.

Включает разрешения, предоставляемые ролью `managed-greenplum.viewer`.

{% endcut %}

{% cut "Yandex StoreDoc" %}

#### managed-mongodb.restorer {#managed-mongodb-restorer}

Роль `managed-mongodb.restorer` позволяет восстанавливать кластеры Yandex StoreDoc из резервных копий, просматривать информацию о кластерах, хостах, шардах, базах данных и пользователях Yandex StoreDoc, логи работы кластеров, а также данные о квотах и операциях с ресурсами сервиса.

Пользователи с этой ролью могут:
* просматривать информацию о резервных копиях [кластеров Yandex StoreDoc](../storedoc/concepts/index.md) и восстанавливать кластеры из [резервных копий](../storedoc/concepts/backup.md);
* просматривать информацию о кластерах Yandex StoreDoc и назначенных [правах доступа](concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](../storedoc/concepts/maintenance.md) кластеров Yandex StoreDoc;
* просматривать информацию о [хостах](../storedoc/concepts/instance-types.md) кластеров Yandex StoreDoc;
* просматривать информацию о [шардах](../storedoc/concepts/sharding.md) кластеров Yandex StoreDoc;
* просматривать информацию о базах данных Yandex StoreDoc;
* просматривать информацию о [пользователях](../storedoc/concepts/users-and-roles.md) Yandex StoreDoc;
* просматривать информацию об алертах Yandex StoreDoc;
* просматривать [логи](../storedoc/operations/cluster-logs.md) работы кластеров Yandex StoreDoc;
* просматривать информацию о результатах диагностики производительности кластеров Yandex StoreDoc;
* просматривать информацию о [квотах](../storedoc/concepts/limits.md#mmg-quotas) сервиса Yandex StoreDoc;
* просматривать информацию об операциях с ресурсами сервиса Yandex StoreDoc.

Включает разрешения, предоставляемые ролью `managed-mongodb.viewer`.

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