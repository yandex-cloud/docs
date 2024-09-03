---
title: "Deleting a rule from an ARL profile"
description: "Follow this guide to delete a rule from an ARL profile."
---

# Deleting a rule from an ARL profile

Basic rules, as well as Smart Protection and WAF rules, are [deleted from a security profile](rule-delete.md).

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) the [ARL profile](../concepts/arl.md) resides in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/arl.svg) **{{ ui-key.yacloud.smart-web-security.arl.label_profiles }}**.
  1. Select the profile to delete a rule from.
  1. Under **{{ ui-key.yacloud.smart-web-security.arl.section_rules }}**, in the profile row, click ![options](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

{% endlist %}