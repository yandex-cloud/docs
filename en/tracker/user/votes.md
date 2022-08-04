# Voting for an issue

{% note warning %}

Voting is available only if it is enabled in the queue settings.

{% endnote %}

{{ tracker-name }} users can vote for issues to help teams decide which issues are highest priority. The number of votes is displayed under the issue title next to the icon: ![](../../_assets/tracker/votes.png).

To vote for an issue, click ![](../../_assets/tracker/vote.png). If you want to remove your vote, click it again.

{% note tip %}

To find issues that you have voted for, use the [query language](query-filter.md):

1. On the {{ tracker-name }} top panel, select **Issues** → **Find issues**.

1. Click **Query language** in the upper-right corner.

1. Enter the query:

    ```
    "Voted By": me()
    ```

{% endnote %}

#### How voting works

- You can view the list of votes by clicking the button with the number of votes.

- All users who have access to the issue can vote.

- If an issue that received votes is closed as a duplicate, all the votes will be transferred to the original issue.

