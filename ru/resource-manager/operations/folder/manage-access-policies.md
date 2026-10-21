---
title: Управлять политиками авторизации каталога
description: Из статьи вы узнаете, как просматривать политики авторизации {{ iam-full-name }}, созданные для каталога, а также создавать и удалять такие политики.
---

# Управлять политиками авторизации каталога

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Назначать и отзывать политики авторизации [каталога](../../concepts/resources-hierarchy.md#folder) может пользователь, которому назначена роль [resource-manager.admin](../../security/index.md#resource-manager-admin) или [admin](../../../iam/roles-reference.md#admin) на этот каталог, либо роль с более широкими разрешениями.

## Создать политику авторизации для каталога {#assign}

{% include [access-policies-assign-folder](../../../_includes/iam/access-policies-assign-folder.md) %}

## Посмотреть список политик авторизации каталога {#view-assigned}

Для просмотра политик авторизации достаточно роли [resource-manager.auditor](../../security/index.md#resource-manager-auditor) на каталог.

{% include [access-policies-view-assigned-folder](../../../_includes/iam/access-policies-view-assigned-folder.md) %}

## Удалить политику авторизации, созданную для каталога {#revoke}

{% include [access-policies-revoke-folder](../../../_includes/iam/access-policies-revoke-folder.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)