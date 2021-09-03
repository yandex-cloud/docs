# Departments

{% note warning %}

This block is only available for [{{ forms-full-name }} for business](../forms-for-org.md) users.

{% endnote %}

In this block, the user can specify a department in a {{ org-full-name }} organization. When they enter text in the field, hints with department names appear there. For example, you can use this block in an application form for a job in a specific department.

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

### Multiple choice{#param-multiple}

Enable this option to allow the user to select multiple departments.

