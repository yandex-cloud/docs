---
title: "Доступ к {{ mgp-name }}"
description: "Чтобы разрешить доступ к ресурсам сервиса {{ mgp-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат."
keywords:
  - доступ
  - access
  - настройка доступа
  - доступ {{ GP }}
  - green plum
  - {{ GP }}
---

# Управление доступом в {{ mgp-name }}

{% if audience != "internal"%}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}


## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mgp-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../../_assets/mdb/roles-managed-greenplum.svg)

{% include [mgp-auditor](../../_includes/iam/roles/mgp-auditor.md) %}

{% include [mgp-viewer](../../_includes/iam/roles/mgp-viewer.md) %}

{% include [mgp-editor](../../_includes/iam/roles/mgp-editor.md) %}

{% include [mgp-admin](../../_includes/iam/roles/mgp-admin.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

{% include [roles-vpc-public-admin](../../_includes/roles-vpc-public-admin.md) %}

### {{ roles-viewer }} {#viewer}

{% include [roles-viewer](../../_includes/roles-viewer.md) %}

### {{ roles-editor }} {#editor}

{% include [roles-editor](../../_includes/roles-editor.md) %}

### {{ roles-admin }} {#admin}

{% include [roles-admin](../../_includes/roles-admin.md) %}

### {{ roles-cloud-member }} {#member}

{% include [roles-cloud-member](../../_includes/roles-cloud-member.md) %}

### {{ roles-cloud-owner }} {#owner}

{% include [roles-cloud-owner](../../_includes/roles-cloud-owner.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `{{ roles.mgp.editor }}` или выше на каталог, в котором создается кластер. Роль `{{ roles.mgp.viewer }}` позволит только просматривать список кластеров.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.mgp.admin }}` вместо `{{ roles.mgp.editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

{% endif %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
