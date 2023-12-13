---
title: "Управление доступом в {{ monitoring-full-name }}"
description: "Управление доступом в сервисе мониторинга, который позволяет собирать и хранить метрики, а также отображать их в виде графиков на дашбордах — {{ monitoring-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ monitoring-full-name }}, назначьте пользователю нужные роли из приведенного списка."
---

# Управление доступом в {{ monitoring-name }}


Пользователь {{ yandex-cloud }} может выполнять только те операции над ресурсами, которые разрешены назначенными ему ролями. Пока у пользователя нет никаких ролей, почти все операции ему запрещены.

Чтобы разрешить доступ к ресурсам сервиса {{ monitoring-full-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным пользователям](../../iam/concepts/federations.md), [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. 

На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

Назначать роли на ресурс могут те, у кого есть роль `admin`, `resource-manager.clouds.owner` или `organization-manager.organizations.owner` на этот ресурс.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [{#T}](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-full-name }}.

{% endnote %}

## Назначение ролей {#grant-roles}

Чтобы назначить пользователю роль:

{% include [grant-role-console](../../_includes/grant-role-console.md) %}

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ monitoring-full-name }}.

### Сервисные роли {#service-roles}

#### {{ roles-monitoring-viewer }} {#monitoring-viewer}

Пользователь с ролью `{{ roles-monitoring-viewer }}` может просматривать созданные дашборды и виджеты, а также загруженные метрики.

#### {{ roles-monitoring-editor }} {#monitoring-editor}

Пользователь с ролью `{{ roles-monitoring-editor }}` может создавать дашборды и виджеты, загружать метрики и управлять алертами.

Помимо этого роль `{{ roles-monitoring-editor }}` включает в себя все разрешения роли `{{ roles-monitoring-viewer }}`.

#### {{ roles-monitoring-admin }} {#monitoring-admin}

Пользователь с ролью `{{ roles-monitoring-admin }}` может создавать дашборды и виджеты, загружать метрики и управлять алертами.

Помимо этого роль `{{ roles-monitoring-admin }}` включает в себя все разрешения роли `{{ roles-monitoring-editor }}`.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}


