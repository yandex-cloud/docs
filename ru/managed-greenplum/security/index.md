---
title: "Доступ к {{ mgp-name }}"
description: "Чтобы разрешить доступ к ресурсам сервиса {{ mgp-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог, облако или организацию, в которых содержатся эти ресурсы."
keywords:
  - доступ
  - access
  - настройка доступа
  - доступ {{ GP }}
  - green plum
  - {{ GP }}
---

# Управление доступом в {{ mgp-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `managed-greenplum.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

{% include [assign-roles-mdb](../../_includes/iam/assign-roles-mdb.md) %}

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../../_assets/mdb/roles-managed-greenplum.svg)

### Сервисные роли {#service-roles}

#### managed-greenplum.auditor {#managed-greenplum-auditor}

{% include [managed-greenplum.auditor](../../_roles/managed-greenplum/auditor.md) %}

#### managed-greenplum.viewer {#managed-greenplum-viewer}

{% include [managed-greenplum.viewer](../../_roles/managed-greenplum/viewer.md) %}

#### managed-greenplum.editor {#managed-greenplum-editor}

{% include [managed-greenplum.editor](../../_roles/managed-greenplum/editor.md) %}

#### managed-greenplum.admin {#managed-greenplum-admin}

{% include [managed-greenplum.admin](../../_roles/managed-greenplum/admin.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

При создании кластера {{ mgp-name }} вместе с ним автоматически создается пользователь-администратор с ролью `mdb_admin`. Эта роль заменяет суперпользователя при работе с БД и не является аналогом роли `{{ roles-mdb-admin }}` в {{ yandex-cloud }}. Подробнее читайте в разделе [{#T}](../concepts/cluster-users.md).

#### vpc.publicAdmin {#vpc-public-admin}

{% include [vpc-publicadmin](../../_roles/vpc/publicAdmin.md) %}


### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима роль [{{ roles.mgp.editor }} или выше](../../iam/concepts/access-control/roles.md) на каталог, в котором создается кластер. Роль `{{ roles.mgp.viewer }}` позволит только просматривать список кластеров.

Чтобы создать кластер {{ mgp-name }}, нужна роль [{{ roles-vpc-user }}](../../vpc/security/index.md#vpc-user) и роль `{{ roles.mgp.editor }}` или выше.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.mgp.admin }}` вместо `{{ roles.mgp.editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
