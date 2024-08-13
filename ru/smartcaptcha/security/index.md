---
title: "Управление доступом в {{ captcha-name }}"
description: "В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ captcha-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

Назначать роли на ресурс могут пользователи, у которых на этот ресурс есть роль `smart-captcha.admin` или одна из следующих ролей:

{% include [roles-list](../../_includes/iam/roles-list.md) %}

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на капчи, которые находятся в них.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ captcha-name }}.

### Сервисные роли {#service-roles}

#### smart-captcha.auditor {#smart-captcha-auditor}

{% include [smart-captcha.auditor](../../_roles/smart-captcha/auditor.md) %}

#### smart-captcha.viewer {#smart-captcha-viewer}

{% include [smartcaptcha-viewer](../../_roles/smart-captcha/viewer.md) %}

#### smart-captcha.editor {#smart-captcha-editor}

{% include [smartcaptcha-editor](../../_roles/smart-captcha/editor.md) %}

#### smart-captcha.admin {#smart-captcha-admin}

{% include [smartcaptcha-admin](../../_roles/smart-captcha/admin.md) %}

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице сопоставлены действия и минимальные роли, необходимые для их выполнения. Вы всегда можете назначить роль, которая дает более широкие права, чем указанная в таблице. Например, вместо `smart-captcha.viewer` можно выдать роль `smart-captcha.editor`.

Действие | Роль
----- | -----
Просмотр информации о капче | `smart-captcha.viewer`
Создание капчи | `smart-captcha.editor`
Редактирование капчи | `smart-captcha.editor`
Удаление капчи | `smart-captcha.editor`
Управление ролями пользователей на капче | `smart-captcha.admin`
