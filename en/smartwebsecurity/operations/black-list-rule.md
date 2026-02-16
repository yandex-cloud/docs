---
title: How to set up a rule for blocking black addresses in {{ sws-full-name }}
description: Follow this guide to set up a rule for blocking black addresses in {{ sws-name }}.
---

# Rule for blocking black addresses

{% include [lists-preview](../../_includes/smartwebsecurity/lists-preview.md) %}

{{ sws-name }} has [pre-installed lists](../concepts/lists.md#yc-rules) of untrusted (black) IP addresses. These lists streamline traffic checking and block requests from unsafe or suspicious addresses. Also, you can add [custom blacklists](../concepts/lists.md#user-rules).

## Set up a rule for blocking black addresses {#black-list-rule}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the left-hand panel, click ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and select the profile.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.smart-web-security.form.button_add-rule }}**.
  1. Enter a name for the rule, e.g., `block-by-list`.
  1. Set a higher **{{ ui-key.yacloud.smart-web-security.overview.column_priority }}** than that of the Smart Protection rules, e.g., `9100`.
  1. Enable **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**.
  1. Specify the rule settings:

     * **{{ ui-key.yacloud.smart-web-security.overview.column_type }}**: `{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_action-type }}**: `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` or `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}`.
     * **Traffic**: `On condition`.
     * **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}**: `{{ ui-key.yacloud.component.condition-column.condition_name-ip-range }}`.
     * **Conditions for IP**: `IP belongs to the list`.
     * **IP belongs to the list**: Add [pre-installed lists](../concepts/lists.md#yc-rules) for filtering or your own blacklists. Requests from these addresses will be blocked.

     {% note tip %}

     We recommend that you immediately add these pre-installed blacklists: `is_ddoser`, `is_tor`, and `is_anonimous`.

     {% endnote %}
  1. Click **{{ ui-key.yacloud.common.add }}**.

{% endlist %}

### See also {#see-also}

* [{#T}](list-create.md)
* [{#T}](profile-create.md)
* [{#T}](rule-add.md)
