# Date

In this block, the user can specify a date or a date range, like their date of birth or vacation period.

![](../../_assets/forms/tutorial-date.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the field name or the prompt.

* To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).

* To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

* To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Date range {#range}

Turn this on if you want to get a date range in response, like the beginning and end of a vacation.

If this option is turned off, the user can specify a single date.

### Limit the date range {#limit}

Turn this on to set the date range in which the user can select a date. For example, do this if you ask users to register for an event that lasts one week.

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


