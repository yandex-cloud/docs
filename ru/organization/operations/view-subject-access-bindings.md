---
title: Просмотр списка доступов субъекта в {{ org-full-name }}
description: В данном разделе вы узнаете, как можно посмотреть все имеющиеся у аккаунта или группы права доступа к ресурсам организации в {{ org-full-name }}.
---

# Просмотреть список доступов субъекта

Вы можете централизованно просматривать полный список прав доступа индивидуальных [субъектов](../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../iam/concepts/access-control/resources-with-access-control.md) организации. Для этого можно использовать [модуль {{ ciem-name }}](../../security-deck/concepts/ciem.md) сервиса [{{ sd-full-name }}]({{ link-sd-main }}) или [{{ yandex-cloud }} CLI](../../cli/).

Просматривать доступы в интерфейсе {{ sd-name }} могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Диагностика доступов с помощью {{ yandex-cloud }} CLI доступна в релизе 0.171 и выше.

Чтобы получить список доступов субъекта к ресурсам организации:

{% include [view-subject-access-bindings](../../_includes/security-deck/view-subject-access-bindings.md) %}


#### См. также {#see-also}

* [{#T}](../../security-deck/concepts/ciem.md)
* [{#T}](../../security-deck/security/index.md)