# Cities and countries

In this block, the user can select cities or countries. For example, they can specify the city where they live.

Suggestions are available from the city and country directory.

![](../../_assets/forms/tutorial-cities.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the field name or the prompt.

* To add an image to the title, click ![](../../_assets/forms/add-picture.png).

* To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

* To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Responses {#answer}

In the **Responses** section, select which type to use in this block: **Cities** or **Countries**.

To limit response options to a set list of countries:

1. Turn on **Limit list of countries**.

1. In the **Select countries** field, specify one or more countries.

For example, you can limit response options if you use a form to accept mail orders but can only deliver within Russia. In that case, select **Cities**, limit the list of countries, and specify Russia.

### Question ID {#id}

Use the question ID to [pre-fill forms](../pre-fill.md).

You can edit the ID. All questions in the same form must have unique IDs.

### Required prompt {#required}

Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

### Hidden question {#hidden}

Turn on this option if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).

{% note warning %}

Don't turn on **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit the completed form.

{% endnote %}

### Multiple choice{#multi}

Turn this on to allow users to select multiple cities or countries, like to specify multiple countries that they visited.


