---
title: How to get information about a CAPTCHA
description: Follow this guide to get information about a {{ captcha-full-name }}.
---

# Getting information about a CAPTCHA

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the [CAPTCHA](../concepts/validation.md).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
  1. Select a CAPTCHA. The **{{ ui-key.yacloud.common.overview }}** page will display detailed information about the CAPTCHA.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view information about a [CAPTCHA](../concepts/validation.md):

     ```bash
     yc smartcaptcha captcha get --help
     ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}

  1. Get detailed information about a CAPTCHA by specifying its name or ID:

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

  To get information about a [CAPTCHA](../concepts/validation.md) using {{ TF }}:

  1. Add the `data` and `output` sections to the Terraform configuration file:

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
         * `resource_id`: Resource ID.
      * `output "ref_description"`: Output variable with information about the [client key](../concepts/keys) (`client_key`):
         * `value`: Returned value.

     You can replace `client_key` with any other parameter to get the information you need. For more information about the `yandex_smartcaptcha_captcha` data source parameters, see the [relevant provider documentation]({{ tf-provider-datasources-link }}/smartcaptcha_captcha).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {{ TF }} will create all the required resources and display the output variable values in the terminal. To check the results, run this command:

      ```bash
      terraform output
      ```

      Result:

      ```text
      my-client-key = ysc1_MtyvvAUieCSUfHb6tugqFAbTyesgGzXWU50sZq0E********
      ...
      ```

- API {#api}

  To get detailed information about a [CAPTCHA](../concepts/validation.md), use the [get](../api-ref/Captcha/get.md) REST API method for the [Captcha](../api-ref/Captcha/index.md) resource or the [CaptchaService/Get](../api-ref/grpc/Captcha/get.md) gRPC API call.

{% endlist %}