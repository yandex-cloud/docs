# One answer

In this block, the user can choose a response from several options. For example, they can specify their marital status.

![](../../_assets/forms/tutorial-single.gif)

## Block settings {#sec_settings}

### Question {#param-question}

Enter your prompt.

- To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Responses {#param-answers}

Set the options that the user can choose:

- To add a response option, select **Add option** and enter the text of the response.

- To format the text of the response, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

- To add an image to the response option, click ![](../../_assets/forms/add-picture.png).

- To move an option to a different position in the list, drag it to the ![](../../_assets/forms/drag-answer.png) icon.

### Question ID {#param-question-id}

Use the question ID to [pre-fill forms](../pre-fill.md). You can edit the ID. All questions in the same form must have unique IDs.

### Required prompt {#param-question-perm}

Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

### Hidden question {#param-question-hide}

Turn on this option if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).

{% note warning %}

Don't turn on **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit the completed form.

{% endnote %}

### Sort responses {#param-answers-sort}

Turn on this option and choose one of the sorting methods:

- **Alphabetical**.

- **Random for each user**: Select this sorting method if you don't want the user's choice to be affected by the order in which responses are displayed.

{% if audience == "internal" %}

### Validation {#validate}

Use an external validator if you need to see if responses match the specified format. When selecting this option in the form settings, specify the [validation server address](../validation.md).

{% endif %}

