---
title: How to search for information in {{ wiki-full-name }}
description: Follow this guide to search for information in {{ wiki-full-name }}.
---

# Searching by {{ wiki-name }}

To perform a search by text on {{ wiki-name }} pages:

1. In the {{ wiki-name }} left-hand panel, click ![](../_assets/wiki/svg/search.svg) **{{ ui-key.beta-wiki.blocks_common_desktop.blocks_b-head.search }}**.

1. Enter your query in the search bar. The pages containing the query will be shown under the search bar.


1. To refine the search results, press **Enter** in the search bar and use the filters in the right-hand panel:

   - **Cluster**: [Cluster's](structure.md#clusters) URL relative to the `{{ wiki-host-name }}` home page. For example, to find a text on the subpages of the `{{ wiki-username }}` cluster, enter `users/<username>`.
   - **Page author**: Name or username of the {{ wiki-name }} page author.
   - **{{ ui-key.beta-wiki.blocks_common_newgrid.blocks_b-grid-table-head.date_created }}** or **Updated**: Date when the page was created or last changed.
   - **Document type**: Search across {{ wiki-name }} documents of a specific type (page, table, or file).
   

1. Sort the search results: by relevance, last update, or creation date.



{% note warning %}

Recent changes to {{ wiki-name }} pages may appear in search results after a delay, since the pages are indexed once every 30 minutes.

{% endnote %}