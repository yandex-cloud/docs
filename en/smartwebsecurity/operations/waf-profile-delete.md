---
title: Deleting a WAF profile
description: Follow this guide to delete a WAF profile.
---

# Deleting a WAF profile

Before you delete a WAF profile, delete all WAF rules from the associated security profiles.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. Save or memorize the ID of the profile you want to delete.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/profiles.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and then the [security profile](../concepts/profiles.md) that uses the WAF profile you want to delete.
  1. In the **{{ ui-key.yacloud.smart-web-security.overview.title_security-rules }}** tab, delete the WAF profile rules:

     1. In the **{{ ui-key.yacloud.smart-web-security.label_search-rule-type }}** filter, select `{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}`.
     1. Click ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}** next to the rule associated with the WAF profile with the relevant ID.
     1. Confirm the deletion.

  1. Similarly, delete the WAF rules from all associated security profiles.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. In the row with the profile, click ![options](../../_assets/console-icons/ellipsis.svg) → ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To delete the {{ sws-full-name }} WAF profile you created with the help of {{ TF }}:

  1. Open the {{ TF }} configuration file and delete the fragment describing the WAF profile.

     {% cut "Example of a WAF profile description in the {{ TF }} configuration" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the deletion of the resources in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [delete](../waf/api-ref/WafProfile/delete.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Delete](../waf/api-ref/grpc/WafProfile/delete.md) gRPC API call.

{% endlist %}
