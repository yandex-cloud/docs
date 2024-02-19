# {{ wiki-full-name }}

You can insert _magic links_ on Wiki pages to individual issues and issue lists. These links always include the key, name, status of the issue, and the assignee's username.

## Inserting a link to an issue {#section_hws_qzr_3bb}

To insert a link to an issue, copy its key and paste it in the text of the page:

| Example | Result |
----- | -----
| ``` TEST-123 ``` | ![](../../_assets/tracker/magic-link.png) |


Magic links to issues aren't just for {{ wiki-full-name }} pages. They also work in other internet services that support Wiki markup.

## Inserting a list of issues from a queue page {#section_oj5_scs_3bb}

In {{ wiki-full-name }}, you can insert a list of issues from any queue page:

1. Open the queue page.

1. In the top-left corner of the page, select ![](../../_assets/tracker/icon-settings2.png) → **Get the Wiki code**.

1. Copy the code.

1. Add the code to a wiki page.

## Inserting a list of issues from a filter page {#section_filter_link}

To place a filtered issue list in {{ wiki-full-name }}:

1. Open the [issue list]({{ link-tracker }}issues) and [set up filters](create-filter.md).

1. Copy the URL from the address bar.

1. Add a link in ``` {{tasks url="link-from-browser"}} ``` format to a Wiki page.

| Example | Result |
----- | -----
| ``` {{tasks url="{{ link-tracker }}filters/<filter>"}} ``` | ![](../../_assets/tracker/magic-tickets-list.png) |

{% note info %}

The `url` parameter of the `tasks` block does not support the `"` character. If this character is present in the filter's URL copied from the address bar, replace it with `%22`.

{% endnote %}
