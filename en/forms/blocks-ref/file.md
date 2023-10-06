# File

Using this block, the user can attach a file, e.g., a photo or an error report, to a form.

If [saving attached files from responses to storage](../storage-for-attached-files.md) is enabled, users can attach any number of files of up to 20 MB each to their response. If storage is not enabled and files are saved to {{ forms-name }}, users can upload up to 20 files with the maximum total size of 20 MB.

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

This option is enabled by default. A user can attach up to 20 files to the form. To allow only one file to be attached, disable this option.