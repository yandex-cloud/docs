# Number

This block is for prompts that require entering a number in response. For example, you can ask users to solve an equation.

The response must be an integer or a fraction with no more than 2 decimal places. The format of the entered number is checked when the user completes the test.

![](../../_assets/forms/tutorial-test-number.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter a prompt that requires a number in response.

- To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Responses {#answer}

1. Enter the correct response. It must be an integer or a fraction with no more than 2 decimal places.

1. Specify how many points the user gets for the correct response. It must be a positive integer or fraction with no more than two decimal places.

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

