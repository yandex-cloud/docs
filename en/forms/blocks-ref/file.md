# File

Using this block, the user can attach a file to a form. For example, a photo or error report.

Users can attach up to 20 files with a maximum total size of 20 MB. Within these limits, you can restrict the total number and size of files that your users can attach.

{% note warning %}

The service stores files attached to the form for {% if audience == "external" %}3 months{% else %} 1 year{% endif%}. After that, the files are deleted and no longer available for download.

{% endnote %}

![](../../_assets/forms/tutorial-file.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the block title.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Allow multiple attachments {#alow-multi}

This option is always on by default. The user can attach up to 20 files to the form. To only allow one file to be attached, turn off this option.