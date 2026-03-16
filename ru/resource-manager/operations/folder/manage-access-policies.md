---
title: Управлять политиками авторизации каталога
description: Из статьи вы узнаете, как просматривать политики авторизации {{ iam-full-name }}, созданные для каталога, а также создавать и удалять такие политики.
---

# Управлять политиками авторизации каталога

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../../_includes/iam/access-policies-instruction-intro.md) %}

Управлять политиками авторизации [каталога](../../concepts/resources-hierarchy.md#folder) может пользователь, которому назначена роль [`resource-manager.admin`](../../security/index.md#resource-manager-admin) или [`admin`](../../../iam/roles-reference.md#admin) на этот каталог.

## Создать политику авторизации для каталога {#assign}

{% include [access-policies-assign-folder](../../../_includes/iam/access-policies-assign-folder.md) %}

## Посмотреть список политик авторизации каталога {#view-assigned}

{% include [access-policies-view-assigned-folder](../../../_includes/iam/access-policies-view-assigned-folder.md) %}

## Удалить политику авторизации, созданную для каталога {#revoke}

{% include [access-policies-revoke-folder](../../../_includes/iam/access-policies-revoke-folder.md) %}

#### См. также {#see-also}

* [{#T}](../../../iam/concepts/access-control/access-policies.md)