---
title: "Управление доступом в {{ dataproc-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению кластерами Apache Hadoop® и Apache Spark™. Чтобы разрешить доступ к ресурсам сервиса {{ dataproc-name }} (кластерам или подкластерам), назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ dataproc-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ dataproc-name }} (кластерам или подкластерам), назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `mdb.admin`, `dataproc.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-role}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ dataproc-name }}.

### Сервисные роли {#service-roles}

#### dataproc.agent {#dataproc-agent}

{% include [dataproc.agent](../../_roles/dataproc/agent.md) %}

#### dataproc.auditor {#dataproc-auditor}

{% include [dataproc.auditor](../../_roles/dataproc/auditor.md) %}

#### dataproc.viewer {#dataproc-viewer}

{% include [dataproc.viewer](../../_roles/dataproc/viewer.md) %}

#### dataproc.user {#dataproc-user}

{% include [dataproc.user](../../_roles/dataproc/user.md) %}

#### dataproc.provisioner {#dataproc-provisioner}

{% include [dataproc.provisioner](../../_roles/dataproc/provisioner.md) %}

#### dataproc.editor {#dataproc-editor}

{% include [dataproc.editor](../../_roles/dataproc/editor.md) %}

#### dataproc.admin {#dataproc-admin}

{% include [dataproc.admin](../../_roles/dataproc/admin.md) %}

#### managed-metastore.auditor {#managed-metastore-auditor}

{% include [managed-metastore.auditor](../../_roles/managed-metastore/auditor.md) %}

#### managed-metastore.viewer {#managed-metastore-viewer}

{% include [managed-metastore.viewer](../../_roles/managed-metastore/viewer.md) %}

#### managed-metastore.editor {#managed-metastore-editor}

{% include [managed-metastore.editor](../../_roles/managed-metastore/editor.md) %}

#### managed-metastore.admin {#managed-metastore-admin}

{% include [managed-metastore.admin](../../_roles/managed-metastore/admin.md) %}

#### managed-metastore.integrationProvider {#managed-metastore-integrationProvider}

{% include [managed-metastore.integrationProvider](../../_roles/managed-metastore/integrationProvider.md) %}

#### mdb.auditor {#mdb-auditor}

{% include [mdb-auditor](../../_roles/mdb/auditor.md) %}

#### mdb.viewer {#mdb-viewer}

{% include [mdb-viewer](../../_roles/mdb/viewer.md) %}

#### mdb.admin {#mdb-admin}

{% include [mdb-admin](../../_roles/mdb/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}