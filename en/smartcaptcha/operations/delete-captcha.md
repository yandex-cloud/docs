# Deleting a CAPTCHA

In this section, you will learn how to delete a [CAPTCHA](../concepts/validation.md).

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
    1. Select the CAPTCHA and click ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
    1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a CAPTCHA:

      ```bash
      yc smartcaptcha captcha delete --help
      ```

  1. {% include [get-list](../../_includes/smartcaptcha/get-list.md) %}
  1. Delete the CAPTCHA by running the CLI command with its name or ID specified:

      ```bash
      yc smartcaptcha captcha delete <CAPTCHA_name_or_ID>
      ```

      {% include [cli-creation-result](../../_includes/smartcaptcha/cli-creation-result.md) %}

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To delete a CAPTCHA created with {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the section describing the `yandex_smartcaptcha_captcha` resource:

      {% cut "{{ TF }} CAPTCHA configuration example" %}

      {% include [tf-creation-configuration](../../_includes/smartcaptcha/tf-creation-configuration.md) %}

      {% endcut %}

   1. Apply the changes:
      
      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
      
      You can verify that the resources have been deleted in the [management console]({{ link-console-main }}) or using this [CLI](../../cli/) command:

      ```bash
      yc smartcaptcha captcha list
      ```

- API {#api}

   To delete a CAPTCHA, use the [delete](../../smartcaptcha/api-ref/Captcha/delete.md) REST API method for the [Captcha](../../smartcaptcha/api-ref/Captcha/index.md) resource or the [Captcha/Delete](../../smartcaptcha/api-ref/grpc/Captcha/delete.md) gRPC API call.

{% endlist %}

The [keys](../concepts/keys.md) of the deleted CAPTCHA will no longer be valid. All service requests made with these keys will return error.
