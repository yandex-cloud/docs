---
title: "Управление доступом в {{ maf-full-name }}"
description: "Управление доступом в сервисе создания и управления кластерами {{ AF }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ maf-name }}


В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

{% include [basic-resources](../../_includes/iam/basic-resources-for-access-control.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ maf-name }}, назначьте пользователю нужные роли на каталог или облако, в котором содержатся эти ресурсы.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе.

{% include [maf-viewer](../../_includes/iam/roles/maf-viewer.md) %}

{% include [maf-editor](../../_includes/iam/roles/maf-editor.md) %}

{% include [maf-admin](../../_includes/iam/roles/maf-admin.md) %}

### {{ roles-viewer }} {#viewer}

Роль `{{ roles-viewer }}` позволяет просматривать информацию о кластерах {{ maf-name }} и логах их работы.

### {{ roles-editor }} {#editor}

Пользователь с ролью `{{ roles-editor }}` может управлять любыми ресурсами, например создать кластер, создать или удалить подкластер в кластере.

Включает в себя роль `{{ roles-viewer }}`.

### {{ roles-admin }} {#admin}

Пользователь с ролью `{{ roles-admin }}` может управлять правами доступа к ресурсам, например разрешить другим пользователям создавать кластеры {{ maf-name }} или просматривать информацию о правах пользователей.

Включает в себя роль `{{ roles-editor }}`.

## Что дальше {#whats-next}

* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).

