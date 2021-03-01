# Home page

{% if audience == "external" %}

To go to the home page, click the {{ tracker-name }} logo.

{% else %}

To go to the home page, click **My page** on the top panel in {{ tracker-name }}.

{% endif %}

By default, this page displays the issue list from the [<q>All issues</q>](my-tickets.md) filter, meaning every issue that you're the reporter, assignee, or follower for.

You can set your home page to display any [filter](filters.md), [dashboard](dashboard.md), or [issue board](../manager/create-agile-board.md):

1. {% if audience == "external" %} On the {{ tracker-name }}  top panel, click ![](../../_assets/tracker/tracker-settings.png)  → **Personal settings** .{% else %} On the {{ tracker-name }} top panel in , click on your profile picture and select **Personal settings**  or follow the link:  [https://st.yandex-team.ru/settings]({{ link-settings-ya }}){% endif %}

    {% if audience == "external" %}

    {% note info %}

    You can also follow this link: [https://tracker.yandex.ru/settings]({{ link-settings }}).

    {% endnote %}

    {% endif %}

1. Choose a filter, dashboard, or issue board you want to see on the home page in the **My page** section.

1. Click **Save**.

{% if audience == "external" %}

[Contact support](../troubleshooting.md)

{% endif %}

