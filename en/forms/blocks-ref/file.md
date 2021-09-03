# File

This block lets users attach a file to the form, like a photo or an error report.

Users can attach up to 20 files with a maximum total size of 20 MB.

{% note warning %}

The service stores files attached to the form for 3 months. After that, the files are deleted and no longer available for download.

{% endnote %}

![](../../_assets/forms/tutorial-file.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the block title.

- To add an image to the title, click ![](../../_assets/forms/add-picture.png).

- To add a comment or hint to the prompt, click **+ Add comment**. The comment is displayed in a small font.

- To format the field header or comment, use [Markdown](../appearance.md#section_pzm_m1j_j3b).

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

### Allow multiple attachments {#alow-multi}

This option is always on by default. The user can attach up to 20 files to the form. To allow only one file to be attached, turn off this option.

