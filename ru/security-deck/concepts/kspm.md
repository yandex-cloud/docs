---
title: Контроль {{ k8s }}® (KSPM) в {{ sd-full-name }}
description: Контроль {{ k8s }}® (KSPM) контролирует соответствие контейнеризованных приложений и используемых образов в инфраструктуре {{ yandex-cloud }} комплексным требованиям и лучшим практикам в сфере безопасности.
---

# Контроль {{ k8s }}® (KSPM)

{% include [note-preview](../../_includes/note-preview.md) %}

{% include [kpsm-requirements](../../_includes/security-deck/kpsm-requirements.md) %}

{% include [kspm-basic-intro](../../_includes/security-deck/kspm-basic-intro.md) %}

Конфигурация KSPM задается при [создании](../operations/workspaces/create.md) окружения и может включать проверку соответствия кластеров следующим стандартам:

{% include [kspm-sec-standard-list](../../_includes/security-deck/kspm-sec-standard-list.md) %}

Модуль KSPM позволяет гибко выбирать и настраивать правила безопасности под специфические требования вашей организации, а также создавать исключения из правил.

{% include [kspm-alerts](../../_includes/security-deck/kspm-alerts.md) %}

Подробнее см. на странице [{#T}](../operations/kspm/enable-kspm.md).

### См. также {#see-also}

* [{#T}](workspace.md)
* [{#T}](cspm.md)
* [{#T}](ai-assistant.md)
* [{#T}](../quickstart-overview.md)
* [{#T}](../operations/kspm/enable-kspm.md).
* [{#T}](../security/kspm-roles.md)
