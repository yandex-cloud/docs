---
title: Проверить соответствие контролируемой инфраструктуры отраслевым стандартам на основе правил контроля модуля KSPM
description: В данном разделе вы узнаете, как использовать интерфейс соответствия требованиям, чтобы просматривать информацию о соответствии контролируемой инфраструктуры отраслевым стандартам в сфере безопасности на основе правил контроля модуля KSPM в {{ sd-full-name }}, выявлять имеющиеся несоответствия и получать рекомендации по их устранению.
---

# Проверить соответствие инфраструктуры стандартам безопасности

{% include [note-preview](../../../_includes/note-preview.md) %}

{% include [check-compliance-instruction-intro](../../../_includes/security-deck/check-compliance-instruction-intro.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ sd-name }} {#cloud-sd}

  1. Перейдите в сервис [{{ sd-full-name }}]({{ link-sd-main }}).
  1. {% include [check-compliance-instruction-step2](../../../_includes/security-deck/check-compliance-instruction-step2.md) %}
  1. Чтобы посмотреть список правил контроля {{ k8s }}, входящих в набор требований, нажмите на строку с этим набором требований. В открывшемся окне:

      * {% include [check-compliance-instruction-step3-list](../../../_includes/security-deck/check-compliance-instruction-step3-list.md) %}
      * {% include [check-compliance-instruction-step3-list2](../../../_includes/security-deck/check-compliance-instruction-step3-list2.md) %}

          {% include [rule-set-rules-list](../../../_includes/security-deck/rule-set-rules-list.md) %}

          {% include [kspm-view-detailed-info](../../../_includes/security-deck/kspm-view-detailed-info.md) %}

      {% note tip %}

      Чтобы настроить исключения, которые будут применяться при проверке контролируемой инфраструктуры на соответствие правилу, воспользуйтесь инструкцией [{#T}](./manage-exceptions.md).

      {% endnote %}

{% endlist %}

#### См. также {#see-also}

* [{#T}](../../concepts/standard-compliance/index.md)