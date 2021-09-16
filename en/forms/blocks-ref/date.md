# Date

In this block, the user can specify a date or a date range, like their date of birth or vacation period.

![](../../_assets/forms/tutorial-date.gif)

## Block settings {#sec_settings}

### Question {#question}

Enter the field name or the prompt.

{% include [question](../../_includes/forms/question.md) %}

### Date range {#range}

Turn this on if you want to get a date range in response, like the beginning and end of a vacation.

If this option is turned off, the user can specify a single date.

### Limit the date range {#limit}

Turn this on to set the date range in which the user can select a date. For example, do this if you ask users to register for an event that lasts one week.

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

{% if audience == "internal" %}

{% include [validate-blockrefs](../../_includes/forms/validate-blockrefs.md) %}

{% endif %}

