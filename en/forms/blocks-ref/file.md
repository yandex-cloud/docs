# File

Using this block, the user can attach a file, e.g., a photo or an error report, to a form.

You can attach a maximum of 20 files, up to 20 MB each. This limit applies if you have not enabled saving attached files from responses to storage, i.e., files are saved in {{ forms-name }}. If you enabled storage, no limits are imposed.

{% note warning %}

The service stores files attached to the form for 3 months. After that, the files are deleted and no longer available for download.

{% endnote %}

![](../../_assets/forms/tutorial-file.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the block title.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Allow multiple attachments {#alow-multi}

This option is always on by default. The user can attach up to 20 files to the form. To only allow one file to be attached, turn off this option.
