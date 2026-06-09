# Управление доступом в {{ captcha-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

## Об управлении доступом {#about-access-control}

Все операции в {{ yandex-cloud }} проверяются в сервисе [{{ iam-full-name }}](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `smart-captcha.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/index.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на капчи, которые находятся в них.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

```mermaid
flowchart BT
    smart-captcha.editor --> smart-captcha.admin
    smart-captcha.viewer --> smart-captcha.editor
    smart-captcha.auditor --> smart-captcha.viewer
```

### Сервисные роли {#service-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

Роль `smart-captcha.auditor` позволяет просматривать информацию о [капчах](../concepts/validation.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним.

#### smart-captcha.viewer {#smart-captcha-viewer}

Роль `smart-captcha.viewer` позволяет просматривать информацию о [капчах](../concepts/validation.md) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также получать [ключи](../concepts/keys.md) капчи.

Включает разрешения, предоставляемые ролью `smart-captcha.auditor`.

#### smart-captcha.editor {#smart-captcha-editor}

Роль `smart-captcha.editor` позволяет управлять капчами, просматривать информацию о них и получать ключи капчи.

Пользователи с этой ролью могут:
* просматривать информацию о [капчах](../concepts/validation.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к капчам;
* получать [ключи капчи](../concepts/keys.md).

Включает разрешения, предоставляемые ролью `smart-captcha.viewer`.

#### smart-captcha.admin {#smart-captcha-admin}

Роль `smart-captcha.admin` позволяет управлять капчами и доступом к ним, а также получать ключи капчи.

Пользователи с этой ролью могут:
* просматривать информацию о [капчах](../concepts/validation.md), а также создавать, изменять и удалять их;
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к капчам и изменять такие права доступа;
* получать [ключи капчи](../concepts/keys.md).

Включает разрешения, предоставляемые ролью `smart-captcha.editor`.

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

## Какие роли мне необходимы {#choosing-roles}

В таблице сопоставлены действия и минимальные роли, необходимые для их выполнения. Вы всегда можете назначить роль, которая дает более широкие права, чем указанная в таблице. Например, вместо `smart-captcha.viewer` можно выдать роль `smart-captcha.editor`.

Действие | Роль
----- | -----
Просмотр информации о капче | `smart-captcha.viewer`
Создание капчи | `smart-captcha.editor`
Редактирование капчи | `smart-captcha.editor`
Удаление капчи | `smart-captcha.editor`
Управление ролями пользователей на капче | `smart-captcha.admin`