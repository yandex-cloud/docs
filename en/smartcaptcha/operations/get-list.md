---
title: How to get a list of captchas
description: Follow this guide to view a list of available {{ captcha-full-name }} captchas.
---

# Getting a list of CAPTCHAs

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder where you want to view a list of [captchas](../concepts/validation.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
  1. The **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}** page will display a list of available captchas.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command to view a list of [captchas](../concepts/validation.md):

      ```bash
      yc smartcaptcha captcha list --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

- API {#api}

  To view the a list of [captchas](../concepts/validation.md), use the [list](../api-ref/Captcha/list.md) REST API method for the [Captcha](../api-ref/Captcha/index.md) resource or the [CaptchaService/List](../api-ref/grpc/Captcha/list.md) gRPC API call.

{% endlist %}