# Управление доступом к Yandex Managed Service for Apache Spark™


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

Для использования сервиса необходимо аутентифицироваться в консоли управления с [аккаунтом на Яндексе](../iam/concepts/users/accounts.md#passport), [федеративным](../iam/concepts/users/accounts.md#saml-federation) или [локальным](../iam/concepts/users/accounts.md#local) аккаунтом.

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../iam/concepts/users/service-accounts.md), [локальному пользователю](../iam/concepts/users/accounts.md#local), [федеративному пользователю](../iam/concepts/federations.md), [группе пользователей](../organization/operations/manage-groups.md), [системной группе](../iam/concepts/access-control/system-group.md) или [публичной группе](../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `managed-spark.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../organization/concepts/organization.md), [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

Чтобы разрешить доступ к ресурсам сервиса Yandex Managed Service for Apache Spark™ (кластеры, учетные записи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы.

В [консоли управления](https://console.yandex.cloud), через [CLI](../cli/index.md) или [API](api-ref/authentication.md) роль также можно назначить на отдельный кластер.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

```mermaid
flowchart BT
    managed-spark.auditor --> managed-spark.viewer
    managed-spark.viewer --> managed-spark.user
    managed-spark.user --> managed-spark.editor
    managed-spark.editor --> managed-spark.admin
    managed-spark.auditor --> managed-spark.maintenanceTask.viewer["`managed-spark.
    maintenanceTask.viewer`"]
    managed-spark.maintenanceTask.viewer --> managed-spark.maintenanceTask.editor["`managed-spark.
    maintenanceTask.editor`"]
    managed-spark.maintenanceTask.viewer --> managed-spark.viewer
    managed-spark.maintenanceTask.editor --> managed-spark.editor
    managed-spark.integrationProvider["`managed-spark.
    integrationProvider`"]
```

### Сервисные роли {#service-roles}

#### managed-spark.auditor {#managed-spark-auditor}

Роль `managed-spark.auditor` позволяет просматривать информацию о [кластерах Apache Spark™](concepts/index.md) и назначенных [правах доступа](../iam/concepts/access-control/index.md) к ним, а также о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

#### managed-spark.viewer {#managed-spark-viewer}

Роль `managed-spark.viewer` позволяет просматривать информацию о кластерах Apache Spark™, заданиях и квотах сервиса Managed Service for Apache Spark™.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Spark™](concepts/index.md) и назначенных [правах доступа](../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](concepts/maintenance.md) кластеров Apache Spark™;
* просматривать информацию о [заданиях](operations/index.md#jobs);
* просматривать информацию о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролями `managed-spark.auditor` и `managed-spark.maintenanceTask.viewer`.

#### managed-spark.user {#managed-spark-user}

Роль `managed-spark.user` позволяет выполнять базовые операции с кластерами Apache Spark™ и заданиями.

Пользователи с этой ролью могут:
* использовать веб-интерфейс Apache Spark™;
* просматривать информацию о [заданиях](operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [кластерах Apache Spark™](concepts/index.md) и назначенных [правах доступа](../iam/concepts/access-control/index.md) к ним;
* просматривать информацию о заданиях на [техническое обслуживание](concepts/maintenance.md) кластеров Apache Spark™;
* просматривать информацию о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.viewer`.

#### managed-spark.editor {#managed-spark-editor}

Роль `managed-spark.editor` позволяет управлять кластерами Apache Spark™ и заданиями.

Пользователи с этой ролью могут:
* просматривать информацию о [кластерах Apache Spark™](concepts/index.md), а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о назначенных [правах доступа](../iam/concepts/access-control/index.md) к кластерам Apache Spark™;
* просматривать информацию о заданиях на [техническое обслуживание](concepts/maintenance.md) кластеров Apache Spark™ и изменять такие задания;
* использовать веб-интерфейс Apache Spark™;
* просматривать информацию о [заданиях](operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролями `managed-spark.user` и `managed-spark.maintenanceTask.editor`.

Для создания кластеров Apache Spark™ дополнительно необходима роль `vpc.user`.

#### managed-spark.admin {#managed-spark-admin}

Роль `managed-spark.admin` позволяет управлять кластерами Apache Spark™ и доступом к ним.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../iam/concepts/access-control/index.md) к [кластерам Apache Spark™](concepts/index.md) и изменять такие права доступа;
* просматривать информацию о кластерах Apache Spark™, а также создавать, изменять, запускать, останавливать и удалять их;
* просматривать информацию о заданиях на [техническое обслуживание](concepts/maintenance.md) кластеров Apache Spark™ и изменять такие задания;
* использовать веб-интерфейс Apache Spark™;
* просматривать информацию о [заданиях](operations/index.md#jobs), а также создавать, запускать и отменять их;
* просматривать информацию о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.editor`.

Для создания кластеров Apache Spark™ дополнительно необходима роль `vpc.user`.

#### managed-spark.maintenanceTask.viewer {#managed-spark-maintenanceTask-viewer}

Роль `managed-spark.maintenanceTask.viewer` позволяет просматривать информацию о [кластерах Apache Spark™](concepts/index.md) и назначенных [правах доступа](../iam/concepts/access-control/index.md) к ним, а также о заданиях на [техническое обслуживание](concepts/maintenance.md) таких кластеров и [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.auditor`.

#### managed-spark.maintenanceTask.editor {#managed-spark-maintenanceTask-editor}

Роль `managed-spark.maintenanceTask.editor` позволяет просматривать информацию о заданиях на [техническое обслуживание](concepts/maintenance.md) кластеров Apache Spark™ и изменять такие задания, просматривать информацию о [кластерах Apache Spark™](concepts/index.md) и назначенных [правах доступа](../iam/concepts/access-control/index.md) к ним, а также о [квотах](concepts/limits.md#quotas) сервиса Managed Service for Apache Spark™.

Включает разрешения, предоставляемые ролью `managed-spark.maintenanceTask.viewer`.

#### managed-spark.integrationProvider {#managed-spark-integrationProvider}

Роль `managed-spark.integrationProvider` позволяет кластеру Apache Spark™ взаимодействовать от имени сервисного аккаунта с пользовательскими ресурсами, необходимыми для работы кластера. Роль назначается сервисному аккаунту, привязанному к кластеру Apache Spark™.

Пользователи с этой ролью могут:
* добавлять записи в [лог-группы](../logging/concepts/log-group.md);
* просматривать информацию о лог-группах;
* просматривать информацию о приемниках логов;
* просматривать информацию о назначенных [правах доступа](../iam/concepts/access-control/index.md) к ресурсам сервиса Cloud Logging;
* просматривать информацию о выгрузках логов;
* просматривать информацию о [метриках](../monitoring/concepts/data-model.md#metric) и их [метках](../monitoring/concepts/data-model.md#label), а также загружать и выгружать метрики;
* просматривать список [дашбордов](../monitoring/concepts/visualization/dashboard.md) и [виджетов](../monitoring/concepts/visualization/widget.md) и информацию о них, а также создавать, изменять и удалять дашборды и виджеты;
* просматривать историю [уведомлений](../monitoring/concepts/alerting/notification-channel.md);
* просматривать информацию о [квотах](../monitoring/concepts/limits.md#monitoring-quotas) сервиса Monitoring;
* просматривать информацию об [облаке](../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../resource-manager/concepts/resources-hierarchy.md#folder).

Включает разрешения, предоставляемые ролями `logging.writer` и `monitoring.editor`.

### Примитивные роли {#primitive-roles}

Примитивные роли позволяют пользователям совершать действия во [всех сервисах](../overview/concepts/services.md) Yandex Cloud.

#### auditor {#auditor}

Роль `auditor` предоставляет разрешения на чтение конфигурации и метаданных любых ресурсов Yandex Cloud без возможности доступа к данным.

Например, пользователи с этой ролью могут:
* просматривать информацию о [ресурсе](../resource-manager/concepts/resources-hierarchy.md);
* просматривать метаданные ресурса;
* просматривать список операций с ресурсом.

Роль `auditor` — наиболее безопасная роль, исключающая доступ к данным [сервисов](../overview/concepts/services.md). Роль подходит для пользователей, которым необходим минимальный уровень доступа к ресурсам Yandex Cloud.

#### viewer {#viewer}

Роль `viewer` предоставляет разрешения на чтение информации о любых [ресурсах](../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud.

Включает разрешения, предоставляемые ролью `auditor`.

В отличие от роли `auditor`, роль `viewer` предоставляет доступ к данным [сервисов](../overview/concepts/services.md) в режиме чтения.

#### editor {#editor}

Роль `editor` предоставляет разрешения на управление любыми [ресурсами](../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме назначения ролей другим пользователям, передачи прав владения [организацией](../organization/concepts/organization.md) и ее удаления, а также удаления [ключей шифрования](../kms/concepts/index.md) Key Management Service.

Например, пользователи с этой ролью могут создавать, изменять и удалять ресурсы.

Включает разрешения, предоставляемые ролью `viewer`.

#### admin {#admin}

Роль `admin` позволяет назначать любые роли, кроме `resource-manager.clouds.owner` и `organization-manager.organizations.owner`, а также предоставляет разрешения на управление любыми [ресурсами](../resource-manager/concepts/resources-hierarchy.md) Yandex Cloud, кроме передачи прав владения [организацией](../organization/concepts/organization.md) и ее удаления.

Прежде чем назначить роль `admin` на организацию, [облако](../resource-manager/concepts/resources-hierarchy.md#cloud) или [платежный аккаунт](../billing/concepts/billing-account.md), ознакомьтесь с информацией о защите [привилегированных аккаунтов](../security/standard/all.md#privileged-users).

Включает разрешения, предоставляемые ролью `editor`.

Вместо примитивных ролей мы рекомендуем использовать роли сервисов. Такой подход позволит более гранулярно управлять доступом и обеспечить соблюдение [принципа минимальных привилегий](../security/standard/all.md#min-privileges).

Подробнее о примитивных ролях в [справочнике ролей Yandex Cloud](../iam/roles-reference.md#primitive-roles).

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль `managed-spark.editor` или выше на каталог, в котором создается кластер. Роль `managed-spark.viewer` позволит только просматривать список кластеров.

Чтобы создать кластер Yandex Managed Service for Apache Spark™, нужны роли [vpc.user](../vpc/security/index.md#vpc-user) и [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user), а также роль `managed-spark.admin` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `managed-spark.admin` вместо `managed-spark.editor`.

## Что дальше {#whats-next}

* [Как назначить роль](../iam/operations/roles/grant.md).
* [Как отозвать роль](../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в Yandex Cloud](../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).