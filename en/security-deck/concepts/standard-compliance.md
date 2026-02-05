---
title: Compliance UI in {{ sd-full-name }}
description: With the compliance UI, you can view information about the compliance of your controlled infrastructure with industry security standards, identify existing non-compliances, and get recommendations on how to fix them.
---

# Compliance UI

In {{ sd-full-name }}, the [{{ cspm-name }}](./cspm.md) and [KSPM](./kspm.md) modules check your controlled infrastructure for compliance with security-related industry standards and regulations. For each standard and regulation, there is an individual set of [requirements](#security-rule-sets).

{% note info %}

The total of industry standards and regulations your infrastructure is checked against is configured separately for each [workspace](./workspace.md).

{% endnote %}

The _compliance UI_ shows what industry standards and regulations to the workspace infrastructure is checked against, and how well its resources comply with these standards and regulations.

With the compliance UI, you can also view the lists of [control rules](#security-rules) that belong to the sets of requirements corresponding to particular industry standards and regulations. On the UI dashboard, there is a summary for each industry standard (set of requirements), which highlights the most common violations, and a diagram for severity of identified violations.

In the compliance UI, you can view the key info about each individual rule within the set of requirements and your cloud resources violating that rule. Also, you can set up exceptions for individual control rules and view recommendations on how to fix the detected violations.

## Sets of security requirements {#security-rule-sets}

{{ sd-name }} comes with sets of security requirements aligned with the following industry standards and regulations in the field of information security:

{% include [workspace-sec-standard-list](../../_includes/security-deck/workspace-sec-standard-list.md) %}

{% include [rule-set-enable-disable-notice](../../_includes/security-deck/rule-set-enable-disable-notice.md) %}

### Control rules {#security-rules}

You can view the list of control rules included in any given set of requirements. Do it by clicking the row corresponding to the set in the compliance UI. This will open a list containing the following info on each control rule in the set:

{% include [rule-set-rules-list](../../_includes/security-deck/rule-set-rules-list.md) %}

Click the row with the rule for additional info, including violation details and fixing recommendations.

#### See also {#see-also}

* [Checking your infrastructure for compliance with security standards based on the KSPM rules](../operations/kspm/check-compliance.md)
* [Checking your infrastructure for compliance with security standards based on the {{ cspm-name }} rules](../operations/cspm/check-compliance.md)