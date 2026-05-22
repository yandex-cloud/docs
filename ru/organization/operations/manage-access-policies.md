---
title: Управлять политиками авторизации организации
description: Из статьи вы узнаете, как просматривать политики авторизации {{ iam-full-name }}, созданные для организации, а также создавать и удалять такие политики.
---

# Управлять политиками авторизации организации

{% include [note-preview-by-request](../../_includes/note-preview-by-request.md) %}

{% include [access-policies-instruction-intro](../../_includes/iam/access-policies-instruction-intro.md) %}

Управлять политиками авторизации [организации](../concepts/organization.md) может пользователь, которому назначена роль [`organization-manager.admin`](../security/index.md#organization-manager-admin) или [`admin`](../../iam/roles-reference.md#admin) на эту организацию.

## Создать политику авторизации для организации {#assign}

{% include [access-policies-assign-org](../../_includes/iam/access-policies-assign-org.md) %}

## Посмотреть список политик авторизации организации {#view-assigned}

{% include [access-policies-view-assigned-org](../../_includes/iam/access-policies-view-assigned-org.md) %}

## Удалить политику авторизации, созданную для организации {#revoke}

{% include [access-policies-revoke-org](../../_includes/iam/access-policies-revoke-org.md) %}

#### См. также {#see-also}

* [{#T}](../../iam/concepts/access-control/access-policies.md)