---
title: "Управление доступом в {{ translate-full-name }}"
description: "Управление доступом в сервисе для интеграции алгоритмов {{ translate-full-name }} в приложения или веб-проекты. Разрешения выдаются при назначении роли. Роль можно назначить на каталог или облако — все разрешения от облака наследуются. Чтобы пользоваться сервисом, необходима одна из ролей — editor, admin, resource-manager.clouds.owner."
---

# Управление доступом в {{ translate-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### ai.translate.user {#translate-user}

{% include [translate-user](../../_roles/ai/translate/user.md) %}

#### ai.auditor {#ai-auditor}

{% include [ai-auditor](../../_roles/ai/auditor.md) %}

#### ai.viewer {#ai-viewer}

{% include [ai-viewer](../../_roles/ai/viewer.md) %}

#### ai.editor {#ai-editor}

{% include [ai-editor](../../_roles/ai/editor.md) %}

#### ai.admin {#ai-admin}

{% include [ai-admin](../../_roles/ai/admin.md) %}

Более подробную информацию о сервисных ролях читайте на странице [{#T}](../../iam/concepts/access-control/roles.md) в документации сервиса {{ iam-full-name }}.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

#### Что дальше {#what-is-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
