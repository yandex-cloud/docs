# YT list

In this block, users can enter response options that are loaded from a [ YT table](https://yt.yandex-team.ru/docs/). When they type, hints with suggested responses appear in the field. Responses that aren't in the table aren't accepted.

If multiple <q>YT list</q> blocks are used in the form, you can [configure response filtering](#param-filter). In this case, the set of possible responses in one <q>YT list</q> block changes depending on the response the user selected in another block.

{% note warning %}

A YT table with response options must contain a maximum of 10,000 rows.

YT data is updated every 30 minutes, which is why the response options may upload with a delay.

{% endnote %}

## Block settings {#sec_settings}

### Question {#param-question}

Enter the field name or the prompt.

- To add an image to the prompt, click ![](../../_assets/forms/add-picture.png).

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

