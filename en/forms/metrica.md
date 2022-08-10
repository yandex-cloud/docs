# Connect Yandex&#160;Metrica

To analyze statistics on form visits and user actions, you can add a [Yandex&#160;Metrica]({{ link-metrika }}) tracking tag to your form. To learn more about tracking tags, go to [Yandex&#160;Metrica Help](https://yandex.ru/support/metrica/general/creating-counter.html#counter-html).

## Add tag {#section-add-counter}

To add a tag to the form page:

1. Select a Yandex&#160;Metrica tag to use for collecting statistics or [create a new one]({{ support-metrica-counter }}).

1. [Copy the form link](publish.md#section_link) and paste it in the tag settings as the site address.

    {% note info %}

    To make sure the tag can receive data from different forms or other sites, turn off **Receive data only from specified addresses** in the tag settings. Then you can specify any address in the **Site address** field.

    {% endnote %}

1. Go to the **Settings** tab and select **Additional** in the left panel.

1. Enable the **Connect Yandex&#160;Metrica** option and enter the tag number.

1. Click **Save**.

## Analyze user actions {#section-goals}

You can use the Yandex&#160;Metrica tag to track the actions of users who opened the form page. For example, you can track the number of users who submitted a completed form and calculate the conversion rate (the percentage of all users who opened the form).

To track user actions:

1. Add a [Yandex&#160;Metrica tag](metrica.md#section-add-counter) to your form.

1. In Yandex&#160;Metrica, go to the added tag's settings and [add a goal]({{ support-metrica-java }}).

1. For the goal, select the ** JavaScript event** condition type and specify the goal ID. Events with the following goal IDs are tracked on the form page:

        
    - The user filled in at least one field in the form: ` ya-forms_start-change`.


    - The user clicked the ** Submit** button on the form: `ya-forms_submit`.

    - The user clicked the ** Next** button on a multi-page form: `ya-forms_next`.

    - The user clicked the **Back** button on a multi-page form: `ya-forms_prev`.

To learn more about using goals, go to [Yandex&#160;Metrica Help]({{ support-metrica-goals }}).

