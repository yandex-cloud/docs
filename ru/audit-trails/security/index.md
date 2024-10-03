---
title: Управление доступом в {{ at-full-name }}
description: Управление доступом в сервисе для управления трейлами — {{ at-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия.
---

# Управление доступом {{ at-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include notitle [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `audit-trails.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

На [трейл](../concepts/trail.md) роль можно назначить через YC CLI или API {{ yandex-cloud }}.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/audit-trails/at-role-diagram.svg)
<small>\* deprecated</small>

### Сервисные роли {#service-roles}

#### audit-trails.auditor {#at-auditor}

{% include [audit-trails.auditor](../../_roles/audit-trails/auditor.md) %}

#### audit-trails.viewer {#at-viewer}

{% include [audit-trails.viewer](../../_roles/audit-trails/viewer.md) %}

#### audit-trails.editor {#at-editor}

{% include [audit-trails.editor](../../_roles/audit-trails/editor.md) %}

#### audit-trails.admin {#at-admin}

{% include [audit-trails.admin](../../_roles/audit-trails/admin.md) %}

#### audit-trails.configViewer {#at-configviewer}

{% include [audit-trails.configviewer](../../_roles/audit-trails/configViewer.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

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
