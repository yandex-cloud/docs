# Управление доступом Audit Trails

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `audit-trails.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

На [трейл](../concepts/trail.md) роль можно назначить через Yandex Cloud [CLI](../../cli/cli-ref/audit-trails/cli-ref/trail/add-access-binding.md) или [API](../api-ref/authentication.md).

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

![image](../../_assets/audit-trails/at-role-diagram.svg)
<small>\* deprecated</small>

### Сервисные роли {#service-roles}

#### audit-trails.auditor {#at-auditor}

Роль `audit-trails.auditor` позволяет просматривать список [трейлов](../concepts/trail.md) и информацию о них, а также об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../concepts/limits.md#audit-trails-quotas) сервиса Audit Trails.

#### audit-trails.viewer {#at-viewer}

Роль `audit-trails.viewer` позволяет читать [аудитные логи](../concepts/index.md), а также просматривать список [трейлов](../concepts/trail.md) и информацию о трейлах, [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../concepts/limits.md#audit-trails-quotas) сервиса Audit Trails.

Включает разрешения, предоставляемые ролью `audit-trails.auditor`.

#### audit-trails.editor {#at-editor}

Роль `audit-trails.editor` позволяет управлять трейлами и читать аудитные логи.

Пользователи с этой ролью могут:
* просматривать список [трейлов](../concepts/trail.md) и информацию о них, а также создавать, изменять и удалять трейлы;
* читать [аудитные логи](../concepts/index.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../concepts/limits.md#audit-trails-quotas) сервиса Audit Trails.

Включает разрешения, предоставляемые ролью `audit-trails.viewer`.

#### audit-trails.admin {#at-admin}

Роль `audit-trails.admin` позволяет управлять трейлами и доступом к ним, а также читать аудитные логи.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к [трейлам](../concepts/trail.md), а также изменять такие права доступа;
* просматривать список трейлов и информацию о них, а также создавать, изменять и удалять трейлы;
* читать [аудитные логи](../concepts/index.md);
* просматривать информацию об [облаке](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../concepts/limits.md#audit-trails-quotas) сервиса Audit Trails.

Включает разрешения, предоставляемые ролью `audit-trails.editor`.

#### audit-trails.configViewer {#at-configviewer}

Роль `audit-trails.configViewer` позволяет просматривать список трейлов и информацию о них, а также об облаке, каталоге и квотах сервиса Audit Trails.

Эта роль недоступна. Используйте роль `audit-trails.auditor`.

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

## Какие роли мне необходимы {#choosing-roles}

В таблице сопоставлены действия и минимальные необходимые для их выполнения роли. Вы всегда можете назначить роль, которая дает более широкие права, чем указанная в таблице. Например, вместо `audit-trails.configViewer` можно выдать роль `audit-trails.editor`.

Действие | Роль
----- | -----
Просмотр информации о трейле | `audit-trails.auditor` 
Сбор и просмотр аудитных событий в трейле | `audit-trails.viewer` 
Создание трейла | `audit-trails.editor` 
Редактирование трейла | `audit-trails.editor` 
Удаление трейла | `audit-trails.editor` 
Управление ролями других пользователей на трейл | `audit-trails.admin`


## Что дальше {#whats-next}

* Ознакомьтесь со структурой [аудитного лога](../concepts/format.md).
* Узнайте, как создать трейл, который [загружает логи в нужный объект назначения](../operations/create-trail.md).