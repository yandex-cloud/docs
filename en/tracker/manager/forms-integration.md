# {{ forms-name }} integration with {{ tracker-name }}

You can create issues automatically based on information taken from [{{ forms-full-name }}]({{ link-forms }}) by setting up integration with {{ tracker-name }}.

The form can be published by a direct link, placed on a website or wiki page. Using such forms, even users without access to {{ tracker-name }} can create issues on their own. Forms are convenient, for example, when you need to [accept support or service requests from users](../support-process-mail-forms.md).

If you want to use a form as a template for quickly creating standardized issues, [embed the form on the issue creation page in {{ tracker-name }}](attach-form.md).

To set up a form for issue creation:

1. Go to [{{ forms-full-name }}]({{ link-forms }}). If the service hasn't been activated, contact your company's administrator.

1. [Create](../../forms/new-form.md) a new form.
   Set up the form to collect the data needed for creating an issue.

1. Set up [integration with {{ tracker-name }}](../../forms/create-task.md):

   1. Specify the queue and other issue parameters.

   1. Use the **{{ ui-key.startrek.blocks-desktop_b-create-ticket-form.fill-desc }}** field to add answers to the questions included in your form.

   1. If you want to save a specific answer in your issue parameters, add an issue field, click **{{ ui-key.startrek.blocks-desktop_trigger-action.webhook-variables }}** → **Answer** and choose the appropriate question.

      You can also [create](../user/create-param.md) a new field if the one you need isn't available in the issue parameters.

   1. Save your integration settings.

      The form will send user answers to {{ tracker-name }} and {{ tracker-name }} will then create issues based on these answers.



1. Configure [access rights to the form](../../forms/restrictions.md#restrictions__sec_access).
   By default, all users can fill out the form. You can only allow users from your organization to fill out the form.


1. [Publish](../../forms/publish.md) the form. Your form will be accessible via the link specified in the **{{ ui-key.startrek.blocks-desktop_page-admin-tab_type_fields.field-type--uri }}** field.

Once the form is published, you can [embed it into a wiki page](../../forms/publish.md#section_xvx_g2c_tbb), [place it on your website](../../forms/publish.md#section_c21_gdb_42b), or add it to the [issue creation page](../manager/attach-form.md) in the {{ tracker-name }} interface.

To learn more about {{ forms-full-name }}, see [Help](../../forms).

