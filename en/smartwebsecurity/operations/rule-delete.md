---
title: "Deleting a rule from a security profile"
description: "Follow this guide to delete a rule from a security profile."
---

# Deleting a rule from a security profile

You can delete basic rules, Smart Protection, and WAF from a security profile. ARL rules are [deleted from an ARL profile](arl-rule-delete.md).

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to delete a [rule](../concepts/rules.md) from a [security profile](../concepts/profiles.md).
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
   1. Select the profile to delete a rule from.
   1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, click ![options](../../_assets/console-icons/ellipsis.svg) next to the rule and select **{{ ui-key.yacloud.common.delete }}**.
   1. Confirm the deletion.

- API {#api}

   {% include [api-profile-update](../../_includes/smartwebsecurity/api-profile-update.md) %}

{% endlist %}