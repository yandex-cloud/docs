---
title: "Управление доступом в {{ captcha-name }}"
description: "В разделе описано, на какие ресурсы можно назначить роль, какие роли действуют в сервисе."
---

# Управление доступом в {{ captcha-name }}

В этом разделе вы узнаете:

* [на какие ресурсы можно назначить роль](#resources);
* [какие роли действуют в сервисе](#roles-list).

{% include [about-access-management](../../_includes/iam/about-access-management.md) %}

## На какие ресурсы можно назначить роль {#resources}

Вы можете назначить роль на [организацию](../../organization/), [облако](../../resource-manager/concepts/resources-hierarchy.md#cloud) и [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder). Роли, назначенные на организацию, облако или каталог, действуют и на капчи, которые находятся в них.

## Какие роли действуют в сервисе {#roles-list}

Ниже перечислены все роли, которые учитываются при проверке прав доступа в сервисе {{ captcha-name }}.

### Сервисные роли {#service-roles}

Роль | Разрешения
----- | -----
`smart-captcha.auditor` | Позволяет просматривать информацию о капче и правах доступа к ней.
`smart-captcha.viewer` | Позволяет просматривать информацию о капче и правах доступа к ней. Включает все права роли `smart-captcha.auditor`.
`smart-captcha.editor` | Позволяет управлять капчами (создавать, изменять и удалять). Включает все права роли `smart-captcha.viewer`.
`smart-captcha.admin` | Позволяет управлять капчами и доступом к ним. Включает все права роли `smart-captcha.editor`.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

## Какие роли мне необходимы {#choosing-roles}

В таблице сопоставлены действия и минимальные роли, необходимые для их выполнения. Вы всегда можете назначить роль, которая дает более широкие права, чем указанная в таблице. Например, вместо `smart-captcha.viewer` можно выдать роль `smart-captcha.editor`.

Действие | Роль
----- | -----
Просмотр информации о капче | `smart-captcha.viewer`
Создание капчи | `smart-captcha.editor`
Редактирование капчи | `smart-captcha.editor`
Удаление капчи | `smart-captcha.editor`
Управление ролями пользователей на капче | `smart-captcha.admin`
