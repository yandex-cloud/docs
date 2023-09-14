---
title: "Управление доступом в {{ dataproc-full-name }}"
description: "Управление доступом в сервисе по созданию и управлению кластерами Apache Hadoop® и Apache Spark™. Чтобы разрешить доступ к ресурсам сервиса {{ dataproc-name }} (кластерам или подкластерам), назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ dataproc-name }}

Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ dataproc-name }} (кластерам или подкластерам), назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-role}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ dataproc-name }}.

### Сервисные роли {#service-roles}

{% include [mdb.dataproc.agent](../../_includes/iam/roles/dataproc-agent.md) %}

{% include [data-proc-roles](../../_includes/iam/roles/data-proc-roles.md) %}

{% include [managed-metastore-roles](../../_includes/iam/roles/managed-metastore-roles.md) %}

{% include [mdb.auditor](../../_includes/iam/roles/mdb.auditor.md) %}

{% include [mdb.viewer](../../_includes/iam/roles/mdb.viewer.md) %}

{% include [mdb.admin](../../_includes/iam/roles/mdb.admin.md) %}

{% include [cloud-roles](../../_includes/cloud-roles.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}
