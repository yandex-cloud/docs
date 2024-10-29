# Управление доступом в {{ video-full-name }}

Доступ к сервису {{ video-name }} регулируется путем назначения прав в организации. Управление организациями осуществляется с помощью сервиса [{{ org-full-name }}](../../organization/).

Список операций, доступных пользователю {{ video-name }}, определяется его ролью. Роли можно назначить аккаунту на Яндексе, [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md). Подробнее об управлении доступом в {{ yandex-cloud }} см. раздел [{#T}](../../iam/concepts/access-control/index.md).

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `video.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## Добавление пользователя в {{ video-name }} {#add-user}

Добавить пользователя в {{ video-name }} можно следующими способами:
* Отправить приглашение из [интерфейса]({{ link-video-main }}) {{ video-name }}, указав электронную почту, с которой пользователь зарегистрирован в организации.
* [Назначить](../../organization/security/index.md) пользователю права доступа через интерфейс {{ org-name }}.

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-intro](../../_includes/roles-intro.md) %}

![service-roles-hierarchy](../../_assets/video/service-roles-hierarchy.svg)

### Сервисные роли {#service-roles}

#### video.auditor {#video-auditor}

{% include [video.auditor](../../_roles/video/auditor.md) %}

#### video.viewer {#video-viewer}

{% include [video.viewer](../../_roles/video/viewer.md) %}

#### video.editor {#video-editor}

{% include [video.editor](../../_roles/video/editor.md) %}

#### video.admin {#video-admin}

{% include [video.admin](../../_roles/video/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}