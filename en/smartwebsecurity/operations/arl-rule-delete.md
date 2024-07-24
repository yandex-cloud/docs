---
title: "Deleting a rule from an ARL profile"
description: "Follow this guide to delete a rule from an ARL profile."
---

# Deleting a rule from an ARL profile

Basic rules, Smart Protection, and WAF are [deleted from a security profile](rule-delete.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [rule](../concepts/rules.md) from an [ARL profile](../concepts/arl.md).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. Go to the ![image](../../_assets/smartwebsecurity/arl.svg) **ARL profiles** tab.
  1. Select the profile to delete a rule from.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, click ![options](../../_assets/console-icons/ellipsis.svg) next to the rule and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}