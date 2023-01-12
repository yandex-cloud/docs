# Text from Delta

[Delta](https://delta.yandex-team.ru/) is a service for co-editing texts online. Use it to log a meeting or make shared notes during a report.
Texts from Delta can be [exported to {{ wiki-name }}](#delta-save).

## Making a new note {#delta-create}

1. Go to [https://delta.yandex-team.ru/](https://delta.yandex-team.ru/).

1. Click **Create**.

1. Select a programming language from the list in the upper-left corner.
   For text with Wiki markup support, select `plain_text`. Enable **Wiki mode** to see the formatted text on the right.

1. To collaborate on text edits with your colleagues, send them a link to the Wiki page from the browser address bar.

{% note alert %}

* Pages in Delta are available to all Yandex employees. Someone might accidentally see your text.

* Delta doesn't provide search features. To make sure your notepad isn't lost, remember its name or save a link to it.

{% endnote %}

## Saving text from Delta to {{ wiki-name }} {#delta-save}

You can save notes from Delta to any editable Wiki page in {{ wiki-name }}. For example, anyone who is allowed to co-edit your text can save it to their personal cluster.

To save text to {{wiki-name}}:

1. Click **Export from Wiki** and enter a relative link to the Wiki page in the format:
   ```{{ wiki-pagename }}```

1. Click **Continue**. If you're exporting different versions of a note to the same address in {{ wiki-name }}, the page will be overwritten. You can see all versions in the [change history](history.md).