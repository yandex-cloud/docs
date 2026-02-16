---
title: Общие роли {{ sd-full-name }}
description: Управление доступом в сервисе контроля и управления информационной безопасностью {{ sd-full-name }}. Чтобы разрешить доступ к ресурсам сервиса {{ sd-name }}, назначьте пользователю нужные роли из приведенного списка.
---

# Общие роли {{ sd-full-name }}

{% include [operate-via-roles-paragraph](../../_includes/iam/operate-via-roles-paragraph.md) %}

Чтобы разрешить доступ к ресурсам сервиса {{ sd-name }}, назначьте аккаунту на Яндексе, [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), [федеративным](../../iam/concepts/users/accounts.md#saml-federation) или [локальным](../../iam/concepts/users/accounts.md#local) пользователям, [группе пользователей](../../organization/operations/manage-groups.md) или [системной группе](../../iam/concepts/access-control/system-group.md) нужные роли из приведенного ниже списка. На данный момент роль может быть назначена только на родительский ресурс (каталог или облако), роли которого наследуются вложенными ресурсами.

{% note info %}

Подробнее о наследовании ролей читайте в разделе [Наследование прав доступа](../../resource-manager/concepts/resources-hierarchy.md#access-rights-inheritance) документации сервиса {{ resmgr-name }}.

{% endnote %}

## Какие роли действуют в сервисе {#roles-list}

{% include [roles-security-deck-general](../../_mermaid/roles/security-deck-general.md) %}

Для управления правами доступа в {{ sd-name }} можно использовать как сервисные, так и примитивные роли.

### Сервисные роли {#service-roles}

#### security-deck.worker {#security-deck-worker}

{% include [security-deck.worker](../../_roles/security-deck/worker.md) %}

#### security-deck.auditor {#security-deck-auditor}

{% include [security-deck.auditor](../../_roles/security-deck/auditor.md) %}

#### security-deck.viewer {#security-deck-viewer}

{% include [security-deck.viewer](../../_roles/security-deck/viewer.md) %}

#### security-deck.editor {#security-deck-editor}

{% include [security-deck.editor](../../_roles/security-deck/editor.md) %}

#### security-deck.admin {#security-deck-admin}

{% include [security-deck.admin](../../_roles/security-deck/admin.md) %}

Кроме того, {{ yandex-cloud }} поддерживает свой список ролей для каждого модуля, включенного в состав {{ sd-name }}. Подробнее читайте в соответствующих разделах:

* [Роли для контроля данных (Data Security Posture Management)](./dspm-roles.md).
* [Роли для контроля безопасности с использованием модуля KSPM](./kspm-roles.md).
* [Роли для диагностики доступов (Cloud Infrastructure Entitlement Management)](./ciem-roles.md).
* [Роли для контроля безопасности с использованием модуля {{ cspm-name }}](./cspm-roles.md).
* [Роли для анализа данных {{ atr-name }}](./access-transparency-roles.md).
* [Роли для управления алертами и приемниками алертов](./alerts-roles.md).

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

{% include [primitive-roles-footnote](../../_includes/primitive-roles-footnote.md) %}

## См. также {#see-also}

[Структура ресурсов {{ yandex-cloud }}](../../resource-manager/concepts/resources-hierarchy.md)