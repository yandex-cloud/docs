---
title: How to get a list of available CAPTCHAs
description: In this tutorial, you will learn how to get a list of available {{ captcha-full-name }} CAPTCHAs.
---

# Getting a list of available CAPTCHAs

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder containing the [CAPTCHAs](../concepts/validation.md) you want to see.
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
  1. You will see the list of available CAPTCHAs on the **{{ ui-key.yacloud.smartcaptcha.label_captcha-settings-list }}** page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../cli/) command for listing [CAPTCHAs](../concepts/validation.md):

      ```bash
      yc smartcaptcha captcha list --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

- API {#api}

  To get a list of [CAPTCHAs](../concepts/validation.md), use the [list](../api-ref/Captcha/list.md) REST API method for the [Captcha](../api-ref/Captcha/index.md) resource or the [CaptchaService/List](../api-ref/grpc/Captcha/list.md) gRPC API call.

{% endlist %}