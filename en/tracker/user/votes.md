---
title: "How to vote for an issue"
description: "Follow this guide to vote for an issue."
---

# Voting for an issue

{% note warning %}

Voting for issues is available only if allowed by the queue settings.

{% endnote %}

{{ tracker-name }} users can vote for issues to help teams decide which issues are highest priority. Number of votes is shown in the upper-right corner of the page next to ![](../../_assets/tracker/svg/vote.svg).

To vote for an issue, click ![](../../_assets/tracker/svg/vote.svg) in the upper-right corner of the page. If you want to revoke your voice, click the button once again.

{% note tip %}

To find issues that you have voted for, use the [query language](query-filter.md):

1. In the left-hand panel, select ![](../../_assets/tracker/svg/tasks.svg) **{{ ui-key.startrek.blocks-desktop_b-head.filters }}**, then, at the bottom of the window, click **{{ ui-key.startrek.ui_components_page-issues_touch.all-issues-filter-title }}**.

1. Click **{{ ui-key.startrek.ui_components_page-issues_touch.query-language }}** in the top-right corner of the page.

1. Enter your query in the bar:

   ```
   "Voted By": me()
   ```

{% endnote %}

#### Voting specifics

* To open a list of users who voted for the issue, hover over the ![](../../_assets/tracker/svg/vote.svg) icon.

* All the users who have access to the issue are allowed to vote on it.

* If you close a duplicate issue, all its votes will be moved to the original issue.
