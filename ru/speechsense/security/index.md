---
title: "Управление доступом в {{ speechsense-full-name }}"
description: "Управление доступом в сервисе речевой аналитики — {{ speechsense-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ speechsense-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ speechsense-name }}

Доступ к сервису {{ speechsense-full-name }} регулируется путем назначения прав в организации. Управление организациями осуществляется с помощью сервиса [{{ org-full-name }}](../../organization/).

Список операций, доступных пользователю {{ speechsense-name }}, определяется его ролью. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее об управлении доступом в {{ yandex-cloud }} см. раздел [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут те, у кого есть роль `admin`, `resource-manager.clouds.owner` или `organization-manager.organizations.owner` на этот ресурс.

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на пространство или проект. Роли, назначенные на пространство, действуют и на вложенные проекты и ресурсы.

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

#### speech-sense.auditor {#speechsense-auditor}

{% include [speechsense-auditor](../../_roles/speech-sense/auditor.md) %}

#### speech-sense.viewer {#speechsense-viewer}

{% include [speechsense-viewer](../../_roles/speech-sense/viewer.md) %}

#### speech-sense.editor {#speechsense-editor}

{% include [speechsense-editor](../../_roles/speech-sense/editor.md) %}

#### speech-sense.admin {#speechsense-admin}

{% include [speechsense-admin](../../_roles/speech-sense/admin.md) %}

#### speech-sense.spaces.creator {#speechsense-spaces-creator}

{% include [speechsense-spaces-creator](../../_roles/speech-sense/spaces/creator.md) %}

#### speech-sense.data.viewer {#speechsense-data-viewer}

{% include [speechsense-data-viewer](../../_roles/speech-sense/data/viewer.md) %}

#### speech-sense.data.editor {#speechsense-data-editor}

{% include [speechsense-data-editor](../../_roles/speech-sense/data/editor.md) %}

Пользователи с ролями вида `speech-sense.data.*` могут просматривать и оценивать содержимое документов, но не имеют доступа к агрегированной информации.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить на пространство роль `speech-sense.editor` вместо `speech-sense.viewer`.

#|
|| **Действие** | **Необходимые роли** ||
|| **Просмотр информации** ||
|| Просмотр пространства и всех его проектов | `speech-sense.auditor` ||
|| Просмотр характеристик пространства и проекта | `speech-sense.viewer` ||
|| Просмотр проекта, его каналов и диалогов | `speech-sense.data.viewer` ||
|| **Управление проектом** ||
|| Создание проекта | `speech-sense.editor` ||
|| Изменение настроек проекта | `speech-sense.editor` ||
|| Загрузка и оценка диалогов | `speech-sense.data.editor` ||
|| Написание комментариев | `speech-sense.data.editor` ||
|| Создание подключений | `speech-sense.editor` ||
|| Создание классификаторов | `speech-sense.editor` ||
|| Запуск анализа | `speech-sense.editor` ||
|| Удаление проекта | `speech-sense.admin` ||
|| Выдача роли в проекте | `speech-sense.admin` ||
|| **Управление пространством** ||
|| Изменение настроек пространства | `speech-sense.editor` ||
|| Удаление пространства | `speech-sense.admin` ||
|| Выдача роли в пространстве | `speech-sense.admin` ||
|#
