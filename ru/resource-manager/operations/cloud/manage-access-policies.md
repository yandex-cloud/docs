---
title: Управлять политиками авторизации облака
description: Из статьи вы узнаете, как просматривать политики авторизации {{ iam-full-name }}, созданные для облака, а также создавать и удалять такие политики.
---

# Управлять политиками авторизации облака

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Назначать и отзывать политики авторизации [облака](../../concepts/resources-hierarchy.md#cloud) может пользователь, которому назначена роль [resource-manager.admin](../../security/index.md#resource-manager-admin) или [admin](../../../iam/roles-reference.md#admin) на это облако, либо роль с более широкими разрешениями.

## Создать политику авторизации для облака {#assign}

{% include [access-policies-assign-cloud](../../../_includes/iam/access-policies-assign-cloud.md) %}

## Посмотреть список политик авторизации облака {#view-assigned}

Для просмотра политик авторизации достаточно роли [resource-manager.auditor](../../security/index.md#resource-manager-auditor) на облако.

{% include [access-policies-view-assigned-cloud](../../../_includes/iam/access-policies-view-assigned-cloud.md) %}

## Удалить политику авторизации, созданную для облака {#revoke}

{% include [access-policies-revoke-cloud](../../../_includes/iam/access-policies-revoke-cloud.md) %}

#### Полезные ссылки {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)