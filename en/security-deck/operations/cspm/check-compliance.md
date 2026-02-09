---
title: Checking compliance of your controlled infrastructure with industry standards based on {{ cspm-name }} control rules
description: In this section, you will learn how to use the compliance UI to view information about the compliance of your controlled infrastructure with industry security standards based on the {{ cspm-name }} control rules in {{ sd-full-name }}, identify existing non-compliances, and get recommendations on how to fix them.
---

# Checking your infrastructure for compliance with security standards

{% include [check-compliance-instruction-intro](../../../_includes/security-deck/check-compliance-instruction-intro.md) %}

{% list tabs group=instructions %}

- {{ sd-name }} UI {#cloud-sd}

  1. Go to [{{ sd-full-name }}]({{ link-sd-main }}).
  1. {% include [check-compliance-instruction-step2](../../../_includes/security-deck/check-compliance-instruction-step2.md) %}   
  1. To view a list of control rules included in a set of requirements, click the relevant line. In the window that opens:
  
      * {% include [check-compliance-instruction-step3-list](../../../_includes/security-deck/check-compliance-instruction-step3-list.md) %}
      * {% include [check-compliance-instruction-step3-list2](../../../_includes/security-deck/check-compliance-instruction-step3-list2.md) %}

          {% include [rule-set-rules-list](../../../_includes/security-deck/rule-set-rules-list.md) %}

          {% include [cspm-view-detailed-info](../../../_includes/security-deck/cspm-view-detailed-info.md) %}

      {% note tip %}

      To configure exceptions to apply when checking your controlled infrastructure for compliance with the rule, refer to [{#T}](./manage-exceptions.md).

      {% endnote %}

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/standard-compliance/index.md)