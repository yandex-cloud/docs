---
title: Просмотр списка доступов субъекта в {{ org-full-name }}
description: В данном разделе вы узнаете, как можно посмотреть все имеющиеся у аккаунта или группы права доступа к ресурсам организации в {{ org-full-name }}.
---

# Просмотреть список доступов субъекта

Вы можете централизованно просматривать полный список прав доступа индивидуальных [субъектов](../../iam/concepts/access-control/index.md#subject) и групп к [ресурсам](../../iam/concepts/access-control/resources-with-access-control.md) организации. Для этого можно использовать [модуль {{ access-analyzer-name }}](../../security-deck/concepts/access-analyzer.md) сервиса [{{ sd-full-name }}]({{ link-sd-main }}) или [{{ yandex-cloud }} CLI](../../cli/index.yaml).

Просматривать доступы в интерфейсе {{ sd-name }} могут [члены организации](../../organization/concepts/membership.md), которым на эту организацию назначена [роль](../../organization/security/index.md#organization-manager-viewer) `organization-manager.viewer` или выше.

Диагностика доступов с помощью {{ yandex-cloud }} CLI доступна в релизе 0.171 и выше.

Чтобы получить список доступов субъекта к ресурсам организации:

{% include [view-subject-access-bindings](../../_includes/security-deck/view-subject-access-bindings.md) %}

В сервисе {{ sd-full-name }} вы также можете активировать автоматический анализ и формирование рекомендаций по сокращению избыточных и отзыву неиспользуемых ролей. Подробнее читайте в разделе [{#T}](../../security-deck/operations/access-analyzer/use-recommendations.md).

#### Полезные ссылки {#see-also}

* [{#T}](../../security-deck/operations/access-analyzer/use-recommendations.md)
* [{#T}](../../security-deck/concepts/access-analyzer.md)
* [{#T}](../../security-deck/security/index.md)