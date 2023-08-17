# Управление доступом {{ at-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles).

{% include notitle [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

В консоли {{ yandex-cloud }} вы можете назначить роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на облако или каталог, действуют и на трейлы, которые находятся в них.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/audit-trails/at-role-diagram.svg)
<small>\* deprecated</small>

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`resource-manager.clouds.member` | Роль, необходимая для доступа к ресурсам в облаке всем, кроме [владельцев облака](../../resource-manager/concepts/resources-hierarchy.md#owner) и [сервисных аккаунтов](../../iam/concepts/users/service-accounts.md)
`resource-manager.clouds.owner` | Дает полный доступ к облаку и ресурсам в нем. Можно назначить только на облако
`audit-trails.auditor` | Позволяет просматривать информацию о трейлах
`audit-trails.viewer` | Дает доступ к аудитным логам трейлов. Включает все права роли `audit-trails.auditor`
`audit-trails.editor` | Позволяет управлять трейлами (создавать, изменять и удалять). Включает все права роли `audit-trails.viewer`
`audit-trails.admin` | Позволяет управлять трейлами и доступом к ним. Включает все права роли `audit-trails.editor`
`audit-trails.configViewer` (deprecated) | Позволяет просматривать информацию о трейлах. Используйте роль `audit-trails.auditor` вместо этой роли.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

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
* Ознакомьтесь с примером [загрузки аудитных логов в {{ cloud-logging-name }}](../operations/export-cloud-logging.md).
