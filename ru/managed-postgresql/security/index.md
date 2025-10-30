---
title: Управление доступом в {{ mpg-full-name }}
description: Управление доступом в сервисе по созданию и управлению базами данных {{ PG }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом в {{ mpg-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `managed-postgresql.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../../_includes/iam/assign-roles-mdb.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../../_assets/mdb/roles-managed-postgresql.svg)

### Сервисные роли {#service-roles}

#### managed-postgresql.auditor {#managed-postgresql-auditor}

{% include [managed-postgresql.auditor](../../_roles/managed-postgresql/auditor.md) %}

#### managed-postgresql.viewer {#managed-postgresql-viewer}

{% include [managed-postgresql.viewer](../../_roles/managed-postgresql/viewer.md) %}

#### managed-postgresql.restorer {#managed-postgresql-restorer}

{% include [managed-postgresql.restorer](../../_roles/managed-postgresql/restorer.md) %}

#### managed-postgresql.editor {#managed-postgresql-editor}

{% include [managed-postgresql.editor](../../_roles/managed-postgresql/editor.md) %}

#### managed-postgresql.admin {#managed-postgresql-admin}

{% include [managed-postgresql.admin](../../_roles/managed-postgresql/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

#### mdb.restorer {#mdb-restorer}

{% include [mdb-restorer](../../_roles/mdb/restorer.md) %}

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль [{{ roles.mpg.editor }} или выше](../../iam/concepts/access-control/roles.md) на каталог, в котором создается кластер. Роль `{{ roles.mpg.viewer }}` позволит только просматривать список кластеров.

Чтобы создать кластер {{ mpg-name }}, нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль `{{ roles.mpg.editor }}` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.mpg.admin }}` вместо `{{ roles.mpg.editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

