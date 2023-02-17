---
title: "Управление доступом в {{ mpg-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению базами данных PostgreSQL. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ mpg-name }}

{% if audience != "internal"%}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#required-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ mpg-name }} (кластеры и хосты БД, резервные копии кластеров, базы данных и их пользователи), назначьте пользователю нужные роли на каталог или облако, в котором эти ресурсы лежат.

## Какие роли действуют в сервисе {#roles-list}

На диаграмме показано, какие роли есть в сервисе и как они наследуют разрешения друг друга. Например, в `{{ roles-editor }}` входят все разрешения `{{ roles-viewer }}`. После диаграммы дано описание каждой роли.

![image](../../_assets/mdb/roles-managed-postgresql.svg)

### {{ roles-mdb-admin }} {#mdb-admin}

{% include [roles-mdb-admin](../../_includes/roles-mdb-admin.md) %}

### {{ roles-mdb-viewer }} {#mdb-viewer}

{% include [roles-mdb-viewer](../../_includes/roles-mdb-viewer.md) %}

### {{ roles-mdb-auditor }} {#mdb-auditor}

{% include [roles-mdb-auditor](../../_includes/roles-mdb-auditor.md) %}

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

### {{ roles.mpg.admin }} {#mpg-admin}

{% include [roles-mpg-admin](../../_includes/roles-mpg-admin.md) %}

### {{ roles.mpg.auditor }} {#mpg-auditor}

{% include [roles-mpg-auditor](../../_includes/roles-mpg-auditor.md) %}

### {{ roles.mpg.editor }} {#mpg-editor}

{% include [roles-mpg-editor](../../_includes/roles-mpg-editor.md) %}

### {{ roles.mpg.viewer }} {#mpg-viewer}

{% include [roles-mpg-viewer](../../_includes/roles-mpg-viewer.md) %}

## Какие роли необходимы {#required-roles}

Чтобы пользоваться сервисом, необходима [роль](../../iam/concepts/access-control/roles.md) `{{ roles.mpg.editor }}` или выше на каталог, в котором создается кластер. Роль `{{ roles.mpg.viewer }}` позволит только просматривать список кластеров.

Вы всегда можете назначить роль, которая дает более широкие разрешения. Например, назначить `{{ roles.mpg.admin }}` вместо `{{ roles.mpg.editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

{% else %}

{% include [abc-roles](../../_includes/mdb/internal/abc-roles.md) %}

## Identity Management (IDM) {#idm}

**IDM** это опция, которая включается при создании кластера, чтобы задействовать [механизм доступа к данным SOX](https://ru.wikipedia.org/wiki/Закон_Сарбейнза_—_Оксли). Она необходима для назначения _Ответственных за кластер_ и предоставления доступа к нему в сервисе [Identity Management](https://idm.yandex-team.ru/) (IDM). Опция обязательна для кластеров, создаваемых в окружении `PRODUCTION`. Выключить опцию нельзя.

_Ответственных за кластер_ утверждают _Ответственные из MDB_, после чего _Ответственный за кластер_ может вместе с MDB утверждать запросы ролей к кластеру.

С помощью опции **IDM** выдаются роли:

* Чтение.
* Запись.
* Ответственный.

{% note warning %}

Роли в ABC (_Администратор MDB_ и _Пользователь MDB_) и роли, которые назначаются с помощью опции **IDM** (_Ответственный за кластер_), это разные роли. При назначении ролей в ABC права выдаются через {% if lang == "ru" and audience != "internal" %}[API](../../glossary/rest-api.md){% else %}API{% endif %} на действия _над кластером_, а с включенной опцией **IDM** — _внутри самой базы_.

{% endnote %}

{% endif %}
