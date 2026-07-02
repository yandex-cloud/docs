[Документация Yandex Cloud](../../index.md) > [Yandex Lockbox](../index.md) > Управление доступом

# Управление доступом в Yandex Lockbox

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

## Об управлении доступом {#about-access-control}

Все операции в Yandex Cloud проверяются в сервисе [Yandex Identity and Access Management](../../iam/index.md). Если у субъекта нет необходимых разрешений, сервис вернет ошибку.


Чтобы выдать разрешения к ресурсу, [назначьте роли](../../iam/operations/roles/grant.md) на этот ресурс субъекту, который будет выполнять операции. Роли можно назначить [аккаунту на Яндексе](../../iam/concepts/users/accounts.md#passport), [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [локальному пользователю](../../iam/concepts/users/accounts.md#local), [федеративному пользователю](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее читайте в разделе [Как устроено управление доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `lockbox.admin` или одна из следующих ролей:

* `admin`;
* `resource-manager.admin`;
* `organization-manager.admin`;
* `resource-manager.clouds.owner`;
* `organization-manager.organizations.owner`.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [организацию](../../organization/concepts/organization.md), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на вложенные ресурсы.

На [секрет](../concepts/secret.md) роль можно назначить в [консоли управления](https://console.yandex.cloud), а также через Yandex Cloud [CLI](../../cli/cli-ref/lockbox/cli-ref/secret/add-access-binding.md), [API](../api-ref/authentication.md) или [Terraform](../../terraform/resources/lockbox_secret_iam_binding.md).

## Какие роли действуют в сервисе {#roles-list}

Управлять доступом к секретам можно как с помощью сервисных, так и с помощью примитивных ролей. 

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `editor` входят все разрешения `viewer`. После диаграммы дано описание каждой роли.

```mermaid
flowchart BT
    lockbox.editor --> lockbox.admin
    lockbox.payloadViewer ---> lockbox.admin
    lockbox.viewer --> lockbox.editor
    lockbox.auditor --> lockbox.viewer
```

### Сервисные роли {#service-roles}

#### lockbox.auditor {#lockbox-auditor}

Роль `lockbox.auditor` позволяет просматривать информацию о [секретах](../concepts/secret.md#secret) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex Lockbox и метаинформацию [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder).

#### lockbox.viewer {#lockbox-viewer}

Роль `lockbox.viewer` позволяет просматривать информацию о [секретах](../concepts/secret.md#secret) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder) и [квотах](../concepts/limits.md#quotas) сервиса Yandex Lockbox.

Включает разрешения, предоставляемые ролью `lockbox.auditor`.

#### lockbox.editor {#lockbox-editor}

Роль `lockbox.editor` позволяет управлять секретами и их версиями, а также просматривать информацию о назначенных правах доступа к секретам.

Пользователи с этой ролью могут:
* просматривать информацию о [секретах](../concepts/secret.md#secret) и назначенных [правах доступа](../../iam/concepts/access-control/index.md) к ним, а также создавать, активировать, деактивировать и удалять секреты;
* изменять метаданные [версий](../concepts/secret.md#version) секретов, создавать и удалять версии секретов, а также изменять текущие версии секретов, планировать удаление и отменять запланированное удаление версий секретов;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex Lockbox.

Включает разрешения, предоставляемые ролью `lockbox.viewer`.

#### lockbox.admin {#lockbox-admin}

Роль `lockbox.admin` позволяет управлять секретами, их версиями и доступом к ним, а также просматривать содержимое секретов.

Пользователи с этой ролью могут:
* просматривать информацию о назначенных [правах доступа](../../iam/concepts/access-control/index.md) к секретам, а также изменять такие права доступа;
* просматривать информацию о [секретах](../concepts/secret.md#secret), в том числе содержимое секретов;
* создавать, активировать, деактивировать и удалять секреты;
* изменять метаданные [версий](../concepts/secret.md#version) секретов, создавать и удалять версии секретов, а также изменять текущие версии секретов, планировать удаление и отменять запланированное удаление версий секретов;
* просматривать информацию о [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder);
* просматривать информацию о [квотах](../concepts/limits.md#quotas) сервиса Yandex Lockbox.

Включает разрешения, предоставляемые ролями `lockbox.editor` и `lockbox.payloadViewer`.

#### lockbox.payloadViewer {#lockbox-payloadViewer}

Роль `lockbox.payloadViewer` позволяет просматривать содержимое [секретов](../concepts/secret.md#secret).

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

Подробнее о примитивных ролях в [справочнике ролей Yandex Cloud](../../iam/roles-reference.md#primitive-roles).

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | `lockbox.admin` | `lockbox.editor` | `lockbox.viewer` | `lockbox.payloadViewer` | `kms.keys.encrypterDecrypter`
----- | ----- | ----- | ----- | ----- | ----- 
Создание и удаление секретов                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Изменение метаданных секрета                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Чтение метаданных секрета                   | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | -
Изменение содержимого версии секрета        | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Чтение содержимого версии секрета           | ![image](../../_assets/common/yes.svg) | - |- | ![image](../../_assets/common/yes.svg) | -
Управление доступом к секрету               | ![image](../../_assets/common/yes.svg) | - | - | - | -
Операции шифрования и расшифровки секрета   | - | - | - | - | ![image](../../_assets/common/yes.svg)

#### Что дальше {#what-is-next}

* [Безопасное использование Yandex Cloud](../../iam/best-practices/using-iam-securely.md)
* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в Yandex Cloud](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
* [Управление доступом в Yandex Key Management Service](../../kms/security/index.md)