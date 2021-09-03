# Integer

In this block, the user can enter an integer, like height in centimeters.

![](../../_assets/forms/tutorial-number-integer.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the field name or the prompt.

- To add an image to the title, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

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

### Limit numbers in a response {#limit}

Set the minimum and maximum values for the field.

{% if audience == "internal" %}

### Validation {#validate}

Use an external validator if you need to see if responses match the specified format. When selecting this option in the form settings, specify the [validation server address](../validation.md).

{% endif %}

