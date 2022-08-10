# Short text

In this block, the user can enter a word or a short phrase, like their first or last name.

The <q>Short text</q> field allows a maximum of 255 characters.

![](../../_assets/forms/tutorial-short-text.gif)

## Block settings {#sec_settings}

### Question {#param-question}

Enter the field name or the prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Limit the number of characters {#param-symbol-max}

Set the minimum and maximum response length.

{% note warning %}

No matter what value is set for the maximum response length, the <q>Short text</q> field can't have more than 255 characters.

{% endnote %}

### Add a hint {#param-tip}

Turn on this option to suggest response options from a directory when the user enters text. Select the hint type:


- **Department**, **Team**, **User**: Users or divisions from the organization's address book in [{{ org-full-name }}]({{ link-org-main }}).


- **Address**, **Cities**, **Countries**: Hints from the address directory.

- **Email addresses**: The user's email address.

- **Gender**: The user's gender.

### Validation {#param-validation}

{% include [validate](../../_includes/forms/validate.md) %}

