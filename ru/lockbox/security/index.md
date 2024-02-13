---
title: "Управление доступом в {{ lockbox-full-name }}"
description: "Управление доступом в сервисе для хранения секретов {{ lockbox-full-name }}. В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе, какие роли необходимы для того или иного действия."
---

# Управление доступом в {{ lockbox-name }}

В этом разделе вы узнаете:
* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list);
* [какие роли необходимы](#choosing-roles) для того или иного действия.

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Роль можно назначить на [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud), [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder) или секрет. Эти роли будут действовать и на вложенные ресурсы.

{% include [roles-intro](../../_includes/roles-intro.md) %}

![image](../../_assets/lockbox/service-roles-hierarchy.svg)
 
## Какие роли действуют в сервисе {#roles-list}

Управлять доступом к секретам можно как с помощью сервисных, так и с помощью примитивных ролей. 

### Сервисные роли {#service-roles}

#### lockbox.auditor {#lockbox-auditor}

{% include [lockbox.auditor](../../_roles/lockbox/auditor.md) %}

#### lockbox.viewer {#lockbox-viewer}

{% include [lockbox.viewer](../../_roles/lockbox/viewer.md) %}

#### lockbox.editor {#lockbox-editor}

{% include [lockbox.editor](../../_roles/lockbox/editor.md) %}

#### lockbox.admin {#lockbox-admin}

{% include [lockbox.admin](../../_roles/lockbox/admin.md) %}

#### lockbox.payloadViewer {#lockbox-payloadViewer}

{% include [lockbox.payloadViewer](../../_roles/lockbox/payloadViewer.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице ниже перечислено, какие роли нужны для выполнения указанного действия. Вы всегда можете назначить роль, которая дает более широкие разрешения, нежели указанная. Например, назначить `editor` вместо `viewer`.

Действие | `{{ roles-lockbox-admin }}` | `{{ roles-lockbox-editor }}` | `{{ roles-lockbox-viewer }}` | `{{ roles-lockbox-payloadviewer }}` | `kms.keys.encrypterDecrypter`
----- | ----- | ----- | ----- | ----- | ----- 
Создание и удаление секретов                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Изменение метаданных секрета                | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Чтение метаданных секрета                   | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | -
Изменение содержимого версии секрета        | ![image](../../_assets/common/yes.svg) | ![image](../../_assets/common/yes.svg) | - | - | -
Чтение содержимого версии секрета           | ![image](../../_assets/common/yes.svg) | - |- | ![image](../../_assets/common/yes.svg) | -
Управление доступом к секрету               | ![image](../../_assets/common/yes.svg) | - | - | - | -
Операции шифрования и расшифровки секрета   | - | - | - | - | ![image](../../_assets/common/yes.svg)

#### Что дальше {#what-is-next}

* [Безопасное использование {{ yandex-cloud }}](../../iam/best-practices/using-iam-securely.md)
* [Как назначить роль](../../iam/operations/roles/grant.md).
* [Как отозвать роль](../../iam/operations/roles/revoke.md).
* [Подробнее об управлении доступом в {{ yandex-cloud }}](../../iam/concepts/access-control/index.md).
* [Подробнее о наследовании ролей](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance).
* [Управление доступом в {{ kms-full-name }}](../../kms/security/index.md)
