---
title: '{{ td-full-name }} ({{ td-name }}) in {{ sd-full-name }}'
description: The {{ td-full-name }} ({{ td-name }}) module automatically detects suspicious activity in the cloud infrastructure.
---

# {{ td-full-name }} ({{ td-name }})

{% include [td-basic-intro](../../_includes/security-deck/td-basic-intro.md) %}

{% note info %}

For the {{ td-full-name }} module to function correctly, the [service account](../../iam/concepts/users/service-accounts.md) linked to the workspace [connector](./workspace.md#connectors) must be [assigned](../../iam/operations/sa/assign-role-for-sa.md) the `threat-detector.worker` role or higher for the resources controlled in the workspace.

{% endnote %}

## Rules {#rules}

You can [view](../operations/td/view-rules.md) information about the {{ td-full-name }} security control rules under **Threat detection** on the **{{ ui-key.yacloud_org.security.controls.ControlsPage.security_control_r4yn7 }}** page.

## Exceptions to rules {#exceptions}

Exceptions allow you to flexibly configure when and for which objects {{ td-full-name }} should ignore the results of a rule check. You can [view the list of exceptions](../operations/td/manage-exceptions.md#view-exceptions-list) set for your workspace in the [{{ sd-name }}]({{ link-sd-main }}) interface under **{{ ui-key.yacloud_org.app.security.control_rules_rWmUV }}**.

#### See also {#see-also}

* [{#T}](./workspace.md)
* [{#T}](./alerts.md)
* [{#T}](../operations/td/view-rules.md)
* [{#T}](../operations/td/manage-exceptions.md)