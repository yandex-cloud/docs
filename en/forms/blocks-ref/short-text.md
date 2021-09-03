# Short text

In this block, the user can enter a word or a short phrase, like their first or last name.

The <q>Short text</q> field allows a maximum of 255 characters.

![](../../_assets/forms/tutorial-short-text.gif)

## Block settings {#sec_settings}

### Question {#param-question}

Enter the field name or the prompt.

- To add an image to the title, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the text of your prompt or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

### Question ID {#param-question-id}

Use the question ID to [pre-fill forms](../pre-fill.md). You can edit the ID. All questions in the same form must have unique IDs.

### Required prompt {#param-question-perm}

Turn this option on to mark required prompts with an <q>asterisk</q>. If the user doesn't respond to this prompt, they can't submit the completed form.

### Hidden question {#param-question-hide}

Turn on this option if you don't want to show a prompt on the form. You can use hidden questions to [send technical parameters](../pre-fill.md#hidden-query).

{% note warning %}

Don't turn on **Hidden question** and **Required prompt** at the same time, otherwise users won't be able to submit the completed form.

{% endnote %}

### Limit the number of characters {#param-symbol-max}

Set the minimum and maximum response length.

{% note warning %}

No matter what value is set for the maximum response length, the <q>Short text</q> field can't have more than 255 characters.

{% endnote %}

### Add a hint {#param-tip}

Turn on this option to suggest response options from a directory when the user enters text. Select the hint type:

{% if audience == "external" %}

- **Department**, **Team**, **User**: Users or divisions from the organization's address book.

{% else %}

- **Service**: Yandex services.

- **Staff group**, **Staff login**, **Staff office**, **Staff organization**: Users or divisions from a Yandex structure.

{% endif %}

- **Address**, **Cities**, **Countries**: Hints from the address directory.

- **Email addresses**: The user's email address.

### Validation {#param-validation}

{% include [validate](../../_includes/forms/validate.md) %}

