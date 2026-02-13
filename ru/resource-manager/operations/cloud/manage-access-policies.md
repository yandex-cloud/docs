---
title: Управлять политиками авторизации облака
description: Из статьи вы узнаете, как просматривать политики авторизации {{ iam-full-name }}, назначенные на облако, а также назначать и отзывать такие политики.
---

# Управлять политиками авторизации облака

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Управлять политиками авторизации [облака](../../concepts/resources-hierarchy.md#cloud) может пользователь, которому назначена роль [`resource-manager.admin`](../../security/index.md#resource-manager-admin) или [`admin`](../../../iam/roles-reference.md#admin) на это облако.

## Назначить политику авторизации на облако {#assign}

{% include [access-policies-assign-cloud](../../../_includes/iam/access-policies-assign-cloud.md) %}

## Посмотреть список политик авторизации, назначенных на облако {#view-assigned}

{% include [access-policies-view-assigned-cloud](../../../_includes/iam/access-policies-view-assigned-cloud.md) %}

## Отозвать политику авторизации, назначенную на облако {#revoke}

{% include [access-policies-revoke-cloud](../../../_includes/iam/access-policies-revoke-cloud.md) %}

#### См. также {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)