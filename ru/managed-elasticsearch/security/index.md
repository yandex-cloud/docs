# Управление доступом к {{ mes-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.


Для использования сервиса необходимо авторизоваться в консоли управления с [аккаунтом на Яндексе](../../iam/concepts/index.md#passport) или с [федеративным аккаунтом](../../iam/concepts/index.md#saml-federation).


{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mes-name }} (кластеры и хосты, резервные копии кластеров, учетные записи), назначьте пользователю нужные роли на каталог или облако, в котором содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

{% include [elasticsearch-viewer](../../_includes/iam/roles/elasticsearch-viewer.md) %}

{% include [elasticsearch-editor](../../_includes/iam/roles/elasticsearch-editor.md) %}

{% include [elasticsearch-admin](../../_includes/iam/roles/elasticsearch-admin.md) %}

{% include [elasticsearch-auditor](../../_includes/iam/roles/elasticsearch-auditor.md) %}

### {{ roles-cloud-member }} {#resmgr-clouds-member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#resmgr-clouds-owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`{{ roles-mdb-admin }}` | Позволяет создавать и изменять кластеры управляемых баз данных.
`{{ roles-mdb-viewer }}`| Позволяет просматривать информацию об управляемых базах данных кластера и логах их работы.
`{{ roles-mdb-auditor }}` | Позволяет просматривать информацию об управляемых базах данных кластера (кроме логов их работы).

## Какие роли необходимы {#required-roles}

В таблице ниже перечислены возможные действия с ресурсами кластера и роли, которые нужны для их выполнения.

Действие | Методы | Необходимые роли
----- | ----- | -----
**Просмотр информации** | |
Просмотр информации о кластере и связанных ресурсах | `get`, `list` | `viewer` на каталог с кластером
Просмотр информации об управляемых базах данных кластера и логах их работы | `get`, `list` | `{{ roles-mdb-viewer }}` на каталог с кластером
Просмотр информации об управляемых базах данных кластера (без доступа к данным и логам работы) | `get`, `list` | `{{ roles-mdb-auditor }}` на каталог с кластером
**Управление ресурсами** | |
Создание кластеров в каталоге | `create` | `mdb.admin` или `editor` на каталог
Создание кластеров с хостами, для которых включен публичный доступ | `create` | Либо `vpc.publicAdmin` вместе с `mdb.admin`, либо `editor` на каталог
Изменение, удаление кластеров и связанных ресурсов | `update`, `delete` | `mdb.admin` или `editor` на каталог с кластером
**Управление доступом к ресурсам** | |
[Создание](../operations/cluster-users.md#adduser), [изменение](../operations/cluster-users.md#updateuser), [удаление](../operations/cluster-users.md#removeuser) учетных записей в кластере | `create`, `update`, `delete` | `editor` или `admin` на каталог с кластером
[Назначение роли](../../iam/operations/roles/grant.md), [отзыв роли](../../iam/operations/roles/revoke.md) и просмотр назначенных ролей на каталог или облако | `setAccessBindings`, `updateAccessBindings`, `listAccessBindings` | `admin` на каталог с кластером или облако

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

