# Forms

In [Yandex.Forms]({{ link-forms }}), you can set up integration with {{ tracker-name }} to automatically create issues using data from forms.

You can post your forms on websites or add them to websites and wiki pages. Using these forms, even users without access to {{ tracker-name }} can create issues on their own. Forms make it much more convenient to [process user requests sent to the support team](../support-process.md#mail_forms) or collect support requests.


To set up forms for issue creation:

1. Go to [Yandex.Forms]({{ link-forms }}). If it isn't activated, contact your organization's administration.

1. [Create]({{ support-forms-create }}) a new form.
Set up your form to collect data needed for issue creation.

1. Set up [{{ tracker-name }} integration]({{ support-forms-tracker }}):

    1. Specify your queue and other issue parameters.

    1. Use the **Issue description** field to add answers to the questions included in your form.

    1. If you want to save a specific answer in your issue parameters, add an issue field in the integration settings, click **Variables** → **Answer**, and choose the corresponding question.
You can also [create](../user/create-param.md) a new field if the one you need isn't available in the issue parameters.

    1. Save your integration settings.
The form will send out notifications containing lists of user answers to {{ tracker-name }}, and {{ tracker-name }} will then create issues based on those lists.



1. Set up [access rights to the form]({{ support-forms-access }}).
Any user can fill out the form by default. If you want, you can reserve this right for just your organization's employees.

1. [Publish]({{ support-forms-publish }}) the form. Your form will be accessible via a link specified in the **Link** field.

Once the form is published, you can [embed it in a wiki page]({{ support-forms-wiki }}), [post it on a website]({{ support-forms-embed }}) interface.

Read more about Yandex.Forms in the [Help]({{ support-forms-main }}).

