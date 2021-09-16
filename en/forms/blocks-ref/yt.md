# YT list

In this block, users can enter response options that are loaded from a [ YT table](https://yt.yandex-team.ru/docs/). When they type, hints with suggested responses appear in the field. Responses that aren't in the table aren't accepted.

If multiple <q>YT list</q> blocks are used in the form, you can [configure response filtering](#param-filter). In this case, the set of possible responses in one <q>YT list</q> block changes depending on the response the user selected in another block.

{% note warning %}

A YT table with response options must contain no more than 10,000 rows.

YT data is updated every 30 minutes, which is why the response options may upload with a delay.

{% endnote %}

## Block settings {#sec_settings}

### Question {#param-question}

Enter the field name or the prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Link to the table of responses {#param-link-tab-answer}

In **Settings**, insert a link to the YT table with response options. The link should look like this:

```
https://yt.yandex-team.ru/hume/navigation?path=//directory-name/table-name
```

### Add a <q>YT table</q> filter {#param-filter}

You can use this option to filter response options in the <q>YT list</q> block: load different rows from the YT table depending on the response selected in a different <q>YT list</q> block. To do this, add at least two <q>YT list</q> blocks to the form:

- Parent block.

- A block with response options that are filtered depending on the response that the user selected in the parent block.

To filter response options:

1. Add a parent <q>YT list</q> block to the form or select an existing block as the parent.

1. Create a [table of responses with an additional column for filtering](#sec_filter).

1. Add a block with filtering to the form and put a link to the created table in **Settings**.

1. Turn on the **Add a<q>YT table</q> filter** option.

1. In the **Select a filter** list, specify the parent <q>YT list</q> block.

### Validation {#param-validation}

Use an external validator if you need to see if responses match the specified format. When selecting this option in the form settings, specify the [validation server address](../validation.md).

## Create a table of responses {#sec_table}

To create a response table for a <q>YT list</q> block:

1. Create a table in [YT](https://yt.yandex-team.ru/).

1. Fill out the table with data in the following format:

    - The table must have columns named `id` and `name`.

    - The `id` column must be filled with unique numbers, for example, sequential numbering.

    - The `name` column must be filled with the response options that will be available in the <q>YT list</q> block.

1. Make sure the `robot-forms@` robot has [access to the table](https://yt.yandex-team.ru/docs/description/common/acl_manage). The robot also has access to the table if the **Available to all employees** mode is on.

1. Put a [link to the table](#param-link-tab-answer) in the <q>YT list</q> block setting.

## Create a table with response filtering {#sec_filter}

To create a table with response filtering:

1. Create a table in [YT](https://yt.yandex-team.ru/).

1. Fill out the table with data in the following format:

    - The table must have columns named `id`,`name`, and `parent`.

    - The `id` column must be filled with unique numbers, for example, sequential numbering.

    - The `name` column must be filled with the response options that will be available in the <q>YT list</q> block.

    - The `parent` column must have an `id` value for each response from the row in the parent table that should load the response in the <q>YT list</q> block with filtering. For example, if the user selects a response from a row with `id = 1` in the parent block, response options that have `1` specified in the `parent` column are available in the block with filtering.

1. Make sure the `robot-forms@` robot has [access to the table](https://yt.yandex-team.ru/docs/description/common/acl_manage). The robot also has access to the table if the **Available to all employees** mode is on.

1. Put a link to the table in the <q>YT list</q> block settings and [turn on response filtering](#param-filter).

