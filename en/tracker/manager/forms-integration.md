# {{ forms-full-name }}

You can create issues automatically based on information taken from [{{ forms-full-name }}]({{ link-forms }}) by setting up integration with {{ tracker-name }}.

You can post your forms on websites or add them to websites and wiki pages. Using such forms, even users without access to {{ tracker-name }} can create issues on their own. Forms make it much more convenient to [process user requests sent to the support team](../support-process-mail-forms.md) or collect support requests.

If you want to use a form as a template for quickly creating standardized issues, [embed the form on the issue creation page in {{ tracker-name }}](attach-form.md).

To set up forms for issue creation:

1. Go to [{{ forms-full-name }}]({{ link-forms }}). If the service hasn't been activated, contact your organization's administrator.

1. [Create](../../forms/new-form.md) a new form.
Set up your form to collect data needed for issue creation.

1. Set up [integration with {{ tracker-name }}](../../forms/create-task.md):

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. If you want to save a specific answer in your issue parameters, add an issue field, click **Variables** → **Answer**, and choose the corresponding question.
You can also [create](../user/create-param.md) a new field if the one you need isn't available in the issue parameters.

    1. Save your integration settings.
The form will send user answers to {{ tracker-name }} and {{ tracker-name }} will then create issues based on these answers.





1. Configure [access rights to the form](../../forms/restrictions.md#restrictions__sec_access).
Any user can fill out the form by default. If you want, you can reserve this right for just your organization's employees.


1. [Publish](../../forms/publish.md) your form. Your form will be accessible via a link specified in the **Link** field.

Once your form is published, you can [embed it in a wiki page](../../forms/publish.md#section_xvx_g2c_tbb), [post it on a website](../../forms/publish.md#section_c21_gdb_42b), or [add it to the issue creation page](../manager/attach-form.md) in the {{ tracker-name }} interface.

To learn more about {{ forms-full-name }}, see [Help](../../forms).

