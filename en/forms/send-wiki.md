# Add a response to {{ wiki-name }}

{% if audience == "external" %}

{% note warning %}

You can only set up integration with {{ wiki-name }} in [{{ forms-full-name }} for business](forms-for-org.md).

{% endnote %}

{% endif %}

You can integrate your form with [{{ wiki-name }}]({{ link-wiki }}) to save user responses on a wiki page. For example, if you're using a form to register participants for an event, you can automatically create a list of participants in {{ wiki-name }}. To learn more about wiki pages, go to [{{ wiki-name }} Help](../wiki/edit-page.md).

To send responses to {{ wiki-name }}:

1. Select a form and go to **Integration**.

1. Select a [group of actions](notifications.md#add-integration) for which you want to send responses to {{ wiki-name }} and click ![](../_assets/forms/wiki-notification-button.png) at the bottom of the group.

1. Specify the address of the wiki page where you want to send data from the form. Example: `users/login/my-page`. By default, responses are added to the bottom of the page. To add responses to a specific place on the page:

    1. Insert an [anchor](../wiki/actions/anchor.md) in the place where you want to add responses from the form. For example, `{{a name="form"}}`.

    1. In the {{ wiki-name }} integration settings, append the `#` character and the name of the anchor to the page address like this: `users/login/my-page#form`. Responses from the form will be added to the page after the anchor.

1. In the **Text** field, specify what data to add to the page. You can format the text using [wiki markup](../wiki/static-markup.md).

   You can add a response to a prompt or other form data to the text:

    - Select a field and click **Variables** on the right.

    - Select a [variable](vars.md) from the list that you want to add. For instance, you can add a user's name and email to the text.

    ![](../_assets/forms/wiki-var-example.png)

1. For the user to get a link to the wiki page after filling out the form, turn on the **Show result to user** option under the name of the action.

1. Click **Save**.

To send responses to multiple wiki pages at the same time, configure multiple notifications using the ![](../_assets/forms/wiki-notification-button.png) button at the bottom of the page.

If you want data to only be sent to {{ wiki-name }} if the user gave certain responses, [set the conditions](notifications.md#section_xlw_rjc_tbb).

