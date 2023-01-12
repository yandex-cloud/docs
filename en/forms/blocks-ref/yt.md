# The list from YT

In this block, the user can enter response options that are loaded from a [YT table](https://yt.yandex-team.ru/docs/). When they type, hints with suggested response options appear in the field. Responses that aren't in the table aren't accepted.

If multiple <q>YT list</q> blocks are used in the form, you can [configure response filtering](#param-filter). In this case, a set of possible responses in one <q>YT list</q> block will change depending on the response selected in another block.

{% note warning %}

A YT table with response options may contain a maximum of 10000 rows.

YT data is updated every 30 minutes. Therefore, response options may be loaded with a delay.

{% endnote %}


## Block settings {#sec_settings}

### Question {#param-question}

Enter a field name or a prompt.

{% include [question](../../_includes/forms/question.md) %}

{% include [id-required-hidden](../../_includes/forms/id-required-hidden.md) %}

### Link to the table of responses {#param-link-tab-answer}

In the **Settings** section field, paste a link to the YT table with response options. The link must look like this:

```
https://yt.yandex-team.ru/hume/navigation?path=//directory-name/table-name
```

### Filter <q>YT tables</q> {#param-filter}

Using this option, you can filter responses in a <q>YT list</q> block: upload different rows from the YT table depending on the response selected in another <q>YT list</q> block. To do this, add at least two <q>YT list</q> blocks to the form:

- Parent block.

- A block with response options that are filtered depending on the response that the user selected in the parent block.

To filter response options:

1. Add a parent <q>YT list</q> block to the form or select an existing block as the parent.

1. Create a [table of responses with an additional column for filtering](#sec_filter).

1. Add a block with filtering to the form and specify a link to the created table in the **Settings** section.

1. Enable **Filter <q>YT tables</q>**.

1. In the **Select filter** list, specify the <q>YT list</q> parent block.

### Validation {#param-validation}

You can use an external validator if you need to check that a response meets a certain format. If you choose this option, specify the [validation server address](../validation.md) in the form settings.


## Create a table of responses {#sec_table}

To create a table of responses for the <q>List from YT</q> block:

1. In [YT](https://yt.yandex-team.ru/), create a table.

1. Write data in the following format to the table:

   - The table must contain columns named `id` and `name`.

   - The `id` column must contain unique numbers, for example, sequence numbering.

   - The `name` column must contain response options that will be displayed in the <q>YT list</q> block.

1. Make sure the `robot-forms@` robot has [access to the table](https://yt.yandex-team.ru/docs/description/common/acl_manage). The robot also has access to the table if **Available to all employees** mode is set.

1. Specify a [link to the table](#param-link-tab-answer) in the <q>YT list</q> block settings.


## Create a table with response filtering {#sec_filter}

To create a table with response filtering:

1. In [YT](https://yt.yandex-team.ru/), create a table.

1. Write data in the following format to the table:

   - The table must contain columns named `id`, `name`, and `parent`.

   - The `id` column must contain unique numbers, for example, sequence numbering.

   - The `name` column must contain response options that will be displayed in the <q>YT list</q> block.

   - In the `parent` column, each response must have a corresponding `id` value from the parent table row after selecting which the response is loaded to the <q>YT list</q> block with filtering. For example, if the user selects a response with `id = 1` in the parent block, then the block with filtering will contain response options that have the value `1` set in the `parent` column.

1. Make sure the `robot-forms@` robot has [access to the table](https://yt.yandex-team.ru/docs/description/common/acl_manage). The robot also has access to the table if **Available to all employees** mode is set.

1. Specify a link to the table in the <q>YT list</q> block settings and [enable response filtering](#param-filter).