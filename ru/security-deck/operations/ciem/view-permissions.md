---
title: Просмотр списка доступов в {{ ciem-name }} {{ sd-full-name }}
description: В данном разделе вы узнаете, как в {{ ciem-name }} {{ sd-name }} можно посмотреть все имеющиеся у аккаунта или группы права доступа к ресурсам организации.
---

# Просмотреть список доступов субъекта

{% include [note-preview-by-request](../../../_includes/note-preview-by-request.md) %}

[Модуль диагностики доступов](../../concepts/ciem.md) (Cloud Infrastructure Entitlement Management) позволяет централизованно просматривать полный список прав доступа индивидуальных [субъектов](../../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../../iam/concepts/access-control/resources-with-access-control.md) организации.

Просматривать доступы в [интерфейсе {{ sd-name }}]({{ link-sd-main }}iam-diagnostics/) могут [члены организации](../../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Чтобы получить список доступов субъекта к ресурсам организации:

{% include [view-subject-access-bindings](../../../_includes/security-deck/view-subject-access-bindings.md) %}


#### См. также {#see-also}

* [{#T}](./revoke-permissions.md)
* [{#T}](../../concepts/ciem.md)
* [{#T}](../../security/index.md)