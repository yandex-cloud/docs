---
title: How to get CAPTCHA details
description: In this tutorial, you will learn how to get {{ captcha-full-name }} details.
---

# Getting CAPTCHA details

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing your [CAPTCHA](../concepts/validation.md).
  1. [Navigate](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
  1. Select the CAPTCHA you need. You can check the CAPTCHA details on the **{{ ui-key.yacloud.common.overview }}** page.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for viewing [CAPTCHA](../concepts/validation.md) details:

     ```bash
     yc smartcaptcha captcha get --help
     ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

  1. Get CAPTCHA details by running the CLI command with its name or ID specified:

     ```bash
     yc smartcaptcha captcha get <captcha_ID>
     ```

     Result:

      ```text
     id: bpne29ifsca8********
     folder_id: b1geoelk7fld********
     cloud_id: b1gia87mbaom********
     client_key: ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
     created_at: "2025-02-24T17:16:13.034742Z"
     name: test
     allowed_sites:
       - example.com
     complexity: MEDIUM
     pre_check_type: CHECKBOX
     challenge_type: IMAGE_TEXT
     ```

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To get [CAPTCHA](../concepts/validation.md) details using {{ TF }}:

  1. Add the `data` and `output` sections to the {{ TF }} configuration file:

      ```hcl
      data "yandex_smartcaptcha_captcha" "my-captcha" {
        captcha_id = "<captcha_ID>"
      }

      output "my-client-key" {
        value = data.yandex_smartcaptcha_captcha.my-captcha.client_key
      }
      ```

      Where:

      * `data "yandex_smartcaptcha_captcha"`: Description of the CAPTCHA as a data source:
         * `resource_id`: Resource identifier.
      * `output "ref_description"`: Output variable with the [client key](../concepts/keys.md) (`client_key`) details:
         * `value`: Return value.

     You can replace `client_key` with another variable to get the information you need. To learn more about the `yandex_smartcaptcha_captcha` data source properties, see [this {{ TF }} provider guide]({{ tf-provider-datasources-link }}/smartcaptcha_captcha).

  1. Create the required resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all required resources and display their output variables. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my-client-key = ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
      ...
      ```

- API {#api}

  To get [CAPTCHA](../concepts/validation.md) details, use the [get](../api-ref/Captcha/get.md) REST API method for the [Captcha](../api-ref/Captcha/index.md) resource or the [CaptchaService/Get](../api-ref/grpc/Captcha/get.md) gRPC API call.

{% endlist %}