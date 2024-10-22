---
title: Управление доступом в сервисе по визуализации и анализу данных — {{ datalens-full-name }}
description: В разделе описано, какие роли необходимы для того или иного действия, на какие ресурсы можно назначить роль, какие роли действуют в сервисе.
---

# Роли в {{ datalens-short-name }}

Роли в {{ datalens-short-name }} бывают двух типов:

* Для доступа к сервису — назначаются на [организацию](../concepts/organizations.md) и предоставляют доступ к сервису {{ datalens-short-name }}.
* На [воркбуки и коллекции](../workbooks-collections/index.md) — определяют уровень доступа непосредственно к каждому воркбуку или коллекции. Эти роли действуют для пользователей, которые [перешли на воркбуки и коллекции](../workbooks-collections/index.md#enable-workbooks) для хранения своих объектов в {{ datalens-short-name }}.

## Роли для доступа к сервису {#service-roles}

Чтобы предоставить пользователю доступ к {{ datalens-short-name }}, [назначьте](../../organization/security/index.md#add-role) ему одну из ролей. Роли можно назначить аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md), [системной группе](../../iam/concepts/access-control/system-group.md) или [публичной группе](../../iam/concepts/access-control/public-group.md).

{% list tabs %}

- До перехода на воркбуки и коллекции

  {% include [datalens-instances-user](../../_includes/roles-datalens-user.md) %}

  {% include [datalens-instances-admin](../../_includes/roles-datalens-admin.md) %}

- После перехода на воркбуки и коллекции

  {% include [roles-datalens-visitor](../../_includes/roles-datalens-visitor.md) %}

  {% include [roles-datalens-creator](../../_includes/roles-datalens-creator.md) %}

  {% include [roles-datalens-admin-org](../../_includes/roles-datalens-admin-org.md) %}

{% endlist %}

## Роли на воркбуки и коллекции {#workbooks-collections-roles}

Эти роли действуют для пользователей, которые перешли на новый подход к организации объектов {{ datalens-short-name }} — в [воркбуках и коллекциях](../workbooks-collections/index.md). Роли позволяют определить уровень доступа для пользователя или группы пользователей к каждому воркбуку или коллекции.

### Роли на воркбуки {#workbook-roles}

Вы можете [назначить](../workbooks-collections/security.md#wb-coll-grant) пользователю роли на воркбуки.

#### datalens.workbooks.limitedViewer {#datalens-workbooks-limitedViewer}

{% include [datalens.workbooks.limitedViewer](../../_roles/datalens/workbooks/limitedViewer.md) %}

#### datalens.workbooks.viewer {#datalens-workbooks-viewer}

{% include [datalens.workbooks.viewer](../../_roles/datalens/workbooks/viewer.md) %}

#### datalens.workbooks.editor {#datalens-workbooks-editor}

{% include [datalens.workbooks.editor](../../_roles/datalens/workbooks/editor.md) %}

#### datalens.workbooks.admin {#datalens-workbooks-admin}

{% include [datalens.workbooks.admin](../../_roles/datalens/workbooks/admin.md) %}

{% note info %}

При создании воркбука автору автоматически назначается роль `datalens.workbooks.admin` (`Администрирование`) на этот воркбук.

{% endnote %}

### Роли на коллекции {#collection-roles}

Вы можете [назначить](../workbooks-collections/security.md#wb-coll-grant) пользователю роли на коллекцию.

#### datalens.collections.limitedViewer {#datalens-collections-limitedViewer}

{% include [datalens.collections.limitedViewer](../../_roles/datalens/collections/limitedViewer.md) %}

#### datalens.collections.viewer {#datalens-collections-viewer}

{% include [datalens.collections.viewer](../../_roles/datalens/collections/viewer.md) %}

#### datalens.collections.editor {#datalens-collections-editor}

{% include [datalens.collections.editor](../../_roles/datalens/collections/editor.md) %}

#### datalens.collections.admin {#datalens-collections-admin}

{% include [datalens.collections.admin](../../_roles/datalens/collections/admin.md) %}

{% note info %}

Роль, выданная на коллекцию, распространяется на все коллекции и воркбуки внутри нее. При создании коллекции автору автоматически назначается роль `datalens.collections.admin` (`Администрирование`) на эту коллекцию.

{% endnote %}
