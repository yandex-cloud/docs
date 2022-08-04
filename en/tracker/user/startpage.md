# Home page

{% if audience == "external" %}

To go to the home page, click the {{ tracker-name }} logo. By default, the page displays your personal [dashboard](dashboard.md).

{% else %}

To open the home page, click **My page** on the {{ tracker-name }} top panel.

By default, this page displays the issue list from the [<q>All issues</q>](my-tickets.md) filter, meaning every issue for which you are the reporter, assignee, or follower.

{% endif %}

You can customize your home page to display any [filter](create-filter.md), [dashboard](dashboard.md), or [issue board](../manager/create-agile-board.md):

1. {% include [open-personal-settings](../../_includes/tracker/open-personal-settings.md) %}

1. Under **My page**, choose the filter, dashboard, or issue board you want to see on the home page.

1. Click **Save**.

