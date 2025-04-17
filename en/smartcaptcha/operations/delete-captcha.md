# Deleting a CAPTCHA

In this section, you will learn how to delete a [CAPTCHA](../concepts/validation.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
    1. Select the CAPTCHA and click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
    1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting the CAPTCHA:

      ```bash
      yc smartcaptcha captcha delete --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}
  1. Delete the CAPTCHA by specifying its name or ID:

      ```bash
      yc smartcaptcha captcha delete <CAPTCHA_name_or_ID>
      ```

      {% include [cli-creation-result](../../_includes/smartcaptcha/cli-creation-result.md) %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a CAPTCHA created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the fragment with the `yandex_smartcaptcha_captcha` resource description:

      {% cut "Example a CAPTCHA description in the {{ TF }} configuration" %}

      {% include [tf-creation-configuration](../../_includes/smartcaptcha/tf-creation-configuration.md) %}

      {% endcut %}

   1. Apply the changes:
      
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      You can check the deletion of the resources using the [management console]({{ link-console-main }}) or this [CLI](../../cli/) command:

      ```bash
      yc smartcaptcha captcha list
      ```

- API {#api}

   To delete a CAPTCHA, use the [delete](../../smartcaptcha/api-ref/Captcha/delete.md) REST API method for the [Captcha](../../smartcaptcha/api-ref/Captcha/index.md) resource or the [Captcha/Delete](../../smartcaptcha/api-ref/grpc/Captcha/delete.md) gRPC API call.

{% endlist %}

The deleted CAPTCHA's [keys](../concepts/keys.md) will become invalid. The service will return an error message to any request made using these keys.
