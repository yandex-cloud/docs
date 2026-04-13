To create an SMS template:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create the template.
  1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. In the left-hand panel, select ![route](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.cns.label_channels }}** and select a channel with an [individual sender](../../notifications/concepts/sms.md#individual-sender) you want to create a template in.
  1. In the left-hand menu, select ![square-chart-bar](../../_assets/console-icons/square-chart-bar.svg) **{{ ui-key.yacloud.cns.local.label_templates_26VqM }}** and click **{{ ui-key.yacloud.cns.SMSChannel.Templates.action_create-sms-template_e6hBJ }}**. In the window that opens:

      1. In the **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_name_c6Q4T }}** field, enter a name for the template.
      1. In the **{{ ui-key.yacloud.cns.SMSChannel.SelectTemplateType.field_type_furT8 }}** field, select the type of your new template:

          {% include [sms-template-types](./sms-template-types.md) %}

      1. In the **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_text_e8S2V }}** field, specify the template body.

          The text of SMS notifications must exactly match the template: the character case as well as the number and type of spaces must match, and the text must not contain any undefined special characters.

          Learn more about template requirements [here](../../notifications/concepts/sms.md#template-contents).
      1. In the **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.field_message_sijJZ }}** field, enter a sample text for the SMS notification you intend to send. This notification must match the template you are creating.

          You cannot create a template if the sample message does not match the template specified above.
      1. Click **{{ ui-key.yacloud.cns.SMSChannel.TemplateCreateForm.button_create_b5P5S }}**.

{% endlist %}

Once created, the SMS template will switch to the `Registering` [status](../../notifications/concepts/sms.md#template-status) and will be sent for registration on the telecom provider side. A [support]({{ link-console-support }}) ticket will be created at the same time. Registering a template takes two to four weeks. Once all telecom providers complete template registration, the template will switch to the `Active` status and be available for use.