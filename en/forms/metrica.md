# Enable Metrica

To analyze statistics on form visits and user actions, you can embed a [Yandex&#160Metrica]({{ link-metrika }}) tag in the page of your form. For more information about tags, see [Yandex&#160;Metrica Help](https://yandex.ru/support/metrica/general/creating-counter.html#counter-html).

## Add the tag {#section-add-counter}

To add a tag to the form page:

1. Select a Yandex&#160;Metrica tag to use for collecting statistics or [create a new one]({{ support-metrica-counter }}).

1. [Copy the form link](publish.md#section_link) and paste it in the tag settings as the website URL.

   {% note info %}

   To make sure the tag can receive data from different forms or other websites, turn off **Accept data only from the specified addresses** in the tag settings. In this case, you can specify any URL in the **Site address** field.

   {% endnote %}

1. Go to the **Settings** tab and select **Additional** in the left panel.

1. Enable the **Connect Yandex&#160;Metrica** option and enter the tag number.

1. Click **{{ ui-key.yacloud.common.save }}**.

## Analyze user actions {#section-goals}

You can use a Yandex&#160;Metrica tag to track the actions of users who opened the form page. For example, you can track the number of users who submitted a completed form and calculate the conversion rate (the percentage of all users who opened the form).

To track user actions:

1. Add a [Yandex&#160;Metrica](metrica.md#section-add-counter) tag to your form.

1. In Yandex&#160;Metrica, go to the tag's settings and [add a goal]({{ support-metrica-java }}).

1. For the goal, select the **JavaScript event** condition type and specify the ID of the goal with the **contains** condition. Events with the following goal IDs are tracked on the form page:

   
   - The user filled in at least one field in the form: `ya-forms_start-change`.


   - The user clicked **{{ ui-key.forms.common.blocks_survey.simple_form-button-text }}** in the form: `ya-forms_submit`.

   - The user clicked **{{ ui-key.forms.common.blocks_survey.next-button-text }}** in a multi-page form: `ya-forms_next`.

   - The user clicked **{{ ui-key.forms.common.blocks_survey.prev-button-text }}** in a multi-page form: `ya-forms_prev`.

For more information about goals, see [Yandex&#160;Metrica Help]({{ support-metrica-goals }}).