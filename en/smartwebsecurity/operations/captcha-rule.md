---
title: How to set up a rule for {{ captcha-full-name }}
description: Follow this guide to set up a rule for {{ captcha-name }}.
---

# Rule for {{ captcha-full-name }}

Set up a rule to redirect requests to [{{ captcha-name }}](../../smartcaptcha/) for verification.

{% include [allow-path-captcha](../../_includes/smartwebsecurity/allow-patch-captcha.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartwebsecurity }}**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/shield.svg) **{{ ui-key.yacloud.smart-web-security.title_profiles }}** and select the profile.
  1. {% include [allow-captcha](../../_includes/smartwebsecurity/allow-captcha.md) %}

{% endlist %}

### See also {#see-also}

* [{#T}](profile-create.md)
* [{#T}](rule-add.md)