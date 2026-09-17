---
title: Editing basic WAF profile settings
description: Follow this guide to edit basic WAF profile settings.
---

# Editing basic WAF profile settings

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the [WAF profile](../concepts/waf.md).
  1. [Navigate]({{ link-console-main }}/link/smartwebsecurity) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, select ![image](../../_assets/smartwebsecurity/waf.svg) **{{ ui-key.yacloud.smart-web-security.waf.label_profiles }}**.
  1. In the row with the profile, click ![options](../../_assets/console-icons/ellipsis.svg) → ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.smart-web-security.overview.action_edit-profile }}**.
  1. On the profile editing page, update these basic parameters:

      * **{{ ui-key.yacloud.common.name }}**.
      * **{{ ui-key.yacloud.common.description }}**.
      * [**{{ ui-key.yacloud.component.label-set.label_labels }}**](../../resource-manager/concepts/labels.md). To add a new label, click **{{ ui-key.yacloud.component.label-set.button_add-label }}**.

  1. Enable or disable rule sets for the WAF profile.
  1. Select a rule set version.
  1. {% include [waf-verdicts](../../_includes/smartwebsecurity/waf-verdicts.md) %}
  1. Click **{{ ui-key.yacloud.common.save }}**.
  1. If required, [configure rules](configure-set-rules.md) in each set you added.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To update the parameters of the {{ sws-full-name }} WAF profile you created with {{ TF }}:

  1. Open the {{ TF }} configuration file and edit the fragment describing the WAF profile.

     {% cut "Example of a WAF profile description in the {{ TF }} configuration" %}

     {% include [waf-profile-terraform-example](../../_includes/smartwebsecurity/waf-profile-terraform-example.md) %}

     {% endcut %}

      For more on the properties of the `yandex_sws_waf_profile` resource, see [this provider guide]({{ tf-provider-resources-link }}/sws_waf_profile).

  1. Apply the changes:

       {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check the update in the [management console]({{ link-console-main }}).

- API {#api}

  Use the [update](../waf/api-ref/WafProfile/update.md) REST API method for the [WafProfile](../waf/api-ref/WafProfile/) resource or the [WafProfile/Update](../waf/api-ref/grpc/WafProfile/update.md) gRPC API call.

{% endlist %}

#### Useful links {#see-also}

* [{#T}](waf-profile-delete.md)
* [{#T}](rule-add.md)
* [{#T}](rule-update.md)
