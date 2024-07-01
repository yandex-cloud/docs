---
title: "Управление доступом в {{ websql-name }}"
description: "Управление доступом в сервисе для работы с запросами к кластерам управляемых баз данных {{ websql-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ websql-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `websql.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Кроме того, роли можно назначать на опубликованные сохраненные запросы и запросы из истории.

## Какие роли действуют в сервисе {#roles-list}

Для управления правами доступа к запросам вы можете использовать роли сервиса {{ websql-full-name }} (_сервисные роли_) и роли {{ yandex-cloud }} (_примитивные роли_).

### Сервисные роли {#service-roles}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ websql-name }}.

#### websql.executedQueries.viewer {#websql-executedQueries-viewer}

{% include [websql.executedQueries.viewer](../../_roles/websql/executedQueries/viewer.md) %}

Роль назначается на опубликованный запрос из истории.

#### websql.savedQueries.viewer {#websql-savedQueries-viewer}

{% include [websql.savedQueries.viewer](../../_roles/websql/savedQueries/viewer.md) %}

Роль назначается на опубликованный сохраненный запрос.

#### websql.executedQueries.editor {#websql-executedQueries-editor}

{% include [websql.executedQueries.editor](../../_roles/websql/executedQueries/editor.md) %}

Роль назначается на опубликованный запрос из истории.

#### websql.savedQueries.editor {#websql-savedQueries-editor}

{% include [websql.savedQueries.editor](../../_roles/websql/savedQueries/editor.md) %}

Роль назначается на опубликованный сохраненный запрос.

#### websql.executedQueries.admin {#websql-executedQueries-admin}

{% include [websql.executedQueries.admin](../../_roles/websql/executedQueries/admin.md) %}

Роль назначается на опубликованный запрос из истории.

#### websql.savedQueries.admin {#websql-savedQueries-admin}

{% include [websql.savedQueries.admin](../../_roles/websql/savedQueries/admin.md) %}

Роль назначается на опубликованный сохраненный запрос.

#### websql.viewer {#websql-viewer}

{% include [websql.viewer](../../_roles/websql/viewer.md) %}

#### websql.user {#websql-user}

{% include [websql.user](../../_roles/websql/user.md) %}

#### websql.editor {#websql-editor}

{% include [websql.editor](../../_roles/websql/editor.md) %}

#### websql.admin {#websql-admin}

{% include [websql.admin](../../_roles/websql/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
